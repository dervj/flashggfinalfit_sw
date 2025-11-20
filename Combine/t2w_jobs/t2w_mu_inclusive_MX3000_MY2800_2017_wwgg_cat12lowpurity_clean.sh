#!/bin/bash

cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Combine

eval `scramv1 runtime -sh`

text2workspace.py Datacard_MX3000_MY2800_2017_wwgg_cat12lowpurity_clean.txt -o Datacard_MX3000_MY2800_2017_wwgg_cat12lowpurity_clean_mu_inclusive.root -m 125 higgsMassRange=122,128 