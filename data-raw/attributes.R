## code to prepare `core_questions` dataset goes here
library(dplyr)

attributes <- readr::read_csv(here::here("data-raw", "attributes.csv"))

usethis::use_data(attributes)
