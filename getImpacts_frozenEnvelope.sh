#!/usr/bin/env bash
set -euo pipefail

# Variant of getImpacts.sh's --unblindDefault branch that additionally freezes:
#   - all 8 pdfindex discrete category choices (the bkgfTest-selected background PDF)
#   - the envelope shape parameters that are NOT the currently-selected candidate in
#     either the hp or lp split for their year, and are therefore mathematically
#     disconnected from the likelihood (RooMultiPdf only evaluates the active candidate).
# The active/inactive split is derived fresh at runtime, per mass point, by calling
# find_dead_envelope_params.py against that mass point's own workspace -- see that
# script for the method (inspect each RooMultiPdf's candidates + current pdfindex,
# diff active-candidate parameters against inactive-candidate parameters). This is
# NOT hardcoded because which candidate is active differs by mass point (e.g.
# cat12hp_2018 selects pow1 for MX1600_MY250 but lau1 for MX1800_MY250).
# shapeBkg_*__norm parameters are intentionally left untouched -- those are live,
# data-sensitive normalization terms, not dead envelope candidates.
#
# --unblind, --unblindDefault, and --unblindRamSettings all apply this freeze+exclude
# (they differ only in the r range and minimizer settings used); the default (blind,
# no flag) mode is unchanged (identical to getImpacts.sh) so this script can be
# diffed/dropped in for a like-for-like before/after comparison against getImpacts.sh's
# original behavior in either unblinding mode.
#
# --passCombine "FLAG VALUE [FLAG VALUE ...]" lets the caller override the combine
# minimizer knobs this script hardcodes per mode (e.g. rerun with a tighter r range:
# `--passCombine "--rMin -1 --rMax 1"`). This is deliberately a WHITELIST, not a raw
# passthrough: combine's own option parser (boost::program_options) hard-errors with
# "option '--rMin' cannot be specified more than once" if a flag is given twice, so
# simply appending user args after the script's existing ones would break rather than
# override. Instead, each whitelisted flag's hardcoded value is read through
# get_override(), which substitutes the --passCombine value when given and falls back
# to this script's per-mode default otherwise -- so the flag appears exactly once in
# the final ctool command either way. Only these flags are overridable:
#   --rMin --rMax --cminDefaultMinimizerStrategy --cminDefaultMinimizerTolerance
#   --cminFallbackAlgo --cminApproxPreFitTolerance --parallel -v
# Passing any other flag is a hard error (naming the allowed set) rather than a silent
# no-op. --cminApproxPreFitTolerance is only used in the --unblind and
# --unblindRamSettings branches; overriding it while running --unblindDefault or default
# mode is accepted but warned-and-ignored since those branches don't set it.
# --rMin's default is -1 in every mode (unified 2026-08-24 -- it used to be 0 for
# --unblind's initial fit specifically; see the comment at that get_override call for why,
# and use --passCombine "--rMin 0" there if that low-stat workaround is needed again).

MX=""
MY=""
TAG=""
UNBLIND=0
UNBLIND_DEFAULT=0
UNBLIND_RAM=0
PASS_COMBINE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --unblind)            UNBLIND=1; shift ;;
    --unblindDefault)     UNBLIND_DEFAULT=1; shift ;;
    --unblindRamSettings) UNBLIND_RAM=1; shift ;;
    --passCombine)
      if [[ $# -lt 2 ]]; then
        echo "Error: --passCombine requires an argument, e.g. --passCombine \"--rMin -1 --rMax 1\"" >&2
        exit 1
      fi
      PASS_COMBINE="$2"
      shift 2 ;;
    hponly)           TAG="hponly"; shift ;;
    *)
      if [[ -z "$MX" ]]; then MX="$1"
      elif [[ -z "$MY" ]]; then MY="$1"
      else echo "Unexpected argument: $1" >&2; exit 1
      fi
      shift ;;
  esac
done

MODE_COUNT=$((UNBLIND + UNBLIND_DEFAULT + UNBLIND_RAM))
if [[ "${MODE_COUNT}" -gt 1 ]]; then
  echo "Error: --unblind, --unblindDefault, and --unblindRamSettings are mutually exclusive" >&2
  exit 1
fi

if [[ -z "$MX" || -z "$MY" ]]; then
  echo "Usage: $(basename "$0") MX MY [hponly] [--unblind|--unblindDefault|--unblindRamSettings] [--passCombine \"FLAG VALUE ...\"]" >&2
  exit 1
fi

# Parse --passCombine into OVERRIDES[flag]=value, gated by WHITELIST. Every whitelisted
# flag takes exactly one value, so pairwise token consumption is unambiguous -- no need
# to guess arity for unknown flags the way a generic passthrough would.
declare -A WHITELIST=(
  [--rMin]=1 [--rMax]=1
  [--cminDefaultMinimizerStrategy]=1 [--cminDefaultMinimizerTolerance]=1
  [--cminFallbackAlgo]=1 [--cminApproxPreFitTolerance]=1
  [--parallel]=1 [-v]=1
)
declare -A OVERRIDES=()
declare -A USED_OVERRIDE=()

