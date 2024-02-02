#' Create vector of facet columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of facet columns (< 5 levels)
#'
#' @export make_facet_vec
#'
#'
#' @examples
#' require(NHANES)
#' require(dplyr)
#' facets <- make_facet_vec(
#'   df = dplyr::select(
#'     NHANES::NHANES,
#'     dplyr::where(is.factor)),
#'   type = "fct")
#' facets
make_facet_vec <- function(df, type) {
  if (ncol(df) < 1) {
    return(purrr::set_names(vector(mode = "character")))
  } else {
    nms <- names(df)
    # set names in names
    dm_nms <- purrr::set_names(nms)
    facet_set <- purrr::map_vec(
      .x = df,
      .f = check_facet_vec,
      type = type
    )
    if (sum(facet_set) < 1) {
      facets <- purrr::set_names(vector(mode = "character"))
    } else {
      facets <- purrr::set_names(dm_nms[facet_set])
    }
  }
  return(facets)
}
