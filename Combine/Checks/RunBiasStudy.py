#!/usr/bin/env python

from biasUtils import *
from os import system,mkdir,getenv,path
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-d","--datacard",default="Datacard.root")
parser.add_option("-w","--workspace",default="w")
parser.add_option("-t","--toys",action="store_true", default=False)
parser.add_option("-n","--nToys",default=1000,type="int")
parser.add_option("-f","--fits",action="store_true", default=False)
parser.add_option("-p","--plots",action="store_true", default=False)
parser.add_option("-e","--expectSignal",default=1.,type="float")
parser.add_option("-m","--mH",default=125.,type="float")
parser.add_option("-c","--combineOptions",default="")
parser.add_option("-s","--seed",default=-1,type="int")
parser.add_option("--dryRun",action="store_true", default=False)
parser.add_option("--poi",default="r")
parser.add_option("--split",default=500,type="int")
parser.add_option("--selectFunction",default=None)
parser.add_option("--gaussianFit",action="store_true", default=False)
parser.add_option("--outdir",default=".",help="Base output directory for Bias* subfolders")
(opts,args) = parser.parse_args()
print
if opts.nToys>opts.split and not opts.nToys%opts.split==0: raise RuntimeError('The number of toys %g needs to be smaller than or divisible by the split number %g'%(opts.nToys, opts.split))

import ROOT as r
r.gROOT.SetBatch(True)
r.gStyle.SetOptStat(2211)
abs_outdir = path.abspath(opts.outdir)
if not path.isdir(abs_outdir):
    system('mkdir -p %s'%abs_outdir)
opts.outdir = abs_outdir
setBaseDir(opts.outdir)

ws = r.TFile(opts.datacard).Get(opts.workspace)

pdfs = rooArgSetToList(ws.allPdfs())
multipdfName = None
for pdf in pdfs:
    if pdf.InheritsFrom("RooMultiPdf"):
        if multipdfName is not None: raiseMultiError() 
        multipdfName = pdf.GetName()
        print 'Conduct bias study for multipdf called %s'%multipdfName
multipdf = ws.pdf(multipdfName)

varlist = rooArgSetToList(ws.allCats())
indexName = None
for var in varlist:
    if var.GetName().startswith('pdfindex'):
        if indexName is not None: raiseMultiError()
        indexName = var.GetName()
        print 'Found index called %s'%indexName

from collections import OrderedDict as od
indexNameMap = od()
for ipdf in range(multipdf.getNumPdfs()):
    if opts.selectFunction is not None:
        if not multipdf.getPdf(ipdf).GetName().count(opts.selectFunction): continue
    indexNameMap[ipdf] = multipdf.getPdf(ipdf).GetName()
print 'Will run bias study for %d pdfs'%len(indexNameMap)
print 'indexNameMap:', indexNameMap
# indexNameMap  OrderedDict([(0, 'env_pdf_0_2017_13TeV_bern2'), (1, 'env_pdf_0_2017_13TeV_lau2')])
def run_in_outdir(cmd):
    run('cd %s && %s'%(opts.outdir, cmd), dry=opts.dryRun)
