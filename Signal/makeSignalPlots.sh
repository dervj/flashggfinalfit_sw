#!/usr/bin/env bash
set -euo pipefail

set -o errtrace
trap 'rc=$?; echo "ERROR: command failed (rc=${rc}) at ${BASH_SOURCE[0]}:${LINENO}: ${BASH_COMMAND}" >&2; exit ${rc}' ERR

usage() {
  cat <<'EOF'
Usage:
  bash makeSignalPlots.sh <MX> <MY> [--weight] [--hponly]

Runs:
  1) Package (merge years) into a single outdir with two cats (cat12highpurity, cat12lowpurity)
  2) (optional --weight) compute cat S/(S+B) weights and write a json keyed by cat12{high,low}purity
  3) Plot combined signal model from the merged outdir (overall and per-category)
  4) Copy plots to /eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/signal/fits as png/pdf

Notes:
  - Uses CMSSW python (python2). Do not run with python3.
  - The workspace is inferred from ../Datacard/datacard_MX<MX>_MY<MY>/MX<MX>_MY<MY>_Run2_cat12_fromproc.root
    (or ..._Run2_cat12highpurity_fromproc.root with --hponly)
  - Runs scripts from their directories via explicit `cd` into `Plots/` and `Signal/`.
EOF
}

MX=""
MY=""
DO_WEIGHT=0
DO_HPONLY=0

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then usage; exit 0; fi
if [[ $# -lt 2 ]]; then usage; exit 2; fi
MX="$1"
MY="$2"
shift 2
while [[ $# -gt 0 ]]; do
  case "${1:-}" in
    --weight) DO_WEIGHT=1 ;;
    --hponly) DO_HPONLY=1 ;;
    *) echo "Unknown arg: ${1}" >&2; usage; exit 2 ;;
  esac
  shift
done

if [[ -z "$MX" || -z "$MY" ]]; then
  echo "ERROR: MX and MY are required" >&2
  usage
  exit 2
fi

WS="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12_fromproc.root"
if [[ ! -f "${WS}" ]]; then
  echo "ERROR: workspace not found: ${WS}" >&2
  exit 2
fi
if [[ "${DO_HPONLY}" -eq 1 ]]; then
  WS="../Datacard/datacard_MX${MX}_MY${MY}/MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc.root"
fi
if [[ ! -f "${WS}" ]]; then
  echo "ERROR: workspace not found: ${WS}" >&2
  exit 2
fi

OUTPUT_EXT="packaged_MX${MX}_MY${MY}_wwgg_cat12"
YEARS="2016pre,2016post,2017,2018"
WWW_OUTDIR="/eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/signal/fits"
if [[ "${DO_HPONLY}" -eq 1 ]]; then
  OUTPUT_EXT="${OUTPUT_EXT}_hponly"
fi

echo "[1/3] Packaging (merge years) -> ${OUTPUT_EXT}"

stage_for_packager() {
  local ext="$1"
  local cat="$2"
  local outdir="outdir_${ext}"
  local staged_dir="${outdir}/signalFit/output"

  mkdir -p "${staged_dir}"

  # RunPackager's underlying packager expects files matching:
  #   outdir_<ext>/signalFit/output/CMS-HGG_sigfit_<ext>_*_<cat>.root
  # but our per-year packaged outputs are often written directly under outdir_<ext>/.
  local src
  src="$(ls -1 "${outdir}/CMS-HGG_sigfit_${ext}"*.root 2>/dev/null | head -n 1 || true)"
  if [[ -z "${src}" ]]; then
    echo "ERROR: cannot find input ROOT under ${outdir}/ for ext=${ext}" >&2
    echo "Expected something like: ${outdir}/CMS-HGG_sigfit_${ext}*.root" >&2
    exit 1
  fi

  local dst="${staged_dir}/CMS-HGG_sigfit_${ext}_staged_${cat}.root"
  if [[ ! -f "${dst}" ]]; then
    cp -f "${src}" "${dst}"
  fi
}

run_packager() {
  local cat="$1"
  local exts="$2"
  local expected="outdir_${OUTPUT_EXT}/CMS-HGG_sigfit_${OUTPUT_EXT}_${cat}.root"

  # Stage inputs into the directory/filename structure expected by scripts/packageSignal.py.
  IFS=',' read -r -a ext_arr <<< "${exts}"
  for ext in "${ext_arr[@]}"; do
    stage_for_packager "${ext}" "${cat}"
  done

  echo "+ (cd Signal && python RunPackager.py) (${cat})"
  local rc=0
  ( cd "$(dirname "$0")" && \
    python RunPackager.py \
      --cats "${cat}" \
      --exts "${exts}" \
      --mergeYears \
      --batch local \
      --massPoints 125 \
      --outputExt "${OUTPUT_EXT}" \
  ) || rc=$?

  if [[ ! -f "${expected}" ]]; then
    echo "ERROR: packager did not produce expected output: ${expected}" >&2
    echo "RunPackager.py exit code was: ${rc}" >&2
    exit 1
  fi
  if [[ "${rc}" -ne 0 ]]; then
    echo "WARNING: RunPackager.py returned rc=${rc} but output exists: ${expected}" >&2
  fi
}

run_packager "cat12highpurity" "packaged_MX${MX}_MY${MY}_2016pre_cat12highpurity_wwgg,packaged_MX${MX}_MY${MY}_2016post_cat12highpurity_wwgg,packaged_MX${MX}_MY${MY}_2017_cat12highpurity_wwgg,packaged_MX${MX}_MY${MY}_2018_cat12highpurity_wwgg"
if [[ "${DO_HPONLY}" -eq 0 ]]; then
  run_packager "cat12lowpurity" "packaged_MX${MX}_MY${MY}_2016pre_cat12lowpurity_wwgg,packaged_MX${MX}_MY${MY}_2016post_cat12lowpurity_wwgg,packaged_MX${MX}_MY${MY}_2017_cat12lowpurity_wwgg,packaged_MX${MX}_MY${MY}_2018_cat12lowpurity_wwgg"
fi

CATWEIGHTS_JSON=""
if [[ "${DO_WEIGHT}" -eq 1 ]]; then
  echo "[2/3] Building category S/(S+B) weights from ${WS}"
  WEIGHT_EXT="_MX${MX}_MY${MY}_Run2_cat12_fromproc"
  if [[ "${DO_HPONLY}" -eq 1 ]]; then
    WEIGHT_EXT="_MX${MX}_MY${MY}_Run2_cat12highpurity_fromproc"
  fi
  export MX MY WEIGHT_EXT
  if [[ "${DO_HPONLY}" -eq 1 ]]; then
    export HP_ONLY=1
  fi
  ( cd "$(dirname "$0")/../Plots" && \
    python getCatInfo.py \
      --inputWSFile "${WS}" \
      --cats all \
      --saveCatInfo \
      --ext "${WEIGHT_EXT}" \
  )
  if [[ ! -f "$(dirname "$0")/../Plots/pkl/catInfo${WEIGHT_EXT}.pkl" ]]; then
    echo "ERROR: expected weights pkl not found: ../Plots/pkl/catInfo${WEIGHT_EXT}.pkl" >&2
    echo "getCatInfo.py likely failed to write the file for this mass point." >&2
    exit 1
  fi
  ( cd "$(dirname "$0")/../Plots" && python convert_pkl_json.py --exts "catInfo${WEIGHT_EXT}" )

  # Convert the 8 per-era channels into 2 purity weights expected by RunPlotter_combined.py (--cats wall).
  # For hp-only, also drop the low-purity entry (still safe for --cats cat12highpurity).
  ( cd "$(dirname "$0")/../Plots" && \
    python - <<'PY'
import json
import os

weight_ext = os.environ["WEIGHT_EXT"]
inp = "./pkl/catInfo%s.json" % (weight_ext,)
with open(inp, "r") as f:
  data = json.load(f)

def add(acc, entry):
  acc["sig"] += float(entry.get("sig", 0.0))
  acc["bkg"] += float(entry.get("bkg", 0.0))

high = {"sig": 0.0, "bkg": 0.0}
low = {"sig": 0.0, "bkg": 0.0}
hp_only = os.environ.get("HP_ONLY") == "1"
for k, v in data.items():
  if hp_only:
    add(high, v)
    continue
  if "cat12highpurity" in k:
    add(high, v)
  elif "cat12lowpurity" in k:
    add(low, v)

def sospb(d):
  s, b = d["sig"], d["bkg"]
  return (s / (s + b)) if (s + b) > 0 else 0.0

out = {
  "cat12highpurity": {"sig": high["sig"], "bkg": high["bkg"], "SoverSplusB": sospb(high)},
  "cat12lowpurity": {"sig": low["sig"], "bkg": low["bkg"], "SoverSplusB": sospb(low)},
}
if os.environ.get("HP_ONLY") == "1":
  out = {
    "cat12highpurity": out["cat12highpurity"],
  }
mx = os.environ["MX"]
my = os.environ["MY"]
outp = "./pkl/catWeights_MX%s_MY%s_Run2_cat12.json" % (mx, my)
with open(outp, "w") as f:
  json.dump(out, f, indent=2, sort_keys=True)
print("Wrote", outp)
PY
  )

  CATWEIGHTS_JSON="../Plots/pkl/catWeights_MX${MX}_MY${MY}_Run2_cat12.json"
  if [[ "${DO_HPONLY}" -eq 1 ]]; then
    CATWEIGHTS_JSON="../Plots/pkl/catWeights_MX${MX}_MY${MY}_Run2_cat12_hponly.json"
    mv -f "../Plots/pkl/catWeights_MX${MX}_MY${MY}_Run2_cat12.json" "${CATWEIGHTS_JSON}"
  fi
fi

echo "[3/3] Plotting combined signal model"

export MX MY
if [[ -n "${CATWEIGHTS_JSON}" ]]; then
  PLOT_TAG="weighted"
  ( cd "$(dirname "$0")" && \
    python RunPlotter_combined.py \
      --procs all \
      --cats wall \
      --loadCatWeights "${CATWEIGHTS_JSON}" \
      --ext "${OUTPUT_EXT}" \
      --years "${YEARS}" \
      --threshold 0 \
  )
else
  PLOT_TAG="unweighted"
  ( cd "$(dirname "$0")" && \
    python RunPlotter_combined.py \
      --procs all \
      --cats all \
      --ext "${OUTPUT_EXT}" \
      --years "${YEARS}" \
      --threshold 0 \
  )
fi

echo "[4/4] Plotting per-category signal models"
if [[ "${DO_HPONLY}" -eq 1 ]]; then
  cats_list=(cat12highpurity)
else
  cats_list=(cat12highpurity cat12lowpurity)
fi
for cat in "${cats_list[@]}"; do
  if [[ -n "${CATWEIGHTS_JSON}" ]]; then
    ( cd "$(dirname "$0")" && \
      python RunPlotter_combined.py \
        --procs all \
        --cats "${cat}" \
        --loadCatWeights "${CATWEIGHTS_JSON}" \
        --ext "${OUTPUT_EXT}" \
        --years "${YEARS}" \
        --threshold 0 \
    )
  else
    ( cd "$(dirname "$0")" && \
      python RunPlotter_combined.py \
        --procs all \
        --cats "${cat}" \
        --ext "${OUTPUT_EXT}" \
        --years "${YEARS}" \
        --threshold 0 \
    )
  fi
done

echo "[5/5] Copying plots to ${WWW_OUTDIR}"
mkdir -p "${WWW_OUTDIR}"
PLOT_DIR="$(dirname "$0")/outdir_${OUTPUT_EXT}/Plots"
for f in "${PLOT_DIR}"/*.pdf "${PLOT_DIR}"/*.png; do
  [[ -f "${f}" ]] || continue
  base="$(basename "${f}")"
  cp -f "${f}" "${WWW_OUTDIR}/MX${MX}_MY${MY}_${PLOT_TAG}_${base}"
done
