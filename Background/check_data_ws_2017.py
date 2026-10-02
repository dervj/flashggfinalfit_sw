#!/usr/bin/env python
import os
import re

BASE = "/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit/2017"

mass_dir_re = re.compile(r"^MX\d+_MY\d+$")

def main():
    if not os.path.isdir(BASE):
        print("Base directory does not exist: {0}".format(BASE))
        return

    problems = 0

    for entry in sorted(os.listdir(BASE)):
        if not mass_dir_re.match(entry):
            continue

        masspoint = entry  # e.g. MX3500_MY900
        mp_dir = os.path.join(BASE, masspoint)
        data_ws_dir = os.path.join(mp_dir, "data", "ws")

        if not os.path.isdir(data_ws_dir):
            print("[MISSING ws dir] {0}: {1}".format(masspoint, data_ws_dir))
            problems += 1
            continue

        hp_name = "Data_2017_cat12highpurity_{0}.root".format(masspoint)
        lp_name = "Data_2017_cat12lowpurity_{0}.root".format(masspoint)

        hp_path = os.path.join(data_ws_dir, hp_name)
        lp_path = os.path.join(data_ws_dir, lp_name)

        missing = []
        if not os.path.exists(hp_path):
            missing.append(hp_name)
        if not os.path.exists(lp_path):
            missing.append(lp_name)

        if missing:
            print("[MISSING files] {0}: {1}".format(masspoint, ", ".join(missing)))
            problems += 1

    if problems == 0:
        print("All MX*/data/ws directories have both high/low purity Data_2017 files.")
    else:
        print("Done. Found {0} mass points with missing dirs/files.".format(problems))

if __name__ == "__main__":
    main()