if opts.toys:
    if not path.isdir(path.join(opts.outdir, 'BiasToys')): system('mkdir -p %s'%path.join(opts.outdir, 'BiasToys'))
    toyCmdBase = 'combine -m %.4f -d %s -M GenerateOnly --expectSignal %.4f -s %g --saveToys %s'%(opts.mH, opts.datacard, opts.expectSignal, opts.seed, opts.combineOptions)
    for ipdf,pdfName in indexNameMap.iteritems():
        name = shortName(pdfName)
        if opts.nToys > opts.split:
            for isplit in range(opts.nToys//opts.split):
                # print("debug indexName", indexName)
                # print("debug ipdf", ipdf)
                # print("debug isplit", isplit)
                # print("debug toyName(name,split=isplit)", toyName(name,split=isplit))
                toyCmd = toyCmdBase + ' -t %g -n _%s_split%g --setParameters %s=%g --freezeParameters %s'%(opts.split, name, isplit, indexName, ipdf, indexName)
                run_in_outdir(toyCmd)
                print("toy command is: ",toyCmd)
                system('mv -f %s %s'%(path.join(opts.outdir, 'higgsCombine_%s*'%name), toyName(name,split=isplit)))
        else: 
            toyCmd = toyCmdBase + ' -t %g -n _%s --setParameters %s=%g --freezeParameters %s'%(opts.nToys, name, indexName, ipdf, indexName)
            run_in_outdir(toyCmd)
            print("toy command is: ",toyCmd)
            system('mv -f %s %s'%(path.join(opts.outdir, 'higgsCombine_%s*'%name), toyName(name)))

if opts.fits:
    if not path.isdir(path.join(opts.outdir, 'BiasFits')): system('mkdir -p %s'%path.join(opts.outdir, 'BiasFits'))
    fitCmdBase = 'combine --rMin -10 --rMax 10 -m %.4f -d %s -M MultiDimFit -P %s --algo singles %s'%(opts.mH, opts.datacard, opts.poi, opts.combineOptions)
    for ipdf,pdfName in indexNameMap.iteritems():
        name = shortName(pdfName)
        print("debug opts.nToys: %g"%opts.nToys)
        print("debug opts.split: %g"%opts.split)
        if opts.nToys > opts.split:
            print("debug opts.split: %g"%opts.split)
            print("debug name: %s"%name)
            print("debug toyName: %s"%toyName(name))
            print("debug fitName: %s"%fitName(name))
            for isplit in range(opts.nToys//opts.split):
                fitCmd = fitCmdBase + ' -t %g -n _%s_split%g --toysFile=%s'%(opts.split, name, isplit, toyName(name,split=isplit))
                run_in_outdir(fitCmd)
                print("fit command: %s"%fitCmd)
                system('mv -f %s %s'%(path.join(opts.outdir, 'higgsCombine_%s*'%name), fitName(name,split=isplit)))
            run('hadd -f %s %s'%(fitName(name), path.join(opts.outdir, 'BiasFits', '*%s*split*.root'%name)), dry=opts.dryRun)
        else:
            fitCmd = fitCmdBase + ' -t %g -n _%s --toysFile=%s'%(opts.nToys, name, toyName(name))
            run_in_outdir(fitCmd)
            print("fit command: %s"%fitCmd)
            system('mv -f %s %s'%(path.join(opts.outdir, 'higgsCombine_%s*'%name), fitName(name)))

if opts.plots:
    if not path.isdir(path.join(opts.outdir, 'BiasPlots')): system('mkdir -p %s'%path.join(opts.outdir, 'BiasPlots'))
    for ipdf,pdfName in indexNameMap.iteritems():
        name = shortName(pdfName)
        tfile = r.TFile(fitName(name))
        print("debug tfile: %s"%tfile)
        tree = tfile.Get('limit')
        if not tree or not tree.InheritsFrom('TTree'):
            raise RuntimeError('Missing limit tree in %s (fit outputs likely failed or hadd did not merge).'%fitName(name))
        pullHist = r.TH1F('pullsForTruth_%s'%name, 'Pull distribution using the envelope to fit %s'%name, 80, -4., 4.)
        pullHist.GetXaxis().SetTitle('Pull')
        pullHist.GetYaxis().SetTitle('Entries')
        for itoy in range(opts.nToys):
            tree.GetEntry(3*itoy)
            print("debug1 tree.quantileExpected: %g"%tree.quantileExpected)
            if not getattr(tree,'quantileExpected') +1 < 0.0001: 
                raiseFailError(itoy,True) 
                continue
            bf = getattr(tree, 'r')
            tree.GetEntry(3*itoy+1)
            print("debug2 tree.quantileExpected: %g"%tree.quantileExpected)
            if not abs(getattr(tree,'quantileExpected')+0.32)<0.0001: 
                raiseFailError(itoy,True) 
                continue
            lo = getattr(tree, 'r')
            tree.GetEntry(3*itoy+2)
            print("debug3 tree.quantileExpected: %g"%tree.quantileExpected)
            if not abs(getattr(tree,'quantileExpected')-0.32)<0.0001: 
                raiseFailError(itoy,True) 
                continue
            print("pass")
            hi = getattr(tree, 'r')
            diff = bf - opts.expectSignal
            unc = 0.5 * (hi-lo)
            if unc > -2000.: 
                pullHist.Fill(diff)
        canv = r.TCanvas()
        pullHist.Draw()
        if opts.gaussianFit:
           r.gStyle.SetOptFit(111)
           pullHist.Fit('gaus')
        print 'Saving %s.pdf'%plotName(name)
        canv.SaveAs('%s.pdf'%plotName(name))
        print 'Saving %s.png'%plotName(name)
        canv.SaveAs('%s.png'%plotName(name))
