#!/usr/bin/env bash
set -euo pipefail

default_mx=""
default_my=""
default_year=""
default_category=""
default_ntoys="1000"
default_combine_opts="--cminDefaultMinimizerStrategy 0 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --freezeParameters MH"
default_outdir=""
default_adjustsignal=0
default_adjustsignal_value="100"
default_check_adjustsignal=0
default_print_datacard=0

usage() {
  cat <<EOF
Usage:
  $0 --mx MX --my MY --year YEAR --category {highpurity|lowpurity} [--outdir OUTDIR] [--ntoys N] [--combine-opts "OPTS"] [--adjustsignal [VALUE]] [--check-adjustsignal] [--print-datacard]
  $0 --passArguments DATACARD_ROOT OUTDIR [NTOYS] [COMBINE_OPTS] [--adjustsignal [VALUE]] [--check-adjustsignal] [--print-datacard]

Defaults (from example):
  MX=REQUIRED MY=REQUIRED YEAR=REQUIRED CATEGORY=REQUIRED
  NTOYS=${default_ntoys}
  COMBINE_OPTS="${default_combine_opts}"
  OUTDIR=BiasRuns/MX<MX>_MY<MY>_<YEAR>_cat12<CATEGORY>
EOF
}

pass_arguments=0
mx="$default_mx"
my="$default_my"
year="$default_year"
category="$default_category"
ntoys="$default_ntoys"
combine_opts="$default_combine_opts"
outdir="$default_outdir"
adjustsignal="$default_adjustsignal"
adjustsignal_value="$default_adjustsignal_value"
check_adjustsignal="$default_check_adjustsignal"
print_datacard="$default_print_datacard"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --passArguments)
      pass_arguments=1
      shift
      break
      ;;
    --mx)
      mx="$2"
      shift 2
      ;;
    --my)
      my="$2"
      shift 2
      ;;
    --year)
      year="$2"
      shift 2
      ;;
    --category)
      category="$2"
      shift 2
      ;;
    --ntoys)
      ntoys="$2"
      shift 2
      ;;
    --combine-opts)
      combine_opts="$2"
      shift 2
      ;;
    --outdir)
      outdir="$2"
      shift 2
      ;;
    --adjustsignal)
      adjustsignal=1
      if [[ $# -gt 1 && "${2:-}" != --* ]]; then
        adjustsignal_value="$2"
        shift 2
      else
        shift
      fi
      ;;
    --check-adjustsignal)
      check_adjustsignal=1
      shift
      ;;
    --print-datacard)
      print_datacard=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

datacard_root=""
datacard_txt=""
adjustsignal_backup=""

