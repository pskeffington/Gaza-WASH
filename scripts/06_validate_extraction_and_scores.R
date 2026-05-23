# 06_validate_extraction_and_scores.R
# Purpose: validate populated extraction rows and score consistency.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(janitor)
})

extraction_path <- "tables/manual_extraction_template.csv"
index_path <- "tables/index_scores.csv"
report_path <- "tables/validation_report.csv"

required_extraction_cols <- c(
  "extraction_id",
  "source_id",
  "source_name",
  "source_url",
  "source_date",
  "access_date",
  "geography",
  "indicator_id",
  "indicator_name",
  "raw_text_or_value",
  "standardized_value",
  "score",
  "score_justification",
  "page_or_location",
  "extractor",
  "verification_status",
  "notes"
)

required_index_cols <- c(
  "area_id",
  "area_name",
  "geography_type",
  "score_date",
  "wash_service_stress",
  "environmental_health_hazard",
  "health_system_access_constraint",
  "population_vulnerability",
  "operational_access_constraint",
  "total_priority_score",
  "priority_class",
  "source_count",
  "verification_status",
  "notes"
)

valid_domain_scores <- c(0, 1, 2)
valid_priority_classes <- c("lower_priority", "moderate_priority", "high_priority")

extraction <- read_csv(extraction_path, show_col_types = FALSE) |>
  clean_names()

index_scores <- read_csv(index_path, show_col_types = FALSE) |>
  clean_names()

missing_extraction_cols <- setdiff(required_extraction_cols, names(extraction))
missing_index_cols <- setdiff(required_index_cols, names(index_scores))

if (length(missing_extraction_cols) > 0) {
  stop("Missing extraction columns: ", paste(missing_extraction_cols, collapse = ", "))
}

if (length(missing_index_cols) > 0) {
  stop("Missing index-score columns: ", paste(missing_index_cols, collapse = ", "))
}

if (nrow(extraction) == 0) {
  stop("Extraction table has no rows.")
}

if (anyDuplicated(extraction$extraction_id) > 0) {
  stop("Duplicate extraction_id values detected.")
}

extraction_checked <- extraction |>
  mutate(score = as.numeric(score))

bad_extraction_scores <- extraction_checked |>
  filter(is.na(score) | !(score %in% valid_domain_scores))

if (nrow(bad_extraction_scores) > 0) {
  stop("Extraction scores must be 0, 1, or 2.")
}

unverified_rows <- extraction_checked |>
  filter(is.na(verification_status) | verification_status == "" | verification_status == "pending")

score_cols <- c(
  "wash_service_stress",
  "environmental_health_hazard",
  "health_system_access_constraint",
  "population_vulnerability",
  "operational_access_constraint"
)

index_checked <- index_scores |>
  mutate(across(all_of(score_cols), as.numeric)) |>
  mutate(total_priority_score = as.numeric(total_priority_score))

bad_domain_scores <- index_checked |>
  filter(if_any(all_of(score_cols), ~ is.na(.x) | !(.x %in% valid_domain_scores)))

if (nrow(bad_domain_scores) > 0) {
  stop("Index domain scores must be 0, 1, or 2.")
}

index_recalculated <- index_checked |>
  rowwise() |>
  mutate(recalculated_total = sum(c_across(all_of(score_cols)))) |>
  ungroup()

bad_totals <- index_recalculated |>
  filter(total_priority_score != recalculated_total)

if (nrow(bad_totals) > 0) {
  stop("Index total_priority_score does not match summed domain scores.")
}

bad_priority_classes <- index_recalculated |>
  filter(!(priority_class %in% valid_priority_classes))

if (nrow(bad_priority_classes) > 0) {
  stop("Invalid priority_class values detected.")
}

validation_report <- tibble::tibble(
  check = c(
    "extraction_rows",
    "unique_extraction_ids",
    "unverified_or_pending_extraction_rows",
    "index_rows",
    "index_totals_recalculated",
    "priority_classes_valid"
  ),
  value = c(
    as.character(nrow(extraction_checked)),
    as.character(length(unique(extraction_checked$extraction_id))),
    as.character(nrow(unverified_rows)),
    as.character(nrow(index_recalculated)),
    "pass",
    "pass"
  ),
  status = c(
    "pass",
    "pass",
    if_else(nrow(unverified_rows) == 0, "pass", "warning"),
    "pass",
    "pass",
    "pass"
  )
)

write_csv(validation_report, report_path)

message("Extraction and score validation complete. Report written to: ", report_path)
