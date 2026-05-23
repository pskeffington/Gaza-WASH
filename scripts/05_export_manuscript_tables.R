# 05_export_manuscript_tables.R
# Purpose: export manuscript-ready LaTeX table fragments from validated CSV files.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(knitr)
})

ensure_dir <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
}

write_latex_table <- function(data, path, caption, label) {
  table_text <- capture.output(
    kable(
      data,
      format = "latex",
      booktabs = TRUE,
      longtable = FALSE,
      caption = caption,
      label = label,
      escape = TRUE
    )
  )

  header <- c(
    "% ************************************************************",
    paste0("% ", toupper(label)),
    "% ************************************************************"
  )

  footer <- c(
    "% ************************************************************",
    paste0("% END ", toupper(label)),
    "% ************************************************************"
  )

  writeLines(c(header, table_text, footer), path)
}

ensure_dir("manuscript/tables")

source_inventory <- read_csv("tables/source_inventory_validated.csv", show_col_types = FALSE)
indicator_crosswalk <- read_csv("tables/indicator_crosswalk_validated.csv", show_col_types = FALSE)
index_scores <- read_csv("tables/index_scores.csv", show_col_types = FALSE)
sensitivity_scores <- read_csv("tables/sensitivity.csv", show_col_types = FALSE)

source_table <- source_inventory |>
  select(source_name, source_owner, geography, variable_class, extraction_method, verification_status)

indicator_table <- indicator_crosswalk |>
  select(domain, indicator_id, indicator_name, standardized_field_name, score_rule, verification_status)

priority_table <- index_scores |>
  select(area_name, geography_type, score_date, wash_service_stress, environmental_health_hazard,
         health_system_access_constraint, population_vulnerability, operational_access_constraint,
         total_priority_score, priority_class, verification_status)

sensitivity_table <- sensitivity_scores |>
  select(area_name, equal_weight_score, equal_weight_class, wash_weighted_score, wash_weighted_class,
         health_access_weighted_score, health_access_weighted_class, classification_stable)

write_latex_table(
  source_table,
  "manuscript/tables/table1_source_inventory.tex",
  "Public source inventory for rapid Gaza WASH-health risk stratification.",
  "tab:source_inventory"
)

write_latex_table(
  indicator_table,
  "manuscript/tables/table2_indicator_crosswalk.tex",
  "Indicator crosswalk for the Gaza WASH-health priority index.",
  "tab:indicator_crosswalk"
)

write_latex_table(
  priority_table,
  "manuscript/tables/table3_priority_index.tex",
  "First-pass Gaza WASH-health priority index scores from public extracted indicators.",
  "tab:priority_index"
)

write_latex_table(
  sensitivity_table,
  "manuscript/tables/table4_sensitivity_analysis.tex",
  "Sensitivity analysis comparing equal-weight, WASH-weighted, and health-access-weighted priority scores.",
  "tab:sensitivity_analysis"
)

message("Manuscript table fragments written to manuscript/tables/.")
