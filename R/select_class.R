#' Select Column Class
#'
#' `select_class()` selects columns from a data.frame based on the specified
#' `class`. Options include logical, integer, double, character, factor, ordered,
#' and list column types.
#'
#' @param df A `data.frame` from which columns will be selected.
#' @param class Character vector specifying the class(es) of columns to select.
#'   Supported values are:
#'   * "logical" ("lo")
#'   * "integer" ("in")
#'   * "double" ("do")
#'   * "character" ("ch")
#'   * "factor" ("fa")
#'   * "ordered" ("or")
#'   * "list" ("li")
#'
#' @param return_tbl Logical indicating whether to return the result as a
#'   `data.frame`. If `FALSE`, a vector of selected column names is returned.
#'
#' @return A `data.frame` or vector of column names, depending on `return_tbl`.
#'
#' @examples
#' data(iris)
#' head(select_class(iris, "numeric"))
#' head(select_class(iris, "factor"))
#' select_class(iris, c("factor", "numeric"), FALSE)
#'
#' @export
select_class <- function(df, class, return_tbl = TRUE) {
  if (!is.data.frame(df)) stop("df must be a dataframe")

  # define classes
  valid_classes <- c("logical", "integer", "double", "numeric", "character",
                     "factor", "ordered", "list")
  class <- match.arg(class, choices = valid_classes, several.ok = TRUE)

  # helper function to check classes
  is_class <- function(x, cls) {
    cls <- match(cls, valid_classes)
    cls_name <- valid_classes[cls]
    switch(cls_name,
           logical = is.logical(x),
           integer = is.integer(x),
           double = is.double(x),
           numeric = is.numeric(x),
           character = is.character(x),
           factor = is.factor(x),
           ordered = is.ordered(x),
           list = is.list(x),
           FALSE)
  }

  selected_cols <- sapply(df, function(x) any(sapply(class, is_class, x = x)))

  col_names <- names(df)[selected_cols]

  if (return_tbl) {
    return(df[, col_names, drop = FALSE])
  } else {
    return(setNames(object = col_names, nm = col_names))
  }
}
