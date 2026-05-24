#!/usr/bin/env Rscript

# Validate manuscript-facing tabular artifacts for the Gaza WASH project.
# Scope: file presence, CSV readability, schema, primary keys, joins, and controlled values.

fail <- function(...) stop(paste(...), call. = FALSE)

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
  fail("Missing required artifact(s):", paste(missing, collapse = ", "))
}

read_checked_csv <- function(path, expected_names) {
  x <- tryCatch(read.csv(path, stringsAsFactors = FALSE, check.names = FALSE), error = function(e) e)
  if (inherits(x, "error")) {
    fail("CSV read failed:", path, x$message)
  }
  if (nrow(x) == 0) {
    fail("CSV has no rows:", path)
  }
  if (!identical(names(x), expected_names)) {
    fail(
      "CSV schema mismatch:", path,
      "expected", paste(expected_names, collapse = "|"),
      "found", paste(names(x), collapse = "|")
    )
  }
  for (nm in expected_names) {
    if (any(is.na(x[[nm]]) | trimws(x[[nm]]) == "")) {
      fail("Empty required field in", path, "column", nm)
    }
  }
  x
}

manifest_names <- c(
  "source_id", "title", "geography", "reporting_period", "source_organization",
  "path_or_url", "original_or_derived", "validation_status", "validator_role",
  "manuscript_role", "use_limitation"
)

claim_names <- c(
  "claim_id", "claim_text", "source_id", "claim_weight", "allowed_status",
  "scope_note", "manuscript_section", "status"
)

trace_names <- c(
  "trace_id", "source_id", "official_or_primary_location", "organization_to_verify",
  "verification_task", "status", "notes"
)

manifest <- read_checked_csv("assessments/manifest.csv", manifest_names)
claims <- read_checked_csv("assessments/citation_audit/source_claim_matrix.csv", claim_names)
trace <- read_checked_csv("assessments/citation_audit/official_source_trace.csv", trace_names)

assert_unique <- function(x, column, frame_name) {
  dup <- x[[column]][duplicated(x[[column]])]
  if (length(dup) > 0) {
    fail("Duplicate", column, "in", frame_name, paste(unique(dup), collapse = ", "))
  }
}

assert_allowed <- function(x, column, allowed, frame_name) {
  bad <- setdiff(unique(x[[column]]), allowed)
  if (length(bad) > 0) {
    fail("Invalid", column, "in", frame_name, paste(bad, collapse = ", "))
  }
}

assert_unique(manifest, "source_id", "manifest")
assert_unique(claims, "claim_id", "source_claim_matrix")
assert_unique(trace, "trace_id", "official_source_trace")

assert_allowed(manifest, "original_or_derived", c("original", "secondary", "derived", "unknown"), "manifest")
assert_allowed(
  manifest,
  "validation_status",
  c(
    "primary_verified", "primary_verified_pending_file",
    "trend_verified", "trend_verified_pending_file",
    "context_verified", "context_verified_pending_file",
    "background_only", "background_only_pending_file",
    "restricted_pending_geography", "excluded", "unverified"
  ),
  "manifest"
)
assert_allowed(
  manifest,
  "validator_role",
  c(
    "core_household_validator", "local_hotspot_validator", "indicative_trend_validator",
    "infrastructure_recovery_validator", "background_mechanism_validator", "excluded_or_restricted"
  ),
  "manifest"
)
assert_allowed(claims, "claim_weight", c("high", "medium", "low", "none"), "source_claim_matrix")
assert_allowed(
  claims,
  "allowed_status",
  c("allowed", "allowed_local_only", "allowed_indicative_only", "allowed_context", "allowed_background_only", "blocked_pending_scope"),
  "source_claim_matrix"
)
assert_allowed(trace, "status", c("pending", "pending_blocked", "verified", "blocked", "needs_revision"), "official_source_trace")

unknown_claim_sources <- setdiff(claims$source_id, manifest$source_id)
if (length(unknown_claim_sources) > 0) {
  fail("Claims reference unknown source_id(s):", paste(unknown_claim_sources, collapse = ", "))
}

unknown_trace_sources <- setdiff(trace$source_id, manifest$source_id)
if (length(unknown_trace_sources) > 0) {
  fail("Trace references unknown source_id(s):", paste(unknown_trace_sources, collapse = ", "))
}

missing_claim_sources <- setdiff(manifest$source_id, claims$source_id)
if (length(missing_claim_sources) > 0) {
  fail("Manifest source_id(s) missing from claim matrix:", paste(missing_claim_sources, collapse = ", "))
}

missing_trace_sources <- setdiff(manifest$source_id, trace$source_id)
if (length(missing_trace_sources) > 0) {
  fail("Manifest source_id(s) missing from official trace:", paste(missing_trace_sources, collapse = ", "))
}

joined <- merge(claims, manifest[, c("source_id", "validator_role", "validation_status")], by = "source_id")

bad_local <- joined$validator_role == "local_hotspot_validator" & joined$allowed_status != "allowed_local_only"
if (any(bad_local)) fail("Local hotspot claim(s) must be allowed_local_only:", paste(joined$claim_id[bad_local], collapse = ", "))

bad_trend <- joined$validator_role == "indicative_trend_validator" & joined$allowed_status != "allowed_indicative_only"
if (any(bad_trend)) fail("Trend claim(s) must be allowed_indicative_only:", paste(joined$claim_id[bad_trend], collapse = ", "))

bad_background <- joined$validator_role == "background_mechanism_validator" & joined$claim_weight == "high"
if (any(bad_background)) fail("Background claim(s) cannot carry high weight:", paste(joined$claim_id[bad_background], collapse = ", "))

bad_restricted <- joined$validator_role == "excluded_or_restricted" & joined$allowed_status != "blocked_pending_scope"
if (any(bad_restricted)) fail("Restricted claim(s) must remain blocked_pending_scope:", paste(joined$claim_id[bad_restricted], collapse = ", "))

path_ok <- grepl("^assessments/", manifest$path_or_url) | grepl("^https?://", manifest$path_or_url)
if (any(!path_ok)) {
  fail("Manifest path_or_url outside assessments/ or URL:", paste(manifest$source_id[!path_ok], collapse = ", "))
}

message("Data-frame validation passed.")
message("Manifest sources checked: ", nrow(manifest))
message("Claim rows checked: ", nrow(claims))
message("Official trace rows checked: ", nrow(trace))
