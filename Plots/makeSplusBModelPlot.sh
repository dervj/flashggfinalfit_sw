#!/bin/bash

MX="$1"
MY="$2"
TAG=""
shift 2 || true
if [ "${1:-}" == "hponly" ]; then
  TAG="hponly"
  shift
fi
EXTRA_ARGS=("$@")

if [ -z "${MX}" ] || [ -z "${MY}" ]; then
  echo "Usage: $0 <MX> <MY> [hponly] [makeSplusBModelPlot.py args...]"
  exit 1
fi

PLOTS_DIR="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Plots"
WWW_DIR="/eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/sigplusbkg"
EXT="_MX${MX}_MY${MY}"
WS_FILE="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
if [ "${TAG}" == "hponly" ]; then
  WS_FILE="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
  EXT="${EXT}_hponly"
fi

pushd "${PLOTS_DIR}" >/dev/null || exit 1
python makeSplusBModelPlot.py --inputWSFile "${WS_FILE}" --cats all --doBands --doSumCategories --ext "${EXT}" "${EXTRA_ARGS[@]}"

# Copy plots with MX/MY tag before file extension
DEST_TAG=""
if [ -n "${TAG}" ]; then
  DEST_TAG="_${TAG}"
fi
mkdir -p "${WWW_DIR}"
shopt -s nullglob
for f in "SplusBModels${EXT}"/*.pdf "SplusBModels${EXT}"/*.png; do
  base="$(basename "${f}")"
  stem="${base%.*}"
  ext="${base##*.}"
  cp "${f}" "${WWW_DIR}/${stem}_MX${MX}_MY${MY}${DEST_TAG}.${ext}"
done
shopt -u nullglob
popd >/dev/null || exit 1
