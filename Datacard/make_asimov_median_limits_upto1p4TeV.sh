#!/usr/bin/env bash
# make_asimov_median_limits_upto1p4TeV.sh

set -euo pipefail

BASE="/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard"

OUTCSV="asimov_median_limits_upto1400.csv"
WORKDIR="${PWD}/limit_smattering_run2_upto1400"
MAX_MX=1400

# runtime guards (seconds)
PROBE_TIMEOUT=300
LIMIT_TIMEOUT=300

# probe config
PROBE_RMAX=0.01
PROBE_POINTS=10
TARGET_DNLL=1.92
RMAX_CAP=0.05
RMAX_FLOOR=1e-6

mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

run_maybe_timeout() {
  local tsec="$1"; shift
  if command -v timeout >/dev/null 2>&1; then
    timeout "${tsec}" "$@"
  else
    "$@"
  fi
}

run_combine_and_get_output() {
  local method="$1"; shift
  local before after
  before="$(mktemp)"
  after="$(mktemp)"

  ls -1 higgsCombine*.${method}.mH125.root 2>/dev/null | sort > "${before}" || true

  "$@"

  ls -1 higgsCombine*.${method}.mH125.root 2>/dev/null | sort > "${after}" || true

  local newf
  newf="$(comm -13 "${before}" "${after}" | tail -n 1 || true)"

  rm -f "${before}" "${after}"
  echo "${newf}"
}

# Find a combine-ready workspace ROOT inside the given datacard directory.
# REQUIREMENTS: file contains RooWorkspace named "w"
# Preference: prefer "*fromproc*.root" if it contains "w"
find_workspace_root() {
  local d="$1"
  local mx="$2"
  local my="$3"

  local ws="${d}/MX${mx}_MY${my}_Run2_cat12_fromproc.root"
  if [[ ! -f "${ws}" ]]; then
    echo ""
    return 1
  fi

  # Optional but strongly recommended: verify it contains RooWorkspace "w"
  if root -l -b -q "${ws}" -e '
    auto f=TFile::Open(gSystem->Getenv("WS"));
    if(!f){ return; }
    auto w=(RooWorkspace*)f->Get("w");
    if(w) std::cout<<"OK\n";
  ' 2>/dev/null WS="${ws}" | grep -q OK; then
    echo "${ws}"
    return 0
  fi

  # If you prefer: return the file even if the check fails (but you'll get combine errors later)
  echo ""
  return 1
}


probe_rmax() {
  local ws="$1"
  local tag="$2"

  echo "  [probe] MultiDimFit grid r=[0,${PROBE_RMAX}] points=${PROBE_POINTS}" >&2

  local probe_out
  probe_out="$(run_combine_and_get_output "MultiDimFit" \
    run_maybe_timeout "${PROBE_TIMEOUT}" \
    combine -M MultiDimFit "${ws}" -m 125 \
      -t -1 --expectSignal 0 \
      --algo grid --points "${PROBE_POINTS}" \
      -P r --floatOtherPOIs 1 \
      --rMin 0 --rMax "${PROBE_RMAX}" \
      --cminDefaultMinimizerStrategy 0 \
      --cminDefaultMinimizerTolerance 0.1 \
      -v 1 \
  )"

  if [[ -z "${probe_out}" || ! -f "${probe_out}" ]]; then
    echo "[WARN] Probe produced no output file; using fallback rMax=${PROBE_RMAX}" >&2
    echo "${PROBE_RMAX}"
    return 0
  fi

  local dump_txt="probe_${tag}.txt"
  root -l -b -q "${probe_out}" -e '
    auto t=(TTree*)_file0->Get("limit");
    if(!t){ std::cout<<"NO_LIMIT_TREE\n"; return; }
    double r=0,d=0;
    t->SetBranchAddress("r",&r);
    t->SetBranchAddress("deltaNLL",&d);
    for(Long64_t i=0;i<t->GetEntries();++i){
      t->GetEntry(i);
      std::cout<<r<<" "<<d<<"\n";
    }
  ' 2>/dev/null > "${dump_txt}"

  if grep -q "NO_LIMIT_TREE" "${dump_txt}"; then
    echo "${PROBE_RMAX}"
    return 0
  fi

  local rmax
  rmax="$(awk -v target="${TARGET_DNLL}" -v cap="${RMAX_CAP}" -v floor="${RMAX_FLOOR}" -v probeMax="${PROBE_RMAX}" '
    BEGIN{prev_r=-1; prev_d=-1; rcross=-1;}
    {
      r=$1; d=$2;
      if(prev_r>=0 && rcross<0){
        if(d>=target && prev_d<target){
          if(d==prev_d){ rcross=r; }
          else{
            frac=(target-prev_d)/(d-prev_d);
            rcross=prev_r + frac*(r-prev_r);
          }
        }
      }
      prev_r=r; prev_d=d;
    }
    END{
      if(rcross<0){
        rcross=probeMax;
      }
      rmax=5.0*rcross;
      if(rmax<floor) rmax=floor;
      if(rmax>cap) rmax=cap;
      printf("%.10g\n", rmax);
    }
  ' "${dump_txt}")"

  echo "${rmax}"
}

