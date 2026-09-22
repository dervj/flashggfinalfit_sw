#!/usr/bin/env bash
set -euo pipefail

# Thin wrapper around getVariations.py: resolves the standard flashggFinalFit combined
# cat12 workspace path for a given mass point (same convention as
# find_dead_envelope_params.py's MX/MY shorthand and getImpacts_frozenEnvelope.sh's WS
# variable), sets up the CMSSW_10_6_20 python2.7/ROOT environment, and forwards the
# --params/--nsigma/--csv options through.
#
# Usage:
#   bash getVariations.sh MX MY --params NAME [NAME ...] [hponly]
#                          [--nsigma N] [--wsfile PATH] [--wsname NAME] [--csv OUTFILE.csv]
#
# Examples:
#   bash getVariations.sh 4000 1600 --params CMS_hgg_nonisoelectron_re_co_SF_2017 CMS_hgg_nuisance_smear_13TeVsmear_2017
#   bash getVariations.sh 1800 250 hponly --params CMS_hgg_nuisance_scale_13TeVscale_2017 --nsigma 2

FLASHGGFINALFIT_DIR="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit"

MX=""
MY=""
TAG=""
NSIGMA=""
WSFILE_OVERRIDE=""
WSNAME=""
CSV_OUT=""
PARAMS=()

usage() {
  echo "Usage: $(basename "$0") MX MY --params NAME [NAME ...] [hponly] [--nsigma N] [--wsfile PATH] [--wsname NAME] [--csv OUTFILE.csv]" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --params)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --params requires at least one parameter name" >&2
        exit 1
      fi
      # Consume everything up to the next --flag as a param name -- mirrors argparse's
      # own nargs='+' greediness in getVariations.py, so this shell-side collection and
      # that Python-side parsing agree on where the list ends.
      while [[ $# -gt 0 && "$1" != --* ]]; do
        PARAMS+=("$1")
        shift
      done
      ;;
    --nsigma)
      NSIGMA="$2"; shift 2 ;;
    --wsfile)
      WSFILE_OVERRIDE="$2"; shift 2 ;;
    --wsname)
      WSNAME="$2"; shift 2 ;;
    --csv)
      CSV_OUT="$2"; shift 2 ;;
    hponly)
      TAG="hponly"; shift ;;
    -h|--help)
      usage ;;
    *)
      if [[ -z "$MX" ]]; then MX="$1"
      elif [[ -z "$MY" ]]; then MY="$1"
      else echo "Unexpected argument: $1" >&2; usage
      fi
      shift ;;
  esac
done

if [[ -z "$MX" || -z "$MY" || ${#PARAMS[@]} -eq 0 ]]; then
  usage
fi

WSFILE="${WSFILE_OVERRIDE}"
if [[ -z "$WSFILE" ]]; then
  WSFILE="${FLASHGGFINALFIT_DIR}/Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
  if [[ "${TAG}" == "hponly" ]]; then
    WSFILE="${FLASHGGFINALFIT_DIR}/Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
  fi
fi

if [[ ! -f "${WSFILE}" ]]; then
  echo "Error: workspace file does not exist: ${WSFILE}" >&2
  exit 1
fi

# setup.sh (not setupctool.sh) is what actually puts python2.7/ROOT on PATH in a fresh
# non-interactive shell -- setupctool.sh only defines the 'ctool' alias and assumes
# cmsenv has already been run in the calling shell. Ignore the slc7-on-el9 SCRAM_ARCH
# warning it prints; python2.7/ROOT/combineTool.py all work anyway on lxplus el9 for
# this CMSSW_10_6_20 area (see reference_fastscan_usage memory).
cd "${FLASHGGFINALFIT_DIR}"
# setup.sh does `export PYTHONPATH=$PYTHONPATH:...` unguarded, which trips this script's
# `set -u` ("unbound variable") if PYTHONPATH isn't already set in the environment --
# pre-seed it so sourcing doesn't abort the whole script.
export PYTHONPATH="${PYTHONPATH:-}"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}"
source setup.sh >/dev/null 2>&1
# Unset DISPLAY: PyROOT's TApplication graphics init can hang for ~2 minutes trying to
# open an X connection in a batch/non-interactive shell that still has DISPLAY set.
unset DISPLAY || true

PY_ARGS=("${WSFILE}")
if [[ -n "${WSNAME}" ]]; then
  PY_ARGS+=("${WSNAME}")
fi
PY_ARGS+=(--params "${PARAMS[@]}")
if [[ -n "${NSIGMA}" ]]; then
  PY_ARGS+=(--nsigma "${NSIGMA}")
fi
if [[ -n "${CSV_OUT}" ]]; then
  PY_ARGS+=(--csv "${CSV_OUT}")
fi

python2.7 "${FLASHGGFINALFIT_DIR}/getVariations.py" "${PY_ARGS[@]}"
