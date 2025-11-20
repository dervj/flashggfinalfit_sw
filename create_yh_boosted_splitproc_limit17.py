# -*- coding: utf-8 -*-
"""
Master script to go from ntuples (root) to limits with flashggFinalFit
for boosted YH cat12 categories, with mc and data in separate subdirs.

Directory layout assumed:
  EOS_BASE / YEAR / MXxxx_MYyyy / mc   : signal ntuples and signal workspaces
  EOS_BASE / YEAR / MXxxx_MYyyy / data : data ntuples and background workspaces
"""

import os
import time
import logging
import subprocess
import sys
import argparse
import glob
import shutil

#Add argument to take mass_point at command line 


parser = argparse.ArgumentParser(description='Process mass point.')
parser.add_argument('--mass_point', type=str, required=True, help='Mass point in the format MXxxx_MYyyy')
args = parser.parse_args()


YEAR = "2017"
# PYTHON = sys.executable
# CMSSW and flashgg base
CMSSW_BASE = os.environ.get("CMSSW_BASE", "")
if not CMSSW_BASE:
    raise RuntimeError("CMSSW_BASE is not set. Please cmsenv before running.")

# adjust if your directory name is different
FGG_BASE = os.path.join(CMSSW_BASE, "src", "flashggFinalFit")

# base EOS path where per mass workspaces live
EOS_BASE = "/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit"

# logging
LOG_FILE = os.path.join(
    CMSSW_BASE,
    "src",
    # "flashggFinalFit",
    "flashggFinalFit",
    "YH_cat12_master.log",
)
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    filemode="w",
    format="%(asctime)s [%(levelname)s] %(message)s",
)

def run_cmd(command, log_message=None, cwd=None):
    if cwd:
        logging.info("cd %s", cwd)
        os.chdir(cwd)
    if log_message:
        logging.info(log_message)
    logging.info("command: %s", command)
    ret = subprocess.call(command, shell=True, stdout=subprocess.PIPE)
    if ret != 0:
        logging.warning("command returned nonzero status %s", ret)
    return ret

# Trees2WS for signal in mc

def run_Tree2WS_sig(sig_path, input_file, log_file, ws_tag, output_sig_root, process):
    logging.info("Trees2WS signal start: %s", time.time())

    process_prefix = process.split("ws_")[1]
    logging.info("process_prefix: %s", process_prefix)

    trees2ws_dir = os.path.join(FGG_BASE, "Trees2WS")

    cmd = (
        "python trees2ws.py "
        "--inputConfig config_sys17.py "
        "--inputTreeFile {inp}{file} "
        "--inputMass 125 "
        "--doSystematics "
        "--productionMode {pmode} "
        "--year {year} "
        "> {log} 2>&1"
    ).format(
        inp=sig_path + os.sep,
        file=input_file,
        pmode=process_prefix,
        year=YEAR,
        log=log_file,
    )
    run_cmd(cmd, log_message="run Trees2WS signal", cwd=trees2ws_dir)

    ws_dir = os.path.join(sig_path, process + "_" + ws_tag)
    cmd_mkdir = "mkdir -p {d}".format(d=ws_dir)
    run_cmd(cmd_mkdir, log_message="mkdir signal ws dir")

    src_file = os.path.join(
        sig_path,
        process,
        input_file.replace(".root", "") + "_" + process_prefix + ".root",
    )
    dst_file = os.path.join(ws_dir, output_sig_root)
    cmd_cp = "cp {src} {dst}".format(src=src_file, dst=dst_file)
    run_cmd(cmd_cp, log_message="copy signal ws to workspace")

    logging.info("Trees2WS signal end: %s", time.time())

# Trees2WS for data in data

