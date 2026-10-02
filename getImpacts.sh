#!/usr/bin/env bash
set -euo pipefail

MX=""
MY=""
TAG=""
UNBLIND=0
UNBLIND_DEFAULT=0

for arg in "$@"; do
  case "$arg" in
    --unblind)        UNBLIND=1 ;;
    --unblindDefault) UNBLIND_DEFAULT=1 ;;
    hponly)           TAG="hponly" ;;
    *)
      if [[ -z "$MX" ]]; then MX="$arg"
      elif [[ -z "$MY" ]]; then MY="$arg"
      else echo "Unexpected argument: $arg" >&2; exit 1
      fi ;;
  esac
done

if [[ "${UNBLIND}" -eq 1 && "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  echo "Error: --unblind and --unblindDefault are mutually exclusive" >&2
  exit 1
fi

if [[ -z "$MX" || -z "$MY" ]]; then
  echo "Usage: $(basename "$0") MX MY [hponly] [--unblind|--unblindDefault]" >&2
  exit 1
fi

WS="../MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
WS_TAG=""
if [ "${TAG}" == "hponly" ]; then
  WS="../MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
  WS_TAG="_hponly"
fi

IMPACTS_DIR="impacts"
LABEL="expected"
if [[ "${UNBLIND}" -eq 1 ]]; then
  IMPACTS_DIR="impacts_unblinded"
  LABEL="unblinded"
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  IMPACTS_DIR="impacts_unblindedDefault"
  LABEL="unblindedDefault"
fi

# Local plot filename suffix and www destination filename
OUT_TAG="${WS_TAG}"
if [[ "${UNBLIND}" -eq 1 ]]; then
  OUT_TAG="_unblinded${WS_TAG}"
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  OUT_TAG="_unblindedDefault${WS_TAG}"
fi
DEST_NAME="impacts_${LABEL}_MX${MX}_MY${MY}${WS_TAG}.pdf"

shopt -s expand_aliases
source /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/setupctool.sh

workdir="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard/datacard_MX${MX}_MY${MY}"
cd "$workdir"
mkdir -p "${IMPACTS_DIR}"
cd "${IMPACTS_DIR}"

if [[ "${UNBLIND}" -eq 1 ]]; then
  # Unblinded: fit to real data, no Asimov (-t -1) and no signal injection (--expectSignal).
  # --blind on plotImpacts hides the signal strength value per unblinding procedure.
  #
  # Bound shapeBkg norms from below to prevent CachingNLL underflow in low-statistics
  # categories. Upper bound set large enough to not trigger anyParameterAtBound.
  NORM_RANGES="shapeBkg_bkg_mass_cat12hp_cat12_2016pre__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2016post__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2017__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2018__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2016pre__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2016post__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2017__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2018__norm=0.001,100000"

  # Freeze pdfindex (discrete background PDF choice) during impact fits.
  # This disables the multipleMinimize path in CascadeMinimizer which explores
  # combinations of PDF indices and can find degenerate solutions where a PDF
  # integrates to ~0 in the mass window, causing the final improve() to fail
  # (status=-1) and producing a 0-entry initial fit ROOT file. Impacts are
  # computed under the best-fit background PDF from the bkgfTest, which is
  # standard practice.
  FREEZE_PARAMS="MH"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2018_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2018_13TeV"

  # Initial fit: use rMin=0 to prevent r<0 from making signal contribution negative,
  # which causes CachingNLL underflow in low-statistics channels (14 events in 2017 HP).
  # The doFits step keeps rMin=-1 so per-nuisance scans probe the full r range.
  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=0,5:${NORM_RANGES}" --rMin 0 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 1 -v 1 \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance 0.1 \
    --doInitialFit --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --parallel 8

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=0,5:${NORM_RANGES}" --rMin 0 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 1 -v 1 \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance 0.1 \
    --doFits --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --parallel 8
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  # Unblinded with default (blinded) configuration: real data only, no Asimov (-t -1)
  # and no signal injection (--expectSignal). All other flags identical to the blinded
  # case — no norm bounds, no pdfindex freezing, rMin=-1. Use this to diagnose whether
  # failures in --unblind are due to the data or to our configuration changes.
  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin -1 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 0 -v 1 --cminPreScan \
    --doInitialFit --setParameters MH=125 --freezeParameters MH \
    --parallel 8

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin -1 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 0 -v 1 --cminPreScan \
    --doFits --setParameters MH=125 --freezeParameters MH \
    --parallel 8

else
  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin -1 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 0 -t -1 -v 1 --cminPreScan \
    --expectSignal 1 --doInitialFit --setParameters MH=125 --freezeParameters MH \
    --parallel 8

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin -1 --rMax 3 \
    --cminFallbackAlgo Minuit2,0:1.0 --cminDefaultMinimizerTolerance 0.0001 \
    --cminDefaultMinimizerStrategy 0 -t -1 -v 1 --cminPreScan \
    --expectSignal 1 --doFits --setParameters MH=125 --freezeParameters MH \
    --parallel 8
fi

ctool -M Impacts -d "${WS}" -m 125 -o impacts.json

if [[ "${UNBLIND}" -eq 1 || "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  plotimpacts -i impacts.json -o "impacts${OUT_TAG}" --blind
else
  plotimpacts -i impacts.json -o "impacts${OUT_TAG}"
fi

cp -f "impacts${OUT_TAG}.pdf" /eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/impacts/${DEST_NAME}
