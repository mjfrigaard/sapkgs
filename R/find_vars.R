#' Find Variable Names Based on a Filter Function
#'
#' @description
#' This function applies a filter function to each column of a data frame
#' and returns the names of columns for which the filter function returns `TRUE`.
#'
#' @param data A data frame or list on which the `filter` will be applied.
#' @param filter A function that is applied to each column of `data`.
#'               It should return a logical vector of length 1.
#'
#' @return A character vector of column names for which the filter function
#'         returns `TRUE`.
#'
#' @examples
#' df <- data.frame(a = 1:10, b = letters[1:10], c = rnorm(10))
#' df
#' find_vars(df, is.numeric)  # Returns names of numeric columns
#' 
#' @keywords internal
#' 
#' @export find_vars
#'
find_vars <- function(data, filter) {
  names(data)[vapply(data, filter, logical(1))]
}
