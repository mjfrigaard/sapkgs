#' Categorical app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of character and factor column names
#'
#' @export pull_cat_cols
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' pull_cat_cols(palmerpenguins::penguins)
#' pull_cat_cols(dplyr::starwars)
pull_cat_cols <- function(df) {
  chrs <- select_class(df = df, class = "character", return_tbl = FALSE)
  # factors
  fcts <- select_class(df = df, class = "factor", return_tbl = FALSE)
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
