#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  copy_multipdf.sh MX MY

Copies all matching PDFs from:
  /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/<year>/MX<MX>_MY<MY>/data/ws_2018_cat12<purity>/multipdf_cat12<purity>.pdf
to:
  /eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/background/multipdf_cat12<purity>_<year>_MX<MX>_MY<MY>.pdf
EOF
}

if [[ $# -ne 2 ]]; then
  usage
  exit 2
fi

MX="$1"
MY="$2"

OUT_DIR="/eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/background"
SRC_GLOB="/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/*/MX${MX}_MY${MY}/data/ws_*_cat12*/multipdf_cat12*.pdf"

mkdir -p "$OUT_DIR"

shopt -s nullglob
found=0
for src in $SRC_GLOB; do
  if [[ ! -f "$src" ]]; then
    continue
  fi
  found=1
  dir1="$(dirname "$src")"
  dir2="$(dirname "$dir1")"
  dir3="$(dirname "$dir2")"
  dir4="$(dirname "$dir3")"

  year="$(basename "$dir4")"
  mass="$(basename "$dir3")"
  base1="$(basename "$dir1")"

  purity="${base1#ws_*_cat12}"
  mx="${mass#MX}"
  mx="${mx%%_MY*}"
  my="${mass##*_MY}"

  out_pdf="${OUT_DIR}/multipdf_cat12${purity}_${year}_MX${mx}_MY${my}.pdf"
  cp -v "$src" "$out_pdf"
done

if [[ "$found" -eq 0 ]]; then
  echo "No files matched: $SRC_GLOB"
  exit 1
fi
