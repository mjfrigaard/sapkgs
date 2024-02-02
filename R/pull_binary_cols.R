#' Pull binary app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of binary column names
#' @export pull_binary_cols
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' pull_binary_cols(palmerpenguins::penguins)
#' pull_binary_cols(dplyr::starwars)
pull_binary_cols <- function(df) {
  # logical
  log_bins <- select_class(df, "logical") |>
    make_binary_vec("log")
  # integer
  int_bins <- select_class(df, "integer") |>
    make_binary_vec("int")
  # character
  chr_bins <- select_class(df, "character") |>
    make_binary_vec("chr")
  # factors
  fct_bins <- select_class(df, "factor") |>
    make_binary_vec("fct")
  # assemble
  all_bins <- list(log_bins, int_bins, chr_bins, fct_bins)
  # reduce
  bins_list <- purrr::compact(all_bins)
  # vector
  bins <- purrr::list_c(bins_list)
  return(bins)
}