def run_Tree2WS_data(data_path, ws_data_tag, data_root_name):
    logging.info("Trees2WS data start: %s", time.time())

    trees2ws_dir = os.path.join(FGG_BASE, "Trees2WS")

    cmd = (
        "python trees2ws_data.py "
        "--inputConfig config_simple.py "
        "--inputTreeFile {inp}{file}"
    ).format(
        inp=data_path + os.sep,
        file=data_root_name,
    )
    run_cmd(cmd, log_message="run Trees2WS data", cwd=trees2ws_dir)

    ws_data_dir = os.path.join(data_path, ws_data_tag)
    cmd_mkdir = "mkdir -p {d}".format(d=ws_data_dir)
    run_cmd(cmd_mkdir, log_message="mkdir data ws dir")

    src = os.path.join(data_path, "ws", data_root_name)
    dst = os.path.join(ws_data_dir, "allData.root")
    cmd_cp = "cp {src} {dst}".format(src=src, dst=dst)
    run_cmd(cmd_cp, log_message="copy data ws to workspace")

    logging.info("Trees2WS data end: %s", time.time())

# Signal fTest and photon syst

def run_ftest(ws_tag, log_file, sig_path, process, clean_output):
    logging.info("signal fTest start: %s", time.time())

    signal_dir = os.path.join(FGG_BASE, "Signal")
    os.chdir(signal_dir)

    outdir = "outdir_{year}_{ws}".format(year=YEAR, ws=ws_tag)
    outdir_pack = "outdir_packaged_{ws}".format(ws=ws_tag)

    if clean_output:
        run_cmd("rm -rf {d}".format(d=outdir), log_message="clean signal outdir")
        run_cmd("rm -rf {d}".format(d=outdir_pack), log_message="clean packaged outdir")

    cfg_name = "config_{proc}{ws}.py".format(proc=process, ws=ws_tag)
    cmd_cp = "cp config_yh2017.py {cfg}".format(cfg=cfg_name)
    run_cmd(cmd_cp, log_message="copy config_yh2017.py")

    time.sleep(2)

    cmd1 = 'sed -i "s#ws_path#{ws}#g" {cfg}'.format(ws=ws_tag, cfg=cfg_name)
    run_cmd(cmd1, log_message="sed ws_path placeholder")

    cmd2 = 'sed -i "s#input_path#{ipath}#g" {cfg}'.format(
        ipath=sig_path + os.sep,
        cfg=cfg_name,
    )
    run_cmd(cmd2, log_message="sed input_path placeholder")

    cmd3 = 'sed -i "s#ggyh#{proc}#g" {cfg}'.format(proc=process, cfg=cfg_name)
    run_cmd(cmd3, log_message="sed process placeholder")

    cmd_ftest = (
        "python RunSignalScripts.py "
        "--inputConfig {cfg} "
        "--mode fTest "
        "--modeOpts '--doPlots' "
        "> {log} 2>&1"
    ).format(cfg=cfg_name, log=log_file)
    run_cmd(cmd_ftest, log_message="run signal fTest")

    cmd_ph = (
        "python RunSignalScripts.py "
        "--inputConfig {cfg} "
        "--mode calcPhotonSyst "
        "> {log} 2>&1"
    ).format(cfg=cfg_name, log=log_file)
    run_cmd(cmd_ph, log_message="run calcPhotonSyst")

    logging.info("signal fTest end: %s", time.time())

# Signal fit

def run_signalfit(ws_tag, log_file, sig_path, process):
    logging.info("signalFit start: %s", time.time())

    signal_dir = os.path.join(FGG_BASE, "Signal")
    os.chdir(signal_dir)

    process_prefix = process.split("ws_")[1]
    cfg_name = "config_{proc}{ws}.py".format(proc=process_prefix, ws=ws_tag)

    cmd = (
        "python RunSignalScripts.py "
        "--inputConfig {cfg} "
        "--mode signalFit "
        "> {log} 2>&1"
    ).format(cfg=cfg_name, log=log_file)
    run_cmd(cmd, log_message="run signalFit")

    src_pattern = "outdir_{year}_{ws}/signalFit/output/*.root".format(
        year=YEAR,
        ws=ws_tag,
    )
    ws_dir = os.path.join(sig_path, process + "_" + ws_tag)
    cmd_cp = "cp {src} {dst}".format(src=src_pattern, dst=ws_dir)
    run_cmd(cmd_cp, log_message="copy signalFit outputs to workspace")

    logging.info("signalFit end: %s", time.time())

# Packager and plotter

