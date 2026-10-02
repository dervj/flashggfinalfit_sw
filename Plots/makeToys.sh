#!/bin/bash

MX="$1"
MY="$2"
TAG="${3:-}"

if [ -z "${MX}" ] || [ -z "${MY}" ]; then
  echo "Usage: $0 <MX> <MY> [hponly]"
  exit 1
fi

PLOTS_DIR="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Plots"
BASE_AFS="/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/makeSplusBplots"
EXT="_MX${MX}_MY${MY}"
WS_FILE="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
if [ "${TAG}" == "hponly" ]; then
  WS_FILE="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
  EXT="${EXT}_hponly"
fi

# Run toy generation from the Plots directory; ignore condor submit failure inside makeToys.py
pushd "${PLOTS_DIR}" >/dev/null || exit 1
python makeToys.py --inputWSFile "${WS_FILE}" --ext "${EXT}" --nToys 500 --batch condor || true

# Copy submit artifacts to AFS and submit from there
DEST_DIR="${BASE_AFS}/SplusBModels${EXT}/toys/jobs"
mkdir -p "${DEST_DIR}"
cp "SplusBModels${EXT}/toys/jobs/sub_toys.s"* "${DEST_DIR}/"
popd >/dev/null || exit 1

pushd "${BASE_AFS}/SplusBModels${EXT}/toys/jobs" >/dev/null || exit 1
condor_submit sub_toys.sub
popd >/dev/null || exit 1
