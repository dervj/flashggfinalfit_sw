#!/usr/bin/env python
import os
import ROOT

EOS_BASE = "/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit"
MASS = "MX4000_MY2000"
YEARS = ["2016pre", "2016post", "2017", "2018"]
CATS = ["cat12lowpurity", "cat12highpurity"]
PROC = "wwgg"
WEIGHT_BRANCH = "weight"
NPRINT = 5


def stats_for(year, cat):
    fpath = os.path.join(
        EOS_BASE, year, MASS, "mc",
        "%s_%s_%s_%s.root" % (MASS, year, PROC, cat)
    )
    if not os.path.exists(fpath):
        return "missing_path", fpath, None
    f = ROOT.TFile.Open(fpath)
    if not f or f.IsZombie():
        return "open_failed", fpath, None
    tname = "ggyhwwgg_125_13TeV_%s" % cat
    t = f.Get(tname)
    if not t:
        f.Close()
        return "missing_tree", fpath, None
    branches = [b.GetName() for b in t.GetListOfBranches()]
    if WEIGHT_BRANCH not in branches:
        f.Close()
        return "missing_weight_branch", fpath, None
    t.SetBranchStatus("*", 0)
    t.SetBranchStatus(WEIGHT_BRANCH, 1)
    n = t.GetEntries()
    if n == 0:
        f.Close()
        return "empty_tree", fpath, None
    wmin, wmax, wsum = None, None, 0.0
    sample = []
    for i in range(n):
        t.GetEntry(i)
        w = float(getattr(t, WEIGHT_BRANCH))
        if wmin is None or w < wmin:
            wmin = w
        if wmax is None or w > wmax:
            wmax = w
        wsum += w
        if len(sample) < NPRINT:
            sample.append(w)
    f.Close()
    return "ok", fpath, {
        "entries": int(n),
        "sum": wsum,
        "mean": wsum / float(n),
        "min": wmin,
        "max": wmax,
        "sample": sample,
    }


for y in YEARS:
    for c in CATS:
        status, fpath, info = stats_for(y, c)
        if status != "ok":
            print "[%s] %s %s -> %s" % (status.upper(), y, c, fpath)
            continue
        print "%s %s entries=%d sum=%.6g mean=%.6g min=%.6g max=%.6g sample=%s" % (
            y, c, info["entries"], info["sum"], info["mean"],
            info["min"], info["max"], info["sample"]
        )
