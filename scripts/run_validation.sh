#!/usr/bin/env bash
set -euo pipefail

python3 scripts/validate_assessments.py
Rscript analysis/validate_figures_tables.R

echo "All Gaza WASH repository validators passed."
