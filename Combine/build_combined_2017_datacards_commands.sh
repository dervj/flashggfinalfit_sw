# ======================= MX1000_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyhcombine_MX1000_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyhcombine_MX1000_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyhcombine_MX1000_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyhcombine_MX1000_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1000_MY250_2017_cat12lowpurity --output MX1000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1000_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1000_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1000_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1000_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY250/mc/ws_ggyhcombine_MX1000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1000_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1000_MY250_2017_cat12lowpurity.txt  > MX1000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX1000_MY300 because both cat12 categories are empty

# ======================= MX1000_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyhcombine_MX1000_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyhcombine_MX1000_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyhcombine_MX1000_MY400_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyhcombine_MX1000_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1000_MY400_2017_cat12lowpurity --output MX1000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1000_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1000_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1000_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1000_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY400/mc/ws_ggyhcombine_MX1000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1000_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1000_MY400_2017_cat12lowpurity.txt  > MX1000_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1000_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY400_2017_cat12.txt -m 125)

# ======================= MX1000_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyhcombine_MX1000_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyhcombine_MX1000_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyhcombine_MX1000_MY500_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyhcombine_MX1000_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1000_MY500_2017_cat12lowpurity --output MX1000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1000_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1000_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1000_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1000_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY500/mc/ws_ggyhcombine_MX1000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1000_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1000_MY500_2017_cat12lowpurity.txt  > MX1000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY500_2017_cat12.txt -m 125)

# ======================= MX1000_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyhcombine_MX1000_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyhcombine_MX1000_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyhcombine_MX1000_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyhcombine_MX1000_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1000_MY600_2017_cat12lowpurity --output MX1000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1000_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1000_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1000_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1000_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY600/mc/ws_ggyhcombine_MX1000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1000_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1000_MY600_2017_cat12lowpurity.txt  > MX1000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY600_2017_cat12.txt -m 125)

# ======================= MX1000_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyhcombine_MX1000_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyhcombine_MX1000_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyhcombine_MX1000_MY700_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyhcombine_MX1000_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1000_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1000_MY700_2017_cat12lowpurity --output MX1000_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1000_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1000_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1000_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1000_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1000_MY700/mc/ws_ggyhcombine_MX1000_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY700_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1000_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1000_MY700_2017_cat12lowpurity.txt  > MX1000_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1000_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1000_MY700_2017_cat12.txt -m 125)

# WARNING: Skipping MX1000_MY800 because both cat12 categories are empty

# ======================= MX1200_MY1000, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12lowpurity --procs ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY1000_2017_cat12lowpurity --output MX1200_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY1000_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY1000_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY1000_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY1000_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY1000_2017_cat12lowpurity.txt -m 125)

# ======================= MX1200_MY1000, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX1200_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY1000_2017_cat12highpurity --output MX1200_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY1000_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY1000_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY1000_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY1000_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY1000/mc/ws_ggyhcombine_MX1200_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY1000_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY1000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY1000_2017_cat12lowpurity.txt cat12highpurity_2017=MX1200_MY1000_2017_cat12highpurity.txt > MX1200_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY1000_2017_cat12.txt -m 125)

# ======================= MX1200_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY250_2017_cat12lowpurity --output MX1200_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY250_2017_cat12lowpurity.txt -m 125)

# ======================= MX1200_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX1200_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY250_2017_cat12highpurity --output MX1200_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY250/mc/ws_ggyhcombine_MX1200_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY250_2017_cat12lowpurity.txt cat12highpurity_2017=MX1200_MY250_2017_cat12highpurity.txt > MX1200_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY250_2017_cat12.txt -m 125)

# ======================= MX1200_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyhcombine_MX1200_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyhcombine_MX1200_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyhcombine_MX1200_MY300_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyhcombine_MX1200_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY300_2017_cat12lowpurity --output MX1200_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY300/mc/ws_ggyhcombine_MX1200_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY300_2017_cat12lowpurity.txt  > MX1200_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY300_2017_cat12.txt -m 125)

# WARNING: Skipping MX1200_MY400 because both cat12 categories are empty

# ======================= MX1200_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyhcombine_MX1200_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyhcombine_MX1200_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyhcombine_MX1200_MY500_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyhcombine_MX1200_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY500_2017_cat12lowpurity --output MX1200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY500/mc/ws_ggyhcombine_MX1200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY500_2017_cat12lowpurity.txt  > MX1200_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY500_2017_cat12.txt -m 125)

# ======================= MX1200_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyhcombine_MX1200_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyhcombine_MX1200_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyhcombine_MX1200_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyhcombine_MX1200_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY600_2017_cat12lowpurity --output MX1200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY600/mc/ws_ggyhcombine_MX1200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY600_2017_cat12lowpurity.txt  > MX1200_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY600_2017_cat12.txt -m 125)

# ======================= MX1200_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyhcombine_MX1200_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyhcombine_MX1200_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyhcombine_MX1200_MY700_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyhcombine_MX1200_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY700_2017_cat12lowpurity --output MX1200_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY700/mc/ws_ggyhcombine_MX1200_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY700_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY700_2017_cat12lowpurity.txt  > MX1200_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY700_2017_cat12.txt -m 125)

# ======================= MX1200_MY800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyhcombine_MX1200_MY800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyhcombine_MX1200_MY800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyhcombine_MX1200_MY800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyhcombine_MX1200_MY800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1200_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1200_MY800_2017_cat12lowpurity --output MX1200_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1200_MY800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1200_MY800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1200_MY800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1200_MY800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1200_MY800/mc/ws_ggyhcombine_MX1200_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1200_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1200_MY800_2017_cat12lowpurity.txt  > MX1200_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1200_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1200_MY800_2017_cat12.txt -m 125)

# WARNING: Skipping MX1200_MY900 because both cat12 categories are empty

# WARNING: Skipping MX1400_MY1000 because both cat12 categories are empty

# ======================= MX1400_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyhcombine_MX1400_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyhcombine_MX1400_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyhcombine_MX1400_MY1100_2017_cat12lowpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyhcombine_MX1400_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY1100_2017_cat12lowpurity --output MX1400_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1100/mc/ws_ggyhcombine_MX1400_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY1100_2017_cat12lowpurity.txt  > MX1400_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY1100_2017_cat12.txt -m 125)

# ======================= MX1400_MY1200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyhcombine_MX1400_MY1200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyhcombine_MX1400_MY1200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyhcombine_MX1400_MY1200_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyhcombine_MX1400_MY1200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY1200_2017_cat12lowpurity --output MX1400_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY1200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY1200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY1200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY1200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY1200/mc/ws_ggyhcombine_MX1400_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY1200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY1200_2017_cat12lowpurity.txt  > MX1400_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY1200_2017_cat12.txt -m 125)

# ======================= MX1400_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyhcombine_MX1400_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyhcombine_MX1400_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyhcombine_MX1400_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyhcombine_MX1400_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY250_2017_cat12lowpurity --output MX1400_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY250/mc/ws_ggyhcombine_MX1400_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY250_2017_cat12lowpurity.txt  > MX1400_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY250_2017_cat12.txt -m 125)

# ======================= MX1400_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyhcombine_MX1400_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyhcombine_MX1400_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyhcombine_MX1400_MY300_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyhcombine_MX1400_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY300_2017_cat12lowpurity --output MX1400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY300/mc/ws_ggyhcombine_MX1400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY300_2017_cat12lowpurity.txt  > MX1400_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY300_2017_cat12.txt -m 125)

# ======================= MX1400_MY400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyhcombine_MX1400_MY400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyhcombine_MX1400_MY400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyhcombine_MX1400_MY400_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyhcombine_MX1400_MY400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX1400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY400_2017_cat12highpurity --output MX1400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY400/mc/ws_ggyhcombine_MX1400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX1400_MY400_2017_cat12highpurity.txt > MX1400_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY400_2017_cat12.txt -m 125)

# WARNING: Skipping MX1400_MY500 because both cat12 categories are empty

# ======================= MX1400_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyhcombine_MX1400_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyhcombine_MX1400_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyhcombine_MX1400_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyhcombine_MX1400_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY600_2017_cat12lowpurity --output MX1400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY600/mc/ws_ggyhcombine_MX1400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY600_2017_cat12lowpurity.txt  > MX1400_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY600_2017_cat12.txt -m 125)

# ======================= MX1400_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyhcombine_MX1400_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyhcombine_MX1400_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyhcombine_MX1400_MY700_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyhcombine_MX1400_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY700_2017_cat12lowpurity --output MX1400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY700/mc/ws_ggyhcombine_MX1400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY700_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY700_2017_cat12lowpurity.txt  > MX1400_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY700_2017_cat12.txt -m 125)

# ======================= MX1400_MY800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyhcombine_MX1400_MY800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyhcombine_MX1400_MY800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyhcombine_MX1400_MY800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyhcombine_MX1400_MY800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY800_2017_cat12lowpurity --output MX1400_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY800/mc/ws_ggyhcombine_MX1400_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY800_2017_cat12lowpurity.txt  > MX1400_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY800_2017_cat12.txt -m 125)