if [[ -n "${PASS_COMBINE}" ]]; then
  read -ra PASS_COMBINE_TOKENS <<< "${PASS_COMBINE}"
  if (( ${#PASS_COMBINE_TOKENS[@]} % 2 != 0 )); then
    echo "Error: --passCombine \"${PASS_COMBINE}\" has an odd number of tokens -- every flag needs exactly one value (e.g. \"--rMin -1 --rMax 1\")." >&2
    exit 1
  fi
  for ((i = 0; i < ${#PASS_COMBINE_TOKENS[@]}; i += 2)); do
    flag="${PASS_COMBINE_TOKENS[i]}"
    value="${PASS_COMBINE_TOKENS[i+1]}"
    if [[ -z "${WHITELIST[$flag]+set}" ]]; then
      echo "Error: --passCombine cannot override '${flag}' -- only these flags are supported: ${!WHITELIST[*]}" >&2
      exit 1
    fi
    OVERRIDES["$flag"]="$value"
  done
fi

# Sets $1 (a variable name) to the --passCombine value for flag $2 if given, else
# default $3 (this script's default for the branch currently running). Marks the
# override as consumed so unused overrides (e.g. one that only applies to a different
# mode) can be warned about at the end. Writes into the named variable directly rather
# than via `$(...)` command substitution -- the latter runs in a subshell, which would
# silently discard the USED_OVERRIDE update the moment the subshell exits.
get_override() {
  local __outvar="$1" key="$2" default="$3"
  if [[ -n "${OVERRIDES[$key]+set}" ]]; then
    USED_OVERRIDE["$key"]=1
    printf -v "$__outvar" '%s' "${OVERRIDES[$key]}"
  else
    printf -v "$__outvar" '%s' "$default"
  fi
}

WS="../MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
WS_TAG=""
if [ "${TAG}" == "hponly" ]; then
  WS="../MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
  WS_TAG="_hponly"
fi

IMPACTS_DIR="impacts"
LABEL="expected"
if [[ "${UNBLIND}" -eq 1 ]]; then
  IMPACTS_DIR="impacts_unblinded_frozenEnvelope"
  LABEL="unblindedFrozenEnvelope"
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  IMPACTS_DIR="impacts_unblindedDefault_frozenEnvelope"
  LABEL="unblindedDefaultFrozenEnvelope"
elif [[ "${UNBLIND_RAM}" -eq 1 ]]; then
  IMPACTS_DIR="impacts_unblindedRamSettings_frozenEnvelope"
  LABEL="unblindedRamSettingsFrozenEnvelope"
fi

# Local plot filename suffix and www destination filename
OUT_TAG="${WS_TAG}"
if [[ "${UNBLIND}" -eq 1 ]]; then
  OUT_TAG="_unblindedFrozenEnvelope${WS_TAG}"
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  OUT_TAG="_unblindedDefaultFrozenEnvelope${WS_TAG}"
elif [[ "${UNBLIND_RAM}" -eq 1 ]]; then
  OUT_TAG="_unblindedRamSettingsFrozenEnvelope${WS_TAG}"
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
  # standard practice. ALSO freeze + exclude the envelope shape parameters that
  # are dead (inactive RooMultiPdf candidate in every category referencing them)
  # for this mass point -- see the --unblindDefault branch below and
  # find_dead_envelope_params.py for the method; this must be re-derived per mass
  # point, never hardcoded or reused.
  DEAD_PARAMS_OUT="$(python2.7 /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/find_dead_envelope_params.py "${WS}" w 2>/dev/null)"
  DEAD_PARAMS="$(echo "${DEAD_PARAMS_OUT}" | grep '^FREEZE=' | cut -d= -f2-)"
  if [[ -z "${DEAD_PARAMS}" ]]; then
    echo "Error: find_dead_envelope_params.py returned no dead parameters -- refusing to proceed blind. Check it ran correctly against ${WS}." >&2
    exit 1
  fi

  FREEZE_PARAMS="MH"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2018_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2018_13TeV"
  FREEZE_PARAMS+=",${DEAD_PARAMS}"
  EXCLUDE_PARAMS="${DEAD_PARAMS}"

  # rMin defaults to -1 here too (unified across all modes on 2026-08-24). It used to
  # default to 0 for this branch's initial fit specifically, to prevent r<0 from making
  # the signal contribution negative -- which caused CachingNLL underflow in
  # low-statistics channels (14 events in 2017 HP). If that resurfaces for a given mass
  # point, pass --passCombine "--rMin 0" rather than re-hardcoding it here.
  get_override RMIN --rMin -1
  get_override RMAX --rMax 3
  get_override STRATEGY --cminDefaultMinimizerStrategy 1
  get_override TOLERANCE --cminDefaultMinimizerTolerance 0.0001
  get_override FALLBACK_ALGO --cminFallbackAlgo Minuit2,0:1.0
  get_override PREFIT_TOL --cminApproxPreFitTolerance 0.1
  get_override PARALLEL --parallel 8
  get_override VERBOSITY -v 1

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=0,5:${NORM_RANGES}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance "${PREFIT_TOL}" \
    --doInitialFit --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --parallel "${PARALLEL}"

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=0,5:${NORM_RANGES}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance "${PREFIT_TOL}" \
    --doFits --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --exclude "${EXCLUDE_PARAMS}" \
    --parallel "${PARALLEL}"
elif [[ "${UNBLIND_DEFAULT}" -eq 1 ]]; then
  # Unblinded with default (blinded) configuration, PLUS freezing pdfindex and the
  # envelope shape parameters that are dead (inactive RooMultiPdf candidate in every
  # category referencing them) for THIS mass point's workspace. The active/inactive
  # split is derived fresh at runtime by find_dead_envelope_params.py -- it depends on
  # which candidate each category's bkgfTest selected, which differs per mass point
  # (e.g. cat12hp_2018 selects pow1 for MX1600_MY250 but lau1 for MX1800_MY250), so it
  # must never be hardcoded or reused across mass points.
  DEAD_PARAMS_OUT="$(python2.7 /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/find_dead_envelope_params.py "${WS}" w 2>/dev/null)"
  DEAD_PARAMS="$(echo "${DEAD_PARAMS_OUT}" | grep '^FREEZE=' | cut -d= -f2-)"
  if [[ -z "${DEAD_PARAMS}" ]]; then
    echo "Error: find_dead_envelope_params.py returned no dead parameters -- refusing to proceed blind. Check it ran correctly against ${WS}." >&2
    exit 1
  fi

  FREEZE_PARAMS="MH"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2018_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2018_13TeV"
  FREEZE_PARAMS+=",${DEAD_PARAMS}"

  # combineTool.py's Impacts mode builds its per-nuisance scan list straight from the
  # workspace's own floating parameters -- it does NOT consult --freezeParameters, so a
  # frozen-but-not-excluded parameter still gets its own dedicated -P scan (which can
  # partially re-float it, producing a misleading asymmetric bar). --exclude is what
  # actually removes these dead parameters from the per-nuisance scan / tornado plot;
  # --freezeParameters is what keeps them numerically fixed everywhere else. Both are
  # needed together -- freeze alone is not enough.
  EXCLUDE_PARAMS="${DEAD_PARAMS}"

  get_override RMIN --rMin -1
  get_override RMAX --rMax 3
  get_override STRATEGY --cminDefaultMinimizerStrategy 0
  get_override TOLERANCE --cminDefaultMinimizerTolerance 0.0001
  get_override FALLBACK_ALGO --cminFallbackAlgo Minuit2,0:1.0
  get_override PARALLEL --parallel 8
  get_override VERBOSITY -v 1

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" --cminPreScan \
    --doInitialFit --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --parallel "${PARALLEL}"

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges r=-1,5 --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" --cminPreScan \
    --doFits --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --exclude "${EXCLUDE_PARAMS}" \
    --parallel "${PARALLEL}"

elif [[ "${UNBLIND_RAM}" -eq 1 ]]; then
  # Ram's settings: same envelope/pdfindex freeze+exclude as --unblind above (see that
  # branch's comments for why), with r allowed to float negative (rMin/rMax -1/3 rather
  # than 0/3). --setParameterRanges for r is built from RMIN/RMAX (like the default
  # branch below) rather than a separately hardcoded r=-1,3, so it can't drift out of
  # sync with --rMin/--rMax under a --passCombine override.
  #
  # Also bounds the shapeBkg norms from below, same as --unblind (added 2026-09-14):
  # confirmed root cause for 13/240 full-grid points (e.g. MX1600_MY400) was
  # CachingNLL.cc underflow ("expected events <=0") in cat12highpurity categories with
  # as few as 12 observed events -- this branch previously omitted the protection
  # --unblind already has for exactly this scenario.
  NORM_RANGES="shapeBkg_bkg_mass_cat12hp_cat12_2016pre__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2016post__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2017__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12hp_cat12_2018__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2016pre__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2016post__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2017__norm=0.001,100000"
  NORM_RANGES+=":shapeBkg_bkg_mass_cat12lp_cat12_2018__norm=0.001,100000"

  DEAD_PARAMS_OUT="$(python2.7 /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/find_dead_envelope_params.py "${WS}" w 2>/dev/null)"
  DEAD_PARAMS="$(echo "${DEAD_PARAMS_OUT}" | grep '^FREEZE=' | cut -d= -f2-)"
  if [[ -z "${DEAD_PARAMS}" ]]; then
    echo "Error: find_dead_envelope_params.py returned no dead parameters -- refusing to proceed blind. Check it ran correctly against ${WS}." >&2
    exit 1
  fi

  FREEZE_PARAMS="MH"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12highpurity_2018_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016pre_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2016post_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2017_13TeV"
  FREEZE_PARAMS+=",pdfindex_cat12lowpurity_2018_13TeV"
  FREEZE_PARAMS+=",${DEAD_PARAMS}"
  EXCLUDE_PARAMS="${DEAD_PARAMS}"

  get_override RMIN --rMin -1
  get_override RMAX --rMax 3
  get_override STRATEGY --cminDefaultMinimizerStrategy 1
  get_override TOLERANCE --cminDefaultMinimizerTolerance 0.0001
  get_override FALLBACK_ALGO --cminFallbackAlgo Minuit2,0:1.0
  get_override PREFIT_TOL --cminApproxPreFitTolerance 0.1
  get_override PARALLEL --parallel 8
  get_override VERBOSITY -v 1

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=${RMIN},${RMAX}:${NORM_RANGES}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance "${PREFIT_TOL}" \
    --doInitialFit --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --parallel "${PARALLEL}"

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=${RMIN},${RMAX}:${NORM_RANGES}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -v "${VERBOSITY}" \
    --X-rtd MINIMIZER_freezeDisassociatedParams \
    --cminApproxPreFitTolerance "${PREFIT_TOL}" \
    --doFits --setParameters MH=125 --freezeParameters "${FREEZE_PARAMS}" \
    --exclude "${EXCLUDE_PARAMS}" \
    --parallel "${PARALLEL}"

else
  get_override RMIN --rMin -1
  get_override RMAX --rMax 3
  get_override STRATEGY --cminDefaultMinimizerStrategy 0
  get_override TOLERANCE --cminDefaultMinimizerTolerance 0.0001
  get_override FALLBACK_ALGO --cminFallbackAlgo Minuit2,0:1.0
  get_override PARALLEL --parallel 8
  get_override VERBOSITY -v 1

  # --setParameterRanges for r is built from RMIN/RMAX rather than a separately hardcoded
  # r=-1,5, so it always matches --rMin/--rMax -- including under --passCombine overrides
  # -- instead of drifting out of sync with them the way it previously did (r=-1,5 vs
  # rMin=-1/rMax=3). Also adds --X-rtd MINIMIZER_freezeDisassociatedParams, matching the
  # other unblinding branches above.
  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=${RMIN},${RMAX}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -t -1 -v "${VERBOSITY}" --cminPreScan \
    --expectSignal 1 --doInitialFit --setParameters MH=125 --freezeParameters MH \
    --parallel "${PARALLEL}" --X-rtd MINIMIZER_freezeDisassociatedParams

  ctool -M Impacts -d "${WS}" -m 125 \
    --setParameterRanges "r=${RMIN},${RMAX}" --rMin "${RMIN}" --rMax "${RMAX}" \
    --cminFallbackAlgo "${FALLBACK_ALGO}" --cminDefaultMinimizerTolerance "${TOLERANCE}" \
    --cminDefaultMinimizerStrategy "${STRATEGY}" -t -1 -v "${VERBOSITY}" --cminPreScan \
    --expectSignal 1 --doFits --setParameters MH=125 --freezeParameters MH \
    --parallel "${PARALLEL}" --X-rtd MINIMIZER_freezeDisassociatedParams
fi

# Warn (don't fail) about any --passCombine override that didn't apply to the branch
# that actually ran, e.g. --cminApproxPreFitTolerance given outside --unblind mode.
for key in "${!OVERRIDES[@]}"; do
  if [[ -z "${USED_OVERRIDE[$key]+set}" ]]; then
    echo "Warning: --passCombine override '${key}' does not apply in this mode and was ignored." >&2
  fi
done

EXCLUDE_ARG=()
if [[ -n "${EXCLUDE_PARAMS:-}" ]]; then
  EXCLUDE_ARG=(--exclude "${EXCLUDE_PARAMS}")
fi
ctool -M Impacts -d "${WS}" -m 125 -o impacts.json "${EXCLUDE_ARG[@]}"

if [[ "${UNBLIND}" -eq 1 || "${UNBLIND_DEFAULT}" -eq 1 || "${UNBLIND_RAM}" -eq 1 ]]; then
  plotimpacts -i impacts.json -o "impacts${OUT_TAG}" --blind
else
  plotimpacts -i impacts.json -o "impacts${OUT_TAG}"
fi

cp -f "impacts${OUT_TAG}.pdf" /eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/impacts/${DEST_NAME}
