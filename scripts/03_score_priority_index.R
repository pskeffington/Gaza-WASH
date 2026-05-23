# 03_score_priority_index.R
# Purpose: compute Gaza WASH--Health priority scores from the scoring template.

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(janitor)
})

input_path <- "tables/index_scoring_template.csv"
out_path <- "tables/index_scores.csv"

score_cols <- c(
  "wash_service_stress",
  "environmental_health_hazard",
  "health_system_access_constraint",
  "population_vulnerability",
  "operational_access_constraint"
)

priority_class <- function(score) {
  case_when(
    is.na(score) ~ NA_character_,
    score <= 3 ~ "lower_priority",
    score <= 6 ~ "moderate_priority",
    score <= 10 ~ "high_priority",
    TRUE ~ "invalid_score"
  )
}

scores <- read_csv(input_path, show_col_types = FALSE) |>
  clean_names()

missing_cols <- setdiff(score_cols, names(scores))

if (length(missing_cols) > 0) {
  stop(
    "Missing required score columns: ",
    paste(missing_cols, collapse = ", ")
  )
}

scores_checked <- scores |>
  mutate(across(all_of(score_cols), as.numeric))

invalid_scores <- scores_checked |>
  filter(if_any(all_of(score_cols), ~ !is.na(.x) & !(.x %in% c(0, 1, 2))))

if (nrow(invalid_scores) > 0) {
  stop("Invalid domain score detected. Domain scores must be 0, 1, 2, or NA.")
}

index_scores <- scores_checked |>
  rowwise() |>
  mutate(
    total_priority_score = if_else(
      all(is.na(c_across(all_of(score_cols)))),
      NA_real_,
      sum(c_across(all_of(score_cols)), na.rm = TRUE)
    ),
    priority_class = priority_class(total_priority_score)
  ) |>
  ungroup() |>
  arrange(desc(total_priority_score), area_name)

write_csv(index_scores, out_path)

message("Priority index scores written to: ", out_path)