# ======================= MX1400_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyhcombine_MX1400_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyhcombine_MX1400_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyhcombine_MX1400_MY900_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyhcombine_MX1400_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1400_MY900_2017_cat12lowpurity --output MX1400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1400_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1400_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1400_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1400_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1400_MY900/mc/ws_ggyhcombine_MX1400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY900_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1400_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1400_MY900_2017_cat12lowpurity.txt  > MX1400_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1400_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1400_MY900_2017_cat12.txt -m 125)

# WARNING: Skipping MX1600_MY1000 because both cat12 categories are empty

# ======================= MX1600_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyhcombine_MX1600_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyhcombine_MX1600_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyhcombine_MX1600_MY1100_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyhcombine_MX1600_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY1100_2017_cat12lowpurity --output MX1600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1100/mc/ws_ggyhcombine_MX1600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY1100_2017_cat12lowpurity.txt  > MX1600_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY1100_2017_cat12.txt -m 125)

# WARNING: Skipping MX1600_MY1200 because both cat12 categories are empty

# WARNING: Skipping MX1600_MY1300 because both cat12 categories are empty

# ======================= MX1600_MY1400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyhcombine_MX1600_MY1400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyhcombine_MX1600_MY1400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyhcombine_MX1600_MY1400_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyhcombine_MX1600_MY1400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY1400_2017_cat12lowpurity --output MX1600_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY1400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY1400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY1400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY1400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY1400/mc/ws_ggyhcombine_MX1600_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY1400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY1400_2017_cat12lowpurity.txt  > MX1600_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY1400_2017_cat12.txt -m 125)

# ======================= MX1600_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyhcombine_MX1600_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyhcombine_MX1600_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyhcombine_MX1600_MY250_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyhcombine_MX1600_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY250_2017_cat12lowpurity --output MX1600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY250/mc/ws_ggyhcombine_MX1600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY250_2017_cat12lowpurity.txt  > MX1600_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX1600_MY300 because both cat12 categories are empty

# ======================= MX1600_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyhcombine_MX1600_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyhcombine_MX1600_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyhcombine_MX1600_MY400_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyhcombine_MX1600_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY400_2017_cat12lowpurity --output MX1600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY400/mc/ws_ggyhcombine_MX1600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY400_2017_cat12lowpurity.txt  > MX1600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY400_2017_cat12.txt -m 125)

# ======================= MX1600_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyhcombine_MX1600_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyhcombine_MX1600_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyhcombine_MX1600_MY500_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyhcombine_MX1600_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY500_2017_cat12lowpurity --output MX1600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY500/mc/ws_ggyhcombine_MX1600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY500_2017_cat12lowpurity.txt  > MX1600_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY500_2017_cat12.txt -m 125)

# ======================= MX1600_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyhcombine_MX1600_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyhcombine_MX1600_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyhcombine_MX1600_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyhcombine_MX1600_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY600_2017_cat12lowpurity --output MX1600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY600/mc/ws_ggyhcombine_MX1600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY600_2017_cat12lowpurity.txt  > MX1600_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX1600_MY700 because both cat12 categories are empty

# ======================= MX1600_MY800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyhcombine_MX1600_MY800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyhcombine_MX1600_MY800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyhcombine_MX1600_MY800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyhcombine_MX1600_MY800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1600_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1600_MY800_2017_cat12lowpurity --output MX1600_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1600_MY800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1600_MY800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1600_MY800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1600_MY800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1600_MY800/mc/ws_ggyhcombine_MX1600_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1600_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1600_MY800_2017_cat12lowpurity.txt  > MX1600_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1600_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1600_MY800_2017_cat12.txt -m 125)

# WARNING: Skipping MX1600_MY900 because both cat12 categories are empty

# ======================= MX1800_MY1000, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyhcombine_MX1800_MY1000_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyhcombine_MX1800_MY1000_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyhcombine_MX1800_MY1000_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyhcombine_MX1800_MY1000_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY1000_2017_cat12lowpurity --output MX1800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY1000_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY1000_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY1000_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY1000_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1000/mc/ws_ggyhcombine_MX1800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1000_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY1000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY1000_2017_cat12lowpurity.txt  > MX1800_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1000_2017_cat12.txt -m 125)

# ======================= MX1800_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyhcombine_MX1800_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyhcombine_MX1800_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyhcombine_MX1800_MY1100_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyhcombine_MX1800_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY1100_2017_cat12lowpurity --output MX1800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1100/mc/ws_ggyhcombine_MX1800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY1100_2017_cat12lowpurity.txt  > MX1800_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1100_2017_cat12.txt -m 125)

# WARNING: Skipping MX1800_MY1200 because both cat12 categories are empty

# WARNING: Skipping MX1800_MY1300 because both cat12 categories are empty

# ======================= MX1800_MY1400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyhcombine_MX1800_MY1400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyhcombine_MX1800_MY1400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyhcombine_MX1800_MY1400_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyhcombine_MX1800_MY1400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY1400_2017_cat12lowpurity --output MX1800_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY1400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY1400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY1400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY1400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY1400/mc/ws_ggyhcombine_MX1800_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY1400_2017_cat12lowpurity.txt  > MX1800_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY1400_2017_cat12.txt -m 125)

# WARNING: Skipping MX1800_MY1600 because both cat12 categories are empty

# ======================= MX1800_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyhcombine_MX1800_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyhcombine_MX1800_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyhcombine_MX1800_MY250_2017_cat12highpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyhcombine_MX1800_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX1800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY250_2017_cat12highpurity --output MX1800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY250/mc/ws_ggyhcombine_MX1800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX1800_MY250_2017_cat12highpurity.txt > MX1800_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY250_2017_cat12.txt -m 125)

# ======================= MX1800_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyhcombine_MX1800_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyhcombine_MX1800_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyhcombine_MX1800_MY300_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyhcombine_MX1800_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY300_2017_cat12lowpurity --output MX1800_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY300/mc/ws_ggyhcombine_MX1800_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY300_2017_cat12lowpurity.txt  > MX1800_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY300_2017_cat12.txt -m 125)

# WARNING: Skipping MX1800_MY400 because both cat12 categories are empty

# ======================= MX1800_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyhcombine_MX1800_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyhcombine_MX1800_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyhcombine_MX1800_MY500_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyhcombine_MX1800_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY500_2017_cat12lowpurity --output MX1800_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY500/mc/ws_ggyhcombine_MX1800_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY500_2017_cat12lowpurity.txt  > MX1800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY500_2017_cat12.txt -m 125)

# ======================= MX1800_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyhcombine_MX1800_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyhcombine_MX1800_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyhcombine_MX1800_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyhcombine_MX1800_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY600_2017_cat12lowpurity --output MX1800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY600/mc/ws_ggyhcombine_MX1800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY600_2017_cat12lowpurity.txt  > MX1800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX1800_MY700 because both cat12 categories are empty

# WARNING: Skipping MX1800_MY800 because both cat12 categories are empty

# ======================= MX1800_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyhcombine_MX1800_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyhcombine_MX1800_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyhcombine_MX1800_MY900_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyhcombine_MX1800_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX1800_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX1800_MY900_2017_cat12lowpurity --output MX1800_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX1800_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX1800_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX1800_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX1800_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX1800_MY900/mc/ws_ggyhcombine_MX1800_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY900_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX1800_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX1800_MY900_2017_cat12lowpurity.txt  > MX1800_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX1800_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX1800_MY900_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY1000 because both cat12 categories are empty

# ======================= MX2000_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyhcombine_MX2000_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyhcombine_MX2000_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyhcombine_MX2000_MY1100_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyhcombine_MX2000_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY1100_2017_cat12lowpurity --output MX2000_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1100/mc/ws_ggyhcombine_MX2000_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY1100_2017_cat12lowpurity.txt  > MX2000_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1100_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY1200 because both cat12 categories are empty

# ======================= MX2000_MY1300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyhcombine_MX2000_MY1300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyhcombine_MX2000_MY1300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyhcombine_MX2000_MY1300_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyhcombine_MX2000_MY1300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY1300_2017_cat12lowpurity --output MX2000_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY1300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY1300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY1300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY1300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1300/mc/ws_ggyhcombine_MX2000_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY1300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY1300_2017_cat12lowpurity.txt  > MX2000_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1300_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY1400 because both cat12 categories are empty

# ======================= MX2000_MY1600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyhcombine_MX2000_MY1600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyhcombine_MX2000_MY1600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyhcombine_MX2000_MY1600_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyhcombine_MX2000_MY1600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY1600_2017_cat12lowpurity --output MX2000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY1600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY1600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY1600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY1600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY1600/mc/ws_ggyhcombine_MX2000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY1600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY1600_2017_cat12lowpurity.txt  > MX2000_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY1600_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY1800 because both cat12 categories are empty

# ======================= MX2000_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyhcombine_MX2000_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyhcombine_MX2000_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyhcombine_MX2000_MY250_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyhcombine_MX2000_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY250_2017_cat12lowpurity --output MX2000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY250/mc/ws_ggyhcombine_MX2000_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY250_2017_cat12lowpurity.txt  > MX2000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY300 because both cat12 categories are empty

