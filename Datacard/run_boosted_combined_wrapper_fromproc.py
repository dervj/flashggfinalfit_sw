#!/usr/bin/env python
import argparse
import os
import shutil
import subprocess
import sys


def log(msg):
    print(msg)
    sys.stdout.flush()


def run(cmd, cwd=None, dry_run=False, allowed_returncodes=None):
    log(">> %s" % cmd)
    if dry_run:
        return 0
    if allowed_returncodes is None:
        allowed_returncodes = [0]
    ret = subprocess.call(cmd, shell=True, cwd=cwd)
    if ret not in allowed_returncodes:
        raise RuntimeError("Command failed (%s): %s" % (ret, cmd))
    return ret


def ensure_dir(path):
    if not os.path.isdir(path):
        os.makedirs(path)


def year_tag(year):
    if year.startswith("2016"):
        return "16"
    return year[-2:]


def combine_cards(output_path, entries, dry_run=False):
    if len(entries) == 0:
        log("[WARN] No inputs for %s" % output_path)
        return False
    out_dir = os.path.abspath(os.path.dirname(output_path))
    rel_entries = []
    for label, path in entries:
        path_abs = os.path.abspath(path)
        if os.path.dirname(path_abs) == out_dir:
            rel_entries.append((label, os.path.basename(path_abs)))
        else:
            rel_entries.append((label, path))
    if len(entries) == 1:
        log("[INFO] Single input -> copying to %s" % output_path)
        if not dry_run:
            shutil.copy2(entries[0][1], output_path)
        return True
    cmd = "combineCards.py %s > %s" % (
        " ".join(["%s=%s" % (label, path) for label, path in rel_entries]),
        output_path,
    )
    run(cmd, cwd=os.path.dirname(output_path), dry_run=dry_run)
    return True


def append_year_specific_rateparam(path, year, dry_run=False):
    if year not in ("2016pre", "2016post", "2018"):
        return
    line1 = "CMS_brHgg      rateParam  * ggyhwwgg_%s_hgg 0.00227" % year
    line2 = "nuisance  edit  freeze  CMS_brHgg"
    if dry_run:
        log(">> append CMS_brHgg rateParam to %s" % path)
        return
    if not os.path.exists(path):
        return
    with open(path, "r") as f:
        contents = f.read()
    has_line1 = line1 in contents
    has_line2 = line2 in contents
    if has_line1 and has_line2:
        return
    with open(path, "a") as f:
        if not has_line1:
            f.write("\n%s\n" % line1)
        if not has_line2:
            f.write("%s\n" % line2)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Run boosted from-proc datacard combine pipeline (non-destructive)."
    )
    parser.add_argument("--mass", action="append", help="Mass point, e.g. MX1400_MY800")
    parser.add_argument("--mass-list", help="Comma-separated mass points")
    parser.add_argument("--mass-file", help="File with one mass point per line")
    parser.add_argument(
        "--years",
        default="2016pre,2016post,2017,2018",
        help="Comma-separated years",
    )
    parser.add_argument(
        "--cats",
        default="cat12lowpurity,cat12highpurity",
        help="Comma-separated categories",
    )
    parser.add_argument(
        "--output-tag",
        default="cat12_fromproc",
        help="Tag used in output filenames (e.g. cat12_fromproc)",
    )
    parser.add_argument(
        "--sigbase",
        default="/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit",
        help="Base dir for signal/background workspaces",
    )
    parser.add_argument(
        "--datacard-dir",
        default=os.getcwd(),
        help="flashggFinalFit/Datacard directory",
    )
    parser.add_argument(
        "--outdir-base",
        default=None,
        help="Base dir for datacard_MX*_MY* folders (defaults to datacard-dir)",
    )
    parser.add_argument(
        "--keep-temp",
        action="store_true",
        help="Keep temporary per-proc working copies",
    )
    parser.add_argument(
        "--do-text2workspace",
        action="store_true",
        help="Run text2workspace.py on Run2 card",
    )
    parser.add_argument(
        "--add-brhgg-rateparam",
        action="store_true",
        help="Append CMS_brHgg rateParam lines to per-year cards",
    )
    parser.add_argument(
        "--retry-count",
        type=int,
        default=0,
        help="Retry count for the combined wrapper (0 disables retries)",
    )
    parser.add_argument(
        "--retry-sleep",
        type=int,
        default=0,
        help="Seconds to sleep between retries in the combined wrapper",
    )
    parser.add_argument("--dry-run", action="store_true", help="Print commands only")
    return parser.parse_args()


