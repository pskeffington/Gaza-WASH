#!/usr/bin/env Rscript

# Validate manuscript-facing tabular artifacts for the Gaza WASH project.
# Scope: file presence, CSV readability, schema, primary keys, joins, controlled values, source-binding gates, and locator results.

fail <- function(...) stop(paste(...), call. = FALSE)

required_paths <- c(
  "ROADMAP.md",
  "docs/source_audit.md",
  "assessments/manifest.csv",
  "assessments/citation_audit/source_claim_matrix.csv",
  "assessments/citation_audit/official_source_trace.csv",
  "assessments/citation_audit/source_binding_status.csv",
  "assessments/citation_audit/source_locator_results.csv",
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

binding_names <- c(
  "source_id", "expected_path", "local_file_status", "public_record_status",
  "page_binding_status", "manuscript_gate", "next_action"
)

locator_names <- c(
  "locator_id", "target_source_id", "query_focus", "result_type", "candidate_title",
  "candidate_url", "candidate_role", "verification_status", "notes"
)

manifest <- read_checked_csv("assessments/manifest.csv", manifest_names)
claims <- read_checked_csv("assessments/citation_audit/source_claim_matrix.csv", claim_names)
trace <- read_checked_csv("assessments/citation_audit/official_source_trace.csv", trace_names)
binding <- read_checked_csv("assessments/citation_audit/source_binding_status.csv", binding_names)
locator <- read_checked_csv("assessments/citation_audit/source_locator_results.csv", locator_names)

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
assert_unique(binding, "source_id", "source_binding_status")
assert_unique(locator, "locator_id", "source_locator_results")

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
    "core_household_validator", "local_hotspot_validator", "local_water_quality_validator", "indicative_trend_validator",
    "infrastructure_recovery_validator", "political_economy_context_validator", "background_mechanism_validator", "excluded_or_restricted"
  ),
  "manifest"
)
assert_allowed(claims, "claim_weight", c("high", "medium", "low", "none"), "source_claim_matrix")
assert_allowed(
  claims,
  "allowed_status",
  c("allowed", "allowed_local_only", "allowed_local_water_quality_only", "allowed_indicative_only", "allowed_context", "allowed_political_economy_context", "allowed_background_only", "blocked_pending_scope"),
  "source_claim_matrix"
)
assert_allowed(trace, "status", c("pending", "pending_blocked", "verified", "blocked", "needs_revision"), "official_source_trace")
assert_allowed(binding, "local_file_status", c("present", "missing", "unknown_not_checked", "uploaded_not_committed"), "source_binding_status")
assert_allowed(binding, "public_record_status", c("verified", "uploaded_file_verified", "secondary_record_found", "not_located", "scope_unresolved"), "source_binding_status")
assert_allowed(binding, "page_binding_status", c("bound", "blocked", "not_required"), "source_binding_status")
assert_allowed(
  binding,
  "manuscript_gate",
  c("allowed", "do_not_promote_claims", "context_only_pending_official_url", "do_not_cite", "excluded_pending_scope"),
  "source_binding_status"
)
assert_allowed(locator, "result_type", c("official_match", "secondary_match", "official_context", "secondary_context", "no_exact_match"), "source_locator_results")
assert_allowed(locator, "verification_status", c("located_official", "located_secondary", "located_secondary_only", "not_located", "scope_unresolved"), "source_locator_results")

for (frame in list(claims = claims, trace = trace, binding = binding)) {
  unknown <- setdiff(frame$source_id, manifest$source_id)
  if (length(unknown) > 0) fail("Frame references unknown source_id(s):", paste(unknown, collapse = ", "))
}

unknown_locator <- setdiff(locator$target_source_id, manifest$source_id)
if (length(unknown_locator) > 0) fail("Locator references unknown source_id(s):", paste(unknown_locator, collapse = ", "))

for (frame_name in c("claims", "trace", "binding")) {
  frame <- get(frame_name)
  missing_source <- setdiff(manifest$source_id, frame$source_id)
  if (length(missing_source) > 0) fail("Manifest source_id(s) missing from", frame_name, paste(missing_source, collapse = ", "))
}

joined <- merge(claims, manifest[, c("source_id", "validator_role", "validation_status")], by = "source_id")
joined <- merge(joined, binding[, c("source_id", "page_binding_status", "manuscript_gate")], by = "source_id")

bad_local <- joined$validator_role == "local_hotspot_validator" & joined$allowed_status != "allowed_local_only"
if (any(bad_local)) fail("Local hotspot claim(s) must be allowed_local_only:", paste(joined$claim_id[bad_local], collapse = ", "))

bad_water_quality <- joined$validator_role == "local_water_quality_validator" & joined$allowed_status != "allowed_local_water_quality_only"
if (any(bad_water_quality)) fail("Local water-quality claim(s) must be allowed_local_water_quality_only:", paste(joined$claim_id[bad_water_quality], collapse = ", "))

bad_trend <- joined$validator_role == "indicative_trend_validator" & joined$allowed_status != "allowed_indicative_only"
if (any(bad_trend)) fail("Trend claim(s) must be allowed_indicative_only:", paste(joined$claim_id[bad_trend], collapse = ", "))

bad_pe <- joined$validator_role == "political_economy_context_validator" & joined$allowed_status != "allowed_political_economy_context"
if (any(bad_pe)) fail("Political-economy claim(s) must be allowed_political_economy_context:", paste(joined$claim_id[bad_pe], collapse = ", "))

bad_background <- joined$validator_role == "background_mechanism_validator" & joined$claim_weight == "high"
if (any(bad_background)) fail("Background claim(s) cannot carry high weight:", paste(joined$claim_id[bad_background], collapse = ", "))

bad_restricted <- joined$validator_role == "excluded_or_restricted" & joined$allowed_status != "blocked_pending_scope"
if (any(bad_restricted)) fail("Restricted claim(s) must remain blocked_pending_scope:", paste(joined$claim_id[bad_restricted], collapse = ", "))

bad_promoted <- joined$page_binding_status != "bound" & joined$status == "ready_for_manuscript"
if (any(bad_promoted)) fail("Unbound claim(s) marked ready_for_manuscript:", paste(joined$claim_id[bad_promoted], collapse = ", "))

located_locator <- locator$verification_status %in% c("located_official", "located_secondary", "located_secondary_only")
missing_locator_url <- located_locator & !grepl("^https?://", locator$candidate_url)
if (any(missing_locator_url)) fail("Located locator row(s) missing candidate URL:", paste(locator$locator_id[missing_locator_url], collapse = ", "))

path_ok <- grepl("^assessments/", manifest$path_or_url) | grepl("^https?://", manifest$path_or_url)
if (any(!path_ok)) fail("Manifest path_or_url outside assessments/ or URL:", paste(manifest$source_id[!path_ok], collapse = ", "))

binding_path_ok <- grepl("^assessments/", binding$expected_path) | binding$expected_path == "not_applicable"
if (any(!binding_path_ok)) fail("Binding expected_path outside assessments/:", paste(binding$source_id[!binding_path_ok], collapse = ", "))

message("Data-frame validation passed.")
message("Manifest sources checked: ", nrow(manifest))
message("Claim rows checked: ", nrow(claims))
message("Official trace rows checked: ", nrow(trace))
message("Source binding rows checked: ", nrow(binding))
message("Locator rows checked: ", nrow(locator))