# WARNING: Skipping MX2000_MY400 because both cat12 categories are empty

# ======================= MX2000_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12lowpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY500_2017_cat12lowpurity --output MX2000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY500_2017_cat12lowpurity.txt -m 125)

# ======================= MX2000_MY500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12highpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2000_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY500_2017_cat12highpurity --output MX2000_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY500/mc/ws_ggyhcombine_MX2000_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY500_2017_cat12lowpurity.txt cat12highpurity_2017=MX2000_MY500_2017_cat12highpurity.txt > MX2000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY500_2017_cat12.txt -m 125)

# ======================= MX2000_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyhcombine_MX2000_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyhcombine_MX2000_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyhcombine_MX2000_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyhcombine_MX2000_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY600_2017_cat12lowpurity --output MX2000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY600/mc/ws_ggyhcombine_MX2000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2000_MY600_2017_cat12lowpurity.txt  > MX2000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY700 because both cat12 categories are empty

# ======================= MX2000_MY800, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyhcombine_MX2000_MY800_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyhcombine_MX2000_MY800_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyhcombine_MX2000_MY800_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyhcombine_MX2000_MY800_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2000_MY800_2017_cat12highpurity --output MX2000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2000_MY800_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2000_MY800_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2000_MY800_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2000_MY800_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2000_MY800/mc/ws_ggyhcombine_MX2000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY800_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2000_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2000_MY800_2017_cat12highpurity.txt > MX2000_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2000_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2000_MY800_2017_cat12.txt -m 125)

# WARNING: Skipping MX2000_MY900 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY1000 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY1100 because both cat12 categories are empty

# ======================= MX2200_MY1200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyhcombine_MX2200_MY1200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyhcombine_MX2200_MY1200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyhcombine_MX2200_MY1200_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyhcombine_MX2200_MY1200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2200_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY1200_2017_cat12lowpurity --output MX2200_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY1200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY1200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY1200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY1200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1200/mc/ws_ggyhcombine_MX2200_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2200_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2200_MY1200_2017_cat12lowpurity.txt  > MX2200_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2200_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1200_2017_cat12.txt -m 125)

# WARNING: Skipping MX2200_MY1300 because both cat12 categories are empty

# ======================= MX2200_MY1400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2200_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY1400_2017_cat12lowpurity --output MX2200_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY1400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY1400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY1400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY1400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1400_2017_cat12lowpurity.txt -m 125)

# ======================= MX2200_MY1400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12highpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2200_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY1400_2017_cat12highpurity --output MX2200_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY1400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY1400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY1400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY1400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1400/mc/ws_ggyhcombine_MX2200_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2200_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2200_MY1400_2017_cat12lowpurity.txt cat12highpurity_2017=MX2200_MY1400_2017_cat12highpurity.txt > MX2200_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2200_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1400_2017_cat12.txt -m 125)

# WARNING: Skipping MX2200_MY1600 because both cat12 categories are empty

# ======================= MX2200_MY1800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyhcombine_MX2200_MY1800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyhcombine_MX2200_MY1800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyhcombine_MX2200_MY1800_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyhcombine_MX2200_MY1800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2200_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY1800_2017_cat12lowpurity --output MX2200_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY1800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY1800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY1800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY1800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY1800/mc/ws_ggyhcombine_MX2200_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2200_MY1800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2200_MY1800_2017_cat12lowpurity.txt  > MX2200_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2200_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY1800_2017_cat12.txt -m 125)

# WARNING: Skipping MX2200_MY2000 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY250 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY300 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY400 because both cat12 categories are empty

# ======================= MX2200_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyhcombine_MX2200_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyhcombine_MX2200_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyhcombine_MX2200_MY500_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyhcombine_MX2200_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY500_2017_cat12lowpurity --output MX2200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY500/mc/ws_ggyhcombine_MX2200_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2200_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2200_MY500_2017_cat12lowpurity.txt  > MX2200_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2200_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY500_2017_cat12.txt -m 125)

# ======================= MX2200_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyhcombine_MX2200_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyhcombine_MX2200_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyhcombine_MX2200_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyhcombine_MX2200_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2200_MY600_2017_cat12lowpurity --output MX2200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2200_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2200_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2200_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2200_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2200_MY600/mc/ws_ggyhcombine_MX2200_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2200_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2200_MY600_2017_cat12lowpurity.txt  > MX2200_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2200_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2200_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX2200_MY700 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY800 because both cat12 categories are empty

# WARNING: Skipping MX2200_MY900 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY1000 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY1100 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY1200 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY1300 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY1400 because both cat12 categories are empty

# ======================= MX2400_MY1600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyhcombine_MX2400_MY1600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyhcombine_MX2400_MY1600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyhcombine_MX2400_MY1600_2017_cat12lowpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyhcombine_MX2400_MY1600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY1600_2017_cat12lowpurity --output MX2400_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY1600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY1600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY1600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY1600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY1600/mc/ws_ggyhcombine_MX2400_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY1600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY1600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY1600_2017_cat12lowpurity.txt  > MX2400_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY1600_2017_cat12.txt -m 125)

# WARNING: Skipping MX2400_MY1800 because both cat12 categories are empty

# WARNING: Skipping MX2400_MY2000 because both cat12 categories are empty

# ======================= MX2400_MY2200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyhcombine_MX2400_MY2200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyhcombine_MX2400_MY2200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyhcombine_MX2400_MY2200_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyhcombine_MX2400_MY2200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY2200_2017_cat12lowpurity --output MX2400_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY2200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY2200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY2200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY2200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY2200/mc/ws_ggyhcombine_MX2400_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY2200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY2200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY2200_2017_cat12lowpurity.txt  > MX2400_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY2200_2017_cat12.txt -m 125)

# WARNING: Skipping MX2400_MY250 because both cat12 categories are empty

# ======================= MX2400_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyhcombine_MX2400_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyhcombine_MX2400_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyhcombine_MX2400_MY300_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyhcombine_MX2400_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY300_2017_cat12lowpurity --output MX2400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY300/mc/ws_ggyhcombine_MX2400_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY300_2017_cat12lowpurity.txt  > MX2400_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY300_2017_cat12.txt -m 125)

# ======================= MX2400_MY400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyhcombine_MX2400_MY400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyhcombine_MX2400_MY400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyhcombine_MX2400_MY400_2017_cat12highpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyhcombine_MX2400_MY400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY400_2017_cat12highpurity --output MX2400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY400/mc/ws_ggyhcombine_MX2400_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2400_MY400_2017_cat12highpurity.txt > MX2400_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY400_2017_cat12.txt -m 125)

# ======================= MX2400_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY500_2017_cat12lowpurity --output MX2400_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY500_2017_cat12lowpurity.txt -m 125)

# ======================= MX2400_MY500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2400_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY500_2017_cat12highpurity --output MX2400_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY500/mc/ws_ggyhcombine_MX2400_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY500_2017_cat12lowpurity.txt cat12highpurity_2017=MX2400_MY500_2017_cat12highpurity.txt > MX2400_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY500_2017_cat12.txt -m 125)

# ======================= MX2400_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyhcombine_MX2400_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyhcombine_MX2400_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyhcombine_MX2400_MY600_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyhcombine_MX2400_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY600_2017_cat12lowpurity --output MX2400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY600/mc/ws_ggyhcombine_MX2400_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY600_2017_cat12lowpurity.txt  > MX2400_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY600_2017_cat12.txt -m 125)

# ======================= MX2400_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY700_2017_cat12lowpurity --output MX2400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY700_2017_cat12lowpurity.txt -m 125)

# ======================= MX2400_MY700, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2400_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY700_2017_cat12highpurity --output MX2400_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY700_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY700_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY700_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY700_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY700/mc/ws_ggyhcombine_MX2400_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY700_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY700_2017_cat12lowpurity.txt cat12highpurity_2017=MX2400_MY700_2017_cat12highpurity.txt > MX2400_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY700_2017_cat12.txt -m 125)

# WARNING: Skipping MX2400_MY800 because both cat12 categories are empty

# ======================= MX2400_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyhcombine_MX2400_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyhcombine_MX2400_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyhcombine_MX2400_MY900_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyhcombine_MX2400_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2400_MY900_2017_cat12lowpurity --output MX2400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2400_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2400_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2400_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2400_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2400_MY900/mc/ws_ggyhcombine_MX2400_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY900_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2400_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2400_MY900_2017_cat12lowpurity.txt  > MX2400_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2400_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2400_MY900_2017_cat12.txt -m 125)

# WARNING: Skipping MX2500_MY1000 because both cat12 categories are empty

# ======================= MX2500_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyhcombine_MX2500_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyhcombine_MX2500_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyhcombine_MX2500_MY1100_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyhcombine_MX2500_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2500_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY1100_2017_cat12lowpurity --output MX2500_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1100/mc/ws_ggyhcombine_MX2500_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2500_MY1100_2017_cat12lowpurity.txt  > MX2500_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY1100_2017_cat12.txt -m 125)

