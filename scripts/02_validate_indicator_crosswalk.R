# 02_validate_indicator_crosswalk.R
# Purpose: validate the indicator crosswalk before extraction and scoring.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(janitor)
})

crosswalk_path <- "tables/indicator_crosswalk.csv"
out_path <- "tables/indicator_crosswalk_validated.csv"

required_cols <- c(
  "indicator_id",
  "domain",
  "indicator_name",
  "definition",
  "preferred_geography",
  "preferred_time_unit",
  "source_class",
  "source_name",
  "source_url",
  "raw_field_name",
  "standardized_field_name",
  "score_rule",
  "score_values",
  "verification_status",
  "notes"
)

valid_domains <- c(
  "WASH service stress",
  "Environmental health hazard",
  "Health-system access",
  "Population vulnerability",
  "Operational access constraint"
)

indicator_crosswalk <- read_csv(crosswalk_path, show_col_types = FALSE) |>
  clean_names()

missing_cols <- setdiff(required_cols, names(indicator_crosswalk))

if (length(missing_cols) > 0) {
  stop(
    "Missing required indicator crosswalk columns: ",
    paste(missing_cols, collapse = ", ")
  )
}

invalid_domains <- setdiff(unique(indicator_crosswalk$domain), valid_domains)

if (length(invalid_domains) > 0) {
  stop(
    "Invalid domain values detected: ",
    paste(invalid_domains, collapse = ", ")
  )
}

indicator_crosswalk_validated <- indicator_crosswalk |>
  mutate(
    indicator_id = as.character(indicator_id),
    indicator_name = as.character(indicator_name),
    verification_status = if_else(
      is.na(verification_status) | verification_status == "",
      "pending",
      verification_status
    )
  ) |>
  arrange(domain, indicator_id)

if (anyDuplicated(indicator_crosswalk_validated$indicator_id) > 0) {
  stop("Duplicate indicator_id values detected.")
}

write_csv(indicator_crosswalk_validated, out_path)

message("Validated indicator crosswalk written to: ", out_path)