def run_signal_plot(output_ext, cats, exts, log_packaged, ws_tag,
                    sig_path, log_plotter, cp_name, process):
    logging.info("signal packaging and plotting start: %s", time.time())

    signal_dir = os.path.join(FGG_BASE, "Signal")
    os.chdir(signal_dir)

    cmd_pack = (
        "python RunPackager.py "
        "--cats {cats} "
        "--exts {exts} "
        "--batch local "
        "--massPoints 125 "
        "--year {year} "
        "--outputExt {out} "
        "> {log} 2>&1"
    ).format(
        cats=cats,
        exts=exts,
        year=YEAR,
        out=output_ext,
        log=log_packaged,
    )
    run_cmd(cmd_pack, log_message="run packager")

    cmd_plot = (
        "python RunPlotter2017.py "
        "--cats {cats} "
        "--procs all "
        "--years {year} "
        "--ext {ext} "
        "> {log} 2>&1"
    ).format(
        cats=cats,
        year=YEAR,
        ext=output_ext,
        log=log_plotter,
    )
    run_cmd(cmd_plot, log_message="run plotter")

    outdir_pack = "outdir_packaged_{ws}".format(ws=ws_tag)

    ws_dir = os.path.join(sig_path, process + "_" + ws_tag)
    src_ws = os.path.join(outdir_pack, "*.root")
    cmd_cp_ws = "cp {src} {dst}/{name}".format(
        src=src_ws,
        dst=ws_dir,
        name=cp_name,
    )
    run_cmd(cmd_cp_ws, log_message="copy packaged signal ws")

    src_plots = os.path.join(outdir_pack, "Plots", "*.pdf")
    cmd_cp_pdf = "cp {src} {dst}/".format(src=src_plots, dst=ws_dir)
    run_cmd(cmd_cp_pdf, log_message="copy signal plots")

    logging.info("signal packaging and plotting end: %s", time.time())

# Background fit in data

def run_backgroundfit(ws_data_tag, log_file, data_path, ext_name, cp_name):
    logging.info("background fit start: %s", time.time())

    bkg_dir = os.path.join(FGG_BASE, "Background")
    os.chdir(bkg_dir)

    outdir = "outdir_{ext}".format(ext=ext_name)
    run_cmd("rm -rf {d}".format(d=outdir), log_message="clean bkg outdir")

    cfg_name = "config_{tag}.py".format(tag=ws_data_tag)
    cmd_cp = "cp config_toy2017.py {cfg}".format(cfg=cfg_name)
    run_cmd(cmd_cp, log_message="copy config_toy2017.py")

    time.sleep(2)

    cmd1 = 'sed -i "s#ws_path#{ws}#g" {cfg}'.format(ws=ws_data_tag, cfg=cfg_name)
    run_cmd(cmd1, log_message="sed ws_path placeholder")

    cmd2 = 'sed -i "s#input_path#{ipath}#g" {cfg}'.format(
        ipath=data_path + os.sep,
        cfg=cfg_name,
    )
    run_cmd(cmd2, log_message="sed input_path placeholder")

    cmd3 = 'sed -i "s#ext_name#{ext}#g" {cfg}'.format(ext=ext_name, cfg=cfg_name)
    run_cmd(cmd3, log_message="sed ext_name placeholder")

    cmd_ftest = (
        "python RunBackgroundScripts.py "
        "--inputConfig {cfg} "
        "--mode fTestParallel "
        "> {log} 2>&1"
    ).format(cfg=cfg_name, log=log_file)
    run_cmd(cmd_ftest, log_message="run background fTest")

    src_pdf = "outdir_{ext}/*.root".format(ext=ext_name)
    ws_data_dir = os.path.join(data_path, ws_data_tag)
    cmd_cp = "cp {src} {dst}/{name}".format(
        src=src_pdf,
        dst=ws_data_dir,
        name=cp_name,
    )
    run_cmd(cmd_cp, log_message="copy background multipdf")

    src_plots = "outdir_{ext}/bkgfTest-Data/*.pdf".format(ext=ext_name)
    cmd_cp_pdf = "cp {src} {dst}/".format(src=src_plots, dst=ws_data_dir)
    run_cmd(cmd_cp_pdf, log_message="copy background plots")

    logging.info("background fit end: %s", time.time())

# Yields and datacard

