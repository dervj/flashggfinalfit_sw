# Config file: options for signal fitting

_year = '2016post'

signalScriptCfg = {
  
  # Setup
  'inputWSDir':'input_pathws_ggyh_ws_path',
  'procs':'ggyh',            # sed'd to e.g. ggyhwwgg; explicit so symlinked files aren't auto-detected
  'cats':'cat_placeholder',  # sed'd to the actual category (cat12highpurity or cat12lowpurity)
  'ext':'%s_ws_path'%_year,
  'analysis':'YH', # To specify which replacement dataset mapping (defined in ./python/replacementMap.py)
  'year':'%s'%_year, # Use 'combined' if merging all years: not recommended
  'massPoints':'125',

  #Photon shape systematics  
  'scales':'scale', # separate nuisance per year
  'scalesCorr':'material,fnuf', # correlated across years
  'scalesGlobal':'', # affect all processes equally, correlated across years
  'smears':'smear', # separate nuisance per year

  # Job submission options
  'batch':'local', # ['condor','SGE','IC','local']
  'queue':'hep.q'
  # 'batch':'condor', # ['condor','SGE','IC','local']
  # 'queue':'espresso',

}
