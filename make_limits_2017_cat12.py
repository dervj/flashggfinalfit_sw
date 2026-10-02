#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import subprocess
import ROOT



BASE_FF_DIR   = "/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit"
DATACARD_ROOT = os.path.join(BASE_FF_DIR, "Datacard")
COMBINED_DIR  = os.path.join(DATACARD_ROOT, "combined_datacards")

OUT_CSV       = os.path.join(COMBINED_DIR, "limits_2017_cat12_expected_1p8to4TeV_mergedbkg.csv")
# OUT_CSV       = os.path.join(COMBINED_DIR, "limits_2017_cat12_expected_upto1p6TeV_mergedbkg.csv")
# MASSPOINTS_FILE = os.path.join(COMBINED_DIR, "masspoints_2017.dat")  # new
# MASSPOINTS_FILE = '/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_2017_upto1p6TeV.dat'
MASSPOINTS_FILE = '/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_2017_1p8to4TeV.dat'



def run_cmd(cmd):
    print(cmd)
    ret = subprocess.call(cmd, shell=True)
    if ret != 0:
        print("  [WARNING] Command returned non-zero exit status: %d" % ret)
    return ret


def parse_mass_dir(name):
    """
    name = 'MX1600_MY1100' -> (1600, 1100)
    """
    if not name.startswith("MX") or "_MY" not in name:
        return None, None
    try:
        parts = name.split("_")
        mx = int(parts[0].replace("MX", ""))
        my = int(parts[1].replace("MY", ""))
        return mx, my
    except Exception:
        return None, None


def get_expected_limits(rootfile):
    """
    Read AsymptoticLimits tree and return:
      [q2.5%, q16%, q50%, q84%, q97.5%]
    (expected-only; ignore any extra entries)
    """
    if not os.path.exists(rootfile):
        print("  [WARNING] combine output not found: %s" % rootfile)
        return None

    f = ROOT.TFile.Open(rootfile)
    if not f or f.IsZombie():
        print("  [WARNING] Could not open file: %s" % rootfile)
        return None

    t = f.Get("limit")
    if not t:
        print("  [WARNING] No 'limit' tree in file: %s" % rootfile)
        f.Close()
        return None

    vals = []
    for i in range(t.GetEntries()):
        t.GetEntry(i)
        vals.append(float(t.limit))

    f.Close()

    if len(vals) < 5:
        print("  [WARNING] Too few entries in limit tree (%d) in %s" % (len(vals), rootfile))
        return None

    # only keep the first 5 expected quantiles
    return vals[:5]


def load_masspoints_from_dat(dat_path, year_filter="2017"):
    """
    Read masspoints_2017.dat-style file with lines like:
      2017 1600 1100
    Returns a list of (MX, MY) for the given year_filter.
    """
    points = []
    if not os.path.exists(dat_path):
        return points

    print("[INFO] Using mass points from %s" % dat_path)
    with open(dat_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            parts = line.split()
            if len(parts) < 3:
                continue
            year = parts[0]
            if year != year_filter:
                continue
            try:
                mx = int(parts[1])
                my = int(parts[2])
            except ValueError:
                continue
            points.append((mx, my))

    return points


def discover_masspoints(max_mx=None):
    """
    Decide which mass points to run over.

    Priority:
      1) If MASSPOINTS_FILE exists: use only mass points listed there
         (2017 MX MY) and for which combined_datacards/MX*_MY* exists.
      2) Otherwise: scan directories under combined_datacards.
    """
    mass_list = []

    if os.path.exists(MASSPOINTS_FILE):
        # Load from dat file
        dat_points = load_masspoints_from_dat(MASSPOINTS_FILE, year_filter="2017")
        seen = set()
        for mx, my in dat_points:
            if max_mx is not None and mx > max_mx:
                continue
            mass_dir = "MX%d_MY%d" % (mx, my)
            full_dir = os.path.join(COMBINED_DIR, mass_dir)
            if not os.path.isdir(full_dir):
                print("[INFO] Directory missing for %s -> skipping" % mass_dir)
                continue
            key = (mx, my)
            if key in seen:
                continue
            seen.add(key)
            mass_list.append((mx, my, full_dir))

    else:
        # Fallback: discover from directories
        print("[INFO] %s not found, discovering mass points from directory names." % MASSPOINTS_FILE)
        for d in os.listdir(COMBINED_DIR):
            full_dir = os.path.join(COMBINED_DIR, d)
            if not os.path.isdir(full_dir):
                continue
            mx, my = parse_mass_dir(d)
            if mx is None:
                continue
            if max_mx is not None and mx > max_mx:
                continue
            mass_list.append((mx, my, full_dir))

        # sort by MX, then MY
        mass_list.sort(key=lambda t: (t[0], t[1]))

    return mass_list


def main():
    # Optional: allow restricting by MX via command line
    # Usage: make_limits_2017_cat12.py [MAX_MX]
    max_mx = None
    if len(sys.argv) == 2:
        try:
            max_mx = int(sys.argv[1])
        except ValueError:
            print("Usage: make_limits_2017_cat12.py [MAX_MX]")
            sys.exit(1)

    mass_points = discover_masspoints(max_mx=max_mx)

    if not mass_points:
        print("[WARNING] No mass points found to process.")
        return

    rows = []
    rows.append("# MX,MY,q2p5,q16,q50,q84,q97p5  (expected-only, blinded)")

    for mx, my, mass_dir in mass_points:
        mass = "MX%d_MY%d" % (mx, my)
        print("\n>>> Processing %s" % mass)

        ws_name = "%s_2017_cat12.root" % mass
        ws_path = os.path.join(mass_dir, ws_name)
        if not os.path.exists(ws_path):
            print("[INFO] Workspace missing for %s -> skipping" % mass)
            continue

        comb_out = os.path.join(
            mass_dir,
            "higgsCombine%s_2017_cat12.AsymptoticLimits.mH125.root" % mass
        )

        if not os.path.exists(comb_out):
            print(">>> Running AsymptoticLimits (expected-only, blinded) for %s" % mass)
            cmd = (
                "cd {mdir} && "
                "combine -M AsymptoticLimits {ws} "
                "-m 125 -n {mass}_2017_cat12 "
                "-t -1 --expectSignal=0 --run blind"
            ).format(
                mdir=mass_dir,
                ws=ws_name,
                mass=mass
            )
            run_cmd(cmd)
        else:
            print(">>> Reusing existing combine output for %s" % mass)

        limits = get_expected_limits(comb_out)
        if limits is None:
            continue

        q2p5, q16, q50, q84, q97p5 = limits
        row = "%d,%d,%.6g,%.6g,%.6g,%.6g,%.6g" % (mx, my, q2p5, q16, q50, q84, q97p5)
        rows.append(row)

    print("\n[INFO] Writing expected limits to %s" % OUT_CSV)
    with open(OUT_CSV, "w") as f:
        for r in rows:
            f.write(r + "\n")

    print("[OK] Done (expected-only, blinded).")


if __name__ == "__main__":
    main()
