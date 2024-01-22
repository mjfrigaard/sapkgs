#' Categorical app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of character and factor column names
#'
#' @examples
#' pull_cat_cols(palmerpenguins::penguins)
#' pull_cat_cols(dplyr::starwars)
#' 
#' @export pull_cat_cols
#' 
pull_cat_cols <- function(df) {
  chrs <- get_column_class(df = df, class = "chr", return_tbl = FALSE)
  # factors
  fcts <- get_column_class(df = df, class = "fct", return_tbl = FALSE)
  # assemble
  all_chrs_fcts_list <- list(chrs, fcts)
  # reduce
  chrs_fcts_list <- purrr::compact(all_chrs_fcts_list)
  # vector
  chrs_fcts <- purrr::list_c(chrs_fcts_list) |> sort()
  if (is.null(chrs_fcts)) {
    NULL
  } else {
    # name
    cats <- purrr::set_names(chrs_fcts)
    return(cats)
  }
}