# -*- coding: utf-8 -*-
"""
Master script to go from ntuples (root) to limits with flashggFinalFit
for boosted YH cat12 categories, with mc and data in separate subdirs.

Directory layout assumed:
  EOS_BASE / YEAR / MXxxx_MYyyy / mc   : signal ntuples and signal workspaces
  EOS_BASE / YEAR / MXxxx_MYyyy / data : data ntuples and background workspaces

Optional resume control:
  --start-step {all,bkg,signal,yields,datacard}

  all      : run everything (default)
  bkg      : start at background fit (skip Trees2WS_data)
  signal   : start at signal Trees2WS (skip data+background)
  yields   : start at RunYields (assume signal+bkg WSes exist)
  datacard : start at makeDatacard (assume yields exist)
"""

import os
import errno
import time
import logging
import subprocess
import sys
import argparse
import glob
import shutil

# Avoid .pyc races in shared directories
os.environ.setdefault("PYTHONDONTWRITEBYTECODE", "1")

# ----------------------------------------------------------------------
# Argument parsing
# ----------------------------------------------------------------------
parser = argparse.ArgumentParser(description='Process mass point.')
parser.add_argument('--mass_point', type=str, required=True,
                    help='Mass point in the format MXxxx_MYyyy')
parser.add_argument(
    '--start-step',
    choices=['all', 'bkg', 'signal', 'yields', 'datacard'],
    default='all',
    help='Earliest step to run in the pipeline (default: all).'
)
parser.add_argument(
    '--stop-step',
    choices=['all', 'bkg', 'signal', 'yields', 'datacard', 'collect'],
    default='collect',
    help='Last step to run in the pipeline (default: collect).'
)
parser.add_argument(
    '--unblind',
    action='store_true',
    help='Disable blinding for background fits/plots (default: blinded).'
)
parser.add_argument('--category', type=str, default='both',
                    choices=['cat12lowpurity', 'cat12highpurity', 'both'],
                    help='Which category to run: cat12lowpurity, cat12highpurity, or both (default).')
parser.add_argument('--replacement-threshold', type=int,
                    default=int(os.environ.get("YH_SIGNAL_REPLACEMENT_THRESHOLD", "15")),
                    help='Minimum number of events needed before the signal fit switches to a replacement sample. '
                         'Defaults to env YH_SIGNAL_REPLACEMENT_THRESHOLD or 15.')
parser.add_argument('--replacement-threshold-wwgg', type=int,
                    default=int(os.environ.get(
                        "YH_SIGNAL_REPLACEMENT_THRESHOLD_WWGG",
                        os.environ.get("YH_SIGNAL_REPLACEMENT_THRESHOLD", "15"),
                    )),
                    help='Replacement threshold for the BSM ggYH(wwgg) signal fit. '
                         'Defaults to env YH_SIGNAL_REPLACEMENT_THRESHOLD_WWGG, '
                         'or falls back to YH_SIGNAL_REPLACEMENT_THRESHOLD.')
parser.add_argument('--replacement-threshold-singleh', type=int,
                    default=int(os.environ.get(
                        "YH_SIGNAL_REPLACEMENT_THRESHOLD_SINGLEH",
                        os.environ.get("YH_SIGNAL_REPLACEMENT_THRESHOLD", "15"),
                    )),
                    help='Replacement threshold for single-Higgs (VBF/VH/TTH/GGH) signal fits. '
                         'Defaults to env YH_SIGNAL_REPLACEMENT_THRESHOLD_SINGLEH, '
                         'or falls back to YH_SIGNAL_REPLACEMENT_THRESHOLD.')
parser.add_argument('--signal-processes', type=str, default="",
                    help='Comma-separated list of signal processes to run '
                         '(wwgg,VBF,VH,TTH,GGH). Empty means all.')
args = parser.parse_args()

YEAR = "2018"
REPLACEMENT_THRESHOLD = args.replacement_threshold
REPLACEMENT_THRESHOLD_WWGG = args.replacement_threshold_wwgg
REPLACEMENT_THRESHOLD_SINGLEH = args.replacement_threshold_singleh

