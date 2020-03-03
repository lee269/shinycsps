## code to prepare `core_questions` dataset goes here
library(dplyr)

core_questions <- readr::read_csv(here::here("data-raw", "core_questions.csv"))

usethis::use_data(core_questions)
