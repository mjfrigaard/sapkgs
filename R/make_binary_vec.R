#' Create vector of binary columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of binary columns
#'
#' @export make_binary_vec
#'
#'
#' @examples
#' require(palmerpenguins)
#' make_binary_vec(
#'   df = dplyr::select(
#'     palmerpenguins::penguins,
#'     dplyr::where(is.factor)
#'   ),
#'   type = "fct"
#' )
make_binary_vec <- function(df, type) {
  if (ncol(df) < 1) {
    return(character())
  } else {
    nms <- names(df)
    bin_set <- sapply(df, check_binary_vec, type = type)
    bins <- nms[bin_set]
  }
  return(setNames(object = bins, nm = bins))
}
