#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import glob
import re
import argparse
from collections import defaultdict

import numpy as np

# ----------------------------------------------------------------------
# Defaults
# ----------------------------------------------------------------------

DEFAULT_DATACARD_DIR = (
    "/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard"
)
DEFAULT_ROOT_NAME = "higgsCombineTest.AsymptoticLimits.mH125.root"
DEFAULT_OUTDIR = os.path.join(DEFAULT_DATACARD_DIR, "combined_limits_run2")
DEFAULT_COMBINED_DIR = "/eos/user/j/jodervan/Analysis/fromShaowei/YH_cat34_Datacard"
DEFAULT_COMBINED_GLOB = "higgsCombineMX*_MY*_cat1234.AsymptoticLimits.mH125.root"
DEFAULT_COMBINED_OUTNAME = "limits_run2_cat1234_expected_combined"
HP_ONLY_TAG = "hp_only"

COMBINED_FILE_RE = re.compile(
    r"^higgsCombineMX(\d+)_MY(\d+)_cat1234\.AsymptoticLimits\.mH125\.root$"
)

TARGET_QUANTILES = {
    0.025: "q2p5",
    0.16: "q16",
    0.5: "q50",
    0.84: "q84",
    0.975: "q97p5",
}

MASSPOINTS = [
    (1000, 250), (1000, 300), (1000, 400), (1000, 500), (1000, 600), (1000, 700),
    (1000, 800), (1200, 1000), (1200, 250), (1200, 300), (1200, 400), (1200, 500),
    (1200, 600), (1200, 700), (1200, 800), (1200, 900), (1400, 1000), (1400, 1100),
    (1400, 1200), (1400, 250), (1400, 300), (1400, 400), (1400, 500), (1400, 600),
    (1400, 700), (1400, 800), (1400, 900), (1600, 1000), (1600, 1100), (1600, 1200),
    (1600, 1300), (1600, 1400), (1600, 250), (1600, 300), (1600, 400), (1600, 500),
    (1600, 600), (1600, 700), (1600, 800), (1600, 900), (1800, 1000), (1800, 1100),
    (1800, 1200), (1800, 1300), (1800, 1400), (1800, 1600), (1800, 250), (1800, 300),
    (1800, 400), (1800, 500), (1800, 600), (1800, 700), (1800, 800), (1800, 900),
    (2000, 1000), (2000, 1100), (2000, 1200), (2000, 1300), (2000, 1400), (2000, 1600),
    (2000, 1800), (2000, 250), (2000, 300), (2000, 400), (2000, 500), (2000, 600),
    (2000, 700), (2000, 800), (2000, 900), (2200, 1000), (2200, 1100), (2200, 1200),
    (2200, 1300), (2200, 1400), (2200, 1600), (2200, 1800), (2200, 2000), (2200, 250),
    (2200, 300), (2200, 400), (2200, 500), (2200, 600), (2200, 700), (2200, 800),
    (2200, 900), (2400, 1000), (2400, 1100), (2400, 1200), (2400, 1300), (2400, 1400),
    (2400, 1600), (2400, 1800), (2400, 2000), (2400, 2200), (2400, 250), (2400, 300),
    (2400, 400), (2400, 500), (2400, 600), (2400, 700), (2400, 800), (2400, 900),
    (2500, 1000), (2500, 1100), (2500, 1200), (2500, 1300), (2500, 1400), (2500, 1600),
    (2500, 1800), (2500, 2000), (2500, 2200), (2500, 250), (2500, 300), (2500, 400),
    (2500, 500), (2500, 600), (2500, 700), (2500, 800), (2500, 900), (2600, 1000),
    (2600, 1100), (2600, 1200), (2600, 1300), (2600, 1400), (2600, 1600), (2600, 1800),
    (2600, 2000), (2600, 2200), (2600, 2400), (2600, 250), (2600, 300), (2600, 400),
    (2600, 500), (2600, 600), (2600, 700), (2600, 800), (2600, 900), (2800, 1000),
    (2800, 1100), (2800, 1200), (2800, 1300), (2800, 1400), (2800, 1600), (2800, 1800),
    (2800, 2000), (2800, 2200), (2800, 2400), (2800, 2500), (2800, 250), (2800, 2600),
    (2800, 300), (2800, 400), (2800, 500), (2800, 600), (2800, 700), (2800, 800),
    (2800, 900), (3000, 1000), (3000, 1100), (3000, 1200), (3000, 1300), (3000, 1400),
    (3000, 1600), (3000, 1800), (3000, 2000), (3000, 2200), (3000, 2400), (3000, 2500),
    (3000, 250), (3000, 2600), (3000, 2800), (3000, 300), (3000, 400), (3000, 500),
    (3000, 600), (3000, 700), (3000, 800), (3000, 900), (3500, 1000), (3500, 1100),
    (3500, 1200), (3500, 1300), (3500, 1400), (3500, 1600), (3500, 1800), (3500, 2000),
    (3500, 2200), (3500, 2400), (3500, 2500), (3500, 250), (3500, 2600), (3500, 2800),
    (3500, 300), (3500, 400), (3500, 500), (3500, 600), (3500, 700), (3500, 800),
    (3500, 900), (4000, 1000), (4000, 1100), (4000, 1200), (4000, 1300), (4000, 1400),
    (4000, 1600), (4000, 1800), (4000, 2000), (4000, 2200), (4000, 2400), (4000, 2500),
    (4000, 250), (4000, 2600), (4000, 2800), (4000, 300), (4000, 400), (4000, 500),
    (4000, 600), (4000, 700), (4000, 800), (4000, 900), (500, 250), (500, 300),
    (600, 250), (600, 300), (600, 400), (700, 250), (700, 300), (700, 400), (700, 500),
    (800, 250), (800, 300), (800, 400), (800, 500), (800, 600), (900, 250), (900, 300),
    (900, 400), (900, 500), (900, 600), (900, 700),
]


