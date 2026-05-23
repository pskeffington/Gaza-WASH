# 04_sensitivity_analysis.R
# Purpose: compare equal-weight, WASH-weighted, and health-access-weighted priority scores.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(janitor)
})

input_path <- "tables/index_scoring_template.csv"
out_path <- "tables/index_sensitivity_scores.csv"

score_cols <- c(
  "wash_service_stress",
  "environmental_health_hazard",
  "health_system_access_constraint",
  "population_vulnerability",
  "operational_access_constraint"
)

classify_priority <- function(score, max_score) {
  pct <- score / max_score
  case_when(
    is.na(score) ~ NA_character_,
    pct < 0.40 ~ "lower_priority",
    pct < 0.70 ~ "moderate_priority",
    pct <= 1.00 ~ "high_priority",
    TRUE ~ "invalid_score"
  )
}

scores <- read_csv(input_path, show_col_types = FALSE) |>
  clean_names() |>
  mutate(across(all_of(score_cols), as.numeric))

invalid_scores <- scores |>
  filter(if_any(all_of(score_cols), ~ !is.na(.x) & !(.x %in% c(0, 1, 2))))

if (nrow(invalid_scores) > 0) {
  stop("Invalid domain score detected. Domain scores must be 0, 1, 2, or NA.")
}

sensitivity_scores <- scores |>
  rowwise() |>
  mutate(
    equal_weight_score = sum(c_across(all_of(score_cols)), na.rm = TRUE),
    wash_weighted_score =
      (wash_service_stress * 2) +
      environmental_health_hazard +
      health_system_access_constraint +
      population_vulnerability +
      operational_access_constraint,
    health_access_weighted_score =
      wash_service_stress +
      environmental_health_hazard +
      (health_system_access_constraint * 2) +
      population_vulnerability +
      operational_access_constraint,
    equal_weight_class = classify_priority(equal_weight_score, 10),
    wash_weighted_class = classify_priority(wash_weighted_score, 12),
    health_access_weighted_class = classify_priority(health_access_weighted_score, 12)
  ) |>
  ungroup() |>
  arrange(desc(equal_weight_score), area_name)

write_csv(sensitivity_scores, out_path)

message("Sensitivity scores written to: ", out_path)
