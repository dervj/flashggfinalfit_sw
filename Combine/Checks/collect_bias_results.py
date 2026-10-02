"""
Harvest bias study pull means from all BiasRuns/*/Pull.log files and write
a CSV summary.  For each (mass, year, category, bkg_model) reports the
Gaussian mean pull and whether it passes the |mean| < 0.14 criterion.

Usage:
    python collect_bias_results.py [--biasruns BIASRUNS_DIR] [--out OUTPUT_CSV]

Defaults:
    --biasruns  BiasRuns/          (relative to script dir)
    --out       bias_results.csv
"""
from __future__ import print_function

import argparse
import csv
import os
import re
import sys

pattern_mean  = re.compile(r'Mean\s+(-?\d+\.\d+(?:e[+-]\d+)?)')
pattern_label = re.compile(r'biasStudy_\S+_pulls\.png')
# BiasRuns directory name format: MX{mx}_MY{my}_{year}_cat12{cat}
pattern_dir   = re.compile(
    r'^MX(?P<mx>\d+)_MY(?P<my>\d+)_(?P<year>20\d+(?:pre|post)?)_cat12(?P<cat>\w+?)(?:_AS(?P<as>\d+))?$'
)

THRESHOLD = 0.14


def parse_pull_log(log_path):
    """Return list of (label, mean) tuples parsed from a Pull.log."""
    means  = []
    labels = []
    with open(log_path, 'r') as fh:
        for line in fh:
            if 'Mean' in line:
                m = pattern_mean.search(line)
                if m:
                    means.append(float(m.group(1)))
            if '_pulls.png' in line:
                m = pattern_label.search(line)
                if m:
                    # e.g. "biasStudy_bern1_pulls.png" -> "bern1"
                    labels.append(m.group().split('_')[1])
    # align in case some fits did not report a mean
    n = min(len(means), len(labels))
    return list(zip(labels[:n], means[:n]))


def main():
    parser = argparse.ArgumentParser(description="Collect bias study pull means into CSV.")
    parser.add_argument('--biasruns', default='BiasRuns',
                        help='Path to BiasRuns directory (default: BiasRuns/)')
    parser.add_argument('--out', default='bias_results.csv',
                        help='Output CSV path (default: bias_results.csv)')
    args = parser.parse_args()

    script_dir  = os.path.dirname(os.path.abspath(__file__))
    biasruns    = args.biasruns if os.path.isabs(args.biasruns) \
                  else os.path.join(script_dir, args.biasruns)
    out_path    = args.out if os.path.isabs(args.out) \
                  else os.path.join(script_dir, args.out)

    if not os.path.isdir(biasruns):
        print("ERROR: BiasRuns directory not found: %s" % biasruns, file=sys.stderr)
        sys.exit(1)

    rows = []
    missing = []

    for dirname in sorted(os.listdir(biasruns)):
        m = pattern_dir.match(dirname)
        if not m:
            continue
        mx   = m.group('mx')
        my   = m.group('my')
        year = m.group('year')
        cat  = m.group('cat')
        adjustsignal = m.group('as') if m.group('as') else 'default'

        log_path = os.path.join(biasruns, dirname, 'Pull.log')
        if not os.path.isfile(log_path):
            missing.append(dirname)
            continue

        results = parse_pull_log(log_path)
        if not results:
            missing.append(dirname + " (empty)")
            continue

        for label, mean in results:
            rows.append({
                'mx':          mx,
                'my':          my,
                'year':        year,
                'category':    cat,
                'adjustsignal': adjustsignal,
                'bkg_model':   label,
                'mean_pull':   mean,
                'pass':        'PASS' if abs(mean) < THRESHOLD else 'FAIL',
            })

    # Write CSV
    fieldnames = ['mx', 'my', 'year', 'category', 'adjustsignal', 'bkg_model', 'mean_pull', 'pass']
    with open(out_path, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    n_total = len(rows)
    n_fail  = sum(1 for r in rows if r['pass'] == 'FAIL')
    n_pass  = n_total - n_fail

    print("Written: %s" % out_path)
    print("Total model x point entries: %d  |  PASS: %d  |  FAIL: %d" % (n_total, n_pass, n_fail))
    if missing:
        print("Missing Pull.log (%d):" % len(missing))
        for d in missing:
            print("  " + d)

    # Print FAIL summary to stdout
    if n_fail:
        print("\nFailing entries (|mean_pull| >= %.2f):" % THRESHOLD)
        print("  %-6s %-6s %-10s %-14s %-10s %s" % (
              'MX', 'MY', 'Year', 'Category', 'Model', 'MeanPull'))
        for r in rows:
            if r['pass'] == 'FAIL':
                print("  %-6s %-6s %-10s %-14s %-10s %.4f" % (
                      r['mx'], r['my'], r['year'], r['category'],
                      r['bkg_model'], r['mean_pull']))


if __name__ == '__main__':
    main()