def read_limits_root(root_path):
    """
    Read quantileExpected + limit values from a combine AsymptoticLimits ROOT file.
    Tries uproot first, then falls back to ROOT.
    Returns (quantiles, limits) as numpy arrays.
    """
    try:
        import uproot  # type: ignore

        tree = uproot.open(root_path)["limit"]
        arrays = tree.arrays(["quantileExpected", "limit"], library="np")
        return arrays["quantileExpected"], arrays["limit"]
    except Exception:
        import ROOT  # type: ignore

        ROOT.gROOT.SetBatch(True)

        f = ROOT.TFile.Open(root_path)
        if not f or f.IsZombie():
            raise RuntimeError("Failed to open ROOT file")
        t = f.Get("limit")
        if not t:
            raise RuntimeError("Missing 'limit' tree")
        qs = []
        vals = []
        for entry in t:
            qs.append(float(entry.quantileExpected))
            vals.append(float(entry.limit))
        f.Close()
        return np.array(qs), np.array(vals)


def extract_expected_limits(quantiles, limits, tol=1e-3):
    """
    Extract expected limits (2.5, 16, 50, 84, 97.5%) from arrays.
    Returns tuple: (q2p5, q16, q50, q84, q97p5)
    """
    found = {}
    for q, lim in zip(quantiles, limits):
        if q < 0:
            continue
        for target, label in TARGET_QUANTILES.items():
            if abs(q - target) < tol:
                found[label] = float(lim)
                break

    missing = [label for label in TARGET_QUANTILES.values() if label not in found]
    if missing:
        raise RuntimeError("Missing quantiles: %s" % ",".join(missing))

    return (
        found["q2p5"],
        found["q16"],
        found["q50"],
        found["q84"],
        found["q97p5"],
    )


def load_masspoints():
    """Return immutable (mX, mY) points to avoid importing PNN dependencies."""
    return sorted({(int(mx), int(my)) for mx, my in MASSPOINTS})


def parse_masspoints_arg(arg):
    """Parse mX,mY pairs from a CLI string."""
    if not arg:
        return []
    tokens = arg.replace(",", " ").replace(":", " ").replace(";", " ").split()
    if len(tokens) % 2 != 0:
        raise RuntimeError("Invalid --masspoints string: expected pairs of numbers")
    points = set()
    for idx in range(0, len(tokens), 2):
        try:
            mx = int(tokens[idx])
            my = int(tokens[idx + 1])
        except ValueError:
            raise RuntimeError(
                "Invalid --masspoints value: %s %s" % (tokens[idx], tokens[idx + 1])
            )
        points.add((mx, my))
    return sorted(points)


def load_masspoints_from_file(path):
    """Load mX,mY pairs from a file (one pair per line)."""
    points = set()
    with open(path, "r") as f:
        for line_no, line in enumerate(f, 1):
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                continue
            tokens = stripped.replace(",", " ").replace(":", " ").split()
            if len(tokens) < 2:
                raise RuntimeError(
                    "Invalid masspoint line %d: %s" % (line_no, stripped)
                )
            try:
                mx = int(tokens[0])
                my = int(tokens[1])
            except ValueError:
                lowered = [tok.lower() for tok in tokens]
                if "mx" in lowered or "my" in lowered:
                    continue
                raise RuntimeError(
                    "Invalid masspoint line %d: %s" % (line_no, stripped)
                )
            points.add((mx, my))
    return sorted(points)


