#!/usr/bin/env python
import os
import ROOT

try:
    from flashggFinalFit.tools.commonObjects import inputWSName__
except Exception:
    inputWSName__ = "tagsDumper/cms_hgg_13TeV"

EOS_BASE = "/eos/cms/store/group/phys_b2g/jodervan/yh_fggfinalfit"
MASS = "MX4000_MY2000"
YEARS = ["2016pre", "2016post", "2017", "2018"]
CATS = ["cat12lowpurity", "cat12highpurity"]
PROC = "wwgg"  # ggyhwwgg

def sumw_for(year, cat, debug=False):
    fpath = os.path.join(
        EOS_BASE, year, MASS, "mc",
        "%s_%s_%s_%s.root" % (MASS, year, PROC, cat)
    )
    if not os.path.exists(fpath):
        return "missing_path", fpath
    f = ROOT.TFile.Open(fpath)
    if not f or f.IsZombie():
        return "open_failed", fpath
    w = f.Get(inputWSName__)
    if not w:
        # Fallback: try to locate any RooWorkspace in the file
        for key in f.GetListOfKeys():
            obj = key.ReadObj()
            if obj and obj.InheritsFrom("RooWorkspace"):
                w = obj
                break
    if not w:
        if debug:
            print "  [DEBUG] Keys in file:", fpath
            for key in f.GetListOfKeys():
                print "    -", key.GetName(), ":", key.GetClassName()
        # Fall back to TTree if present (flashgg ntuples)
        tname = "ggyhwwgg_125_13TeV_%s" % cat
        t = f.Get(tname)
        if t:
            branches = [b.GetName() for b in t.GetListOfBranches()]
            weight_candidates = [
                "weight", "weight_nominal", "weightCentral",
                "evtWeight", "weightXS", "weight_XS", "w"
            ]
            wbranch = None
            for b in weight_candidates:
                if b in branches:
                    wbranch = b
                    break
            if wbranch is None:
                if debug:
                    print "  [DEBUG] No known weight branch; using entries."
                val = float(t.GetEntries())
            else:
                if debug:
                    print "  [DEBUG] Using weight branch:", wbranch
                val = 0.0
                t.SetBranchStatus("*", 0)
                t.SetBranchStatus(wbranch, 1)
                for i in range(t.GetEntries()):
                    t.GetEntry(i)
                    val += float(getattr(t, wbranch))
            f.Close()
            return val, fpath
        f.Close()
        return "missing_ws", fpath
    dname = "ggyhwwgg_%s_13TeV_%s" % (MASS, cat)
    data = w.data(dname)
    if not data:
        f.Close()
        if debug:
            print "  [DEBUG] Available datasets in workspace:", w.GetName()
            data = w.allData()
            it = ROOT.TIter(data)
            obj = it.Next()
            while obj:
                print "    -", obj.GetName()
                obj = it.Next()
        return "missing_dataset", fpath
    val = data.sumEntries()
    f.Close()
    return val, fpath

for y in YEARS:
    for c in CATS:
        val, fpath = sumw_for(y, c, debug=False)
        if isinstance(val, basestring):
            print "[%s]" % val.upper(), y, c, "->", fpath
        else:
            print y, c, "sumEntries =", val, "from", fpath
