# Force Combine tools to use python2.7 (CMSSW_10_6_20)
alias ctool='python2.7 $(command -v combineTool.py)'
alias combine2='python2.7 $(command -v combine.py)'
alias plotimpacts='python2.7 $(command -v plotImpacts.py)'

# One-time ROOT load (useful to warm caches and verify PyROOT works)
python2.7 - <<'EOF'
import ROOT
print("ROOT loaded")
EOF