run_asimov_limit() {
  local ws="$1"
  local tag="$2"
  local rmax="$3"

  echo "  [limit] AsymptoticLimits Asimov (median expected), rMax=${rmax}" >&2

  local out
  out="$(run_combine_and_get_output "AsymptoticLimits" \
    run_maybe_timeout "${LIMIT_TIMEOUT}" \
    combine -M AsymptoticLimits "${ws}" -m 125 \
      -t -1 --expectSignal 0 \
      --rMin 0 --rMax "${rmax}" \
      --cminDefaultMinimizerStrategy 0 \
      --cminDefaultMinimizerTolerance 0.1 \
      -v 1 \
  )"

  if [[ -z "${out}" || ! -f "${out}" ]]; then
    echo "NaN NO_OUTPUT"
    return 0
  fi

  local lim
  lim="$(root -l -b -q "${out}" -e '
    auto t=(TTree*)_file0->Get("limit");
    if(!t){ std::cout<<"NaN\n"; return; }
    double q=0, L=0;
    t->SetBranchAddress("quantileExpected",&q);
    t->SetBranchAddress("limit",&L);
    double best=-1; bool found=false;
    for(Long64_t i=0;i<t->GetEntries();++i){
      t->GetEntry(i);
      if(q < -0.5){ best=L; found=true; break; }
    }
    if(found) std::cout<<best<<"\n";
    else std::cout<<"NaN\n";
  ' 2>/dev/null | tail -n 1)"

  if [[ "${lim}" == "NaN" || -z "${lim}" ]]; then
    echo "NaN NO_LIMIT_ENTRY"
  else
    echo "${lim} OK"
  fi
}

echo "MX,MY,workspace,rMax,asimov_median_expected_limit,status" > "${OUTCSV}"

mapfile -t DIRS < <(find "${BASE}" -maxdepth 1 -type d -name "datacard_MX*_MY*" | sort)

echo "[INFO] Found ${#DIRS[@]} datacard directories under ${BASE}" >&2
echo "[INFO] Writing CSV to: ${WORKDIR}/${OUTCSV}" >&2
echo >&2

for d in "${DIRS[@]}"; do
  bn="$(basename "${d}")"
  if [[ "${bn}" =~ datacard_MX([0-9]+)_MY([0-9]+) ]]; then
    MX="${BASH_REMATCH[1]}"
    MY="${BASH_REMATCH[2]}"
  else
    continue
  fi

  if (( MX > MAX_MX )); then
    continue
  fi

  echo "==> Processing MX=${MX} MY=${MY} (${bn})" >&2

  ws="$(find_workspace_root "${d}" "${MX}" "${MY}" || true)"
    if [[ -z "${ws}" ]]; then
    echo "  [skip] Missing/invalid workspace: ${d}/MX${MX}_MY${MY}_Run2_cat12_fromproc.root" >&2
    echo "${MX},${MY},,${PROBE_RMAX},NaN,NO_WORKSPACE" >> "${OUTCSV}"
    echo >&2
    continue
    fi

  tag="_MX${MX}_MY${MY}"

  rmax="$(probe_rmax "${ws}" "${tag}")"
  echo "  [probe] chosen rMax=${rmax}" >&2

  read -r lim status <<<"$(run_asimov_limit "${ws}" "${tag}" "${rmax}")"
  echo "  [done] limit=${lim} status=${status}" >&2

  echo "${MX},${MY},${ws},${rmax},${lim},${status}" >> "${OUTCSV}"
  echo >&2
done

echo "[INFO] Done. Results: ${WORKDIR}/${OUTCSV}" >&2
