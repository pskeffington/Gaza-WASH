#!/usr/bin/env Rscript

# Validate expected manuscript-facing Gaza WASH artifacts.
# This script checks file presence and basic CSV readability without making claims.

required_paths <- c(
  "ROADMAP.md",
  "docs/source_audit.md",
  "assessments/manifest.csv",
  "assessments/citation_audit/source_claim_matrix.csv",
  "assessments/citation_audit/official_source_trace.csv",
  "manuscript/main.tex",
  "manuscript/sections/01_introduction.tex",
  "manuscript/sections/02_methods.tex",
  "manuscript/sections/03_results.tex",
  "manuscript/sections/04_discussion.tex",
  "manuscript/references.bib"
)

missing <- required_paths[!file.exists(required_paths)]
if (length(missing) > 0) {
  stop(paste("Missing required artifact(s):", paste(missing, collapse = ", ")), call. = FALSE)
}

csv_paths <- c(
  "assessments/manifest.csv",
  "assessments/citation_audit/source_claim_matrix.csv",
  "assessments/citation_audit/official_source_trace.csv"
)

for (p in csv_paths) {
  x <- tryCatch(read.csv(p, stringsAsFactors = FALSE), error = function(e) e)
  if (inherits(x, "error")) {
    stop(paste("CSV read failed:", p, x$message), call. = FALSE)
  }
  if (nrow(x) == 0) {
    stop(paste("CSV has no rows:", p), call. = FALSE)
  }
}

message("Figure/table artifact validation passed.")
