#!/usr/bin/env python2
"""
Report the up/down effect of one or more nuisance parameters on a flashggFinalFit
combined workspace, by name.

Context: this analysis's datacards only use two systematic types (checked against
Datacard/datacard_MX*_MY*/*.txt): "lnN" and "param". Neither is a template/histogram
shape -- there is no per-nuisance TH1 "_Up"/"_Down" pair to pull out of the root file.
Instead every nuisance is a plain unit-Gaussian RooRealVar (nominal 0, constraint sigma
1) that feeds into the actual physical quantities via RooFormulaVar (signal peak mean_*/
sigma_*/rate_* terms, for "param"-type shape nuisances) or ProcessNormalization (per-
process/category yield scale factors, for "lnN"-type rate nuisances). So "the up/down
variation of a parameter" here means: hold every other nuisance at its current workspace
value, move this one to +/-Nsigma (default 1), and read off how much each of those
downstream quantities changes. That is a set of numbers, not a distribution -- there is
nothing to plot (see the class-name check below, which will speak up if some other mass
point/category ever turns out to use a template-shape systematic after all).

Usage:
    python2.7 getVariations.py <workspace.root> --params NAME [NAME ...]
        [--wsname w] [--nsigma 1.0] [--csv OUTFILE.csv]

Prints, per requested parameter, its nominal value/constraint width/range, then a table
of every downstream RooFormulaVar / ProcessNormalization that depends on it directly,
evaluated at down (-Nsigma), nominal (0, or whatever the workspace currently holds),
and up (+Nsigma).
"""
import sys
import os
import argparse
import ROOT

# Node classes whose value at down/nominal/up is the actual reportable "variation" --
# see the module docstring. RooFormulaVar covers shape-parameter ("param" datacard type)
# effects (mean_*, sigma_*, rate_*); ProcessNormalization covers rate ("lnN" datacard
# type) effects.
REPORT_CLASSES = ("RooFormulaVar", "ProcessNormalization")

# Client classes that are expected but not themselves reportable (the Gaussian penalty
# term combine attaches to every nuisance) -- skipped silently rather than listed under
# "other clients", since they show up on every single parameter and would just be noise.
CONSTRAINT_PDF_CLASSES = ("SimpleGaussianConstraint", "RooGaussian", "RooPoisson")


def get_direct_clients(var):
    # Hold an explicit reference to the client iterator's backing collection before
    # walking it -- PyROOT can garbage-collect an unreferenced temporary mid-iteration
    # and silently corrupt the walk (same hazard documented in find_dead_envelope_params.py).
    it = var.clientIterator()
    out = []
    c = it.Next()
    while c:
        out.append(c)
        c = it.Next()
    return out


def format_num(x):
    return "%.6g" % x


def pct(delta, base):
    if base == 0:
        return "n/a"
    return "%+.3f%%" % (100.0 * delta / base)


