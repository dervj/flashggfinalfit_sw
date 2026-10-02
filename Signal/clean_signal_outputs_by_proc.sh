#!/usr/bin/env bash
set -euo pipefail

BASE="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Signal"
MASSPOINTS="/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/condor_yh_boosted/masspoints.txt"
YEARS=(2016pre 2016post 2017 2018)
PURITIES=(high low)

PROC="${1:-}"
DRY_RUN="${2:-1}"  # 1 = dry-run, 0 = delete

if [[ -z "${PROC}" ]]; then
  echo "Usage: $0 <PROC> [DRY_RUN]"
  echo "  PROC: wwgg|GGH|VBF|VH|TTH"
  exit 1
fi

while read -r mx my _; do
  [[ -z "${mx:-}" || "${mx:0:1}" == "#" ]] && continue
  for year in "${YEARS[@]}"; do
    for purity in "${PURITIES[@]}"; do
      d1="${BASE}/outdir_${year}_MX${mx}_MY${my}_${year}_cat12${purity}purity_${PROC}"
      d2="${BASE}/outdir_packaged_MX${mx}_MY${my}_${year}_cat12${purity}purity_${PROC}"

      for d in "$d1" "$d2"; do
        [[ -d "$d" ]] || continue
        if [[ "$DRY_RUN" -eq 1 ]]; then
          echo "Would remove: $d"
        else
          rm -rf "$d"
          echo "Removed: $d"
        fi
      done
    done
  done
done < "$MASSPOINTS"