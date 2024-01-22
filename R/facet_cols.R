#' Facet checks (helper)
#'
#' @param x a vector
#' @param type type of column to return.
#'
#' @return TRUE/FALSE if facet variable (< 5 levels)
#' @export check_facet_vec
#'
#' @examples
#' require(NHANES)
#' check_facet_vec(NHANES::NHANES$Education, type = "fct")
#' levels(NHANES::NHANES$Education)
#' check_facet_vec(NHANES::NHANES$MaritalStatus, type = "fct")
#' levels(NHANES::NHANES$MaritalStatus)
check_facet_vec <- function(x, type) {
  check_chr_facet <- function(x) {
    length(unique(na.omit(x))) <= 4
  }
  check_fct_facet <- function(x) {
    length(unique(na.omit(x))) <= 4
  }
  switch(type,
    chr = check_chr_facet(x),
    ord = check_fct_facet(x),
    fct = check_fct_facet(x)
  )
}

#' Create vector of facet columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of facet columns (< 5 levels)
#' @export make_facet_vec
#'
#' @importFrom purrr set_names map_vec
#' @importFrom cli cli_alert_info
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