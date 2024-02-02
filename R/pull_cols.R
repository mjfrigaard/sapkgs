#' Pull names of column by type
#'
#' @param df a `data.frame` or `tibble`
#' @param type one of `bin`, `cat`, `num`, or `facet`
#'
#' @return a named character vector of column names by type
#'
#' @export
#'
#' @examples
#' require(palmerpenguins)
#' pull_cols(palmerpenguins::penguins, "bin")
#' pull_cols(palmerpenguins::penguins, "cat")
#' pull_cols(palmerpenguins::penguins, "facet")
pull_cols <- function(df, type) {
  switch(type,
    bin = pull_binary_cols(df = df),
    cat = pull_cat_cols(df = df),
    num = pull_numeric_cols(df = df),
    facet = pull_facet_cols(df = df),
  )
}
