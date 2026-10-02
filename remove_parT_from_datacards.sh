#!/usr/bin/env bash
set -euo pipefail

pattern="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard/datacard_MX*_MY*/Datacard_MX*_MY*_*_*_cat12*.txt"
masspoints_file="${1:-}"

python3 - "$pattern" "$masspoints_file" <<'PY'
import glob
import re
import sys
from pathlib import Path

pattern = sys.argv[1]
masspoints_file = sys.argv[2].strip() if len(sys.argv) > 2 else ""
files = sorted(glob.glob(pattern))

if not files:
    print(f"No files matched pattern: {pattern}")
    sys.exit(0)

removed_total = 0
scanned = 0
skipped_my250 = 0
skipped_unknown = 0
skipped_masspoints = 0

re_line = re.compile(r"^\s*PTransformerHtaggerSF_.*\s+lnN\b")
re_my = re.compile(r"MY(\d+)")
re_mx = re.compile(r"MX(\d+)")

allowed_pairs = None
if masspoints_file:
    allowed_pairs = set()
    mp_path = Path(masspoints_file)
    if not mp_path.exists():
        print(f"Masspoints file not found: {mp_path}")
        sys.exit(1)
    for raw in mp_path.read_text().splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split()
        if len(parts) < 2:
            print(f"Invalid masspoint line (need 'mx my'): {raw}")
            sys.exit(1)
        try:
            mx = int(parts[0])
            my = int(parts[1])
        except ValueError:
            print(f"Invalid masspoint line (non-integer): {raw}")
            sys.exit(1)
        allowed_pairs.add((mx, my))

for f in files:
    path = Path(f)
    scanned += 1
    my_vals = [int(x) for x in re_my.findall(path.name)]
    if not my_vals:
        my_vals = [int(x) for x in re_my.findall(str(path))]
    mx_vals = [int(x) for x in re_mx.findall(path.name)]
    if not mx_vals:
        mx_vals = [int(x) for x in re_mx.findall(str(path))]
    if not my_vals:
        print(f"[skip] Could not extract MY from: {path}")
        skipped_unknown += 1
        continue
    if not mx_vals:
        print(f"[skip] Could not extract MX from: {path}")
        skipped_unknown += 1
        continue

    my_val = my_vals[-1]
    mx_val = mx_vals[-1]
    if allowed_pairs is not None and (mx_val, my_val) not in allowed_pairs:
        skipped_masspoints += 1
        continue
    if my_val <= 250:
        skipped_my250 += 1
        continue

    text = path.read_text()
    lines = text.splitlines(keepends=True)
    new_lines = [ln for ln in lines if not re_line.match(ln)]

    if len(new_lines) != len(lines):
        path.write_text("".join(new_lines))
        removed = len(lines) - len(new_lines)
        removed_total += removed
        print(f"[edit] {path} (removed {removed} line(s))")

print(f"Scanned: {scanned}")
print(f"Skipped (MY<=250): {skipped_my250}")
print(f"Skipped (unknown MY): {skipped_unknown}")
print(f"Skipped (not in masspoints file): {skipped_masspoints}")
print(f"Total PTransformerHtaggerSF_* lines removed: {removed_total}")
PY
