#' Get number of data.frame columns by type
#'
#' @param df `data.frame` or `tibble`
#' @param type column type, one of: "num", "chr", "fct", "log",
#' "lst".
#'
#' @return count of columns by type
#' 
#' @export 
#'
#' @examples
#' require(dplyr)
#' col_type_count(mtcars, "num")
#' col_type_count(dplyr::starwars, "chr")
col_type_count <- function(df, type) {
  # determine the type of each column
  col_types <- sapply(df, class)
  
  # count columns based on the specified type
  count <- 0
  switch(EXPR = type,
    chr = {count <- sum(col_types == "character")},
    num = {count <- sum(col_types == "numeric")},
    int = {count <- sum(col_types == "integer")}, # Adding integer type
    fct = {count <- sum(col_types == "factor")},
    log = {count <- sum(col_types == "logical")},
    lst = {count <- sum(col_types == "list")}
  )
  
  # return the count
  return(count)
}
# col_type_count <- function(df, type) {
#   switch(EXPR = type,
#     chr = ncol(dplyr::select(df, dplyr::where(is.character))),
#     num = ncol(dplyr::select(df, dplyr::where(is.numeric))),
#     fct = ncol(dplyr::select(df, dplyr::where(is.factor))),
#     log = ncol(dplyr::select(df, dplyr::where(is.logical))),
#     lst = ncol(dplyr::select(df, dplyr::where(is.list)))
#     )
# }
