#' Binary app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of binary column names
#'
#' @examples
#' pull_binary_cols(palmerpenguins::penguins)
#' pull_binary_cols(dplyr::starwars)
#' 
#' @export pull_binary_cols
#' 
pull_binary_cols <- function(df) {
  # logical
  log_bins <- get_column_class(df, "log") |>
    make_binary_vec("log")
  # integer
  int_bins <- get_column_class(df, "int") |>
    make_binary_vec("int")
  # character
  chr_bins <- get_column_class(df, "chr") |>
    make_binary_vec("chr")
  # factors
  fct_bins <- get_column_class(df, "fct") |>
    make_binary_vec("fct")
  # assemble
  all_bins <- list(log_bins, int_bins, chr_bins, fct_bins)
  # reduce
  bins_list <- purrr::compact(all_bins)
  # vector
  bins <- purrr::list_c(bins_list)
  return(bins)
}