from __future__ import print_function

import os
import ROOT
import numpy as np

YEAR = "2017"
BASE = "/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit"
CATS = ["cat12lowpurity", "cat12highpurity"]


def get_all_masspoints():
    return np.array([
        [1000, 250], [1000, 300], [1000, 400], [1000, 500], [1000, 600], [1000, 700], [1000, 800],
        [1200, 1000], [1200, 250], [1200, 300], [1200, 400], [1200, 500], [1200, 600], [1200, 700],
        [1200, 800], [1200, 900], [1400, 1000], [1400, 1100], [1400, 1200], [1400, 250], [1400, 300],
        [1400, 400], [1400, 500], [1400, 600], [1400, 700], [1400, 800], [1400, 900], [1600, 1000],
        [1600, 1100], [1600, 1200], [1600, 1300], [1600, 1400], [1600, 250], [1600, 300], [1600, 400],
        [1600, 500], [1600, 600], [1600, 700], [1600, 800], [1600, 900], [1800, 1000], [1800, 1100],
        [1800, 1200], [1800, 1300], [1800, 1400], [1800, 1600], [1800, 250], [1800, 300], [1800, 400],
        [1800, 500], [1800, 600], [1800, 700], [1800, 800], [1800, 900], [2000, 1000], [2000, 1100],
        [2000, 1200], [2000, 1300], [2000, 1400], [2000, 1600], [2000, 1800], [2000, 250], [2000, 300],
        [2000, 400], [2000, 500], [2000, 600], [2000, 700], [2000, 800], [2000, 900], [2200, 1000],
        [2200, 1100], [2200, 1200], [2200, 1300], [2200, 1400], [2200, 1600], [2200, 1800], [2200, 2000],
        [2200, 250], [2200, 300], [2200, 400], [2200, 500], [2200, 600], [2200, 700], [2200, 800],
        [2200, 900], [2400, 1000], [2400, 1100], [2400, 1200], [2400, 1300], [2400, 1400], [2400, 1600],
        [2400, 1800], [2400, 2000], [2400, 2200], [2400, 250], [2400, 300], [2400, 400], [2400, 500],
        [2400, 600], [2400, 700], [2400, 800], [2400, 900], [2500, 1000], [2500, 1100], [2500, 1200],
        [2500, 1300], [2500, 1400], [2500, 1600], [2500, 1800], [2500, 2000], [2500, 2200], [2500, 250],
        [2500, 300], [2500, 400], [2500, 500], [2500, 600], [2500, 700], [2500, 800], [2500, 900],
        [2600, 1000], [2600, 1100], [2600, 1200], [2600, 1300], [2600, 1400], [2600, 1600], [2600, 1800],
        [2600, 2000], [2600, 2200], [2600, 2400], [2600, 250], [2600, 300], [2600, 400], [2600, 500],
        [2600, 600], [2600, 700], [2600, 800], [2600, 900], [2800, 1000], [2800, 1100], [2800, 1200],
        [2800, 1300], [2800, 1400], [2800, 1600], [2800, 1800], [2800, 2000], [2800, 2200], [2800, 2400],
        [2800, 2500], [2800, 250], [2800, 2600], [2800, 300], [2800, 400], [2800, 500], [2800, 600],
        [2800, 700], [2800, 800], [2800, 900], [3000, 1000], [3000, 1100], [3000, 1200], [3000, 1300],
        [3000, 1400], [3000, 1600], [3000, 1800], [3000, 2000], [3000, 2200], [3000, 2400], [3000, 2500],
        [3000, 250], [3000, 2600], [3000, 2800], [3000, 300], [3000, 400], [3000, 500], [3000, 600],
        [3000, 700], [3000, 800], [3000, 900], [3500, 1000], [3500, 1100], [3500, 1200], [3500, 1300],
        [3500, 1400], [3500, 1600], [3500, 1800], [3500, 2000], [3500, 2200], [3500, 2400], [3500, 2500],
        [3500, 250], [3500, 2600], [3500, 2800], [3500, 300], [3500, 400], [3500, 500], [3500, 600],
        [3500, 700], [3500, 800], [3500, 900], [4000, 1000], [4000, 1100], [4000, 1200], [4000, 1300],
        [4000, 1400], [4000, 1600], [4000, 1800], [4000, 2000], [4000, 2200], [4000, 2400], [4000, 2500],
        [4000, 250], [4000, 2600], [4000, 2800], [4000, 300], [4000, 400], [4000, 500], [4000, 600],
        [4000, 700], [4000, 800], [4000, 900], [500, 250], [500, 300], [600, 250], [600, 300], [600, 400],
        [700, 250], [700, 300], [700, 400], [700, 500], [800, 250], [800, 300], [800, 400], [800, 500],
        [800, 600], [900, 250], [900, 300], [900, 400], [900, 500], [900, 600], [900, 700]
    ], dtype=int)


def get_all_masspoints_from_file(path):
    """
    Read mass points from a .dat/.txt file.

    Expected line formats (whitespace-, comma-, or tab-separated):
      - mX mY
      - YEAR mX mY         where YEAR is in {2016pre, 2016post, 2017, 2018}

    Lines starting with '#' or empty lines are ignored.
    """
    valid_year_tokens = {"2016pre", "2016post", "2017", "2018"}
    masspoints = []

    with open(path) as f:
        for raw_line in f:
            line = raw_line.strip()
            if not line or line.startswith("#"):
                continue

            # Normalize separators
            for sep in [",", ";", "\t"]:
                line = line.replace(sep, " ")

            tokens = line.split()
            if not tokens:
                continue

            if tokens[0] in valid_year_tokens:
                if len(tokens) < 3:
                    raise ValueError(
                        "Line '{0}' has a year but not enough columns.".format(raw_line.rstrip())
                    )
                mX, mY = int(tokens[1]), int(tokens[2])
            else:
                if len(tokens) < 2:
                    raise ValueError(
                        "Line '{0}' does not have at least two columns.".format(raw_line.rstrip())
                    )
                mX, mY = int(tokens[0]), int(tokens[1])

            masspoints.append([mX, mY])

    if not masspoints:
        raise ValueError("No mass points found in file '{0}'".format(path))

    return np.array(masspoints, dtype=int)


def check_one(mass, cat):
    wsdir = os.path.join(BASE, YEAR, mass, "data", "ws_{0}_{1}".format(YEAR, cat))
    if not os.path.isdir(wsdir):
        return "NO_DIR"
    # print(wsdir)

    allData = os.path.join(wsdir, "allData.root")
    multipdf = os.path.join(wsdir, "CMS-HGG_multipdf_{0}_{1}.root".format(cat, YEAR))

    if not os.path.exists(allData):
        return "NO_ALLDATA"
    if os.path.getsize(allData) == 0:
        return "ALLDATA_EMPTYFILE"

    if not os.path.exists(multipdf):
        return "NO_MULTIPDF"
    if os.path.getsize(multipdf) == 0:
        return "MULTIPDF_EMPTYFILE"

    return "OK"


for masspoint in get_all_masspoints_from_file(
    '/afs/cern.ch/user/j/jodervan/diHiggs/combine_condor/condor_yh_boosted/masspoints_debug.txt'
):
    mass = "MX{0}_MY{1}".format(masspoint[0], masspoint[1])
    for cat in CATS:
        status = check_one(mass, cat)
        print("Mass {0} Cat {1}: {2}".format(mass, cat, status))
        
