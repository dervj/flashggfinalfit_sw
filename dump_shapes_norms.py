#!/usr/bin/env python
import re
import sys
import ROOT

def parse_shapes(datacard):
    shapes = []
    with open(datacard) as f:
        for line in f:
            if not line.startswith("shapes "):
                continue
            parts = line.split()
            # shapes <proc> <cat> <file> <obj>
            if len(parts) < 5:
                continue
            proc, cat, fpath, obj = parts[1], parts[2], parts[3], parts[4]
            shapes.append((proc, cat, fpath, obj))
    return shapes

def get_norm(ws, obj):
    # obj like: wsig_13TeV:hggpdfsmrel_ggyhGGH_2018_cat12lowpurity_13TeV
    if ":" not in obj:
        return None
    wsname, pdfname = obj.split(":", 1)
    w = ws.Get(wsname)
    if not w:
        return None

    def _fmt(v):
        try:
            return "%.6f" % float(v)
        except Exception:
            return None

    # norm function is <pdfname>_normThisLumi
    fn = w.function(pdfname + "_normThisLumi")
    if fn:
        return _fmt(fn.getVal())
    # fallback: try to find any matching function
    cand = w.allFunctions().selectByName("*%s*normThisLumi" % pdfname.split("_")[0])
    it = ROOT.TIter(cand)
    obj = it.Next()
    if obj:
        return _fmt(obj.getVal())
    return None

def main():
    if len(sys.argv) < 2:
        print "Usage: dump_shapes_norms.py <datacard.txt>"
        sys.exit(1)
    card = sys.argv[1]
    shapes = parse_shapes(card)
    print "Datacard:", card
    for proc, cat, fpath, obj in shapes:
        if proc in ("bkg_mass", "data_obs"):
            continue
        f = ROOT.TFile.Open(fpath)
        if not f or f.IsZombie():
            print "  [ERR] cannot open", fpath
            continue
        norm = get_norm(f, obj)
        f.Close()
        print "  %-30s %-25s normThisLumi=%s" % (proc, cat, norm)
    return 0

if __name__ == "__main__":
    main()