if [[ $pass_arguments -eq 1 ]]; then
  if [[ $# -lt 2 ]]; then
    usage
    exit 1
  fi
  datacard_root="$1"
  outdir="$2"
  shift 2
  if [[ $# -gt 0 && "${1:-}" != --* ]]; then
    ntoys="$1"
    shift
  fi
  if [[ $# -gt 0 && "${1:-}" != --* ]]; then
    combine_opts="$1"
    shift
  fi
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --adjustsignal)
        adjustsignal=1
        if [[ $# -gt 1 && "${2:-}" != --* ]]; then
          adjustsignal_value="$2"
          shift 2
        else
          shift
        fi
        ;;
      --check-adjustsignal)
        check_adjustsignal=1
        shift
        ;;
      --print-datacard)
        print_datacard=1
        shift
        ;;
      *)
        echo "Unknown argument: $1"
        usage
        exit 1
        ;;
    esac
  done
  datacard_txt="${datacard_root%.root}.txt"
else
  if [[ -z "$mx" || -z "$my" || -z "$year" || -z "$category" ]]; then
    echo "Missing required inputs. Provide --mx, --my, --year, and --category."
    usage
    exit 1
  fi
  datacard_root="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard/datacard_MX${mx}_MY${my}/MX${mx}_MY${my}_${year}_cat12${category}.root"
  datacard_txt="${datacard_root%.root}.txt"
fi

apply_adjustsignal() {
  if [[ ! -f "$datacard_txt" ]]; then
    echo "ERROR: datacard text file not found: $datacard_txt" >&2
    exit 1
  fi
  adjustsignal_backup="${datacard_txt}.adjustsignal.bak"
  cp -f "$datacard_txt" "$adjustsignal_backup"
  python - "$datacard_txt" "$adjustsignal_value" <<'PY'
import sys

path   = sys.argv[1]
factor = float(sys.argv[2])

with open(path) as f:
    lines = f.readlines()

process_nums  = None
rate_line_idx = None

for i, line in enumerate(lines):
    tokens = line.split()
    if not tokens:
        continue
    if tokens[0] == 'process' and process_nums is None:
        try:
            process_nums = [int(t) for t in tokens[1:]]
        except ValueError:
            pass  # name row, not number row
    elif tokens[0] == 'rate' and process_nums is not None:
        rate_line_idx = i
        break

if process_nums is None or rate_line_idx is None:
    print("ERROR: could not locate process-number row or rate row")
    sys.exit(1)

signal_cols = [j for j, n in enumerate(process_nums) if n <= 0]
if not signal_cols:
    print("ERROR: no signal processes (process number <= 0) found")
    sys.exit(1)

rate_tokens = lines[rate_line_idx].split()
new_rates = list(rate_tokens[1:])
for col in signal_cols:
    new_rates[col] = repr(float(new_rates[col]) * factor)

lines[rate_line_idx] = 'rate          ' + '  '.join(new_rates) + '\n'

with open(path, 'w') as f:
    f.writelines(lines)

print("Signal rate x{} applied to column(s): {}".format(int(factor), signal_cols))
for col in signal_cols:
    print("  col {}: {}".format(col, new_rates[col]))
PY
}

print_datacard_snapshot() {
  if [[ ! -f "$datacard_txt" ]]; then
    echo "ERROR: datacard text file not found: $datacard_txt" >&2
    return 1
  fi
  echo "Datacard snapshot: $datacard_txt"
  echo "  rate line:"
  grep -n '^rate' "$datacard_txt" || true
  echo "  Datacard tail (last 6 lines):"
  tail -n 6 "$datacard_txt"
}

cleanup_adjustsignal() {
  if [[ "$adjustsignal" -ne 1 ]]; then
    return
  fi
  # datacard_txt/root are now job-private copies inside outdir — no restore needed.
  echo "adjustsignal cleanup: private datacard retained in $outdir"
}

check_adjustsignal_rates() {
  local dc_txt="$1"
  python - "$dc_txt" "$adjustsignal_value" <<'PY'
import sys

path   = sys.argv[1]
factor = float(sys.argv[2])

with open(path) as f:
    lines = f.readlines()

process_names = None
process_nums  = None
rate_tokens   = None

for line in lines:
    tokens = line.split()
    if not tokens:
        continue
    if tokens[0] == 'process':
        try:
            nums = [int(t) for t in tokens[1:]]
            process_nums = nums
        except ValueError:
            process_names = tokens[1:]
    elif tokens[0] == 'rate' and process_nums is not None:
        rate_tokens = tokens[1:]
        break

if process_nums is None or rate_tokens is None:
    print("ERROR: could not parse datacard")
    sys.exit(1)

signal_cols = [j for j, n in enumerate(process_nums) if n <= 0]
print("Signal columns (process number <= 0): {}".format(signal_cols))
for col in signal_cols:
    name = process_names[col] if process_names else "col{}".format(col)
    print("  {}: rate = {}".format(name, rate_tokens[col]))
PY
}

if [[ "$adjustsignal" -eq 1 ]]; then
  trap cleanup_adjustsignal EXIT
fi

if [[ $pass_arguments -eq 1 ]]; then
  if [[ "$datacard_root" =~ MX([0-9]+)_MY([0-9]+)_([0-9]{4})_cat12([A-Za-z]+) ]]; then
    mx="${BASH_REMATCH[1]}"
    my="${BASH_REMATCH[2]}"
    year="${BASH_REMATCH[3]}"
    category="${BASH_REMATCH[4]}"
  fi
fi

if [[ -z "$outdir" ]]; then
  if [[ "$adjustsignal" -ne 0 && "$adjustsignal_value" != "$default_adjustsignal_value" ]]; then
    outdir="BiasRuns/MX${mx}_MY${my}_${year}_cat12${category}_AS${adjustsignal_value}"
  else
    outdir="BiasRuns/MX${mx}_MY${my}_${year}_cat12${category}"
  fi
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

# Remove stale outputs so hadd never sees mixed results from different runs.
if [[ -d "$outdir" ]]; then
  echo "Removing stale BiasRuns directory: $outdir"
  rm -rf "$outdir"
fi
mkdir -p "$outdir"

if [[ "$adjustsignal" -eq 1 ]]; then
  # Copy datacard to a job-private outdir so concurrent AS jobs don't race
  # on the shared EOS datacard file. Use absolute paths so combine can find
  # the workspace when run_in_outdir cd's into the outdir.
  local_dc_txt="${script_dir}/${outdir}/$(basename "$datacard_txt")"
  local_dc_root="${script_dir}/${outdir}/$(basename "$datacard_root")"
  cp -f "$datacard_txt" "$local_dc_txt"
  datacard_txt="$local_dc_txt"
  datacard_root="$local_dc_root"
  echo "Adjusting signal in datacard and rebuilding workspace:"
  echo "  $datacard_txt"
  apply_adjustsignal
  if [[ "$print_datacard" -eq 1 ]]; then
    print_datacard_snapshot
  fi
  text2workspace.py "$datacard_txt" -o "$datacard_root"
else
  if [[ ! -f "$datacard_root" ]]; then
    if [[ -f "$datacard_txt" ]]; then
      echo "Root workspace not found. Building with text2workspace.py:"
      echo "  text2workspace.py $datacard_txt -o $datacard_root"
      if [[ "$print_datacard" -eq 1 ]]; then
        print_datacard_snapshot
      fi
      text2workspace.py "$datacard_txt" -o "$datacard_root"
    else
      echo "Missing both ROOT and TXT datacards:"
      echo "  $datacard_root"
      echo "  $datacard_txt"
      exit 1
    fi
  fi
fi

if [[ "$check_adjustsignal" -eq 1 ]]; then
  echo "Checking adjustsignal rates in datacard:"
  echo "  $datacard_txt"
  check_adjustsignal_rates "$datacard_txt"
fi

python RunBiasStudy.py -d "$datacard_root" -t -n "$ntoys" --outdir "$outdir"
python RunBiasStudy.py -d "$datacard_root" -f -n "$ntoys" --outdir "$outdir" -c "$combine_opts"
python RunBiasStudy.py -d "$datacard_root" -p --gaussianFit --outdir "$outdir" 2>&1 | tee "$outdir/Pull.log"
python plot_bias.py --log "$outdir/Pull.log" --out "$outdir/bias_study_dot_plot.png"

web_outdir="/eos/user/j/jodervan/www/Analysis/HHWWgg/modeling/biasstudy"
mkdir -p "$web_outdir"
as_tag=""
if [[ "$adjustsignal" -ne 0 && "$adjustsignal_value" != "$default_adjustsignal_value" ]]; then
  as_tag="_AS${adjustsignal_value}"
fi
web_plot="${web_outdir}/bias_study_dot_plot_MX${mx}_MY${my}_${year}_cat12${category}${as_tag}.png"
cp -f "$outdir/bias_study_dot_plot.png" "$web_plot"
echo "Web dotplot: $web_plot"

web_fits_dir="${web_outdir}/BiasPlots_MX${mx}_MY${my}_${year}_cat12${category}${as_tag}"
mkdir -p "$web_fits_dir"
cp -a "$outdir/BiasFits" "$web_fits_dir/"
index_src="${web_outdir}/index.php"
if [[ -f "$index_src" ]]; then
  find "$web_fits_dir" -type d | while read d; do
    cp -f "$index_src" "${d}/index.php"
  done
fi
echo "Web BiasFits dir: $web_fits_dir/BiasFits"