TREES2WS_SIG_CONFIG = "config_sys18.py"
SIGNAL_CONFIG_TEMPLATE = "config_yh2018.py"
RUN_PLOTTER_SCRIPT = "RunPlotter2018.py"
BACKGROUND_CONFIG_TEMPLATE = "config_toy2018.py"
YIELDS_SCRIPT = "RunYields_18boosted.py"
DATACARD_SCRIPT = "makeDatacard_18boosted.py"
DATACARD_SCRIPT_SINGLEH = "makeDatacard_18boosted_singlehiggs.py"

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
    "flashggFinalFit",
    "YH_cat12_master_{0}.log".format(YEAR),
)
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    filemode="w",
    format="%(asctime)s [%(levelname)s] %(message)s",
)

# ----------------------------------------------------------------------
# Step indexing for resume logic
# ----------------------------------------------------------------------
STEP_INDEX = {
    'trees2ws_data': 0,
    'background':    1,
    'trees2ws_sig':  2,
    'signal_ftest':  3,
    'signal_fit':    4,
    'signal_pack':   5,
    'yields':        6,
    'datacard':      7,
    'collect':       8,
}

if args.start_step == 'all':
    MIN_STEP = STEP_INDEX['trees2ws_data']
elif args.start_step == 'bkg':
    MIN_STEP = STEP_INDEX['background']
elif args.start_step == 'signal':
    MIN_STEP = STEP_INDEX['trees2ws_sig']
elif args.start_step == 'yields':
    MIN_STEP = STEP_INDEX['yields']
elif args.start_step == 'datacard':
    MIN_STEP = STEP_INDEX['datacard']
else:
    MIN_STEP = STEP_INDEX['trees2ws_data']  # fallback

logging.info("Start-step requested: %s (MIN_STEP=%d)", args.start_step, MIN_STEP)

# Stop-step mapping (end of the chain)
if args.stop_step in ['all', 'collect']:
    MAX_STEP = STEP_INDEX['collect']
elif args.stop_step == 'bkg':
    MAX_STEP = STEP_INDEX['background']
elif args.stop_step == 'signal':
    MAX_STEP = STEP_INDEX['signal_pack']
elif args.stop_step == 'yields':
    MAX_STEP = STEP_INDEX['yields']
elif args.stop_step == 'datacard':
    MAX_STEP = STEP_INDEX['datacard']
else:
    MAX_STEP = STEP_INDEX['collect']  # fallback

logging.info("Stop-step requested: %s (MAX_STEP=%d)", args.stop_step, MAX_STEP)
logging.info("Blinded: %s", not args.unblind)

# ----------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------

def _proc_label_for_cfg(process):
    """
    Try to extract the 'ggyhXXX' piece from whatever string we got.
    E.g. 'ggyhwwgg'            -> 'ggyhwwgg'
         'ws_ggyhwwgg_MX...'   -> 'ggyhwwgg'
    Fallback: 'ggyh' (should not normally be needed).
    """
    if "ggyh" in process:
        s = process[process.index("ggyh"):]
        return s.split("_")[0]
    return "ggyh"


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

def safe_makedirs(path):
    """Create directory tree; ignore EEXIST races from concurrent jobs."""
    try:
        os.makedirs(path)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise

def require_exists(path, what):
    """Fail early if a required file/dir is missing."""
    if not os.path.exists(path):
        msg = "ERROR: Missing prerequisite {0}: {1}".format(what, path)
        logging.error(msg)
        print(msg)
        sys.exit(1)

def require_nonempty_glob(pattern, what):
    """Fail if glob pattern finds no matches."""
    matches = glob.glob(pattern)
    if not matches:
        msg = "ERROR: Missing prerequisite {0}: no files matching {1}".format(what, pattern)
        logging.error(msg)
        print(msg)
        sys.exit(1)

def should_run(step_key):
    """Return True if this step is within the requested [start, stop] window."""
    idx = STEP_INDEX[step_key]
    return (MIN_STEP <= idx) and (idx <= MAX_STEP)

