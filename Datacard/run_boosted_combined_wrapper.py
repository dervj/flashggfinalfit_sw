#!/usr/bin/env python
import argparse
import glob
import os
import shutil
import subprocess
import sys
import time


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


def run_with_retries(cmd, cwd=None, dry_run=False, allowed_returncodes=None, retries=0, sleep_sec=0):
    attempt = 0
    while True:
        try:
            return run(cmd, cwd=cwd, dry_run=dry_run, allowed_returncodes=allowed_returncodes)
        except RuntimeError as exc:
            if attempt >= retries:
                raise
            attempt += 1
            log("[WARN] %s (retry %d/%d)" % (exc, attempt, retries))
            if sleep_sec:
                time.sleep(sleep_sec)


def ensure_dir(path):
    if not os.path.isdir(path):
        os.makedirs(path)


def copy_ws_files(pattern, dest_dir):
    files = glob.glob(pattern)
    if not files:
        return 0
    ensure_dir(dest_dir)
    for fpath in files:
        shutil.copy2(fpath, dest_dir)
    return len(files)


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


def parse_args():
    parser = argparse.ArgumentParser(
        description="Run boosted combined datacard pipeline with verbose output."
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
        "--batch",
        default="local",
        help="Batch mode passed to RunYields_*boosted_combined.py",
    )
    parser.add_argument("--queue", default="microcentury", help="Queue for batch")
    parser.add_argument(
        "--job-opts",
        default="",
        help="Extra job options for condor/SGE",
    )
    parser.add_argument("--no-systematics", action="store_true", help="Skip systematics")
    parser.add_argument("--no-prune", action="store_true", help="Disable pruning")
    parser.add_argument(
        "--keep-top-level",
        action="store_true",
        help="Keep combined cards in datacard-dir (copy instead of move)",
    )
    parser.add_argument(
        "--cleanup-combine-ws",
        action="store_true",
        help="Remove temporary ws_ggyhcombine_* directories",
    )
    parser.add_argument(
        "--keep-missing",
        action="store_true",
        help="Do not drop missing processes in fix step",
    )
    parser.add_argument(
        "--skip-object-check",
        action="store_true",
        help="Skip ROOT object check in fix step",
    )
    parser.add_argument(
        "--skip-combine",
        action="store_true",
        help="Skip combineCards.py steps",
    )
    parser.add_argument(
        "--do-text2workspace",
        action="store_true",
        help="Run text2workspace.py on Run2 card",
    )
    parser.add_argument(
        "--retry-count",
        type=int,
        default=0,
        help="Retry count for yields/datacard steps (0 disables retries)",
    )
    parser.add_argument(
        "--retry-sleep",
        type=int,
        default=0,
        help="Seconds to sleep between retries",
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

    fix_script = os.path.join(dc_dir, "fix_boosted_combined_cards.py")

    for mass in masses:
        log("\n=== Mass %s ===" % mass)
        mass_dir = os.path.join(outdir_base, "datacard_%s" % mass)
        ensure_dir(mass_dir)

        for year in years:
            yy = year_tag(year)
            runyields = os.path.join(dc_dir, "RunYields_%sboosted_combined.py" % yy)
            makedc = os.path.join(dc_dir, "makeDatacard_%sboosted_combined.py" % yy)
            if not os.path.exists(runyields) or not os.path.exists(makedc):
                log("[WARN] Missing boosted scripts for %s (year %s)" % (mass, year))
                continue

            for cat in cats:
                combine_dir = os.path.join(
                    args.sigbase,
                    year,
                    mass,
                    "mc",
                    "ws_ggyhcombine_%s_%s_%s" % (mass, year, cat),
                )
                pattern = os.path.join(
                    args.sigbase,
                    year,
                    mass,
                    "mc",
                    "ws_ggyh*_%s_%s_%s_*" % (mass, year, cat),
                    "*.root",
                )
                nfiles = copy_ws_files(pattern, combine_dir)
                if nfiles == 0:
                    log("[WARN] No ws files for %s %s %s" % (mass, year, cat))
                    continue
                log("[INFO] Copied %d ws files into %s" % (nfiles, combine_dir))

                bkg_dir = os.path.join(
                    args.sigbase, year, mass, "data", "ws_%s_%s" % (year, cat)
                )
                ext = "%s_%s_%s" % (mass, year, cat)

                syst_flag = "--doSystematics" if not args.no_systematics else ""
                prune_flag = "--prune" if not args.no_prune else ""

                cmd = (
                    "python %s --cats %s --inputWSDirMap %s=%s --procs auto "
                    "--sigModelWSDir %s=%s --bkgModelWSDir %s %s "
                    "--batch %s --queue %s --jobOpts \"%s\" --ext %s"
                    % (
                        runyields,
                        cat,
                        year,
                        combine_dir,
                        year,
                        combine_dir,
                        bkg_dir,
                        syst_flag,
                        args.batch,
                        args.queue,
                        args.job_opts,
                        ext,
                    )
                )
                run_with_retries(
                    cmd,
                    cwd=dc_dir,
                    dry_run=args.dry_run,
                    retries=args.retry_count,
                    sleep_sec=args.retry_sleep,
                )

                cmd = (
                    "python %s --years %s %s %s --ext %s --output %s_%s_%s"
                    % (makedc, year, syst_flag, prune_flag, ext, mass, year, cat)
                )
                # makeDatacard_* scripts always exit with code 1 on success
                run_with_retries(
                    cmd,
                    cwd=dc_dir,
                    dry_run=args.dry_run,
                    allowed_returncodes=[0, 1],
                    retries=args.retry_count,
                    sleep_sec=args.retry_sleep,
                )

                cmd = "sed -i 's/%s=//g' %s_%s_%s.txt" % (year, mass, year, cat)
                run(cmd, cwd=dc_dir, dry_run=args.dry_run)

                src = os.path.join(dc_dir, "%s_%s_%s.txt" % (mass, year, cat))
                dst = os.path.join(mass_dir, os.path.basename(src))
                if os.path.exists(src):
                    if args.keep_top_level:
                        log("[INFO] Copying %s -> %s" % (src, dst))
                        if not args.dry_run:
                            shutil.copy2(src, dst)
                    else:
                        log("[INFO] Moving %s -> %s" % (src, dst))
                        if not args.dry_run:
                            shutil.move(src, dst)
                else:
                    log("[WARN] Missing output card: %s" % src)

                if args.cleanup_combine_ws:
                    if not args.dry_run and os.path.isdir(combine_dir):
                        shutil.rmtree(combine_dir)
                        log("[INFO] Removed %s" % combine_dir)

        if os.path.exists(fix_script):
            cmd = "python %s %s" % (fix_script, mass_dir)
            if args.keep_missing:
                cmd += " --keep-missing"
            if args.skip_object_check:
                cmd += " --skip-object-check"
            run(cmd, cwd=dc_dir, dry_run=args.dry_run)
        else:
            log("[WARN] fix_boosted_combined_cards.py not found in %s" % dc_dir)

        if args.skip_combine:
            continue

        # Combine cats per year
        for year in years:
            entries = []
            for cat in cats:
                fname = "%s_%s_%s.txt" % (mass, year, cat)
                fpath = os.path.join(mass_dir, fname)
                if os.path.exists(fpath):
                    entries.append(("%s_%s" % (cat, year), fpath))
            out_path = os.path.join(mass_dir, "%s_%s_cat12.txt" % (mass, year))
            combine_cards(out_path, entries, dry_run=args.dry_run)

        # Combine years to Run2
        entries = []
        for year in years:
            fname = "%s_%s_cat12.txt" % (mass, year)
            fpath = os.path.join(mass_dir, fname)
            if os.path.exists(fpath):
                entries.append(("cat12_%s" % year, fpath))
        run2_path = os.path.join(mass_dir, "%s_Run2_cat12.txt" % mass)
        combine_cards(run2_path, entries, dry_run=args.dry_run)

        if args.do_text2workspace:
            cmd = "text2workspace.py %s -m 125 -o %s_Run2_cat12.root" % (
                os.path.basename(run2_path),
                mass,
            )
            run(cmd, cwd=mass_dir, dry_run=args.dry_run)

    return 0


if __name__ == "__main__":
    sys.exit(main())
