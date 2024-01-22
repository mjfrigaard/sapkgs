#' Make UI inputs
#'
#' @description
#' This is meant to be used in the console--it generates the code for assigning
#' the elements from a list into a collection of vectors.
#'
#' @param app_data dataset for app (`data.frame` or `tibble`)
#'
#' @return zeallot assignment (`%<-%`) with input character vector on LHS and
#'    list of names by type on the RHS
#'
#' @export make_ui_inputs
#'
#' @examples
#' require(palmerpenguins)
#' make_ui_inputs(palmerpenguins::penguins)
#' require(zeallot)
#' c(double_vars, integer_vars, factor_vars) %<-%
#'   list(
#'     double_vars = c("bill_length_mm", "bill_depth_mm"),
#'     integer_vars = c("flipper_length_mm", "body_mass_g", "year"),
#'     factor_vars = c("species", "island", "sex")
#'   )
#' double_vars
#' integer_vars
#' factor_vars
make_ui_inputs <- function(app_data) {
  ui_inputs <- names(col_type_list(df = app_data))
  lhs_out <- deconstruct(x = ui_inputs, return = TRUE, quote = FALSE)
  zeallot_operator <- deconstruct(x = "%<-%", return = TRUE, quote = FALSE)
  rhs_out <- deconstruct(x = col_type_list(df = app_data), return = TRUE)
  cat(lhs_out, zeallot_operator, rhs_out)
}