def collect_limits(datacard_dir, masspoints, root_name, strict_quantiles=False):
    """
    Build dict[mX] -> list[(mY, q2p5, q16, q50, q84, q97p5)]
    from combine output ROOT files in datacard_MX*_MY*.
    """
    limits = defaultdict(list)
    missing = []
    for mx, my in masspoints:
        mass = "MX%d_MY%d" % (mx, my)
        root_path = os.path.join(datacard_dir, "datacard_%s" % mass, root_name)
        if not os.path.exists(root_path):
            missing.append(mass + " (missing ROOT)")
            continue
        try:
            quantiles, lims = read_limits_root(root_path)
        except Exception as exc:
            missing.append(mass + " (read error: %s)" % exc)
            if strict_quantiles:
                raise
            continue
        if len(quantiles) == 0:
            missing.append(mass + " (empty limit tree)")
            if strict_quantiles:
                raise RuntimeError("Empty limit tree for %s" % mass)
            continue
        try:
            q2p5, q16, q50, q84, q97p5 = extract_expected_limits(quantiles, lims)
        except RuntimeError as exc:
            missing.append(mass + " (%s)" % exc)
            if strict_quantiles:
                raise
            continue
        limits[mx].append((my, q2p5, q16, q50, q84, q97p5))
    return limits, missing


def collect_limits_from_combined_outputs(
    combined_dir, pattern, strict_quantiles=False, file_re=None
):
    """
    Build dict[mX] -> list[(mY, q2p5, q16, q50, q84, q97p5)]
    from combined higgsCombineMX*_MY*_cat1234 AsymptoticLimits outputs.
    """
    limits = defaultdict(list)
    missing = []
    glob_path = os.path.join(combined_dir, pattern)
    files = sorted(glob.glob(glob_path))
    if not files:
        raise RuntimeError("No combined outputs found at %s" % glob_path)

    if file_re is None:
        file_re = COMBINED_FILE_RE

    for root_path in files:
        base = os.path.basename(root_path)
        match = file_re.match(base)
        if not match:
            missing.append(base + " (unexpected filename)")
            if strict_quantiles:
                raise RuntimeError("Unexpected filename: %s" % base)
            continue
        mx = int(match.group(1))
        my = int(match.group(2))
        try:
            quantiles, lims = read_limits_root(root_path)
        except Exception as exc:
            missing.append(base + " (read error: %s)" % exc)
            if strict_quantiles:
                raise
            continue
        if len(quantiles) == 0:
            missing.append(base + " (empty limit tree)")
            if strict_quantiles:
                raise RuntimeError("Empty limit tree for %s" % base)
            continue
        try:
            q2p5, q16, q50, q84, q97p5 = extract_expected_limits(quantiles, lims)
        except RuntimeError as exc:
            missing.append(base + " (%s)" % exc)
            if strict_quantiles:
                raise
            continue
        limits[mx].append((my, q2p5, q16, q50, q84, q97p5))
    return limits, missing


def write_csv(path, limits):
    outdir = os.path.dirname(path)
    if outdir and not os.path.isdir(outdir):
        os.makedirs(outdir)
    with open(path, "w") as f:
        f.write("mX,mY,q2p5,q16,q50,q84,q97p5\n")
        for mx in sorted(limits.keys()):
            for (my, q2p5, q16, q50, q84, q97p5) in sorted(
                limits[mx], key=lambda x: x[0]
            ):
                f.write(
                    "%d,%.1f,%.6g,%.6g,%.6g,%.6g,%.6g\n"
                    % (mx, my, q2p5, q16, q50, q84, q97p5)
                )

def load_limits_csv(csv_path):
    """Load limits from CSV into dict[mX] -> list[(mY, q2p5, q16, q50, q84, q97p5)]."""
    names = ("mX", "mY", "q2p5", "q16", "q50", "q84", "q97p5")
    data = np.genfromtxt(
        csv_path,
        delimiter=",",
        names=names,
        dtype=None,
        encoding=None,
        usecols=range(7),
        skip_header=1,
    )
    limits = defaultdict(list)
    for row in data:
        mx = int(row["mX"])
        my = float(row["mY"])
        q2p5 = float(row["q2p5"])
        q16 = float(row["q16"])
        q50 = float(row["q50"])
        q84 = float(row["q84"])
        q97p5 = float(row["q97p5"])
        limits[mx].append((my, q2p5, q16, q50, q84, q97p5))
    return limits