# WARNING: Skipping MX2500_MY1200 because both cat12 categories are empty

# ======================= MX2500_MY1300, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyhcombine_MX2500_MY1300_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyhcombine_MX2500_MY1300_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyhcombine_MX2500_MY1300_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyhcombine_MX2500_MY1300_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY1300_2017_cat12highpurity --output MX2500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY1300_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY1300_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY1300_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY1300_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY1300/mc/ws_ggyhcombine_MX2500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY1300_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY1300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2500_MY1300_2017_cat12highpurity.txt > MX2500_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY1300_2017_cat12.txt -m 125)

# WARNING: Skipping MX2500_MY1400 because both cat12 categories are empty

# WARNING: Skipping MX2500_MY1600 because both cat12 categories are empty

# WARNING: Skipping MX2500_MY1800 because both cat12 categories are empty

# WARNING: Skipping MX2500_MY2000 because both cat12 categories are empty

# WARNING: Skipping MX2500_MY2200 because both cat12 categories are empty

# ======================= MX2500_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY250_2017_cat12lowpurity --output MX2500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY250_2017_cat12lowpurity.txt -m 125)

# ======================= MX2500_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12highpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY250_2017_cat12highpurity --output MX2500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY250/mc/ws_ggyhcombine_MX2500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2500_MY250_2017_cat12lowpurity.txt cat12highpurity_2017=MX2500_MY250_2017_cat12highpurity.txt > MX2500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY250_2017_cat12.txt -m 125)

# ======================= MX2500_MY300, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyhcombine_MX2500_MY300_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyhcombine_MX2500_MY300_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyhcombine_MX2500_MY300_2017_cat12highpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyhcombine_MX2500_MY300_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY300_2017_cat12highpurity --output MX2500_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY300_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY300_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY300_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY300_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY300/mc/ws_ggyhcombine_MX2500_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY300_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2500_MY300_2017_cat12highpurity.txt > MX2500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY300_2017_cat12.txt -m 125)

# ======================= MX2500_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyhcombine_MX2500_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyhcombine_MX2500_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyhcombine_MX2500_MY400_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyhcombine_MX2500_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2500_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY400_2017_cat12lowpurity --output MX2500_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY400/mc/ws_ggyhcombine_MX2500_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2500_MY400_2017_cat12lowpurity.txt  > MX2500_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY400_2017_cat12.txt -m 125)

# ======================= MX2500_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2500_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY500_2017_cat12lowpurity --output MX2500_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY500_2017_cat12lowpurity.txt -m 125)

# ======================= MX2500_MY500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12highpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY500_2017_cat12highpurity --output MX2500_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY500/mc/ws_ggyhcombine_MX2500_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2500_MY500_2017_cat12lowpurity.txt cat12highpurity_2017=MX2500_MY500_2017_cat12highpurity.txt > MX2500_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY500_2017_cat12.txt -m 125)

# WARNING: Skipping MX2500_MY600 because both cat12 categories are empty

# WARNING: Skipping MX2500_MY700 because both cat12 categories are empty

# ======================= MX2500_MY800, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyhcombine_MX2500_MY800_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyhcombine_MX2500_MY800_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyhcombine_MX2500_MY800_2017_cat12highpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyhcombine_MX2500_MY800_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY800_2017_cat12highpurity --output MX2500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY800_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY800_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY800_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY800_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY800/mc/ws_ggyhcombine_MX2500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY800_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2500_MY800_2017_cat12highpurity.txt > MX2500_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY800_2017_cat12.txt -m 125)

# ======================= MX2500_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY900_2017_cat12lowpurity --output MX2500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY900_2017_cat12lowpurity.txt -m 125)

# ======================= MX2500_MY900, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2500_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2500_MY900_2017_cat12highpurity --output MX2500_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2500_MY900_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2500_MY900_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2500_MY900_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2500_MY900_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2500_MY900/mc/ws_ggyhcombine_MX2500_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY900_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2500_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2500_MY900_2017_cat12lowpurity.txt cat12highpurity_2017=MX2500_MY900_2017_cat12highpurity.txt > MX2500_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2500_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2500_MY900_2017_cat12.txt -m 125)

# ======================= MX2600_MY1000, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyhcombine_MX2600_MY1000_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyhcombine_MX2600_MY1000_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyhcombine_MX2600_MY1000_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyhcombine_MX2600_MY1000_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2600_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1000_2017_cat12highpurity --output MX2600_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1000_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1000_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1000_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1000_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1000/mc/ws_ggyhcombine_MX2600_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1000_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2600_MY1000_2017_cat12highpurity.txt > MX2600_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1000_2017_cat12.txt -m 125)

# ======================= MX2600_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyhcombine_MX2600_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyhcombine_MX2600_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyhcombine_MX2600_MY1100_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyhcombine_MX2600_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1100_2017_cat12lowpurity --output MX2600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1100/mc/ws_ggyhcombine_MX2600_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY1100_2017_cat12lowpurity.txt  > MX2600_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1100_2017_cat12.txt -m 125)

# ======================= MX2600_MY1200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1200_2017_cat12lowpurity --output MX2600_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1200_2017_cat12lowpurity.txt -m 125)

# ======================= MX2600_MY1200, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12highpurity --procs ggyhwwgg,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2600_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1200_2017_cat12highpurity --output MX2600_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1200_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1200_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1200_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1200_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1200/mc/ws_ggyhcombine_MX2600_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1200_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY1200_2017_cat12lowpurity.txt cat12highpurity_2017=MX2600_MY1200_2017_cat12highpurity.txt > MX2600_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1200_2017_cat12.txt -m 125)

# ======================= MX2600_MY1300, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyhcombine_MX2600_MY1300_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyhcombine_MX2600_MY1300_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyhcombine_MX2600_MY1300_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyhcombine_MX2600_MY1300_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2600_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1300_2017_cat12highpurity --output MX2600_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1300_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1300_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1300_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1300_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1300/mc/ws_ggyhcombine_MX2600_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1300_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2600_MY1300_2017_cat12highpurity.txt > MX2600_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1300_2017_cat12.txt -m 125)

# ======================= MX2600_MY1400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyhcombine_MX2600_MY1400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyhcombine_MX2600_MY1400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyhcombine_MX2600_MY1400_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyhcombine_MX2600_MY1400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2600_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1400_2017_cat12highpurity --output MX2600_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1400/mc/ws_ggyhcombine_MX2600_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2600_MY1400_2017_cat12highpurity.txt > MX2600_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1400_2017_cat12.txt -m 125)

# WARNING: Skipping MX2600_MY1600 because both cat12 categories are empty

# ======================= MX2600_MY1800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyhcombine_MX2600_MY1800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyhcombine_MX2600_MY1800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyhcombine_MX2600_MY1800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyhcombine_MX2600_MY1800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY1800_2017_cat12lowpurity --output MX2600_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY1800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY1800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY1800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY1800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY1800/mc/ws_ggyhcombine_MX2600_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY1800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY1800_2017_cat12lowpurity.txt  > MX2600_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY1800_2017_cat12.txt -m 125)

# WARNING: Skipping MX2600_MY2000 because both cat12 categories are empty

# WARNING: Skipping MX2600_MY2200 because both cat12 categories are empty

# ======================= MX2600_MY2400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyhcombine_MX2600_MY2400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyhcombine_MX2600_MY2400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyhcombine_MX2600_MY2400_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyhcombine_MX2600_MY2400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY2400_2017_cat12lowpurity --output MX2600_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY2400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY2400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY2400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY2400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY2400/mc/ws_ggyhcombine_MX2600_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY2400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY2400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY2400_2017_cat12lowpurity.txt  > MX2600_MY2400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY2400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY2400_2017_cat12.txt -m 125)

# WARNING: Skipping MX2600_MY250 because both cat12 categories are empty

# WARNING: Skipping MX2600_MY300 because both cat12 categories are empty

# ======================= MX2600_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyhcombine_MX2600_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyhcombine_MX2600_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyhcombine_MX2600_MY400_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyhcombine_MX2600_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY400_2017_cat12lowpurity --output MX2600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY400/mc/ws_ggyhcombine_MX2600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY400_2017_cat12lowpurity.txt  > MX2600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY400_2017_cat12.txt -m 125)

# ======================= MX2600_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyhcombine_MX2600_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyhcombine_MX2600_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyhcombine_MX2600_MY500_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyhcombine_MX2600_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY500_2017_cat12lowpurity --output MX2600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY500/mc/ws_ggyhcombine_MX2600_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY500_2017_cat12lowpurity.txt  > MX2600_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY500_2017_cat12.txt -m 125)

# ======================= MX2600_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY600_2017_cat12lowpurity --output MX2600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY600_2017_cat12lowpurity.txt -m 125)

# ======================= MX2600_MY600, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2600_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY600_2017_cat12highpurity --output MX2600_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY600_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY600_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY600_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY600_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY600/mc/ws_ggyhcombine_MX2600_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY600_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY600_2017_cat12lowpurity.txt cat12highpurity_2017=MX2600_MY600_2017_cat12highpurity.txt > MX2600_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY600_2017_cat12.txt -m 125)

