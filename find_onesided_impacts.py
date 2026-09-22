#!/usr/bin/env python3
"""
Flag one-sided nuisances among the top-30 (page-1) impacts, per mass point, across the
whole flashggFinalFit Datacard/ area.

This reads the impacts.json files combineTool.py -M Impacts already produced (via
getImpacts_frozenEnvelope.sh --unblindRamSettings) -- it does NOT run combine itself, so
it needs no CMSSW/ROOT environment and runs in seconds. It reproduces plotImpacts.py's
own ranking/impact formulas exactly (see CombineHarvester/CombineTools/scripts/
plotImpacts.py) so "top 30" here means the same set that lands on page 1 of the tornado
PDF, with the same signed impact_hi/impact_lo used to draw the bars:

    impact_hi = r[2] - r[1]   (Delta-r from pushing the nuisance to +1 sigma)
    impact_lo = r[0] - r[1]   (Delta-r from pushing the nuisance to -1 sigma)
    rank key  = abs(impact_r) descending   (impact_r is written into the json directly
                                             by combineTool.py -- not recomputed here)

"One-sided" here is about the IMPACT ON r, not the raw nuisance value -- a nuisance is
one-sided if moving it in one direction barely moves r while moving it the other way
moves r a lot: ratio = min(|impact_hi|, |impact_lo|) / max(|impact_hi|, |impact_lo|),
flagged when ratio < --ratio-threshold (default 0.05, i.e. the smaller side is under 5%
of the larger side). A nuisance with essentially zero impact either way (max side below
--min-impact) is excluded rather than called one-sided -- "no effect" is not the same
claim as "one-directional effect".

Each mass point's impacts.json already reports ONE row per nuisance from the actual
multi-category profile likelihood fit -- no per-category/per-process aggregation is
invented here; whatever combineTool.py already resolved across categories is what gets
read straight through per mass point.

Usage:
    python3 find_onesided_impacts.py [--datacard-dir DIR] [--impacts-subdir NAME]
        [--per-page 30] [--ratio-threshold 0.05] [--min-impact 1e-6]
        [--out-csv FILE] [--out-onesided-csv FILE] [--mx MX --my MY]
"""
import argparse
import csv
import glob
import json
import os
import re
import sys

MASSPOINT_RE = re.compile(r"^datacard_MX(\d+)_MY(\d+)$")

# NOTE: different mass points in this grid were run with different --rMin/--rMax overrides
# (most at the --unblindRamSettings default r=[-1,3]; 13 low-stat rescue points rerun with
# --passCombine "--rMin 0" per project_unblinding_convergence_MX1600_MY250 memory) -- the
# actual range used per point is NOT recorded in impacts.json, so pinning can't be checked
# against a hardcoded range. Instead this checks whether the fitted best-fit sits at either
# edge of its OWN reported uncertainty interval (r_best == r_lo or r_best == r_hi to within
# R_PIN_ABS_TOL) -- the classic sign of a hard-wall collapse regardless of where that wall
# actually is. This correctly catches points pinned at -1, at 0, or at any other boundary,
# with no per-point config needed.
# 1e-6 missed MX700_MY250 (gap=3.16e-6, clearly still a collapsed fit -- MINOS/Migrad just
# didn't converge to exactly the wall). Every genuinely pinned point found so far has a gap
# <1e-10; every genuinely unpinned point found so far has a gap >0.05 -- huge separation, so
# 1e-4 has wide margin on both sides without needing a width-relative threshold.
R_PIN_ABS_TOL = 1e-4
# Separately: an unusually WIDE interval (not collapsed, just huge) is its own pathology --
# r essentially unconstrained -- flagged when r_hi - r_lo exceeds this (picked by inspection:
# healthy points in this grid run ~0.1-0.3 wide; the worst offenders found so far are 4-7 wide).
R_WIDTH_FLAG = 1.0


def load_impacts(path):
    with open(path) as fh:
        return json.load(fh)