def replace_single_masspoint(csv_path, out_path, datacard_dir, root_name, mx, my):
    """Replace or insert a single (mX, mY) row in an existing CSV."""
    if not os.path.exists(csv_path):
        raise RuntimeError("Missing CSV: %s" % csv_path)

    limits = load_limits_csv(csv_path)
    mass = "MX%d_MY%d" % (mx, my)
    root_path = os.path.join(datacard_dir, "datacard_%s" % mass, root_name)
    if not os.path.exists(root_path):
        raise RuntimeError("Missing ROOT file for %s: %s" % (mass, root_path))

    quantiles, lims = read_limits_root(root_path)
    q2p5, q16, q50, q84, q97p5 = extract_expected_limits(quantiles, lims)

    existing = [(row[0], row[1], row[2], row[3], row[4], row[5]) for row in limits.get(mx, []) if row[0] != my]
    existing.append((my, q2p5, q16, q50, q84, q97p5))
    limits[mx] = existing

    write_csv(out_path, limits)
    print("[INFO] Replaced %s in %s" % (mass, out_path))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--datacard-dir",
        default=DEFAULT_DATACARD_DIR,
        help="flashggFinalFit/Datacard directory",
    )
    parser.add_argument(
        "--outdir",
        default=DEFAULT_OUTDIR,
        help="Output directory for CSV",
    )
    parser.add_argument("--tag", default="", help="Optional tag appended to output filenames")
    parser.add_argument(
        "--hp-only",
        action="store_true",
        help="Append hp_only tag to output filenames (convenience for high-purity mode)",
    )
    parser.add_argument(
        "--lo-max", type=int, default=1600, help="Max mX for low-mass CSV"
    )
    parser.add_argument(
        "--hi-min", type=int, default=1800, help="Min mX for high-mass CSV"
    )
    parser.add_argument(
        "--masspoints-file",
        default="",
        help="Path to file with mX mY pairs; overrides lo/hi split",
    )
    parser.add_argument(
        "--masspoints",
        default="",
        help="Inline mX mY pairs (e.g. '1000,250 1200,300'); overrides lo/hi split",
    )
    parser.add_argument(
        "--out-name",
        default="",
        help="Optional base name for custom masspoint CSV (no extension)",
    )
    parser.add_argument(
        "--root-name",
        default=DEFAULT_ROOT_NAME,
        help="ROOT filename inside each datacard directory",
    )
    parser.add_argument(
        "--strict-quantiles",
        action="store_true",
        help="Fail if expected quantiles are missing in a ROOT file",
    )
    parser.add_argument(
        "--replace-csv",
        default="",
        help="If set, replace a single mass point in this CSV and exit",
    )
    parser.add_argument("--replace-mx", type=int, default=None, help="mX to replace in --replace-csv")
    parser.add_argument("--replace-my", type=int, default=None, help="mY to replace in --replace-csv")
    parser.add_argument(
        "--replace-out",
        default="",
        help="Optional output CSV path for replacement (defaults to --replace-csv)",
    )
    parser.add_argument(
        "--combined",
        action="store_true",
        help=(
            "Extract limits from YH_cat34_Datacard higgsCombineMX*_MY*_cat1234 outputs "
            "into a *_combined CSV in --outdir"
        ),
    )
    parser.add_argument(
        "--combined-tag",
        default="",
        help="Optional tag suffix for cat1234 combined outputs (e.g. hp_only)",
    )
    args = parser.parse_args()

    if args.hp_only:
        if args.tag:
            if not re.search(r"(^|_)%s($|_)" % HP_ONLY_TAG, args.tag):
                args.tag = "%s_%s" % (args.tag, HP_ONLY_TAG)
        else:
            args.tag = HP_ONLY_TAG

    if args.replace_csv:
        if args.replace_mx is None or args.replace_my is None:
            raise RuntimeError("--replace-mx and --replace-my are required with --replace-csv")
        if args.replace_out:
            out_path = args.replace_out
        elif args.hp_only:
            base, ext = os.path.splitext(args.replace_csv)
            out_path = "%s_%s%s" % (base, HP_ONLY_TAG, ext or ".csv")
        else:
            out_path = args.replace_csv
        replace_single_masspoint(
            args.replace_csv,
            out_path,
            args.datacard_dir,
            args.root_name,
            args.replace_mx,
            args.replace_my,
        )
        return

    if args.combined:
        combined_tag = args.combined_tag.strip()
        combined_glob = DEFAULT_COMBINED_GLOB
        combined_re = COMBINED_FILE_RE
        if combined_tag:
            combined_glob = (
                "higgsCombineMX*_MY*_cat1234_%s.AsymptoticLimits.mH125.root"
                % combined_tag
            )
            combined_re = re.compile(
                r"^higgsCombineMX(\d+)_MY(\d+)_cat1234_%s\.AsymptoticLimits\.mH125\.root$"
                % re.escape(combined_tag)
            )
            if not args.tag:
                args.tag = combined_tag
        limits_combined, missing_combined = collect_limits_from_combined_outputs(
            DEFAULT_COMBINED_DIR,
            combined_glob,
            strict_quantiles=args.strict_quantiles,
            file_re=combined_re,
        )
        if missing_combined:
            print(
                "[WARN] Missing or invalid combined outputs: %s"
                % ", ".join(missing_combined)
            )
        if not limits_combined:
            raise RuntimeError("No limits loaded for combined outputs")
        if args.outdir and not os.path.isdir(args.outdir):
            os.makedirs(args.outdir)
        csv_name = DEFAULT_COMBINED_OUTNAME
        if args.tag:
            csv_name += "_%s" % args.tag
        csv_path = os.path.join(args.outdir, csv_name + ".csv")
        write_csv(csv_path, limits_combined)
        print("[INFO] Wrote %s" % csv_path)
        return

    custom_masspoints = []
    if args.masspoints_file:
        custom_masspoints.extend(load_masspoints_from_file(args.masspoints_file))
    if args.masspoints:
        custom_masspoints.extend(parse_masspoints_arg(args.masspoints))
    if custom_masspoints:
        masspoints = sorted({(mx, my) for mx, my in custom_masspoints})
        limits_custom, missing_custom = collect_limits(
            args.datacard_dir,
            masspoints,
            args.root_name,
            strict_quantiles=args.strict_quantiles,
        )
        if missing_custom:
            print(
                "[WARN] Missing combine outputs for custom set: %s"
                % ", ".join(missing_custom)
            )
        if not limits_custom:
            raise RuntimeError("No limits loaded for custom masspoints")
        if args.outdir and not os.path.isdir(args.outdir):
            os.makedirs(args.outdir)
        csv_name = args.out_name or "limits_run2_cat12_expected_custom"
        if args.tag:
            csv_name += "_%s" % args.tag
        csv_path = os.path.join(args.outdir, csv_name + ".csv")
        write_csv(csv_path, limits_custom)
        print("[INFO] Wrote %s" % csv_path)
        return

    masspoints = load_masspoints()
    if not masspoints:
        raise RuntimeError("No mass points loaded from PNN")

    masspoints_lo = [(mx, my) for (mx, my) in masspoints if mx <= args.lo_max]
    masspoints_hi = [(mx, my) for (mx, my) in masspoints if mx >= args.hi_min]

    limits_lo, missing_lo = collect_limits(
        args.datacard_dir,
        masspoints_lo,
        args.root_name,
        strict_quantiles=args.strict_quantiles,
    )
    limits_hi, missing_hi = collect_limits(
        args.datacard_dir,
        masspoints_hi,
        args.root_name,
        strict_quantiles=args.strict_quantiles,
    )

    if missing_lo:
        print("[WARN] Missing combine outputs for low-mass set: %s" % ", ".join(missing_lo))
    if missing_hi:
        print("[WARN] Missing combine outputs for high-mass set: %s" % ", ".join(missing_hi))

    if not limits_lo and not limits_hi:
        raise RuntimeError("No limits loaded; check inputs and combine outputs")

    if args.outdir and not os.path.isdir(args.outdir):
        os.makedirs(args.outdir)

    if limits_lo:
        csv_name = "limits_run2_cat12_expected_upto1p6TeV"
        if args.tag:
            csv_name += "_%s" % args.tag
        csv_path = os.path.join(args.outdir, csv_name + ".csv")
        write_csv(csv_path, limits_lo)
        print("[INFO] Wrote %s" % csv_path)

    if limits_hi:
        csv_name = "limits_run2_cat12_expected_1p8to4TeV"
        if args.tag:
            csv_name += "_%s" % args.tag
        csv_path = os.path.join(args.outdir, csv_name + ".csv")
        write_csv(csv_path, limits_hi)
        print("[INFO] Wrote %s" % csv_path)


if __name__ == "__main__":
    main()
