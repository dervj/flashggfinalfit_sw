# Python file to store systematics: for STXS analysis

# Comment out all nuisances that you do not want to include

# THEORY SYSTEMATICS:

# For type:constant
#  1) specify same value for all processes
#  2) define process map json in ./theory_uncertainties (add process names where necessary!)

# For type:factory
# Tier system: adds different uncertainties to dataframe
#   1) shape: absolute yield of process kept constant, shape effects i.e. calc migrations across cats
#   2) ishape: as (1) but absolute yield for proc x cat is allowed to vary
#   3) norm: absolute yield of production mode (s0) kept constant but migrations across sub-processes e.g. STXS bins.Same value in each category.
#   4) inorm: as (3) but absolute yield of production mode (s0) can vary
#   5) inc: variations in production mode (s0), same value for each subprocess in each category
# Relations: shape = ishape/inorm
#            norm  = inorm/inc
# Specify as list in dict: e.g. 'tiers'=['inc','inorm','norm','ishape','shape']

theory_systematics = [
                # Normalisation uncertainties: enter interpretations
                {'name':'BR_hgg','title':'BR_hgg','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/br_hgg_singleH.json"},
                # New scheme for ggH stage 1.2 
                {'name':'BR_hZZ','title':'BR_hZZ','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},
                {'name':'BR_htt','title':'BR_htt','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},
                {'name':'BR_hWW','title':'BR_hWW','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},
                {'name':'BR_hbb','title':'BR_hbb','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'QCDscale_ttH','title':'QCDscale_ttH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'pdf_Higgs_ttH','title':'pdf_Higgs_ttH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'alphaS_ttH','title':'alphaS_ttH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'QCDscale_ggH','title':'QCDscale_ggH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'pdf_Higgs_ggH','title':'pdf_Higgs_ggH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'alphaS_ggH','title':'alphaS_ggH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'QCDscale_VH','title':'QCDscale_VH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'pdf_Higgs_VH','title':'pdf_Higgs_VH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'alphaS_VH','title':'alphaS_VH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'QCDscale_qqH','title':'QCDscale_qqH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'pdf_Higgs_qqH','title':'pdf_Higgs_qqH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                {'name':'alphaS_qqH','title':'alphaS_qqH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"theory_uncertainties/wwgg.json"},         
                # {'name':'QCDscale_ggHH','title':'QCDscale','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"0.950/1.022"},
                # {'name':'pdf_Higgs_ggHH','title':'pdf_Higgs','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':"1.030"},
                # {'name':'alphaS_ttH','title':'alphaS_ttH','type':'constant','prior':'lnN','correlateAcrossYears':1,'value':'theory_uncertainties/thu_tth.json'},
              
              ]
# PDF weight
# for i in range(1,60): theory_systematics.append( {'name':'pdfWeight_%g'%i, 'title':'CMS_hgg_pdfWeight_%g'%i, 'type':'factory','prior':'lnN','correlateAcrossYears':1,'tiers':['shape']} )

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# EXPERIMENTAL SYSTEMATICS
# correlateAcrossYears = 0 : no correlation
# correlateAcrossYears = 1 : fully correlated
# correlateAcrossYears = -1 : partially correlated

experimental_systematics = [
                {'name':'lumi_13TeV_Uncorrelated','title':'lumi_13TeV_Uncorrelated','type':'constant','prior':'lnN','correlateAcrossYears':0,'value':{'2016':'1.010','2016pre':'1.010','2016post':'1.010','2017':'1.020','2018':'1.015'}},
                {'name':'PNXbb_sf_','title':'PNXbb_sf','type':'factory','prior':'lnN','correlateAcrossYears':0},
                # {'name':'lumi_13TeV_Correlated','title':'lumi_13TeV_Correlated','type':'constant','prior':'lnN','correlateAcrossYears':-1,'value':{'2016':'1.006','2017':'1.009','2018':'1.020'}},
                {'name':'lumi_13TeV_Correlated_1718','title':'lumi_13TeV_Correlated_1718','type':'constant','prior':'lnN','correlateAcrossYears':-1,'value':{'2016':'-','2017':'1.009','2018':'1.02'}},
                {'name':'photon_id_sf_Diphoton_Photon_','title':'CMS_hgg_MVASF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'photon_presel_sf_Diphoton_Photon_','title':'CMS_hgg_PreselSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'electron_veto_sf_Diphoton_Photon_','title':'CMS_hgg_electronVetoSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'muon_highptid_sf_','title':'CMS_hgg_muonhighptIDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'muon_highptreco_sf_','title':'CMS_zmuon_highpt_recoSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'isomuon_id_sf_SelectedMuon_iso_','title':'CMS_hgg_isomuonIDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'isomuon_iso_sf_SelectedMuon_iso_','title':'CMS_hgg_isomuonIsoSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'nonisoelectron_id_sf_SelectedElectron_noiso_','title':'CMS_hgg_nonisoelectronnonisoIDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'isoelectron_id_sf_SelectedElectron_noiso_','title':'CMS_hgg_nonisoelectronIDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'isoelectron_id_sf_SelectedElectron_iso_','title':'CMS_hgg_isoelectronIDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'isoelectron_reco_sf_','title':'CMS_hgg_isoelectron_reco_','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'nonisoelectron_reco_sf_','title':'CMS_hgg_nonisoelectron_re_co_SF','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'trigger_sf_','title':'CMS_hgg_TriggerWeight','type':'factory','prior':'lnN','correlateAcrossYears':0},               
                {'name':'jet_pu_id_sf_','title':'Jet_puID','type':'factory','prior':'lnN','correlateAcrossYears':0},               
                {'name':'L1_prefiring_sf_','title':'CMS_hgg_prefire','type':'factory','prior':'lnN','correlateAcrossYears':0},               
                {'name':'puWeight_','title':'CMS_hgg_puWeight','type':'factory','prior':'lnN','correlateAcrossYears':0},               
                {'name':'FJES','title':'CMS_scale_fatjet','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'FJER','title':'CMS_res_fatjet','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'JES','title':'CMS_scale_j','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'JER','title':'CMS_res_j','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'MET_JES','title':'CMS_res_JET_MET','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'MET_Unclustered','title':'CMS_MET','type':'factory','prior':'lnN','correlateAcrossYears':0},
                {'name':'Muon_pt','title':'CMS_Muon_Momentumscale','type':'factory','prior':'lnN','correlateAcrossYears':0},

                {'name':'PNetWvsQCDW1_sf_','title':'PNWvsQCDSF','type':'factory','prior':'lnN','correlateAcrossYears':0},            
                {'name':'PNetWvsQCDW1_mistagging_sf_','title':'PNWvsQCD_mistaggingSF','type':'factory','prior':'lnN','correlateAcrossYears':0},            
                {'name':'PTransformerHtagger_sf_','title':'PTransformerHtaggerSF','type':'factory','prior':'lnN','correlateAcrossYears':0}          
        
              ]

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Shape nuisances: effect encoded in signal model
# mode = (other,scalesGlobal,scales,scalesCorr,smears): match the definition in the signal models

signal_shape_systematics = [
              
                {'name':'scale','title':'scale','type':'signal_shape','mode':'scales','mean':'0.0','sigma':'1.0'},
            
                {'name':'material','title':'material','type':'signal_shape','mode':'scalesCorr','mean':'0.0','sigma':'1.0'},

                {'name':'fnuf','title':'fnuf','type':'signal_shape','mode':'scalesCorr','mean':'0.0','sigma':'1.0'},
        
                {'name':'smear','title':'smear','type':'signal_shape','mode':'smears','mean':'0.0','sigma':'1.0'}
           
              ]