def run_yields(ws_sig_tag, ws_bkg_tag, sig_path, data_path, log_file, process):
    logging.info("yields start: %s", time.time())

    dc_dir = os.path.join(FGG_BASE, "Datacard")
    os.chdir(dc_dir)

    sig_ws_dir = os.path.join(sig_path, process + "_" + ws_sig_tag)
    bkg_ws_dir = os.path.join(data_path, ws_bkg_tag)

    yields_script = "RunYields_17resolved.py"
    if "bbgg" in process:
        yields_script = "RunYields_17resolved_bbgg.py"

    cmd = (
        "python {script} "
        "--inputWSDirMap {year}={sig_dir} "
        "--sigModelWSDir {sig_dir} "
        "--bkgModelWSDir {bkg_dir} "
        "--cats auto "
        "--doSystematics "
        "--procs {proc} "
        "--batch local "
        "--ext {ext} "
        "> {log} 2>&1"
    ).format(
        script=yields_script,
        year=YEAR,
        sig_dir=sig_ws_dir,
        bkg_dir=bkg_ws_dir,
        proc=process.split("ws_")[-1],
        ext=ws_sig_tag,
        log=log_file,
    )
    run_cmd(cmd, log_message="run yields")

    logging.info("yields end: %s", time.time())

def run_makeDatacard(ws_sig_tag, output_card_name, log_file, process):
    logging.info("makeDatacard start: %s", time.time())

    dc_dir = os.path.join(FGG_BASE, "Datacard")
    os.chdir(dc_dir)

    if "wwgg" in process:
        script = "makeDatacard_17resolved.py"
    else:
        script = "makeDatacard_17resolved_singlehiggs.py"

    cmd = (
        "python {script} "
        "--years {year} "
        "--doSystematics "
        "--prune "
        "--ext {ext} "
        "--output {out} "
        "> {log} 2>&1"
    ).format(
        script=script,
        year=YEAR,
        ext=ws_sig_tag,
        out=output_card_name,
        log=log_file,
    )
    run_cmd(cmd, log_message="run makeDatacard")

    dc_txt = output_card_name + ".txt"
    try:
        with open(dc_txt, "a") as f:
            f.write("")
    except IOError:
        logging.warning("could not open datacard %s for appending", dc_txt)

    logging.info("makeDatacard end: %s", time.time())

