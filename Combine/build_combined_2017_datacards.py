#!/usr/bin/env python

import os
import glob
import sys
import numpy as np

year = '2017'

def get_all_masspoints():
    return np.array([
        [1000, 250], [1000, 300], [1000, 400], [1000, 500], [1000, 600], [1000, 700], [1000, 800],
        [1200, 1000], [1200, 250], [1200, 300], [1200, 400], [1200, 500], [1200, 600], [1200, 700],
        [1200, 800], [1200, 900], [1400, 1000], [1400, 1100], [1400, 1200], [1400, 250], [1400, 300],
        [1400, 400], [1400, 500], [1400, 600], [1400, 700], [1400, 800], [1400, 900], [1600, 1000],
        [1600, 1100], [1600, 1200], [1600, 1300], [1600, 1400], [1600, 250], [1600, 300], [1600, 400],
        [1600, 500], [1600, 600], [1600, 700], [1600, 800], [1600, 900], [1800, 1000], [1800, 1100],
        [1800, 1200], [1800, 1300], [1800, 1400], [1800, 1600], [1800, 250], [1800, 300], [1800, 400],
        [1800, 500], [1800, 600], [1800, 700], [1800, 800], [1800, 900], [2000, 1000], [2000, 1100],
        [2000, 1200], [2000, 1300], [2000, 1400], [2000, 1600], [2000, 1800], [2000, 250], [2000, 300],
        [2000, 400], [2000, 500], [2000, 600], [2000, 700], [2000, 800], [2000, 900], [2200, 1000],
        [2200, 1100], [2200, 1200], [2200, 1300], [2200, 1400], [2200, 1600], [2200, 1800], [2200, 2000],
        [2200, 250], [2200, 300], [2200, 400], [2200, 500], [2200, 600], [2200, 700], [2200, 800],
        [2200, 900], [2400, 1000], [2400, 1100], [2400, 1200], [2400, 1300], [2400, 1400], [2400, 1600],
        [2400, 1800], [2400, 2000], [2400, 2200], [2400, 250], [2400, 300], [2400, 400], [2400, 500],
        [2400, 600], [2400, 700], [2400, 800], [2400, 900], [2500, 1000], [2500, 1100], [2500, 1200],
        [2500, 1300], [2500, 1400], [2500, 1600], [2500, 1800], [2500, 2000], [2500, 2200], [2500, 250],
        [2500, 300], [2500, 400], [2500, 500], [2500, 600], [2500, 700], [2500, 800], [2500, 900],
        [2600, 1000], [2600, 1100], [2600, 1200], [2600, 1300], [2600, 1400], [2600, 1600], [2600, 1800],
        [2600, 2000], [2600, 2200], [2600, 2400], [2600, 250], [2600, 300], [2600, 400], [2600, 500],
        [2600, 600], [2600, 700], [2600, 800], [2600, 900], [2800, 1000], [2800, 1100], [2800, 1200],
        [2800, 1300], [2800, 1400], [2800, 1600], [2800, 1800], [2800, 2000], [2800, 2200], [2800, 2400],
        [2800, 2500], [2800, 250], [2800, 2600], [2800, 300], [2800, 400], [2800, 500], [2800, 600],
        [2800, 700], [2800, 800], [2800, 900], [3000, 1000], [3000, 1100], [3000, 1200], [3000, 1300],
        [3000, 1400], [3000, 1600], [3000, 1800], [3000, 2000], [3000, 2200], [3000, 2400], [3000, 2500],
        [3000, 250], [3000, 2600], [3000, 2800], [3000, 300], [3000, 400], [3000, 500], [3000, 600],
        [3000, 700], [3000, 800], [3000, 900], [3500, 1000], [3500, 1100], [3500, 1200], [3500, 1300],
        [3500, 1400], [3500, 1600], [3500, 1800], [3500, 2000], [3500, 2200], [3500, 2400], [3500, 2500],
        [3500, 250], [3500, 2600], [3500, 2800], [3500, 300], [3500, 400], [3500, 500], [3500, 600],
        [3500, 700], [3500, 800], [3500, 900], [4000, 1000], [4000, 1100], [4000, 1200], [4000, 1300],
        [4000, 1400], [4000, 1600], [4000, 1800], [4000, 2000], [4000, 2200], [4000, 2400], [4000, 2500],
        [4000, 250], [4000, 2600], [4000, 2800], [4000, 300], [4000, 400], [4000, 500], [4000, 600],
        [4000, 700], [4000, 800], [4000, 900], [500, 250], [500, 300], [600, 250], [600, 300], [600, 400],
        [700, 250], [700, 300], [700, 400], [700, 500], [800, 250], [800, 300], [800, 400], [800, 500],
        [800, 600], [900, 250], [900, 300], [900, 400], [900, 500], [900, 600], [900, 700]
    ], dtype=int)

