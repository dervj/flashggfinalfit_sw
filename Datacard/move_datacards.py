#!/usr/bin/env python

import os
import re
import shutil

# Locate flashggFinalFit/Datacard
CMSSW_BASE = os.environ.get("CMSSW_BASE")
if not CMSSW_BASE:
    raise RuntimeError("cmsenv first - CMSSW_BASE is not set")

DC_BASE = os.path.join(CMSSW_BASE, "src", "flashggFinalFit", "Datacard")

# Regex to extract mass point and year token
# Example filename:
#   Datacard_MX3000_MY2800_2017_wwgg_cat12lowpurity.txt
#   Datacard_MX3000_MY2800_2016pre_wwgg_cat12lowpurity.txt
pattern = re.compile(r"Datacard_(MX\d+_MY\d+)_(\d{4}(?:pre|post)?)_.+\.txt")

for fname in os.listdir(DC_BASE):
    match = pattern.match(fname)
    if not match:
        continue

    mass_point = match.group(1)
    year_tag = match.group(2)
    src = os.path.join(DC_BASE, fname)

    # Destination directory: combined_datacards_<year>/datacard_<mass>
    dst_dir = os.path.join(
        DC_BASE,
        "combined_datacards_{0}".format(year_tag),
        "datacard_" + mass_point,
    )
    if not os.path.isdir(dst_dir):
        os.makedirs(dst_dir)

    dst = os.path.join(dst_dir, fname)

    print(
        "Moving {0} -> combined_datacards_{1}/datacard_{2}".format(
            fname, year_tag, mass_point
        )
    )
    shutil.move(src, dst)

print("Done.")