def report_param(w, name, nsigma):
    var = w.var(name)
    if not var:
        sys.stderr.write("ERROR: '%s' is not a RooRealVar in this workspace (typo, or it's a different object type -- check with w.arg()).\n" % name)
        return False

    nominal_theta = var.getVal()
    sigma = var.getError()
    print("=== %s ===" % name)
    print("  class:        %s" % var.ClassName())
    print("  current value: %s   constraint width (getError): %s   range: (%s, %s)" %
          (format_num(nominal_theta), format_num(sigma) if sigma else "n/a",
           format_num(var.getMin()), format_num(var.getMax())))

    if var.isConstant():
        print("  This parameter is CONSTANT in the workspace -- frozen, so it has no up/down effect on anything downstream.")
        print("")
        return True

    clients = get_direct_clients(var)
    report_nodes = [c for c in clients if c.ClassName() in REPORT_CLASSES]
    skipped_constraint = [c for c in clients if c.ClassName() in CONSTRAINT_PDF_CLASSES]
    other = [c for c in clients if c.ClassName() not in REPORT_CLASSES and c.ClassName() not in CONSTRAINT_PDF_CLASSES]

    if not report_nodes:
        print("  No downstream RooFormulaVar/ProcessNormalization clients found -- this parameter does not "
              "appear to feed into any shape or rate term (dead parameter, or an object type this script "
              "doesn't know to report -- see 'other clients' below if listed).")

    if other:
        # Cap the listing -- a hub parameter like MH can have hundreds of unrelated
        # clients (RooSpline1D interpolators, etc.), and dumping all of them is just
        # noise. This is a heads-up for template/histogram-style nodes this script
        # doesn't know to report, not a place to enumerate every server of a shared var.
        shown = other[:8]
        listing = ", ".join("%s (%s)" % (c.GetName(), c.ClassName()) for c in shown)
        if len(other) > len(shown):
            listing += ", ... and %d more" % (len(other) - len(shown))
        print("  NOTE: %d other client(s) with an unrecognized class were skipped (not a template/histogram "
              "type this script knows about, but flagging in case one is): %s" % (len(other), listing))

    if report_nodes:
        down_theta = nominal_theta - nsigma
        up_theta = nominal_theta + nsigma

        rows = []
        for node in report_nodes:
            base = node.getVal()
            var.setVal(down_theta)
            down_val = node.getVal()
            var.setVal(up_theta)
            up_val = node.getVal()
            var.setVal(nominal_theta)  # restore -- must happen before computing base-relative deltas below too
            rows.append((node.GetName(), node.ClassName(), down_val, base, up_val))

        rows.sort(key=lambda r: r[0])

        name_w = max(len(r[0]) for r in rows)
        cls_w = max(len(r[1]) for r in rows)
        header = "  %-*s  %-*s  %14s  %14s  %14s  %12s  %12s" % (
            name_w, "downstream node", cls_w, "class",
            "down(-%gs)" % nsigma, "nominal", "up(+%gs)" % nsigma, "%down", "%up")
        print(header)
        print("  " + "-" * (len(header) - 2))
        for nname, ncls, dval, bval, uval in rows:
            print("  %-*s  %-*s  %14s  %14s  %14s  %12s  %12s" % (
                name_w, nname, cls_w, ncls,
                format_num(dval), format_num(bval), format_num(uval),
                pct(dval - bval, bval), pct(uval - bval, bval)))
        print("")
        return rows
    print("")
    return True


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("wsfile", help="Path to the *_fromproc.root workspace file")
    ap.add_argument("wsname", nargs="?", default="w", help="Workspace object name inside the file (default: w)")
    ap.add_argument("--params", nargs="+", required=True, help="One or more nuisance parameter names to report")
    ap.add_argument("--nsigma", type=float, default=1.0, help="Size of the up/down step, in units of the parameter's own (unit-Gaussian) scale (default: 1.0)")
    ap.add_argument("--csv", default=None, help="Optional path to also write the results as CSV (param,node,class,down,nominal,up,pct_down,pct_up)")
    args = ap.parse_args()

    if not os.path.isfile(args.wsfile):
        sys.stderr.write("Workspace file does not exist: %s\n" % args.wsfile)
        sys.exit(1)

    f = ROOT.TFile.Open(args.wsfile)
    if not f or f.IsZombie():
        sys.stderr.write("Could not open file: %s\n" % args.wsfile)
        sys.exit(1)
    w = f.Get(args.wsname)
    if not w:
        sys.stderr.write("Could not find workspace '%s' in %s\n" % (args.wsname, args.wsfile))
        sys.exit(1)

    print("Workspace: %s (object '%s')" % (args.wsfile, args.wsname))
    print("Up/down step: +/-%g (in the parameter's own normalized units -- 1.0 = its Gaussian constraint sigma)" % args.nsigma)
    print("")

    csv_rows = []
    any_missing = False
    for pname in args.params:
        result = report_param(w, pname, args.nsigma)
        if result is False:
            any_missing = True
        elif isinstance(result, list):
            for nname, ncls, dval, bval, uval in result:
                csv_rows.append((pname, nname, ncls, dval, bval, uval,
                                  "" if bval == 0 else "%.6g" % (100.0 * (dval - bval) / bval),
                                  "" if bval == 0 else "%.6g" % (100.0 * (uval - bval) / bval)))

    if args.csv and csv_rows:
        import csv as csvmod
        with open(args.csv, "w") as fh:
            writer = csvmod.writer(fh)
            writer.writerow(["param", "downstream_node", "class", "down", "nominal", "up", "pct_down", "pct_up"])
            for row in csv_rows:
                writer.writerow(row)
        sys.stderr.write("Wrote CSV: %s\n" % args.csv)

    sys.exit(1 if any_missing else 0)


if __name__ == "__main__":
    ROOT.gROOT.SetBatch(True)
    main()