# ----------------------------------------------------------------------
# Trees2WS for signal in mc
# ----------------------------------------------------------------------
def run_Tree2WS_sig(sig_path, input_file, log_file, ws_tag, output_sig_root, process):
    logging.info("Trees2WS signal start: %s", time.time())

    process_prefix = process.split("ws_")[1]
    logging.info("process_prefix: %s", process_prefix)

    trees2ws_dir = os.path.join(FGG_BASE, "Trees2WS")

    cmd = (
        "python trees2ws.py "
        "--inputConfig {cfg} "
        "--inputTreeFile {inp}{file} "
        "--inputMass 125 "
        "--doSystematics "
        "--productionMode {pmode} "
        "--year {year} "
        "> {log} 2>&1"
    ).format(
        cfg=TREES2WS_SIG_CONFIG,
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

# ----------------------------------------------------------------------
# Trees2WS for data in data
# ----------------------------------------------------------------------
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

# ----------------------------------------------------------------------
# Signal fTest and photon syst
# ----------------------------------------------------------------------
def run_ftest(ws_tag, log_file, sig_path, process, clean_output, cat):
    logging.info("signal fTest start: %s", time.time())

    signal_dir = os.path.join(FGG_BASE, "Signal")

    # base directory for all Signal workdirs
    work_root = os.path.join(signal_dir, "workdirs")
    if not os.path.isdir(work_root):
        safe_makedirs(work_root)

    # per-job workdir
    safe_proc = process.replace("/", "_").replace(" ", "_")
    workdir_name = "ftest_{year}_{ws}_{proc}".format(
        year=YEAR, ws=ws_tag, proc=safe_proc
    )
    workdir = os.path.join(work_root, workdir_name)

    if clean_output:
        run_cmd("rm -rf {d}".format(d=workdir),
                log_message="clean fTest workdir")
        outdir = os.path.join(signal_dir, "outdir_{year}_{ws}".format(
            year=YEAR, ws=ws_tag
        ))
        outdir_pack = os.path.join(signal_dir, "outdir_packaged_{ws}".format(
            ws=ws_tag
        ))
        run_cmd("rm -rf {d}".format(d=outdir),     log_message="clean signal outdir")
        run_cmd("rm -rf {d}".format(d=outdir_pack), log_message="clean packaged outdir")

    if not os.path.isdir(workdir):
        safe_makedirs(workdir)

    # ------------------------------------------------------------------
    # Prepare per-job config file *inside this workdir*
    # ------------------------------------------------------------------
    cfg_name = "config_{proc}{ws}.py".format(proc=process, ws=ws_tag)
    cfg_path = os.path.join(workdir, cfg_name)

    template_cfg = os.path.join(signal_dir, SIGNAL_CONFIG_TEMPLATE)
    cmd_cp = "cp {src} {dst}".format(src=template_cfg, dst=cfg_path)
    run_cmd(cmd_cp, log_message="copy {cfg} into workdir".format(cfg=SIGNAL_CONFIG_TEMPLATE))

    # sed in this local config file
    proc_label = _proc_label_for_cfg(process)

    cmd1 = 'sed -i "s#ws_path#{ws}#g" {cfg}'.format(ws=ws_tag, cfg=cfg_path)
    run_cmd(cmd1, log_message="sed ws_path placeholder")

    cmd2 = 'sed -i "s#input_path#{ipath}#g" {cfg}'.format(
        ipath=sig_path + os.sep,
        cfg=cfg_path,
    )
    run_cmd(cmd2, log_message="sed input_path placeholder")

    cmd3 = 'sed -i "s#ggyh#{proc}#g" {cfg}'.format(
        proc=proc_label, cfg=cfg_path
    )
    run_cmd(cmd3, log_message="sed process placeholder")

    cmd4 = 'sed -i "s#cat_placeholder#{cat}#g" {cfg}'.format(cat=cat, cfg=cfg_path)
    run_cmd(cmd4, log_message="sed cat_placeholder")

    # ------------------------------------------------------------------
    # Run RunSignalScripts.py from inside the workdir
    # (so it creates/deletes workdir/config.py, not Signal/config.py)
    # ------------------------------------------------------------------
    runscript = os.path.join(signal_dir, "RunSignalScripts.py")
    log_abs   = os.path.abspath(log_file)

    cmd_ftest = (
        "cd {wd} && "
        "python {script} "
        "--inputConfig {cfg} "
        "--mode fTest "
        "--modeOpts '--doPlots' "
        "> {log} 2>&1"
    ).format(
        wd=workdir,
        script=runscript,
        cfg=cfg_name,           # relative to workdir
        log=log_abs,
    )
    run_cmd(cmd_ftest, log_message="run signal fTest")

    cmd_ph = (
        "cd {wd} && "
        "python {script} "
        "--inputConfig {cfg} "
        "--mode calcPhotonSyst "
        ">> {log} 2>&1"
    ).format(
        wd=workdir,
        script=runscript,
        cfg=cfg_name,
        log=log_abs,
    )
    run_cmd(cmd_ph, log_message="run calcPhotonSyst")

    logging.info("signal fTest end: %s", time.time())


# ----------------------------------------------------------------------
# Signal fit
# ----------------------------------------------------------------------
def run_signalfit(ws_tag, log_file, sig_path, process, replacement_threshold, cat):
    logging.info("signalFit start: %s", time.time())

    signal_dir = os.path.join(FGG_BASE, "Signal")

    # base workdir root
    work_root = os.path.join(signal_dir, "workdirs")
    if not os.path.isdir(work_root):
        safe_makedirs(work_root)

    safe_proc = process.replace("/", "_").replace(" ", "_")
    workdir_name = "sigfit_{year}_{ws}_{proc}".format(
        year=YEAR, ws=ws_tag, proc=safe_proc
    )
    workdir = os.path.join(work_root, workdir_name)
    if not os.path.isdir(workdir):
        safe_makedirs(workdir)

    # process_prefix is what your original code used in the config name
    process_prefix = process.split("ws_")[1] if "ws_" in process else process
    cfg_name = "config_{proc}{ws}.py".format(
        proc=process_prefix, ws=ws_tag
    )
    cfg_path = os.path.join(workdir, cfg_name)

    # (Re)create config for signalFit if it doesn't exist yet
    if not os.path.exists(cfg_path):
        template_cfg = os.path.join(signal_dir, SIGNAL_CONFIG_TEMPLATE)
        cmd_cp = "cp {src} {dst}".format(src=template_cfg, dst=cfg_path)
        run_cmd(cmd_cp, log_message="copy {cfg} for signalFit".format(cfg=SIGNAL_CONFIG_TEMPLATE))

        proc_label = _proc_label_for_cfg(process)

        cmd1 = 'sed -i "s#ws_path#{ws}#g" {cfg}'.format(ws=ws_tag, cfg=cfg_path)
        run_cmd(cmd1, log_message="sed ws_path placeholder (signalFit)")

        cmd2 = 'sed -i "s#input_path#{ipath}#g" {cfg}'.format(
            ipath=sig_path + os.sep,
            cfg=cfg_path,
        )
        run_cmd(cmd2, log_message="sed input_path placeholder (signalFit)")

        cmd3 = 'sed -i "s#ggyh#{proc}#g" {cfg}'.format(
            proc=proc_label, cfg=cfg_path
        )
        run_cmd(cmd3, log_message="sed process placeholder (signalFit)")

        cmd4 = 'sed -i "s#cat_placeholder#{cat}#g" {cfg}'.format(cat=cat, cfg=cfg_path)
        run_cmd(cmd4, log_message="sed cat_placeholder (signalFit)")

    runscript = os.path.join(signal_dir, "RunSignalScripts.py")
    log_abs   = os.path.abspath(log_file)

    cmd = (
        "cd {wd} && "
        "python {script} "
        "--inputConfig {cfg} "
        "--mode signalFit "
        "--modeOpts \"--replacementThreshold {thresh}\" "
        "> {log} 2>&1"
    ).format(
        wd=workdir,
        script=runscript,
        cfg=cfg_name,
        log=log_abs,
        thresh=replacement_threshold,
    )
    run_cmd(cmd, log_message="run signalFit")

    # Copy outputs from Signal/outdir_* to EOS workspace dir (as before),
    # but build the source path absolute so our current cwd doesn't matter.
    src_pattern = os.path.join(
        signal_dir,
        "outdir_{year}_{ws}/signalFit/output/*.root".format(
            year=YEAR, ws=ws_tag
        )
    )
    ws_dir = os.path.join(sig_path, process + "_" + ws_tag)
    cmd_cp2 = "cp {src} {dst}".format(src=src_pattern, dst=ws_dir)
    run_cmd(cmd_cp2, log_message="copy signalFit outputs to workspace")

    logging.info("signalFit end: %s", time.time())


# ----------------------------------------------------------------------
# Packager and plotter
# ----------------------------------------------------------------------
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
        "python {plotter} "
        "--cats {cats} "
        "--procs all "
        "--years {year} "
        "--ext {ext} "
        "> {log} 2>&1"
    ).format(
        plotter=RUN_PLOTTER_SCRIPT,
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

# ----------------------------------------------------------------------
# Background fit in data (mass-specific configs!)
# ----------------------------------------------------------------------
def run_backgroundfit(ws_data_tag, log_file, data_path, ext_name, cp_name, mass):
    logging.info("background fit start: %s", time.time())

    background_dir = os.path.join(FGG_BASE, "Background")

    # Clean outdir for this ext (absolute path)
    outdir_root = background_dir
    outdir = os.path.join(outdir_root, "outdir_{ext}".format(ext=ext_name))
    run_cmd("rm -rf {d}".format(d=outdir), log_message="clean bkg outdir")

    # Per-job workdir to isolate config.py / config.pyc
    work_root = os.path.join(background_dir, "workdirs")
    if not os.path.isdir(work_root):
        safe_makedirs(work_root)

    # ext_name is already unique per mass+category, e.g. ws_2018_cat12lowpurity_MX1200_MY400
    workdir = os.path.join(work_root, ext_name)
    if os.path.isdir(workdir):
        shutil.rmtree(workdir)
    safe_makedirs(workdir)

    # Mass-specific config tag, e.g. ws_2018_cat12lowpurity_MX1200_MY400
    cfg_tag = "{tag}_{mass}".format(tag=ws_data_tag, mass=mass)
    cfg_name = "config_{tag}.py".format(tag=cfg_tag)
    cfg_path = os.path.join(workdir, cfg_name)

    # Copy template config into the workdir
    template_cfg = os.path.join(background_dir, BACKGROUND_CONFIG_TEMPLATE)
    shutil.copyfile(template_cfg, cfg_path)
    logging.info("copied %s -> %s", template_cfg, cfg_path)

    with open(cfg_path, "r") as cfg_in:
        cfg_txt = cfg_in.read()
    cfg_txt = cfg_txt.replace("ws_path", ws_data_tag)
    cfg_txt = cfg_txt.replace("input_path", data_path + os.sep)
    cfg_txt = cfg_txt.replace("ext_name", ext_name)
    with open(cfg_path, "w") as cfg_out:
        cfg_out.write(cfg_txt)

    # Run background scripts from inside the workdir
    runscript = os.path.join(background_dir, "RunBackgroundScripts.py")
    log_abs   = os.path.abspath(log_file)

    unblind_opt = "--unblind" if args.unblind else ""

    cmd_ftest = (
        "python {script} "
        "--inputConfig {cfg} "
        "--mode fTestParallel "
        "--ext {ext} "
        "{unblind} "
        "> {log} 2>&1"
    ).format(
        script=runscript,
        cfg=cfg_name,
        ext=ext_name,
        unblind=unblind_opt,
        log=log_abs,
    )
    run_cmd(cmd_ftest, log_message="run background fTest (isolated workdir)", cwd=workdir)

    # Copy background multipdf and plots from absolute outdir
    src_pdf = os.path.join(outdir_root, "outdir_{ext}".format(ext=ext_name), "*.root")
    ws_data_dir = os.path.join(data_path, ws_data_tag)
    cmd_cp = "cp {src} {dst}/{name}".format(
        src=src_pdf,
        dst=ws_data_dir,
        name=cp_name,
    )
    run_cmd(cmd_cp, log_message="copy background multipdf")

    src_plots = os.path.join(
        outdir_root,
        "outdir_{ext}".format(ext=ext_name),
        "bkgfTest-Data",
        "*.pdf",
    )
    cmd_cp_pdf = "cp {src} {dst}/".format(src=src_plots, dst=ws_data_dir)
    run_cmd(cmd_cp_pdf, log_message="copy background plots")

    logging.info("background fit end: %s", time.time())

# ----------------------------------------------------------------------
# Yields and datacard
# ----------------------------------------------------------------------
def run_yields(ws_sig_tag, ws_bkg_tag, sig_path, data_path, log_file, process):
    logging.info("yields start: %s", time.time())

    dc_dir = os.path.join(FGG_BASE, "Datacard")
    os.chdir(dc_dir)

    sig_ws_dir = os.path.join(sig_path, process + "_" + ws_sig_tag)
    bkg_ws_dir = os.path.join(data_path, ws_bkg_tag)

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
        script=YIELDS_SCRIPT,
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
        script = DATACARD_SCRIPT
    else:
        script = DATACARD_SCRIPT_SINGLEH

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
        f = open(dc_txt, "a")
        f.write("")
        f.close()
    except IOError:
        logging.warning("could not open datacard %s for appending", dc_txt)

    logging.info("makeDatacard end: %s", time.time())

# ----------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------
if __name__ == "__main__":

    mass_list = [args.mass_point]  # e.g. ["MX3000_MY2800"]

    # NEW: decide which categories to run based on --category
    if args.category == "both":
        cat_list = ["cat12lowpurity", "cat12highpurity"]
    else:
        cat_list = [args.category]

    final_state_list = ["wwgg", "VBF", "VH", "TTH", "GGH"]
    signal_processes = None
    if args.signal_processes:
        requested = [p.strip() for p in args.signal_processes.split(",") if p.strip()]
        signal_processes = set(requested)
        valid = set(final_state_list)
        if not (signal_processes & valid):
            raise RuntimeError(
                "No valid signal processes requested. Valid choices: wwgg,VBF,VH,TTH,GGH"
            )

    for mass in mass_list:
        # per mass paths
        mass_base = os.path.join(EOS_BASE, YEAR, mass)
        sig_base = os.path.join(mass_base, "mc")
        data_base = os.path.join(mass_base, "data")
        log_dir = os.path.join(mass_base, "logs_cat12")
        if not os.path.isdir(log_dir):
            safe_makedirs(log_dir)

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

            # Path to allData and multipdf for checks
            ws_data_dir = os.path.join(data_base, ws_data_tag)
            allData_path = os.path.join(ws_data_dir, "allData.root")
            multipdf_path = os.path.join(
                ws_data_dir,
                "CMS-HGG_multipdf_{cat}_{year}.root".format(cat=cat, year=YEAR)
            )

            # --- Data Trees2WS ---
            if should_run('trees2ws_data'):
                run_Tree2WS_data(
                    data_path=data_base,
                    ws_data_tag=ws_data_tag,
                    data_root_name=data_root_name,
                )
            else:
                # Skipping Trees2WS_data: require that allData.root already exists
                require_exists(
                    allData_path,
                    "allData workspace for mass {0}, cat {1}".format(mass, cat)
                )

            ext_name = "{tag}_{mass}".format(tag=ws_data_tag, mass=mass)

            # --- Background fit ---
            if should_run('background'):
                run_backgroundfit(
                    ws_data_tag=ws_data_tag,
                    log_file=log_bkg_data,
                    data_path=data_base,
                    ext_name=ext_name,
                    cp_name="CMS-HGG_multipdf_{cat}_{year}.root".format(
                        cat=cat,
                        year=YEAR,
                    ),
                    mass=mass,
                )

            missing_signals = []
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
                    mass=mass,
                    cat=cat,
                    year=YEAR,
                    fs=final_state,
                )

                proc_full = "ws_ggyh" + final_state
                sig_ws_dir = os.path.join(sig_base, proc_full + "_" + ws_sig_tag)
                packaged_signal = os.path.join(
                    sig_ws_dir,
                    "CMS-HGG_sigfit_packaged_{cat}_{year}.root".format(
                        cat=cat, year=YEAR
                    )
                )
                skip_signal_process = False

                do_signal = signal_processes is None or final_state in signal_processes

                # --- Signal Trees2WS ---
                if do_signal and should_run('trees2ws_sig'):
                    run_Tree2WS_sig(
                        sig_path=sig_base,
                        input_file=input_sig_name,
                        log_file=os.path.join(log_dir, "Tree2WS_" + log_sig),
                        ws_tag=ws_sig_tag,
                        output_sig_root=output_sig_root,
                        process=proc_full,
                    )
                else:
                    # If we skip Trees2WS_sig and later steps use signal WS,
                    # we can check existence closer to yields.
                    pass

                # --- Signal fTest ---
                if do_signal and should_run('signal_ftest'):
                    run_ftest(
                        ws_tag=ws_sig_tag,
                        log_file=os.path.join(log_dir, "signal_ftest_" + log_sig),
                        sig_path=sig_base,
                        process="ggyh" + final_state,
                        clean_output=False,
                        cat=cat,
                    )

                # --- Signal fit ---
                if do_signal and should_run('signal_fit'):
                    if final_state == "wwgg":
                        replacement_threshold = REPLACEMENT_THRESHOLD_WWGG
                    else:
                        replacement_threshold = REPLACEMENT_THRESHOLD_SINGLEH
                    run_signalfit(
                        ws_tag=ws_sig_tag,
                        log_file=os.path.join(
                            log_dir,
                            "signal_signalfit_" + log_sig,
                        ),
                        sig_path=sig_base,
                        process=proc_full,
                        replacement_threshold=replacement_threshold,
                        cat=cat,
                    )

                # --- Signal packaging + plots ---
                if do_signal and should_run('signal_pack'):
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
                        process=proc_full,
                    )

                if not os.path.exists(packaged_signal):
                    logging.warning(
                        "Missing packaged signal WS for mass %s, cat %s, proc %s: %s",
                        mass,
                        cat,
                        final_state,
                        packaged_signal,
                    )
                    missing_signals.append(
                        "{proc} ({path})".format(proc=final_state, path=packaged_signal)
                    )
                    skip_signal_process = True

                if skip_signal_process:
                    continue

                # --- Yields ---
                if should_run('yields'):
                    # If we are *starting* at yields or later, we skipped some upstream pieces.
                    # Check prerequisites before calling RunYields.
                    if MIN_STEP > STEP_INDEX['background']:
                        require_exists(
                            multipdf_path,
                            "background multipdf WS for mass {0}, cat {1}".format(
                                mass, cat
                            )
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
                        process=proc_full,
                    )

                # --- Datacard ---
                if should_run('datacard'):
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

            if missing_signals:
                logging.info(
                    "Skipping packaged signal inputs for mass %s, cat %s: %s",
                    mass,
                    cat,
                    ", ".join(missing_signals),
                )

        # ---- after all cats and final states for this mass are done ----
        # Collect all datacards for this mass into a dedicated directory
        if should_run('collect'):
            dc_base = os.path.join(FGG_BASE, "Datacard")
            mass_dc_dir = os.path.join(dc_base, "datacard_{mass}".format(mass=mass))
            if not os.path.isdir(mass_dc_dir):
                safe_makedirs(mass_dc_dir)

            pattern = os.path.join(
                dc_base,
                "Datacard_{mass}_{year}_*.txt".format(mass=mass, year=YEAR)
            )

            for src in glob.glob(pattern):
                dst = os.path.join(mass_dc_dir, os.path.basename(src))
                shutil.copy2(src, dst)