def r_pin_status(data):
    """Checks the fitted POI (r) for two pathologies that make every impact_r at this mass
    point suspect (see project_unblinding_convergence_MX1600_MY250 memory): the best fit
    sitting exactly on its own uncertainty interval's edge (classic hard-wall collapse --
    config-independent, so it catches pinning at -1, at 0, or at any other boundary a
    per-point --passCombine override might use), or the interval being unusually wide
    (near-totally-unconstrained r, a different pathology from pinning)."""
    poi = data["POIs"][0]
    r_lo, r_best, r_hi = poi["fit"]
    pinned_at_lo = (r_best - r_lo) < R_PIN_ABS_TOL
    pinned_at_hi = (r_hi - r_best) < R_PIN_ABS_TOL
    return {
        "r_bestfit": r_best,
        "r_lo": r_lo,
        "r_hi": r_hi,
        "r_pinned": pinned_at_lo or pinned_at_hi,
        "r_band_wide": (r_hi - r_lo) > R_WIDTH_FLAG,
    }


def process_one(data, per_page, ratio_threshold, min_impact):
    """Returns (full_top_rows, onesided_rows) for one mass point's impacts.json."""
    pois = [ele["name"] for ele in data["POIs"]]
    poi = pois[0]  # flashggFinalFit's impacts.json always has a single POI, r
    impact_key = "impact_%s" % poi
    pin = r_pin_status(data)

    rows = []
    for ele in data["params"]:
        r = ele[poi]  # [r_lo, r_bestfit, r_hi], same convention as plotImpacts.py
        impact_hi = r[2] - r[1]
        impact_lo = r[0] - r[1]
        rows.append({
            "param": ele["name"],
            "type": ele.get("type", ""),
            "impact_r": ele.get(impact_key),
            "impact_hi": impact_hi,
            "impact_lo": impact_lo,
            "r_bestfit": r[1],
            "r_pinned": pin["r_pinned"],
            "r_band_wide": pin["r_band_wide"],
        })

    # Same rank key plotImpacts.py's default --sort impact uses.
    rows.sort(key=lambda x: abs(x["impact_r"]) if x["impact_r"] is not None else 0.0, reverse=True)
    top = rows[:per_page]
    for i, row in enumerate(top):
        row["rank"] = i + 1
        hi, lo = abs(row["impact_hi"]), abs(row["impact_lo"])
        biggest, smallest = max(hi, lo), min(hi, lo)
        if biggest < min_impact:
            row["ratio"] = None
            row["is_onesided"] = False  # negligible impact either way -- not "one-sided", just dead
        else:
            row["ratio"] = smallest / biggest
            row["is_onesided"] = row["ratio"] < ratio_threshold

    onesided = [row for row in top if row["is_onesided"]]
    return top, onesided, pin


def find_masspoint_dirs(datacard_dir, mx=None, my=None):
    out = []
    for path in sorted(glob.glob(os.path.join(datacard_dir, "datacard_MX*_MY*"))):
        m = MASSPOINT_RE.match(os.path.basename(path))
        if not m:
            continue
        this_mx, this_my = m.group(1), m.group(2)
        if mx is not None and this_mx != str(mx):
            continue
        if my is not None and this_my != str(my):
            continue
        out.append((this_mx, this_my, path))
    return out


