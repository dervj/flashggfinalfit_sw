#!/usr/bin/env python
import argparse
import os
import re
import sys

try:
    import ROOT
except Exception:
    ROOT = None

PROC_SUFFIX = {
    "GGH": "GGH",
    "TTH": "TTH",
    "VBF": "VBF",
    "VH": "VH",
    "wwgg": "wwgg",
}

SHAPE_PROC_RE = re.compile(r"^ggyh(?P<proc>[A-Za-z0-9]+)_(?P<year>\d{4}(?:pre|post)?)_hgg$")


def parse_mass_from_filename(path):
    base = os.path.basename(path)
    parts = base.split("_")
    if len(parts) < 2:
        return None
    if parts[0].startswith("MX") and parts[1].startswith("MY"):
        return "%s_%s" % (parts[0], parts[1])
    return None


def is_int(token):
    try:
        int(token)
        return True
    except Exception:
        return False


def has_ws_object(root_path, ws_obj):
    if ROOT is None:
        return True
    if not os.path.exists(root_path):
        return False
    if ":" in ws_obj:
        wsname, objname = ws_obj.split(":", 1)
    else:
        wsname, objname = ws_obj, None
    f = ROOT.TFile.Open(root_path)
    if not f or f.IsZombie():
        return False
    w = f.Get(wsname)
    if not w:
        f.Close()
        return False
    ok = True
    if objname:
        obj = w.obj(objname)
        if not obj:
            obj = w.pdf(objname)
        if not obj:
            obj = w.data(objname)
        ok = obj is not None
    f.Close()
    return ok


def rewrite_shapes_lines(lines, mass, drop_missing, check_objects):
    missing = set()
    new_lines = []
    for line in lines:
        if not line.startswith("shapes"):
            new_lines.append(line)
            continue
        tokens = line.split()
        if len(tokens) < 5:
            new_lines.append(line)
            continue
        proc = tokens[1]
        match = SHAPE_PROC_RE.match(proc)
        if not match:
            new_lines.append(line)
            continue
        proc_key = match.group("proc")
        year = match.group("year")
        channel = tokens[2]
        if channel.endswith("_" + year):
            cat = channel[:-(len(year) + 1)]
        else:
            cat = channel
        file_path = tokens[3]
        if "/mc/" not in file_path:
            new_lines.append(line)
            continue
        if proc_key not in PROC_SUFFIX:
            new_lines.append(line)
            continue
        proc_suffix = PROC_SUFFIX[proc_key]
        base = file_path.split("/mc/")[0]
        new_dir = "%s/mc/ws_ggyh%s_%s_%s_%s_%s" % (
            base, proc_key, mass, year, cat, proc_suffix
        )
        new_path = os.path.join(new_dir, os.path.basename(file_path))
        tokens[3] = new_path
        new_line = " ".join(tokens) + "\n"
        new_lines.append(new_line)
        if not drop_missing:
            continue
        if not os.path.exists(new_path):
            missing.add(proc)
            continue
        if check_objects and not has_ws_object(new_path, tokens[4]):
            missing.add(proc)
    return new_lines, missing


def drop_process_columns(lines, drop_procs):
    # Drop shapes lines first
    filtered = []
    for line in lines:
        if line.startswith("shapes"):
            tokens = line.split()
            if len(tokens) > 1 and tokens[1] in drop_procs:
                continue
        filtered.append(line)
    lines = filtered

    proc_idx = None
    for i, line in enumerate(lines):
        if not line.startswith("process"):
            continue
        tokens = line.split()
        if len(tokens) < 2:
            continue
        if any(not is_int(t) for t in tokens[1:]):
            proc_idx = i
            break
    if proc_idx is None:
        return lines

    name_tokens = lines[proc_idx].split()
    names = name_tokens[1:]
    keep_indices = [i for i, n in enumerate(names) if n not in drop_procs]
    if not keep_indices:
        return lines

    ncols = len(names)
    bin_idx = proc_idx - 1
    procid_idx = proc_idx + 1
    rate_idx = proc_idx + 2

    def rebuild_simple(line):
        tokens = line.split()
        if len(tokens) < 2:
            return line
        label = tokens[0]
        vals = [tokens[1 + i] for i in keep_indices]
        return " ".join([label] + vals) + "\n"

    lines[bin_idx] = rebuild_simple(lines[bin_idx])
    lines[proc_idx] = rebuild_simple(lines[proc_idx])
    lines[procid_idx] = rebuild_simple(lines[procid_idx])
    lines[rate_idx] = rebuild_simple(lines[rate_idx])

    # Update systematics lines with column entries
    updated = []
    for line in lines:
        tokens = line.split()
        if len(tokens) == 2 + ncols:
            prefix = tokens[:2]
            vals = [tokens[2 + i] for i in keep_indices]
            updated.append(" ".join(prefix + vals) + "\n")
            continue
        if len(tokens) == 3 + ncols:
            prefix = tokens[:3]
            vals = [tokens[3 + i] for i in keep_indices]
            updated.append(" ".join(prefix + vals) + "\n")
            continue
        updated.append(line)
    return updated


def process_card(card_path, drop_missing, check_objects):
    mass = parse_mass_from_filename(card_path)
    if not mass:
        return False
    with open(card_path, "r") as f:
        lines = f.readlines()
    new_lines, missing = rewrite_shapes_lines(lines, mass, drop_missing, check_objects)
    if drop_missing and missing:
        new_lines = drop_process_columns(new_lines, missing)
    with open(card_path, "w") as f:
        f.writelines(new_lines)
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Fix boosted combined cards to point at per-proc signal model directories."
    )
    parser.add_argument(
        "mass_dir",
        help="Path to datacard_MX*_MY* directory containing combined cards",
    )
    parser.add_argument(
        "--keep-missing",
        action="store_true",
        help="Do not drop processes when the signal model object is missing",
    )
    parser.add_argument(
        "--skip-object-check",
        action="store_true",
        help="Only check file existence, not workspace objects",
    )
    args = parser.parse_args()

    if not os.path.isdir(args.mass_dir):
        sys.stderr.write("[ERROR] Not a directory: %s\n" % args.mass_dir)
        return 2

    drop_missing = not args.keep_missing
    check_objects = not args.skip_object_check

    card_paths = []
    for name in os.listdir(args.mass_dir):
        if not name.endswith(".txt"):
            continue
        if name.startswith("Datacard_"):
            continue
        card_paths.append(os.path.join(args.mass_dir, name))

    card_paths.sort()
    if not card_paths:
        sys.stderr.write("[WARN] No combined cards found in %s\n" % args.mass_dir)
        return 0

    for card_path in card_paths:
        ok = process_card(card_path, drop_missing, check_objects)
        if not ok:
            sys.stderr.write("[WARN] Skipped: %s\n" % card_path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
