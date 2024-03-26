#' Get the results from `data(package = [package])`
#'
#' @param pkg name of package
#'
#' @return metadata table of data object
#'
#' @export pkg_data_results
#'
#'
#' @examples
#' pkg_data_results("lubridate")
#' pkg_data_results("dplyr")
pkg_data_results <- function(pkg) {
  # load the package namespace quietly
  check_pkg_ns(pkg = pkg, quiet = TRUE)
  
  # obtain data about available datasets in the package
  pkg_data <- data(package = pkg)$results
  if (is.null(pkg_data) || nrow(pkg_data) == 0) {
    # if no data found, create an empty data.frame 
    # with specified columns
    results <- data.frame(
      Package = character(), 
      Item = character(), 
      Title = character(), 
      Class = character(), 
      Columns = integer(), 
      Rows = integer(), 
      Logical = integer(), 
      Numeric = integer(), 
      Character = integer(), 
      Factor = integer(), 
      List = integer()
    )
  } else {
    # Create a data frame from the results
    results <- data.frame(
      Package = pkg_data[, "Package"],
      Item = pkg_data[, "Item"],
      Title = pkg_data[, "Title"]
    )
    return(results)
  }
}
# pkg_data_results <- function(pkg) {
#   # load packages
#   check_pkg_ns(pkg = pkg, quiet = TRUE)
# 
#   results <- tibble::as_tibble(
#     data.frame(
#       Package = data(package = pkg)$results[, "Package"],
#       Item = data(package = pkg)$results[, "Item"],
#       Title = data(package = pkg)$results[, "Title"],
#       stringsAsFactors = FALSE,
#       check.names = FALSE,
#       row.names = NULL
#     )
#   )
# 
#   if (nrow(results) == 0) {
# 
#   data_results <- tibble::as_tibble(
#     data.frame(
# 		matrix(
# 			nrow = 1, ncol = 11,
# 			byrow = TRUE,
# 			dimnames = list(NULL,
# 			  c("Package", "Item", "Title",
# 			    "Class", "Columns", "Rows",
# 			    "Logical", "Numeric",
# 			    "Character", "Factor",
# 			    "List"))
# 				),
# 		row.names = NULL))
# 
#     return(data_results)
# 
# 
#   } else {
# 
#     results
# 
#   }
# 
# }