def write_csv(path, rows):
    fieldnames = ["MX", "MY", "rank", "param", "type", "impact_r", "impact_hi", "impact_lo",
                  "ratio", "is_onesided", "r_bestfit", "r_pinned", "r_band_wide"]
    with open(path, "w") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--datacard-dir", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "Datacard"),
        help="Directory containing datacard_MX*_MY* subdirs (default: ./Datacard next to this script)")
    ap.add_argument("--impacts-subdir", default="impacts_unblindedRamSettings_frozenEnvelope",
        help="Subdirectory under each datacard_MX*_MY*/ holding impacts.json "
             "(default: impacts_unblindedRamSettings_frozenEnvelope, the getImpacts_frozenEnvelope.sh "
             "--unblindRamSettings output -- covers 240/240 mass points as of 2026-09-15)")
    ap.add_argument("--impacts-filename", default="impacts.json")
    ap.add_argument("--per-page", type=int, default=30, help="Matches plotImpacts.py's --per-page default")
    ap.add_argument("--ratio-threshold", type=float, default=0.05,
        help="Flag as one-sided when min(|impact_hi|,|impact_lo|)/max(...) is below this (default 0.05 = strict)")
    ap.add_argument("--min-impact", type=float, default=1e-6,
        help="Below this |impact_r| on the larger side, treat as no real effect rather than one-sided")
    ap.add_argument("--mx", default=None, help="Restrict to a single mass point (with --my)")
    ap.add_argument("--my", default=None, help="Restrict to a single mass point (with --mx)")
    ap.add_argument("--out-csv", default="onesided_impacts_top30_full.csv",
        help="CSV with every top-30 row per mass point (is_onesided column included)")
    ap.add_argument("--out-onesided-csv", default="onesided_impacts_top30_flagged.csv",
        help="CSV with only the rows flagged one-sided")
    args = ap.parse_args()

    masspoints = find_masspoint_dirs(args.datacard_dir, args.mx, args.my)
    if not masspoints:
        sys.stderr.write("No datacard_MX*_MY* directories found under %s\n" % args.datacard_dir)
        sys.exit(1)

    full_rows = []
    onesided_rows = []
    missing = []
    onesided_counts = {}  # param name -> number of mass points where it was flagged
    pinned_points = []  # r_bestfit sitting exactly on its own interval's edge (any boundary)
    wide_band_points = []  # interval unusually wide -- essentially unconstrained, not pinned

    for mx, my, dirpath in masspoints:
        jsonpath = os.path.join(dirpath, args.impacts_subdir, args.impacts_filename)
        if not os.path.isfile(jsonpath):
            missing.append((mx, my))
            continue
        try:
            data = load_impacts(jsonpath)
        except (ValueError, KeyError) as e:
            sys.stderr.write("WARNING: could not parse %s (%s) -- skipping\n" % (jsonpath, e))
            missing.append((mx, my))
            continue

        top, onesided, pin = process_one(data, args.per_page, args.ratio_threshold, args.min_impact)
        for row in top:
            row["MX"], row["MY"] = mx, my
            full_rows.append(row)
        for row in onesided:
            onesided_rows.append(row)
            onesided_counts[row["param"]] = onesided_counts.get(row["param"], 0) + 1
        if pin["r_pinned"]:
            pinned_points.append((mx, my, pin["r_lo"], pin["r_bestfit"], pin["r_hi"]))
        elif pin["r_band_wide"]:
            wide_band_points.append((mx, my, pin["r_lo"], pin["r_bestfit"], pin["r_hi"]))

    write_csv(args.out_csv, full_rows)
    write_csv(args.out_onesided_csv, onesided_rows)

    n_ok = len(masspoints) - len(missing)
    print("Mass points found: %d   processed: %d   missing '%s/%s': %d" %
          (len(masspoints), n_ok, args.impacts_subdir, args.impacts_filename, len(missing)))
    if missing:
        print("Missing mass points (MX,MY): " + ", ".join("%s_%s" % (mx, my) for mx, my in missing))
    print("")
    print("Top-30-by-impact rows written: %d -> %s" % (len(full_rows), args.out_csv))
    print("One-sided-flagged rows written: %d -> %s" % (len(onesided_rows), args.out_onesided_csv))
    print("")
    print("Nuisances flagged one-sided most often across mass points (top 20):")
    for name, count in sorted(onesided_counts.items(), key=lambda kv: kv[1], reverse=True)[:20]:
        print("  %4d / %-4d mass points: %s" % (count, n_ok, name))
    print("")
    print("CAUTION -- r-hat pinned at its own interval's edge (%d mass points, tol %.0e): every "
          "impact_r/one-sided flag at these points rides on a collapsed-curvature fit, not a "
          "real ranking (see project_unblinding_convergence_MX1600_MY250 memory, MX2600_MY500 "
          "case). Rows for these ARE still included in both CSVs -- r_pinned column marks them "
          "so you can exclude/deprioritize in your own tabulation:" % (len(pinned_points), R_PIN_ABS_TOL))
    for mx, my, lo, best, hi in pinned_points:
        print("  MX%-6s MY%-6s r=[%.4g, %.4g, %.4g]" % (mx, my, lo, best, hi))
    if wide_band_points:
        print("")
        print("NOTE -- r-hat's interval is unusually wide (> %g, not pinned, but essentially "
              "unconstrained) at %d mass points -- r_band_wide column marks these:" %
              (R_WIDTH_FLAG, len(wide_band_points)))
        for mx, my, lo, best, hi in wide_band_points:
            print("  MX%-6s MY%-6s r=[%.4g, %.4g, %.4g]" % (mx, my, lo, best, hi))


if __name__ == "__main__":
    main()
