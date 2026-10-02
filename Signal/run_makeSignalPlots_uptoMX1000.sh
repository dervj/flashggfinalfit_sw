#!/usr/bin/env bash
set -euo pipefail

masspoints_file="/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/masspoints_2017_upto1p6TeV.dat"
script="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Signal/makeSignalPlots.sh"

if [[ ! -f "${masspoints_file}" ]]; then
  echo "[ERROR] Masspoints file not found: ${masspoints_file}" >&2
  exit 1
fi
if [[ ! -x "${script}" ]]; then
  # allow running via bash even if not executable
  if [[ ! -f "${script}" ]]; then
    echo "[ERROR] makeSignalPlots.sh not found: ${script}" >&2
    exit 1
  fi
fi

while read -r year mx my; do
  [[ -z "${year}" ]] && continue
  [[ "${year}" =~ ^# ]] && continue
  if [[ "${year}" != "2017" ]]; then
    continue
  fi
  if (( mx <= 1000 )); then
    bash "${script}" "${mx}" "${my}" --weight
  fi
done < "${masspoints_file}"
