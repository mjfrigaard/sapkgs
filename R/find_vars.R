#' Find variables
#'
#' @param data selected dataset
#' @param filter function for filtering data object
#'
#' @return filtered data
#' @export find_vars
#'
find_vars <- function(data, filter) {
  names(data)[vapply(data, filter, logical(1))]
}