# ======================= MX2600_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyhcombine_MX2600_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyhcombine_MX2600_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyhcombine_MX2600_MY700_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyhcombine_MX2600_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY700_2017_cat12lowpurity --output MX2600_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY700/mc/ws_ggyhcombine_MX2600_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY700_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY700_2017_cat12lowpurity.txt  > MX2600_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY700_2017_cat12.txt -m 125)

# WARNING: Skipping MX2600_MY800 because both cat12 categories are empty

# ======================= MX2600_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyhcombine_MX2600_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyhcombine_MX2600_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyhcombine_MX2600_MY900_2017_cat12lowpurity --procs ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyhcombine_MX2600_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2600_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2600_MY900_2017_cat12lowpurity --output MX2600_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2600_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2600_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2600_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2600_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2600_MY900/mc/ws_ggyhcombine_MX2600_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY900_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2600_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2600_MY900_2017_cat12lowpurity.txt  > MX2600_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2600_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2600_MY900_2017_cat12.txt -m 125)

# ======================= MX2800_MY1000, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyhcombine_MX2800_MY1000_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyhcombine_MX2800_MY1000_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyhcombine_MX2800_MY1000_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyhcombine_MX2800_MY1000_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1000_2017_cat12lowpurity --output MX2800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1000_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1000_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1000_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1000_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1000/mc/ws_ggyhcombine_MX2800_MY1000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1000_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY1000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY1000_2017_cat12lowpurity.txt  > MX2800_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1000_2017_cat12.txt -m 125)

# ======================= MX2800_MY1100, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyhcombine_MX2800_MY1100_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyhcombine_MX2800_MY1100_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyhcombine_MX2800_MY1100_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyhcombine_MX2800_MY1100_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1100_2017_cat12lowpurity --output MX2800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1100_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1100_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1100_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1100_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1100/mc/ws_ggyhcombine_MX2800_MY1100_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1100_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY1100_2017_cat12lowpurity.txt  > MX2800_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1100_2017_cat12.txt -m 125)

# ======================= MX2800_MY1200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1200_2017_cat12lowpurity --output MX2800_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1200_2017_cat12lowpurity.txt -m 125)

# ======================= MX2800_MY1200, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2800_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1200_2017_cat12highpurity --output MX2800_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1200_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1200_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1200_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1200_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1200/mc/ws_ggyhcombine_MX2800_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1200_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY1200_2017_cat12lowpurity.txt cat12highpurity_2017=MX2800_MY1200_2017_cat12highpurity.txt > MX2800_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1200_2017_cat12.txt -m 125)

# ======================= MX2800_MY1300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyhcombine_MX2800_MY1300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyhcombine_MX2800_MY1300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyhcombine_MX2800_MY1300_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyhcombine_MX2800_MY1300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1300_2017_cat12lowpurity --output MX2800_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1300/mc/ws_ggyhcombine_MX2800_MY1300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY1300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY1300_2017_cat12lowpurity.txt  > MX2800_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1300_2017_cat12.txt -m 125)

# WARNING: Skipping MX2800_MY1400 because both cat12 categories are empty

# WARNING: Skipping MX2800_MY1600 because both cat12 categories are empty

# ======================= MX2800_MY1800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyhcombine_MX2800_MY1800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyhcombine_MX2800_MY1800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyhcombine_MX2800_MY1800_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyhcombine_MX2800_MY1800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY1800_2017_cat12lowpurity --output MX2800_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY1800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY1800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY1800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY1800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY1800/mc/ws_ggyhcombine_MX2800_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY1800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY1800_2017_cat12lowpurity.txt  > MX2800_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY1800_2017_cat12.txt -m 125)

# WARNING: Skipping MX2800_MY2000 because both cat12 categories are empty

# ======================= MX2800_MY2200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyhcombine_MX2800_MY2200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyhcombine_MX2800_MY2200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyhcombine_MX2800_MY2200_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyhcombine_MX2800_MY2200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY2200_2017_cat12lowpurity --output MX2800_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY2200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY2200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY2200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY2200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY2200/mc/ws_ggyhcombine_MX2800_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY2200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY2200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY2200_2017_cat12lowpurity.txt  > MX2800_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY2200_2017_cat12.txt -m 125)

# WARNING: Skipping MX2800_MY2400 because both cat12 categories are empty

# WARNING: Skipping MX2800_MY2500 because both cat12 categories are empty

# ======================= MX2800_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY250_2017_cat12lowpurity --output MX2800_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY250_2017_cat12lowpurity.txt -m 125)

# ======================= MX2800_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12highpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY250_2017_cat12highpurity --output MX2800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY250/mc/ws_ggyhcombine_MX2800_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY250_2017_cat12lowpurity.txt cat12highpurity_2017=MX2800_MY250_2017_cat12highpurity.txt > MX2800_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX2800_MY2600 because both cat12 categories are empty

# WARNING: Skipping MX2800_MY300 because both cat12 categories are empty

# ======================= MX2800_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyhcombine_MX2800_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyhcombine_MX2800_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyhcombine_MX2800_MY400_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyhcombine_MX2800_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY400_2017_cat12lowpurity --output MX2800_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY400/mc/ws_ggyhcombine_MX2800_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY400_2017_cat12lowpurity.txt  > MX2800_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY400_2017_cat12.txt -m 125)

# ======================= MX2800_MY500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyhcombine_MX2800_MY500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyhcombine_MX2800_MY500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyhcombine_MX2800_MY500_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyhcombine_MX2800_MY500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY500_2017_cat12highpurity --output MX2800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY500/mc/ws_ggyhcombine_MX2800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX2800_MY500_2017_cat12highpurity.txt > MX2800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY500_2017_cat12.txt -m 125)

# ======================= MX2800_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyhcombine_MX2800_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyhcombine_MX2800_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyhcombine_MX2800_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyhcombine_MX2800_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY600_2017_cat12lowpurity --output MX2800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY600/mc/ws_ggyhcombine_MX2800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY600_2017_cat12lowpurity.txt  > MX2800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY600_2017_cat12.txt -m 125)

# ======================= MX2800_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12lowpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX2800_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY700_2017_cat12lowpurity --output MX2800_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY700_2017_cat12lowpurity.txt -m 125)

# ======================= MX2800_MY700, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX2800_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX2800_MY700_2017_cat12highpurity --output MX2800_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX2800_MY700_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX2800_MY700_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX2800_MY700_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX2800_MY700_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX2800_MY700/mc/ws_ggyhcombine_MX2800_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY700_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX2800_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX2800_MY700_2017_cat12lowpurity.txt cat12highpurity_2017=MX2800_MY700_2017_cat12highpurity.txt > MX2800_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX2800_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX2800_MY700_2017_cat12.txt -m 125)

# WARNING: Skipping MX2800_MY800 because both cat12 categories are empty

# WARNING: Skipping MX2800_MY900 because both cat12 categories are empty

# ======================= MX3000_MY1000, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyhcombine_MX3000_MY1000_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyhcombine_MX3000_MY1000_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyhcombine_MX3000_MY1000_2017_cat12highpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyhcombine_MX3000_MY1000_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY1000_2017_cat12highpurity --output MX3000_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY1000_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY1000_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY1000_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY1000_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1000/mc/ws_ggyhcombine_MX3000_MY1000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1000_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY1000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3000_MY1000_2017_cat12highpurity.txt > MX3000_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY1000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1000_2017_cat12.txt -m 125)

# ======================= MX3000_MY1100, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyhcombine_MX3000_MY1100_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyhcombine_MX3000_MY1100_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyhcombine_MX3000_MY1100_2017_cat12highpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyhcombine_MX3000_MY1100_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY1100_2017_cat12highpurity --output MX3000_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY1100_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY1100_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY1100_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY1100_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1100/mc/ws_ggyhcombine_MX3000_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1100_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3000_MY1100_2017_cat12highpurity.txt > MX3000_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1100_2017_cat12.txt -m 125)

# WARNING: Skipping MX3000_MY1200 because both cat12 categories are empty

# WARNING: Skipping MX3000_MY1300 because both cat12 categories are empty

# ======================= MX3000_MY1400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyhcombine_MX3000_MY1400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyhcombine_MX3000_MY1400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyhcombine_MX3000_MY1400_2017_cat12highpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyhcombine_MX3000_MY1400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY1400_2017_cat12highpurity --output MX3000_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY1400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY1400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY1400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY1400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1400/mc/ws_ggyhcombine_MX3000_MY1400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3000_MY1400_2017_cat12highpurity.txt > MX3000_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1400_2017_cat12.txt -m 125)

# ======================= MX3000_MY1600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyhcombine_MX3000_MY1600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyhcombine_MX3000_MY1600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyhcombine_MX3000_MY1600_2017_cat12lowpurity --procs ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyhcombine_MX3000_MY1600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY1600_2017_cat12lowpurity --output MX3000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY1600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY1600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY1600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY1600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1600/mc/ws_ggyhcombine_MX3000_MY1600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY1600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY1600_2017_cat12lowpurity.txt  > MX3000_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY1600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1600_2017_cat12.txt -m 125)