if __name__ == "__main__":

    mass_list = [args.mass_point]  # e.g. ["MX3000_MY2800"]
    cat_list = ["cat12lowpurity", "cat12highpurity"]
    final_state_list = ["wwgg", "VBF", "VH", "TTH", "GGH"]

    for mass in mass_list:
        # per mass paths
        mass_base = os.path.join(EOS_BASE, YEAR, mass)
        sig_base = os.path.join(mass_base, "mc")
        data_base = os.path.join(mass_base, "data")
        log_dir = os.path.join(mass_base, "logs_cat12")
        if not os.path.isdir(log_dir):
            os.makedirs(log_dir)

        for cat in cat_list:

            ws_data_tag = "ws_{year}_{cat}".format(year=YEAR, cat=cat)
            data_root_name = "Data_{year}_{cat}_{mass}.root".format(
                year=YEAR,
                cat=cat,
                mass=mass,
            )
            log_bkg_data = os.path.join(
                log_dir,
                "bkg_{year}_{cat}.log".format(year=YEAR, cat=cat),
            )

            run_Tree2WS_data(
                data_path=data_base,
                ws_data_tag=ws_data_tag,
                data_root_name=data_root_name,
            )

            ext_name = "{tag}_{mass}".format(tag=ws_data_tag, mass=mass)

            run_backgroundfit(
                ws_data_tag=ws_data_tag,
                log_file=log_bkg_data,
                data_path=data_base,
                ext_name=ext_name,
                cp_name="CMS-HGG_multipdf_{cat}_{year}.root".format(
                    cat=cat,
                    year=YEAR,
                ),
            )

            for final_state in final_state_list:

                input_sig_name = "{mass}_{year}_{fs}_{cat}.root".format(
                    mass=mass,
                    year=YEAR,
                    fs=final_state,
                    cat=cat,
                )
                log_sig = "{mass}_YH_{year}_{cat}_{fs}.log".format(
                    mass=mass,
                    year=YEAR,
                    cat=cat,
                    fs=final_state,
                )
                ws_sig_tag = "{mass}_{year}_{cat}_{fs}".format(
                    mass=mass,
                    year=YEAR,
                    cat=cat,
                    fs=final_state,
                )
                output_sig_root = (
                    "output_Signal{mass}{cat}_M125_{year}_13TeV_amcatnloFXFX_pythia8_ggyh{fs}.root"
                ).format(
                    mass=mass,      # e.g. MX3000_MY2800
                    cat=cat,        # e.g. cat12lowpurity
                    year=YEAR,      # 2017
                    fs=final_state, # wwgg, VBF, VH, TTH, GGH
                )

                run_Tree2WS_sig(
                    sig_path=sig_base,
                    input_file=input_sig_name,
                    log_file=os.path.join(log_dir, "Tree2WS_" + log_sig),
                    ws_tag=ws_sig_tag,
                    output_sig_root=output_sig_root,
                    process="ws_ggyh" + final_state,
                )

                run_ftest(
                    ws_tag=ws_sig_tag,
                    log_file=os.path.join(log_dir, "signal_ftest_" + log_sig),
                    sig_path=sig_base,
                    process="ggyh" + final_state,
                    clean_output=False,
                )

                run_signalfit(
                    ws_tag=ws_sig_tag,
                    log_file=os.path.join(
                        log_dir,
                        "signal_signalfit_" + log_sig,
                    ),
                    sig_path=sig_base,
                    process="ws_ggyh" + final_state,
                )

                run_signal_plot(
                    cats=cat,
                    exts="{year}_{mass}_{year}_{cat}_{fs}".format(
                        year=YEAR,
                        mass=mass,
                        cat=cat,
                        fs=final_state,
                    ),
                    output_ext="packaged_{mass}_{year}_{cat}_{fs}".format(
                        mass=mass,
                        year=YEAR,
                        cat=cat,
                        fs=final_state,
                    ),
                    log_packaged=os.path.join(
                        log_dir,
                        "packaged_{mass}_{cat}.log".format(
                            mass=mass,
                            cat=cat,
                        ),
                    ),
                    ws_tag=ws_sig_tag,
                    sig_path=sig_base,
                    log_plotter=os.path.join(
                        log_dir,
                        "plotter_{mass}_{cat}.log".format(
                            mass=mass,
                            cat=cat,
                        ),
                    ),
                    cp_name="CMS-HGG_sigfit_packaged_{cat}_{year}.root".format(
                        cat=cat,
                        year=YEAR,
                    ),
                    process="ws_ggyh" + final_state,
                )

                run_yields(
                    ws_sig_tag=ws_sig_tag,
                    ws_bkg_tag=ws_data_tag,
                    sig_path=sig_base,
                    data_path=data_base,
                    log_file=os.path.join(
                        log_dir,
                        "{mass}_{year}_{cat}_yields.log".format(
                            mass=mass,
                            year=YEAR,
                            cat=cat,
                        ),
                    ),
                    process="ws_ggyh" + final_state,
                )

                run_makeDatacard(
                    ws_sig_tag=ws_sig_tag,
                    output_card_name="Datacard_{mass}_{year}_{fs}_{cat}".format(
                        mass=mass,
                        year=YEAR,
                        fs=final_state,
                        cat=cat,
                    ),
                    log_file=os.path.join(
                        log_dir,
                        "{mass}_{cat}_makeDatacard.log".format(
                            mass=mass,
                            cat=cat,
                        ),
                    ),
                    process="ggyh" + final_state,
                )

        # ---- after all cats and final states for this mass are done ----
        # Collect all datacards for this mass into a dedicated directory
        dc_base = os.path.join(FGG_BASE, "Datacard")
        mass_dc_dir = os.path.join(dc_base, f"datacard_{mass}")
        os.makedirs(mass_dc_dir, exist_ok=True)

        # Pattern for the datacards you just made for this mass & year
        pattern = os.path.join(dc_base, f"Datacard_{mass}_{YEAR}_*.txt")

        for src in glob.glob(pattern):
            dst = os.path.join(mass_dc_dir, os.path.basename(src))
            # use copy2 so timestamps etc. are preserved;
            # use shutil.move if you want them removed from the top level
            shutil.copy2(src, dst)