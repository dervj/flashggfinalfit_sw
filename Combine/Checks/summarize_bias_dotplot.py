from __future__ import print_function

import argparse
import os
import re


def parse_pull_log(path):
    # Match floats with optional exponent (e.g. -0.0123, 1.23e-02, 4.5E+01)
    mean_re = re.compile(r"Mean\s+(-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)")
    label_re = re.compile(r"biasStudy_\\S+_pulls\\.png")

    mean_values = []
    function_labels = []

    with open(path, "r") as fh:
        for line in fh:
            if "Mean" in line:
                m = mean_re.search(line)
                if m:
                    try:
                        mean_values.append(float(m.group(1)))
                    except ValueError:
                        pass
            if "_pulls.png" in line:
                m = label_re.search(line)
                if m:
                    function_labels.append(m.group().split("_")[1])

    # Keep arrays aligned in case some fits did not report a mean.
    if len(mean_values) != len(function_labels):
        min_len = min(len(mean_values), len(function_labels))
        mean_values = mean_values[:min_len]
        function_labels = function_labels[:min_len]

    return mean_values, function_labels


def main():
    parser = argparse.ArgumentParser(
        description="Summarize bias study pulls from Pull.log."
    )
    parser.add_argument("--log", default="Pull.log", help="Path to Pull.log")
    parser.add_argument(
        "--threshold",
        type=float,
        default=0.14,
        help="Absolute pull threshold to count as out-of-range (default: 0.14)",
    )
    args = parser.parse_args()

    if not os.path.isfile(args.log):
        raise IOError("Pull log not found: %s" % args.log)

    mean_values, function_labels = parse_pull_log(args.log)

    print(mean_values)
    print(function_labels)

    total = len(mean_values)
    out = [
        (i, v, function_labels[i])
        for i, v in enumerate(mean_values)
        if abs(v) > args.threshold
    ]
    print("Total points:", total)
    print("Outside |pull| > %.3f: %d" % (args.threshold, len(out)))
    if out:
        print("Outside points (index, mean, label):")
        for i, v, lab in out:
            print("  %d  %.6g  %s" % (i, v, lab))


if __name__ == "__main__":
    main()
