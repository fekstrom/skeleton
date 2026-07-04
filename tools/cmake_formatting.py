#! /usr/bin/env python3

import argparse
import os
import subprocess

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
CONFIG_FILE = os.path.join(PROJECT_ROOT, "gersemi.yml")

parser = argparse.ArgumentParser(description="CMake formatting with Gersemi.")
parser.add_argument(
    "sources",
    nargs="*",
    default=[PROJECT_ROOT],
    help="Files or directories to check (project root by default).",
)
parser.add_argument(
    "-d",
    "--diff",
    action="store_true",
    help="Show formatting diff.",
)
parser.add_argument(
    "-f",
    "--format",
    action="store_true",
    help="Format in place.",
)
parser.add_argument(
    "-q",
    "--quiet",
    action="store_true",
    help="Suppress output on success.",
)
args = parser.parse_args()

commandline = ["gersemi", "--config", CONFIG_FILE] + args.sources

if args.diff:
    commandline += ["--diff"]

if args.format:
    commandline += ["--in-place"]
else:
    commandline += ["--check"]

result = subprocess.run(commandline)
if not args.format:
    if result.returncode == 0:
        if not args.quiet:
            print("CMake formatting is OK!")
    else:
        print(
            f"\n"
            f"CMake formatting check failed. To format in place, run\n"
            f"{os.path.relpath(__file__, PROJECT_ROOT)} --format"
        )

exit(result.returncode)