# ======================= MX3000_MY1800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyhcombine_MX3000_MY1800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyhcombine_MX3000_MY1800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyhcombine_MX3000_MY1800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyhcombine_MX3000_MY1800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY1800_2017_cat12lowpurity --output MX3000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY1800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY1800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY1800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY1800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY1800/mc/ws_ggyhcombine_MX3000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY1800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY1800_2017_cat12lowpurity.txt  > MX3000_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY1800_2017_cat12.txt -m 125)

# ======================= MX3000_MY2000, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyhcombine_MX3000_MY2000_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyhcombine_MX3000_MY2000_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyhcombine_MX3000_MY2000_2017_cat12highpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyhcombine_MX3000_MY2000_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2000_2017_cat12highpurity --output MX3000_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2000_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2000_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2000_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2000_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2000/mc/ws_ggyhcombine_MX3000_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2000_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY2000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3000_MY2000_2017_cat12highpurity.txt > MX3000_MY2000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY2000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2000_2017_cat12.txt -m 125)

# ======================= MX3000_MY2200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyhcombine_MX3000_MY2200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyhcombine_MX3000_MY2200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyhcombine_MX3000_MY2200_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyhcombine_MX3000_MY2200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2200_2017_cat12lowpurity --output MX3000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2200/mc/ws_ggyhcombine_MX3000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY2200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY2200_2017_cat12lowpurity.txt  > MX3000_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2200_2017_cat12.txt -m 125)

# WARNING: Skipping MX3000_MY2400 because both cat12 categories are empty

# ======================= MX3000_MY2500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY2500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2500_2017_cat12lowpurity --output MX3000_MY2500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2500_2017_cat12lowpurity.txt -m 125)

# ======================= MX3000_MY2500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2500_2017_cat12highpurity --output MX3000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2500/mc/ws_ggyhcombine_MX3000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY2500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY2500_2017_cat12lowpurity.txt cat12highpurity_2017=MX3000_MY2500_2017_cat12highpurity.txt > MX3000_MY2500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY2500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2500_2017_cat12.txt -m 125)

# ======================= MX3000_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyhcombine_MX3000_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyhcombine_MX3000_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyhcombine_MX3000_MY250_2017_cat12highpurity --procs ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyhcombine_MX3000_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY250_2017_cat12highpurity --output MX3000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY250/mc/ws_ggyhcombine_MX3000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3000_MY250_2017_cat12highpurity.txt > MX3000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX3000_MY2600 because both cat12 categories are empty

# ======================= MX3000_MY2800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2800_2017_cat12lowpurity --output MX3000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2800_2017_cat12lowpurity.txt -m 125)

# ======================= MX3000_MY2800, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY2800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY2800_2017_cat12highpurity --output MX3000_MY2800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY2800_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY2800_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY2800_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY2800_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY2800/mc/ws_ggyhcombine_MX3000_MY2800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2800_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY2800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY2800_2017_cat12lowpurity.txt cat12highpurity_2017=MX3000_MY2800_2017_cat12highpurity.txt > MX3000_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY2800_2017_cat12.txt -m 125)

# WARNING: Skipping MX3000_MY300 because both cat12 categories are empty

# ======================= MX3000_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY400_2017_cat12lowpurity --output MX3000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY400_2017_cat12lowpurity.txt -m 125)

# ======================= MX3000_MY400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12highpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3000_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY400_2017_cat12highpurity --output MX3000_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY400/mc/ws_ggyhcombine_MX3000_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY400_2017_cat12lowpurity.txt cat12highpurity_2017=MX3000_MY400_2017_cat12highpurity.txt > MX3000_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY400_2017_cat12.txt -m 125)

# ======================= MX3000_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyhcombine_MX3000_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyhcombine_MX3000_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyhcombine_MX3000_MY500_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyhcombine_MX3000_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY500_2017_cat12lowpurity --output MX3000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY500/mc/ws_ggyhcombine_MX3000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY500_2017_cat12lowpurity.txt  > MX3000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY500_2017_cat12.txt -m 125)

# ======================= MX3000_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyhcombine_MX3000_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyhcombine_MX3000_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyhcombine_MX3000_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyhcombine_MX3000_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3000_MY600_2017_cat12lowpurity --output MX3000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3000_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3000_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3000_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3000_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3000_MY600/mc/ws_ggyhcombine_MX3000_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY600_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3000_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3000_MY600_2017_cat12lowpurity.txt  > MX3000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3000_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX3000_MY700 because both cat12 categories are empty

# WARNING: Skipping MX3000_MY800 because both cat12 categories are empty

# WARNING: Skipping MX3000_MY900 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY1000 because both cat12 categories are empty

# ======================= MX3500_MY1100, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyhcombine_MX3500_MY1100_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyhcombine_MX3500_MY1100_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyhcombine_MX3500_MY1100_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyhcombine_MX3500_MY1100_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY1100_2017_cat12highpurity --output MX3500_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY1100_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY1100_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY1100_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY1100_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1100/mc/ws_ggyhcombine_MX3500_MY1100_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1100_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY1100 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3500_MY1100_2017_cat12highpurity.txt > MX3500_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY1100_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1100_2017_cat12.txt -m 125)

# ======================= MX3500_MY1200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyhcombine_MX3500_MY1200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyhcombine_MX3500_MY1200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyhcombine_MX3500_MY1200_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyhcombine_MX3500_MY1200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY1200_2017_cat12lowpurity --output MX3500_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY1200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY1200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY1200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY1200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1200/mc/ws_ggyhcombine_MX3500_MY1200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY1200_2017_cat12lowpurity.txt  > MX3500_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1200_2017_cat12.txt -m 125)

# ======================= MX3500_MY1300, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyhcombine_MX3500_MY1300_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyhcombine_MX3500_MY1300_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyhcombine_MX3500_MY1300_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyhcombine_MX3500_MY1300_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY1300_2017_cat12highpurity --output MX3500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY1300_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY1300_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY1300_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY1300_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY1300/mc/ws_ggyhcombine_MX3500_MY1300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1300_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY1300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3500_MY1300_2017_cat12highpurity.txt > MX3500_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY1300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY1300_2017_cat12.txt -m 125)

# WARNING: Skipping MX3500_MY1400 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY1600 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY1800 because both cat12 categories are empty

# ======================= MX3500_MY2000, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY2000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY2000_2017_cat12lowpurity --output MX3500_MY2000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY2000_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY2000_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY2000_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY2000_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY2000_2017_cat12lowpurity.txt -m 125)

# ======================= MX3500_MY2000, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12highpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY2000_2017_cat12highpurity --output MX3500_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY2000_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY2000_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY2000_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY2000_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2000/mc/ws_ggyhcombine_MX3500_MY2000_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY2000_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY2000 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY2000_2017_cat12lowpurity.txt cat12highpurity_2017=MX3500_MY2000_2017_cat12highpurity.txt > MX3500_MY2000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY2000_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY2000_2017_cat12.txt -m 125)

# WARNING: Skipping MX3500_MY2200 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY2400 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY2500 because both cat12 categories are empty

# ======================= MX3500_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyhcombine_MX3500_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyhcombine_MX3500_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyhcombine_MX3500_MY250_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyhcombine_MX3500_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY250_2017_cat12highpurity --output MX3500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY250/mc/ws_ggyhcombine_MX3500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX3500_MY250_2017_cat12highpurity.txt > MX3500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX3500_MY2600 because both cat12 categories are empty

# ======================= MX3500_MY2800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyhcombine_MX3500_MY2800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyhcombine_MX3500_MY2800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyhcombine_MX3500_MY2800_2017_cat12lowpurity --procs ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyhcombine_MX3500_MY2800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY2800_2017_cat12lowpurity --output MX3500_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY2800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY2800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY2800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY2800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY2800/mc/ws_ggyhcombine_MX3500_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY2800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY2800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY2800_2017_cat12lowpurity.txt  > MX3500_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY2800_2017_cat12.txt -m 125)

# ======================= MX3500_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyhcombine_MX3500_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyhcombine_MX3500_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyhcombine_MX3500_MY300_2017_cat12lowpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyhcombine_MX3500_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY300_2017_cat12lowpurity --output MX3500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY300/mc/ws_ggyhcombine_MX3500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY300_2017_cat12lowpurity.txt  > MX3500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY300_2017_cat12.txt -m 125)

# WARNING: Skipping MX3500_MY400 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY500 because both cat12 categories are empty

# WARNING: Skipping MX3500_MY600 because both cat12 categories are empty

# ======================= MX3500_MY700, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY700_2017_cat12lowpurity --output MX3500_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY700_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY700_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY700_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY700_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY700_2017_cat12lowpurity.txt -m 125)

