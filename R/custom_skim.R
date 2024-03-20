#' Custom `skimr::skim()` for numeric variables
#'
#' @description
#' A custom `skimr::skim_with()` for numeric variables.
#'
#' @export custom_skim
#'
#' @examples
#' require(dplyr)
#' custom_skim(dplyr::starwars)
custom_skim <- function(x) {
  skims <- list(numeric = skimr::sfl(min = ~ min(., na.rm = TRUE),
                                     med = ~ median(., na.rm = TRUE),
                                     max = ~ max(., na.rm = TRUE),
                                     p0 = NULL, 
                                     p25 = NULL, 
                                     p50 = NULL,
                                     p75 = NULL, 
                                     p100 = NULL),
                factor = skimr::sfl(ordered = NULL),
                character = skimr::sfl(min = NULL, 
                                       max = NULL,
                                       whitespace = NULL))
  my_skim <- skimr::skim_with(!!!skims)
  my_skim(x)
}