# 01_build_source_inventory.R
# Purpose: validate and export the Gaza WASH source inventory.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(janitor)
})

source_path <- "tables/source_inventory.csv"
out_path <- "tables/source_inventory_validated.csv"

required_cols <- c(
  "source_id",
  "source_name",
  "source_owner",
  "source_url",
  "access_status",
  "geography",
  "time_period",
  "variable_class",
  "variables_expected",
  "update_frequency",
  "extraction_method",
  "manuscript_role",
  "verification_status",
  "access_date",
  "notes"
)

source_inventory <- read_csv(source_path, show_col_types = FALSE) |>
  clean_names()

missing_cols <- setdiff(required_cols, names(source_inventory))

if (length(missing_cols) > 0) {
  stop(
    "Missing required source inventory columns: ",
    paste(missing_cols, collapse = ", ")
  )
}

source_inventory_validated <- source_inventory |>
  mutate(
    source_id = as.character(source_id),
    source_name = as.character(source_name),
    source_url = as.character(source_url),
    verification_status = if_else(
      is.na(verification_status) | verification_status == "",
      "pending",
      verification_status
    )
  ) |>
  arrange(source_id)

if (anyDuplicated(source_inventory_validated$source_id) > 0) {
  stop("Duplicate source_id values detected.")
}

write_csv(source_inventory_validated, out_path)

message("Validated source inventory written to: ", out_path)
