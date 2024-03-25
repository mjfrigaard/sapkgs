## code to prepare `diamonds` dataset goes here
# this is just used to load diamonds without needing to load ggplot2
library(vroom)
diamonds <- vroom::vroom(
  "https://raw.githubusercontent.com/tidyverse/ggplot2/main/data-raw/diamonds.csv", col_types =
  list(
    cut = col_factor(c("Fair", "Good", "Very Good", "Premium", "Ideal"), TRUE),
    color = col_factor(c("D", "E", "F", "G", "H", "I", "J"), TRUE),
    clarity = col_factor(c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"), TRUE)
  )
)
usethis::use_data(diamonds, overwrite = TRUE)