mass_points = ["MX{0}_MY{1}".format(mx, my) for mx, my in get_all_masspoints()]
cat_names   = ['cat12lowpurity', 'cat12highpurity']

datacard_dir   = '/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard'
signal_ws_base = '/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit'
bkg_ws_base    = '/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit'

processes = ['ggyhwwgg', 'ggyhVBF', 'ggyhTTH', 'ggyhVH', 'ggyhGGH']
labels    = ["wwgg",     "VBF",      "TTH",      "VH",      "GGH"]

datacard_clean_suffix = ""

if "16" in year:
    yieldyear = "16"
else:
    yieldyear = year.split("20")[-1]  # "2017" -> "17"


def run_cmd(cmd):
    """Print and execute a shell command."""
    print(cmd)
    ret = os.system(cmd)
    if ret != 0:
        print("  [WARNING] Command returned non-zero exit status: %d" % ret)
    return ret


for mass in mass_points:
    # Per-mass datacard subdirectory:
    mass_dc_dir = os.path.join(datacard_dir, "datacards/datacard_{0}".format(mass))
    if not os.path.isdir(mass_dc_dir):
        # No datacards yet for this mass point
        continue

    print("\n#################### %s ####################" % mass)
    no_cat = []

    for category in cat_names:
        print("\n# ======================= {0}, {1} =======================".format(mass, category))

        # 1) Per-process datacard paths inside datacards/datacard_{mass}/
        perproc_dc = {}
        for label in labels:
            dc_name = "Datacard_{0}_{1}_{2}_{3}{4}.txt".format(
                mass, year, label, category, datacard_clean_suffix
            )
            perproc_dc[label] = os.path.join(mass_dc_dir, dc_name)

        # 2) Per-process signal WS dirs
        ws_mass_mc_dir = os.path.join(signal_ws_base, year, mass, "mc")

        FHSLws_path = os.path.join(
            ws_mass_mc_dir, "ws_ggyhwwgg_{0}_{1}_{2}_wwgg".format(mass, year, category)
        )
        vbfws_path = os.path.join(
            ws_mass_mc_dir, "ws_ggyhVBF_{0}_{1}_{2}_VBF".format(mass, year, category)
        )
        tthws_path = os.path.join(
            ws_mass_mc_dir, "ws_ggyhTTH_{0}_{1}_{2}_TTH".format(mass, year, category)
        )
        vhws_path = os.path.join(
            ws_mass_mc_dir, "ws_ggyhVH_{0}_{1}_{2}_VH".format(mass, year, category)
        )
        gghws_path = os.path.join(
            ws_mass_mc_dir, "ws_ggyhGGH_{0}_{1}_{2}_GGH".format(mass, year, category)
        )

        FHSLsignalmodel = glob.glob(os.path.join(FHSLws_path, "CMS-HGG_sigfit_packaged_*.root"))
        vbfsignalmodel  = glob.glob(os.path.join(vbfws_path,  "CMS-HGG_sigfit_packaged_*.root"))
        tthsignalmodel  = glob.glob(os.path.join(tthws_path,  "CMS-HGG_sigfit_packaged_*.root"))
        vhsignalmodel   = glob.glob(os.path.join(vhws_path,   "CMS-HGG_sigfit_packaged_*.root"))
        gghsignalmodel  = glob.glob(os.path.join(gghws_path,  "CMS-HGG_sigfit_packaged_*.root"))

        # 3) Check datacard size > 1000 bytes
        FHSLsignaltxt = os.path.exists(perproc_dc["wwgg"]) and os.path.getsize(perproc_dc["wwgg"]) > 1000
        vbfsignaltxt  = os.path.exists(perproc_dc["VBF"])  and os.path.getsize(perproc_dc["VBF"])  > 1000
        tthsignaltxt  = os.path.exists(perproc_dc["TTH"])  and os.path.getsize(perproc_dc["TTH"])  > 1000
        vhsignaltxt   = os.path.exists(perproc_dc["VH"])   and os.path.getsize(perproc_dc["VH"])   > 1000
        gghsignaltxt  = os.path.exists(perproc_dc["GGH"])  and os.path.getsize(perproc_dc["GGH"])  > 1000

        FHSLok = (len(FHSLsignalmodel) > 0) and FHSLsignaltxt
        vbflok = (len(vbfsignalmodel)  > 0) and vbfsignaltxt
        tthok  = (len(tthsignalmodel)  > 0) and tthsignaltxt
        vhok   = (len(vhsignalmodel)   > 0) and vhsignaltxt
        gghok  = (len(gghsignalmodel)  > 0) and gghsignaltxt

        ifprocess = [FHSLok, vbflok, tthok, vhok, gghok]

        existed_process = " "
        for i, ok in enumerate(ifprocess):
            if ok:
                existed_process += processes[i] + ","

        process_list = [p for p in existed_process.split(",") if p.strip()]

        # Case a) no valid process → mark empty
        if len(process_list) == 0:
            print("# No valid processes for {0}, {1}".format(mass, category))
            no_cat.append(category)
            continue

        # Case b) only ggyhwwgg → copy that datacard up one level
        if (len(process_list) == 1) and ("ggyhwwgg" in process_list):
            src = os.path.basename(perproc_dc["wwgg"])
            dst = "{0}_{1}_{2}.txt".format(mass, year, category)
            cmd = "(cd {0} && cp {1} ../{2})".format(mass_dc_dir, src, dst)
            run_cmd(cmd)
            # For this case we don't need RunYields/makeDatacard; shapes already point to ws_ggyhwwgg
            continue

        # Case c) only one non-wwgg → skip this category
        if (len(process_list) == 1) and ("ggyhwwgg" not in process_list):
            print("# Only non-ggyhwwgg process present for {0}, {1} – skipping".format(mass, category))
            no_cat.append(category)
            continue

        # Case d) multiple processes → build combined signal WS and combined datacard
        combine_ws_dir = os.path.join(
            ws_mass_mc_dir,
            "ws_ggyhcombine_{0}_{1}_{2}".format(mass, year, category)
        )

        # Make combined WS dir and copy all ws_ggyh*cat* ROOT files into it
        cmd = "mkdir -p {0}".format(combine_ws_dir)
        run_cmd(cmd)

        pattern = os.path.join(ws_mass_mc_dir, "ws_ggyh*{0}*/*.root".format(category))
        cmd = "cp {0} {1}/".format(pattern, combine_ws_dir)
        run_cmd(cmd)

        # Background WS dir (matches the shapes line in your example datacard)
        bkg_ws_dir = os.path.join(
            bkg_ws_base, year, mass,
            "data",
            "ws_{0}_{1}".format(year, category)
        )

        # RunYields
        yield_ext = "{0}_{1}_{2}".format(mass, year, category)
        yieldcommand = (
            "python RunYields_{yy}resolved_combined.py "
            "--cats {cat} "
            "--inputWSDirMap {year}={combine} "
            "--procs {procs} "
            "--sigModelWSDir {year}={combine} "
            "--bkgModelWSDir {bkg} "
            "--cats {cat} "
            "--doSystematics --batch local --ext {ext}"
        ).format(
            yy=yieldyear,
            cat=category,
            year=year,
            combine=combine_ws_dir,
            procs=existed_process.replace(" ", "").rstrip(","),
            bkg=bkg_ws_dir,
            ext=yield_ext
        )
        cmd = "(cd {0} && {1})".format(datacard_dir, yieldcommand)
        run_cmd(cmd)

        # makeDatacard
        mdc_ext = yield_ext
        mkdatacard = (
            "python makeDatacard_{yy}resolved_combined.py "
            "--years {year} --doSystematics --prune "
            "--ext {ext} --output {out}"
        ).format(
            yy=yieldyear,
            year=year,
            ext=mdc_ext,
            out="{0}_{1}_{2}".format(mass, year, category)
        )
        cmd = "(cd {0} && {1})".format(datacard_dir, mkdatacard)
        run_cmd(cmd)

        # Fix WS directory names and purity nuisances
        process_txt = (
            "strlist=($(grep \"shapes *ggyh*\" {mass}_{year}_{cat}.txt | "
            "awk '{{print $2}}' | cut -d'_' -f1))"
        ).format(mass=mass, year=year, cat=category)

        cmd = (
            "(cd {dc} && {pt}; "
            "for str in \"${{strlist[@]}}\"; do "
            "sed -i '0,/ws_ggyhcombine/s//ws_${{str}}/' '{mass}_{year}_{cat}.txt'; "
            "sed -i '0,/purity\\/CMS/s//purity_${{str#ggyh}}\\/CMS/' '{mass}_{year}_{cat}.txt'; "
            "done)"
        ).format(
            dc=datacard_dir,
            pt=process_txt,
            mass=mass,
            year=year,
            cat=category
        )
        run_cmd(cmd)

        # Remove "2017=" prefix in WS paths
        replace_ws_prefix = "sed -i 's/{0}=//g' {1}_{0}_{2}.txt".format(
            year, mass, category
        )
        cmd = "(cd {0} && {1})".format(datacard_dir, replace_ws_prefix)
        run_cmd(cmd)

        # Remove combined WS dir (now datacard points to per-process WS dirs)
        cmd = "rm -r {0}".format(combine_ws_dir)
        run_cmd(cmd)

        # text2workspace for per-category combined datacard
        cat_dc = "{0}_{1}_{2}.txt".format(mass, year, category)
        cmd = "(cd {0} && text2workspace.py {1} -m 125)".format(datacard_dir, cat_dc)
        run_cmd(cmd)

    # ------------------ combine cat12 cats → cat12 ------------------
    # If both categories empty, skip this mass
    if len(no_cat) == len(cat_names):
        print("# WARNING: Skipping {0} because both cat12 categories are empty".format(mass))
        continue

    # Default combine with both cats
    combinecommand = (
        "combineCards.py "
        "cat12lowpurity_{year}={mass}_{year}_cat12lowpurity.txt "
        "cat12highpurity_{year}={mass}_{year}_cat12highpurity.txt "
        "> {mass}_{year}_cat12.txt"
    ).format(year=year, mass=mass)

    # If exactly one cat is empty, drop it from the combine command
    if len(no_cat) > 0 and len(no_cat) < len(cat_names):
        for category in no_cat:
            rmcat = "{cat}_{year}={mass}_{year}_{cat}.txt".format(
                cat=category, year=year, mass=mass
            )
            combinecommand = combinecommand.replace(rmcat, "")

    cmd = "(cd {0} && {1})".format(datacard_dir, combinecommand)
    run_cmd(cmd)

    # Remove HH BR nuisance (if present)
    rmcommand = "sed -i '/CMS_wwgg_br_HH_WWgg/d' {0}_{1}_cat12.txt".format(mass, year)
    cmd = "(cd {0} && {1})".format(datacard_dir, rmcommand)
    run_cmd(cmd)

    # text2workspace on the combined cat12 datacard
    cat12_dc = "{0}_{1}_cat12.txt".format(mass, year)
    cmd = "(cd {0} && text2workspace.py {1} -m 125)".format(datacard_dir, cat12_dc)
    run_cmd(cmd)

print("\nAll done.")
