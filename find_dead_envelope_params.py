#!/usr/bin/env python2
"""
Inspect a flashggFinalFit combined workspace and report which env_pdf_0_* envelope
shape parameters are "dead" -- i.e. they belong to a RooMultiPdf candidate that is
NOT the currently active (pdfindex-selected) one in ANY category that references it.
RooMultiPdf only evaluates its active candidate, so a dead parameter is mathematically
disconnected from the likelihood and safe to freeze + exclude from Impacts.

Usage:
    python2.7 find_dead_envelope_params.py <workspace.root> [wsname]
    python2.7 find_dead_envelope_params.py <MX> <MY>
        Shorthand for the combined cat12 workspace of that mass point, i.e.
        FLASHGGFINALFIT_DIR/Datacard/datacard_MX<MX>_MY<MY>/MX<MX>_MY<MY>_Run2_cat12_fromproc.root
        (wsname defaults to "w"). Only covers the standard combined workspace --
        for anything else (hponly, a different category set, etc.) pass the
        explicit path instead.

Prints two lines to stdout, ready for use in a bash variable:
    FREEZE=<comma list of dead params>
    EXCLUDE=<comma list of dead params>   (identical set; kept separate since Impacts
                                            needs --exclude in addition to --freezeParameters)
Also prints a human-readable active-vs-dead breakdown to stderr.
"""
import sys
import os
import ROOT

FLASHGGFINALFIT_DIR = "/eos/user/j/jodervan/Analysis/flashggfinalfit_sw/CMSSW_10_6_20/src/flashggFinalFit"

# MX>=1000 workspaces abbreviate purity in the multipdf name (cat12hp/cat12lp), e.g.
# "shapeBkg_bkg_mass_cat12hp_cat12_2016post". MX 500-900 workspaces spell it out and
# repeat the year, e.g. "shapeBkg_bkg_mass_cat12_2016post_cat12highpurity_2016post"
# (an earlier/different combineCards run for that mass range -- same family of naming
# drift as the combineCards double-path issue). The old string-slice derivation
# (name.split("_cat12_")[-1] + "cat12hp" in name) silently produced a garbage category
# name for the second form -- e.g. "pdfindex_cat12lowpurity_2016post_cat12highpurity_
# 2016post_13TeV" -- so it never matched anything and MX 500-900 always looked like
# they had zero dead params (getImpacts_frozenEnvelope.sh then refuses to run at all).
# Resolve purity/year by token search instead so both naming conventions work; verified
# to reproduce the exact same FREEZE list as the old code for every MX>=1000 point
# checked, and to correctly find dead params (previously zero) for MX 500-900.
YEARS = ["2016pre", "2016post", "2017", "2018"]

def resolve_pdfindex_catname(multipdf_name, catnames):
    if "cat12hp" in multipdf_name or "highpurity" in multipdf_name:
        hplp = "highpurity"
    elif "cat12lp" in multipdf_name or "lowpurity" in multipdf_name:
        hplp = "lowpurity"
    else:
        return None
    year = None
    for y in YEARS:
        if y in multipdf_name:
            year = y
            break
    if year is None:
        return None
    catname = "pdfindex_cat12%s_%s_13TeV" % (hplp, year)
    return catname if catname in catnames else None

def get_env_params(pdf):
    # Hold an explicit reference to the RooArgSet before iterating -- PyROOT can
    # garbage-collect an unreferenced temporary while its iterator is still in use,
    # silently corrupting the walk (seen in practice on the MX1800_MY250 workspace).
    params = pdf.getParameters(ROOT.RooArgSet())
    out = set()
    it = params.createIterator()
    v = it.Next()
    while v:
        if not v.isConstant() and v.GetName().startswith("env_pdf_0_"):
            out.add(v.GetName())
        v = it.Next()
    return out

def main():
    if len(sys.argv) < 2:
        sys.stderr.write("Usage: %s <workspace.root> [wsname]\n" % sys.argv[0])
        sys.stderr.write("   or: %s <MX> <MY>\n" % sys.argv[0])
        sys.exit(1)

    if len(sys.argv) == 3 and sys.argv[1].isdigit() and sys.argv[2].isdigit():
        mx, my = sys.argv[1], sys.argv[2]
        wsfile = os.path.join(FLASHGGFINALFIT_DIR, "Datacard", "datacard_MX%s_MY%s" % (mx, my),
                              "MX%s_MY%s_Run2_cat12_fromproc.root" % (mx, my))
        wsname = "w"
    else:
        wsfile = sys.argv[1]
        wsname = sys.argv[2] if len(sys.argv) > 2 else "w"

    if not os.path.isfile(wsfile):
        sys.stderr.write("Workspace file does not exist: %s\n" % wsfile)
        sys.exit(1)

    f = ROOT.TFile.Open(wsfile)
    w = f.Get(wsname)
    if not w:
        sys.stderr.write("Could not find workspace '%s' in %s\n" % (wsname, wsfile))
        sys.exit(1)

    multipdfs = []
    allpdfs_set = w.allPdfs()  # hold a reference -- see get_env_params comment
    it = allpdfs_set.createIterator()
    p = it.Next()
    while p:
        if p.ClassName() == "RooMultiPdf":
            multipdfs.append(p.GetName())
        p = it.Next()

    catnames = []
    allcats_set = w.allCats()  # hold a reference -- see get_env_params comment
    itc = allcats_set.createIterator()
    c = itc.Next()
    while c:
        if "pdfindex" in c.GetName():
            catnames.append(c.GetName())
        c = itc.Next()

    active_params = set()
    inactive_params = set()
    active_report = []

    for name in sorted(multipdfs):
        mp = w.pdf(name)
        n = mp.getNumPdfs()
        cands = [mp.getPdf(i).GetName() for i in range(n)]
        catname = resolve_pdfindex_catname(name, catnames)
        if catname is None:
            sys.stderr.write("WARNING: could not resolve a pdfindex category for multipdf %s, skipping\n" % name)
            continue
        idx = w.cat(catname).getIndex()
        active_report.append((name, cands[idx]))
        for i, cand in enumerate(cands):
            ps = get_env_params(w.pdf(cand))
            if i == idx:
                active_params |= ps
            else:
                inactive_params |= ps

    truly_dead = sorted(inactive_params - active_params)

    sys.stderr.write("=== Active candidate per category ===\n")
    for name, cand in active_report:
        sys.stderr.write("  %s -> %s\n" % (name, cand))
    sys.stderr.write("\n=== Live (never freeze) params: %d ===\n" % len(active_params))
    for p in sorted(active_params):
        sys.stderr.write("  %s\n" % p)
    sys.stderr.write("\n=== Dead (freeze + exclude) params: %d ===\n" % len(truly_dead))
    for p in truly_dead:
        sys.stderr.write("  %s\n" % p)

    print("FREEZE=%s" % ",".join(truly_dead))
    print("EXCLUDE=%s" % ",".join(truly_dead))

if __name__ == "__main__":
    ROOT.gROOT.SetBatch(True)
    main()