def load_masses(args):
    masses = []
    if args.mass:
        masses.extend(args.mass)
    if args.mass_list:
        masses.extend([m.strip() for m in args.mass_list.split(",") if m.strip()])
    if args.mass_file:
        with open(args.mass_file, "r") as f:
            for line in f:
                m = line.strip()
                if not m or m.startswith("#"):
                    continue
                masses.append(m)
    return sorted(set(masses))


def main():
    args = parse_args()
    masses = load_masses(args)
    if not masses:
        log("[ERROR] No mass points specified")
        return 2

    dc_dir = os.path.abspath(args.datacard_dir)
    outdir_base = os.path.abspath(args.outdir_base or dc_dir)

    years = [y.strip() for y in args.years.split(",") if y.strip()]
    cats = [c.strip() for c in args.cats.split(",") if c.strip()]
    output_tag = args.output_tag.strip()

    for mass in masses:
        log("\n=== Mass %s ===" % mass)
        mass_dir = os.path.join(outdir_base, "datacard_%s" % mass)
        ensure_dir(mass_dir)

        # Run the standard combined-card pipeline first (keeps bin structure),
        # then rely on fix_boosted_combined_cards.py to drop missing processes.
        combined_wrapper = os.path.join(dc_dir, "run_boosted_combined_wrapper.py")
        if not os.path.exists(combined_wrapper):
            raise RuntimeError("Missing wrapper: %s" % combined_wrapper)

        cleanup_flag = ""
        if not os.environ.get("RUN2COMBINE_NO_CLEANUP"):
            cleanup_flag = " --cleanup-combine-ws"
        retry_flags = ""
        if args.retry_count:
            retry_flags += " --retry-count %d" % args.retry_count
        if args.retry_sleep:
            retry_flags += " --retry-sleep %d" % args.retry_sleep
        cmd = (
            "python %s --mass %s --datacard-dir %s --sigbase %s "
            "--years '%s' --cats '%s' --skip-combine%s%s"
            % (
                combined_wrapper,
                mass,
                dc_dir,
                args.sigbase,
                args.years,
                args.cats,
                cleanup_flag,
                retry_flags,
            )
        )
        run(cmd, cwd=dc_dir, dry_run=args.dry_run)

        # Combine cats per year using the fixed combined cards.
        for year in years:
            entries = []
            for cat in cats:
                fname = "%s_%s_%s.txt" % (mass, year, cat)
                fpath = os.path.join(mass_dir, fname)
                if os.path.exists(fpath):
                    entries.append(("%s_%s" % (cat, year), fpath))
            out_path = os.path.join(
                mass_dir, "%s_%s_%s.txt" % (mass, year, output_tag)
            )
            if combine_cards(out_path, entries, dry_run=args.dry_run):
                if args.add_brhgg_rateparam:
                    append_year_specific_rateparam(out_path, year, dry_run=args.dry_run)

        # Combine years to Run2
        entries = []
        for year in years:
            fname = "%s_%s_%s.txt" % (mass, year, output_tag)
            fpath = os.path.join(mass_dir, fname)
            if os.path.exists(fpath):
                entries.append(("cat12_%s" % year, fpath))
        run2_path = os.path.join(mass_dir, "%s_Run2_%s.txt" % (mass, output_tag))
        combine_cards(run2_path, entries, dry_run=args.dry_run)

        if args.do_text2workspace:
            cmd = "text2workspace.py %s -m 125 -o %s_Run2_%s.root" % (
                os.path.basename(run2_path),
                mass,
                output_tag,
            )
            run(cmd, cwd=mass_dir, dry_run=args.dry_run)

    return 0


if __name__ == "__main__":
    sys.exit(main())
