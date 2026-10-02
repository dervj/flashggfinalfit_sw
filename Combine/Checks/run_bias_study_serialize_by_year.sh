#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat << "USAGE"
Usage:
  run_bias_study_serialize_by_year.sh <year> [masspoints_file]

Defaults:
  masspoints_file=/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_upto1p6TeV.txt

Format:
  masspoints_file should contain two columns: MX MY (no year column)

Runs (serial):
  run_bias_study_one.sh --mx <MX> --my <MY> --year <year> --category lowpurity --ntoys 1000 --adjustsignal 500

Note:
  Only runs masspoints with MX <= 1000.
USAGE
}

if [[ ${#} -lt 1 || ${#} -gt 2 ]]; then
  usage
  exit 2
fi

YEAR="$1"
MASSPOINTS_FILE="${2:-/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_upto1p6TeV.txt}"
SCRIPT="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Combine/Checks/run_bias_study_one.sh"

if [[ ! -f "${MASSPOINTS_FILE}" ]]; then
  echo "[ERROR] Masspoints file not found: ${MASSPOINTS_FILE}" >&2
  exit 1
fi
if [[ ! -f "${SCRIPT}" ]]; then
  echo "[ERROR] run_bias_study_one.sh not found: ${SCRIPT}" >&2
  exit 1
fi

count=0
failed=()
while read -r mx my; do
  [[ -z "${mx}" ]] && continue
  [[ "${mx}" =~ ^# ]] && continue

  if [[ -z "${my}" ]]; then
    echo "[ERROR] Malformed line in ${MASSPOINTS_FILE}: ${mx} ${my:-}" >&2
    exit 1
  fi

  if (( mx > 1000 )); then
    continue
  fi

  echo "[${YEAR}] Running MX=${mx} MY=${my}"
  if ! bash "${SCRIPT}" \
    --mx "${mx}" \
    --my "${my}" \
    --year "${YEAR}" \
    --category lowpurity \
    --ntoys 1000 \
    --adjustsignal 1000; then
    echo "[${YEAR}] FAILED MX=${mx} MY=${my}, skipping" >&2
    failed+=("MX=${mx} MY=${my}")
    continue
  fi

  count=$((count+1))
done < "${MASSPOINTS_FILE}"

echo "Done. Ran ${count} masspoints for year ${YEAR}."
if [[ ${#failed[@]} -gt 0 ]]; then
  echo "Failed (${#failed[@]}):" >&2
  for f in "${failed[@]}"; do
    echo "  ${f}" >&2
  done
fi
