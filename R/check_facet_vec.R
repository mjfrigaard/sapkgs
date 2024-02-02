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