# ======================= MX3500_MY700, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12highpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY700_2017_cat12highpurity --output MX3500_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY700_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY700_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY700_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY700_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY700/mc/ws_ggyhcombine_MX3500_MY700_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY700_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY700 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY700_2017_cat12lowpurity.txt cat12highpurity_2017=MX3500_MY700_2017_cat12highpurity.txt > MX3500_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY700_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY700_2017_cat12.txt -m 125)

# ======================= MX3500_MY800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12lowpurity --procs ggyhwwgg,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY800_2017_cat12lowpurity --output MX3500_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY800_2017_cat12lowpurity.txt -m 125)

# ======================= MX3500_MY800, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX3500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY800_2017_cat12highpurity --output MX3500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY800_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY800_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY800_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY800_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY800/mc/ws_ggyhcombine_MX3500_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY800_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY800_2017_cat12lowpurity.txt cat12highpurity_2017=MX3500_MY800_2017_cat12highpurity.txt > MX3500_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY800_2017_cat12.txt -m 125)

# ======================= MX3500_MY900, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyhcombine_MX3500_MY900_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyhcombine_MX3500_MY900_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyhcombine_MX3500_MY900_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyhcombine_MX3500_MY900_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX3500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX3500_MY900_2017_cat12lowpurity --output MX3500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX3500_MY900_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX3500_MY900_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX3500_MY900_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX3500_MY900_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX3500_MY900/mc/ws_ggyhcombine_MX3500_MY900_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY900_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX3500_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX3500_MY900_2017_cat12lowpurity.txt  > MX3500_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX3500_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX3500_MY900_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY1000 because both cat12 categories are empty

# WARNING: Skipping MX4000_MY1100 because both cat12 categories are empty

# ======================= MX4000_MY1200, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyhcombine_MX4000_MY1200_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyhcombine_MX4000_MY1200_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyhcombine_MX4000_MY1200_2017_cat12highpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyhcombine_MX4000_MY1200_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY1200_2017_cat12highpurity --output MX4000_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY1200_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY1200_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY1200_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY1200_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1200/mc/ws_ggyhcombine_MX4000_MY1200_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1200_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY1200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX4000_MY1200_2017_cat12highpurity.txt > MX4000_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY1200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1200_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY1300 because both cat12 categories are empty

# ======================= MX4000_MY1400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyhcombine_MX4000_MY1400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyhcombine_MX4000_MY1400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyhcombine_MX4000_MY1400_2017_cat12lowpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyhcombine_MX4000_MY1400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY1400_2017_cat12lowpurity --output MX4000_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY1400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY1400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY1400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY1400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1400/mc/ws_ggyhcombine_MX4000_MY1400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY1400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY1400_2017_cat12lowpurity.txt  > MX4000_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY1400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1400_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY1600 because both cat12 categories are empty

# ======================= MX4000_MY1800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyhcombine_MX4000_MY1800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyhcombine_MX4000_MY1800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyhcombine_MX4000_MY1800_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyhcombine_MX4000_MY1800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY1800_2017_cat12lowpurity --output MX4000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY1800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY1800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY1800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY1800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY1800/mc/ws_ggyhcombine_MX4000_MY1800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY1800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY1800_2017_cat12lowpurity.txt  > MX4000_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY1800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY1800_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY2000 because both cat12 categories are empty

# ======================= MX4000_MY2200, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyhcombine_MX4000_MY2200_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyhcombine_MX4000_MY2200_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyhcombine_MX4000_MY2200_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyhcombine_MX4000_MY2200_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY2200_2017_cat12lowpurity --output MX4000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY2200_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY2200_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY2200_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY2200_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2200/mc/ws_ggyhcombine_MX4000_MY2200_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2200_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY2200 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY2200_2017_cat12lowpurity.txt  > MX4000_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY2200_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2200_2017_cat12.txt -m 125)

# ======================= MX4000_MY2400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyhcombine_MX4000_MY2400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyhcombine_MX4000_MY2400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyhcombine_MX4000_MY2400_2017_cat12lowpurity --procs ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyhcombine_MX4000_MY2400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY2400_2017_cat12lowpurity --output MX4000_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY2400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY2400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY2400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY2400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2400/mc/ws_ggyhcombine_MX4000_MY2400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY2400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY2400_2017_cat12lowpurity.txt  > MX4000_MY2400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY2400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2400_2017_cat12.txt -m 125)

# ======================= MX4000_MY2500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyhcombine_MX4000_MY2500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyhcombine_MX4000_MY2500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyhcombine_MX4000_MY2500_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyhcombine_MX4000_MY2500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY2500_2017_cat12highpurity --output MX4000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY2500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY2500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY2500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY2500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2500/mc/ws_ggyhcombine_MX4000_MY2500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY2500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX4000_MY2500_2017_cat12highpurity.txt > MX4000_MY2500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY2500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2500_2017_cat12.txt -m 125)

# ======================= MX4000_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyhcombine_MX4000_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyhcombine_MX4000_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyhcombine_MX4000_MY250_2017_cat12highpurity --procs ggyhwwgg,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyhcombine_MX4000_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY250_2017_cat12highpurity --output MX4000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY250/mc/ws_ggyhcombine_MX4000_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX4000_MY250_2017_cat12highpurity.txt > MX4000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY2600 because both cat12 categories are empty

# ======================= MX4000_MY2800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyhcombine_MX4000_MY2800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyhcombine_MX4000_MY2800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyhcombine_MX4000_MY2800_2017_cat12lowpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyhcombine_MX4000_MY2800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY2800_2017_cat12lowpurity --output MX4000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY2800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY2800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY2800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY2800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY2800/mc/ws_ggyhcombine_MX4000_MY2800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2800_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY2800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY2800_2017_cat12lowpurity.txt  > MX4000_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY2800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY2800_2017_cat12.txt -m 125)

# ======================= MX4000_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyhcombine_MX4000_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyhcombine_MX4000_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyhcombine_MX4000_MY300_2017_cat12lowpurity --procs ggyhVBF,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyhcombine_MX4000_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY300_2017_cat12lowpurity --output MX4000_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY300/mc/ws_ggyhcombine_MX4000_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY300_2017_cat12lowpurity.txt  > MX4000_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY300_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY400 because both cat12 categories are empty

# ======================= MX4000_MY500, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyhcombine_MX4000_MY500_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyhcombine_MX4000_MY500_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyhcombine_MX4000_MY500_2017_cat12lowpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyhcombine_MX4000_MY500_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY500_2017_cat12lowpurity --output MX4000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY500_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY500_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY500_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY500_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY500/mc/ws_ggyhcombine_MX4000_MY500_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY500_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY500_2017_cat12lowpurity.txt  > MX4000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY500_2017_cat12.txt -m 125)

# ======================= MX4000_MY600, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyhcombine_MX4000_MY600_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyhcombine_MX4000_MY600_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyhcombine_MX4000_MY600_2017_cat12highpurity --procs ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyhcombine_MX4000_MY600_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY600_2017_cat12highpurity --output MX4000_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY600_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY600_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY600_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY600_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY600/mc/ws_ggyhcombine_MX4000_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY600_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX4000_MY600_2017_cat12highpurity.txt > MX4000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY600_2017_cat12.txt -m 125)

# WARNING: Skipping MX4000_MY700 because both cat12 categories are empty

# ======================= MX4000_MY800, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX4000_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY800_2017_cat12lowpurity --output MX4000_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY800_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY800_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY800_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY800_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY800_2017_cat12lowpurity.txt -m 125)

# ======================= MX4000_MY800, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12highpurity --procs ggyhVBF,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY800_2017_cat12highpurity --output MX4000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY800_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY800_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY800_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY800_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY800/mc/ws_ggyhcombine_MX4000_MY800_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY800_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY800 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX4000_MY800_2017_cat12lowpurity.txt cat12highpurity_2017=MX4000_MY800_2017_cat12highpurity.txt > MX4000_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY800_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY800_2017_cat12.txt -m 125)

# ======================= MX4000_MY900, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyhcombine_MX4000_MY900_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyhcombine_MX4000_MY900_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyhcombine_MX4000_MY900_2017_cat12highpurity --procs ggyhVBF,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyhcombine_MX4000_MY900_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX4000_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX4000_MY900_2017_cat12highpurity --output MX4000_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX4000_MY900_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX4000_MY900_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX4000_MY900_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX4000_MY900_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX4000_MY900/mc/ws_ggyhcombine_MX4000_MY900_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY900_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX4000_MY900 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX4000_MY900_2017_cat12highpurity.txt > MX4000_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX4000_MY900_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX4000_MY900_2017_cat12.txt -m 125)

# ======================= MX500_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX500_MY250_2017_cat12lowpurity --output MX500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX500_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX500_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX500_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX500_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX500_MY250_2017_cat12lowpurity.txt -m 125)

# ======================= MX500_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX500_MY250_2017_cat12highpurity --output MX500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX500_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX500_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX500_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX500_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY250/mc/ws_ggyhcombine_MX500_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX500_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX500_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX500_MY250_2017_cat12lowpurity.txt cat12highpurity_2017=MX500_MY250_2017_cat12highpurity.txt > MX500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX500_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX500_MY250_2017_cat12.txt -m 125)

