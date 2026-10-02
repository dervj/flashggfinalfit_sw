#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat << "USAGE"
Usage:
  run_bias_study_parallel_by_year.sh <year> [--jobs N] [masspoints_file]

Defaults:
  jobs=4
  masspoints_file=/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_upto1p6TeV.txt

Format:
  masspoints_file should contain two columns: MX MY (no year column)

Runs (parallel, up to N at a time):
  run_bias_study_one.sh --mx <MX> --my <MY> --year <year> --category lowpurity --ntoys 1000 --adjustsignal 500

Note:
  Only runs masspoints with MX <= 1000.
  Requires bash >= 4.3 for wait -n.
USAGE
}

if [[ ${#} -lt 1 ]]; then
  usage
  exit 2
fi

YEAR="$1"
shift

JOBS=4
MASSPOINTS_FILE="/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/condor_yh_boosted/masspoints_upto1p6TeV.txt"
ADJUSTSIGNAL=100

while [[ $# -gt 0 ]]; do
  case "$1" in
    --jobs|-j)
      JOBS="$2"
      shift 2
      ;;
    --adjustsignal|-a)
      ADJUSTSIGNAL="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      exit 2
      ;;
    *)
      MASSPOINTS_FILE="$1"
      shift
      ;;
  esac
done

SCRIPT="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Combine/Checks/run_bias_study_one.sh"

if [[ ! -f "${MASSPOINTS_FILE}" ]]; then
  echo "[ERROR] Masspoints file not found: ${MASSPOINTS_FILE}" >&2
  exit 1
fi
if [[ ! -f "${SCRIPT}" ]]; then
  echo "[ERROR] run_bias_study_one.sh not found: ${SCRIPT}" >&2
  exit 1
fi

# Temp dir to record failures across subshells (one file per failed masspoint)
FAIL_DIR=$(mktemp -d)
trap 'rm -rf "${FAIL_DIR}"' EXIT

n_launched=0
n_active=0

while read -r mx my; do
  [[ -z "${mx}" ]] && continue
  [[ "${mx}" =~ ^# ]] && continue

  if [[ -z "${my}" ]]; then
    echo "[ERROR] Malformed line in ${MASSPOINTS_FILE}: ${mx} ${my:-}" >&2
    wait
    exit 1
  fi

  if (( mx > 1000 )); then
    continue
  fi

  # If at capacity, wait for one job to finish before launching another
  while (( n_active >= JOBS )); do
    wait -n 2>/dev/null || true
    n_active=$(( n_active - 1 ))
  done

  echo "[${YEAR}] Launching MX=${mx} MY=${my} (slot $(( n_active + 1 ))/${JOBS})"
  (
    if ! bash "${SCRIPT}" \
      --mx "${mx}" \
      --my "${my}" \
      --year "${YEAR}" \
      --category lowpurity \
      --ntoys 1000 \
      --adjustsignal "${ADJUSTSIGNAL}"; then
      echo "[${YEAR}] FAILED MX=${mx} MY=${my}" >&2
      touch "${FAIL_DIR}/MX${mx}_MY${my}"
    fi
  ) &

  n_active=$(( n_active + 1 ))
  n_launched=$(( n_launched + 1 ))

done < "${MASSPOINTS_FILE}"

# Wait for all remaining jobs to finish
wait

# Collect failures from the temp dir
failed=()
for f in "${FAIL_DIR}"/*; do
  [[ -e "$f" ]] || continue
  failed+=("${f##*/}")
done

n_failed=${#failed[@]}
n_succeeded=$(( n_launched - n_failed ))

echo "Done. Launched ${n_launched} masspoints for year ${YEAR}: ${n_succeeded} succeeded, ${n_failed} failed."
if (( n_failed > 0 )); then
  echo "Failed (${n_failed}):" >&2
  for f in "${failed[@]}"; do
    echo "  ${f//_/ }" >&2
  done
fi
