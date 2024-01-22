#' Facet app inputs
#'
#' @section Variables to use for facets:
#'
#' This function is designed to quickly determine which variables have an
#' appropriate number of categorical levels for using `ggplot2::facet_wrap()`
#' or `ggplot2::facet_grid()`
#'
#' @param df a `data.frame` or `tibble`
#'
#'
#' @return a named character vector or column from with < 5 unique levels
#' 
#'
#'
#' @examples
#' require(dplyr)
#' require(NHANES)
#' pull_facet_cols(df = dplyr::starwars)
#' pull_facet_cols(df = NHANES::NHANES)
#'
#' str(dplyr::select(
#'   dplyr::starwars,
#'   dplyr::all_of(pull_facet_cols(df = dplyr::starwars))
#' ))
#' str(dplyr::select(
#'   NHANES::NHANES,
#'   dplyr::all_of(pull_facet_cols(df = NHANES::NHANES))
#' ))
#' 
#' @export pull_facet_cols
#' 
pull_facet_cols <- function(df) {
  # get bins
  bins <- pull_binary_cols(df)
  # character
  chr_facets <- get_column_class(df, "chr") |> make_facet_vec("chr")
  # factors
  fct_facets <- get_column_class(df, "fct") |> make_facet_vec("fct")
  # assemble
  all_facets_list <- list(chr_facets, fct_facets)
  # reduce
  facets_list <- purrr::compact(all_facets_list)
  # vector
  all_facets <- purrr::list_c(facets_list)
  # reduce
  facets <- all_facets[all_facets %nin% bins]
  return(facets)
}