# ======================= MX500_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyhcombine_MX500_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyhcombine_MX500_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyhcombine_MX500_MY300_2017_cat12lowpurity --procs ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyhcombine_MX500_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX500_MY300_2017_cat12lowpurity --output MX500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX500_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX500_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX500_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX500_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX500_MY300/mc/ws_ggyhcombine_MX500_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX500_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX500_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX500_MY300_2017_cat12lowpurity.txt  > MX500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX500_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX500_MY300_2017_cat12.txt -m 125)

# ======================= MX600_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyhcombine_MX600_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyhcombine_MX600_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyhcombine_MX600_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyhcombine_MX600_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX600_MY250_2017_cat12lowpurity --output MX600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX600_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX600_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX600_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX600_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY250/mc/ws_ggyhcombine_MX600_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX600_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX600_MY250_2017_cat12lowpurity.txt  > MX600_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX600_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY250_2017_cat12.txt -m 125)

# ======================= MX600_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12lowpurity --procs ggyhVBF,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX600_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX600_MY300_2017_cat12lowpurity --output MX600_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX600_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX600_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX600_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX600_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY300_2017_cat12lowpurity.txt -m 125)

# ======================= MX600_MY300, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX600_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX600_MY300_2017_cat12highpurity --output MX600_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX600_MY300_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX600_MY300_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX600_MY300_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX600_MY300_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY300/mc/ws_ggyhcombine_MX600_MY300_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY300_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX600_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX600_MY300_2017_cat12lowpurity.txt cat12highpurity_2017=MX600_MY300_2017_cat12highpurity.txt > MX600_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX600_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY300_2017_cat12.txt -m 125)

# ======================= MX600_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyhcombine_MX600_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyhcombine_MX600_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyhcombine_MX600_MY400_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyhcombine_MX600_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX600_MY400_2017_cat12lowpurity --output MX600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX600_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX600_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX600_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX600_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX600_MY400/mc/ws_ggyhcombine_MX600_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX600_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX600_MY400_2017_cat12lowpurity.txt  > MX600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX600_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX600_MY400_2017_cat12.txt -m 125)

# ======================= MX700_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyhcombine_MX700_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyhcombine_MX700_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyhcombine_MX700_MY250_2017_cat12lowpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyhcombine_MX700_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX700_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX700_MY250_2017_cat12lowpurity --output MX700_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX700_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX700_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX700_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX700_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY250/mc/ws_ggyhcombine_MX700_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX700_MY250_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX700_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX700_MY250_2017_cat12lowpurity.txt  > MX700_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX700_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX700_MY250_2017_cat12.txt -m 125)

# WARNING: Skipping MX700_MY300 because both cat12 categories are empty

# ======================= MX700_MY400, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyhcombine_MX700_MY400_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyhcombine_MX700_MY400_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyhcombine_MX700_MY400_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyhcombine_MX700_MY400_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX700_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX700_MY400_2017_cat12lowpurity --output MX700_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX700_MY400_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX700_MY400_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX700_MY400_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX700_MY400_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX700_MY400/mc/ws_ggyhcombine_MX700_MY400_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX700_MY400_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX700_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX700_MY400_2017_cat12lowpurity.txt  > MX700_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX700_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX700_MY400_2017_cat12.txt -m 125)

# WARNING: Skipping MX700_MY500 because both cat12 categories are empty

# WARNING: Skipping MX800_MY250 because both cat12 categories are empty

# WARNING: Skipping MX800_MY300 because both cat12 categories are empty

# ======================= MX800_MY400, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyhcombine_MX800_MY400_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyhcombine_MX800_MY400_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyhcombine_MX800_MY400_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyhcombine_MX800_MY400_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX800_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX800_MY400_2017_cat12highpurity --output MX800_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX800_MY400_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX800_MY400_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX800_MY400_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX800_MY400_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY400/mc/ws_ggyhcombine_MX800_MY400_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY400_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX800_MY400 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX800_MY400_2017_cat12highpurity.txt > MX800_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX800_MY400_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY400_2017_cat12.txt -m 125)

# ======================= MX800_MY500, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyhcombine_MX800_MY500_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyhcombine_MX800_MY500_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyhcombine_MX800_MY500_2017_cat12highpurity --procs ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyhcombine_MX800_MY500_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX800_MY500_2017_cat12highpurity --output MX800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX800_MY500_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX800_MY500_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX800_MY500_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX800_MY500_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY500/mc/ws_ggyhcombine_MX800_MY500_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY500_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX800_MY500 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py  cat12highpurity_2017=MX800_MY500_2017_cat12highpurity.txt > MX800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX800_MY500_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY500_2017_cat12.txt -m 125)

# ======================= MX800_MY600, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH,ggyhVH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX800_MY600_2017_cat12lowpurity --output MX800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX800_MY600_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX800_MY600_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX800_MY600_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX800_MY600_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY600_2017_cat12lowpurity.txt -m 125)

# ======================= MX800_MY600, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX800_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX800_MY600_2017_cat12highpurity --output MX800_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX800_MY600_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX800_MY600_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX800_MY600_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX800_MY600_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX800_MY600/mc/ws_ggyhcombine_MX800_MY600_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY600_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX800_MY600 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX800_MY600_2017_cat12lowpurity.txt cat12highpurity_2017=MX800_MY600_2017_cat12highpurity.txt > MX800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX800_MY600_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX800_MY600_2017_cat12.txt -m 125)

# ======================= MX900_MY250, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12lowpurity --procs ggyhwwgg,ggyhVBF,ggyhTTH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX900_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX900_MY250_2017_cat12lowpurity --output MX900_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX900_MY250_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX900_MY250_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX900_MY250_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX900_MY250_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX900_MY250_2017_cat12lowpurity.txt -m 125)

# ======================= MX900_MY250, cat12highpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12highpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyh*cat12highpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12highpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12highpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12highpurity --procs ggyhwwgg,ggyhTTH,ggyhGGH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12highpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/data/ws_2017_cat12highpurity --cats cat12highpurity --doSystematics --batch local --ext MX900_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX900_MY250_2017_cat12highpurity --output MX900_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX900_MY250_2017_cat12highpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX900_MY250_2017_cat12highpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX900_MY250_2017_cat12highpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX900_MY250_2017_cat12highpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY250/mc/ws_ggyhcombine_MX900_MY250_2017_cat12highpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX900_MY250_2017_cat12highpurity.txt -m 125)

# ===== Combine cat12 for MX900_MY250 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX900_MY250_2017_cat12lowpurity.txt cat12highpurity_2017=MX900_MY250_2017_cat12highpurity.txt > MX900_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX900_MY250_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX900_MY250_2017_cat12.txt -m 125)

# ======================= MX900_MY300, cat12lowpurity =======================
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc && mkdir -p /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyhcombine_MX900_MY300_2017_cat12lowpurity)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc && cp /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyh*cat12lowpurity*/*.root /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyhcombine_MX900_MY300_2017_cat12lowpurity/)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python RunYields_17resolved_combined.py --cats cat12lowpurity --inputWSDirMap 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyhcombine_MX900_MY300_2017_cat12lowpurity --procs ggyhwwgg,ggyhTTH,ggyhVH --sigModelWSDir 2017=/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyhcombine_MX900_MY300_2017_cat12lowpurity --bkgModelWSDir /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/data/ws_2017_cat12lowpurity --cats cat12lowpurity --doSystematics --batch local --ext MX900_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && python makeDatacard_17resolved_combined.py --years 2017 --doSystematics --prune --ext MX900_MY300_2017_cat12lowpurity --output MX900_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && strlist=($(grep "shapes *ggyh*" MX900_MY300_2017_cat12lowpurity.txt | awk '{print $2}' | cut -d'_' -f1))
for str in "${strlist[@]}"; do
    sed -i "0,/ws_ggyhcombine/s//ws_${str}/" "MX900_MY300_2017_cat12lowpurity.txt"
    sed -i "0,/purity\/CMS/s//purity_${str#ggyh}\/CMS/" "MX900_MY300_2017_cat12lowpurity.txt"
done)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i 's/2017=//g' MX900_MY300_2017_cat12lowpurity.txt)
(cd /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc && rm -r /eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017/MX900_MY300/mc/ws_ggyhcombine_MX900_MY300_2017_cat12lowpurity)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX900_MY300_2017_cat12lowpurity.txt -m 125)

# ===== Combine cat12 for MX900_MY300 =====
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && combineCards.py cat12lowpurity_2017=MX900_MY300_2017_cat12lowpurity.txt  > MX900_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && sed -i '/CMS_wwgg_br_HH_WWgg/d' MX900_MY300_2017_cat12.txt)
(cd /eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit/Datacard && text2workspace.py MX900_MY300_2017_cat12.txt -m 125)

# WARNING: Skipping MX900_MY400 because both cat12 categories are empty

# WARNING: Skipping MX900_MY500 because both cat12 categories are empty

# WARNING: Skipping MX900_MY600 because both cat12 categories are empty

# WARNING: Skipping MX900_MY700 because both cat12 categories are empty

