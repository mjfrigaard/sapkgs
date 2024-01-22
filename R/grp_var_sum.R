#' Grouped variable summary
#'
#' @param data tibble (unquoted)
#' @param grp_var group variable (as quoted string)
#' @param var variable to summarize (as quoted string)
#'
#' @return tibble with summary statistics
#'
#' @export
#'
#'
#' @examples
#' require(palmerpenguins)
#' grp_var_sum(
#' data = palmerpenguins::penguins,
#' grp_var = "island",
#' var = "bill_length_mm")
grp_var_sum <- function(data, grp_var, var) {
  data |>
    dplyr::group_by(.data[[ grp_var ]]) |>
      dplyr::summarise(
        "Mean: {{var}}" := mean(x = .data[[ var ]], na.rm = TRUE),
        "SD: {{var}}" := sd(x = .data[[ var ]], na.rm = TRUE),
        "N: {{var}}" := dplyr::n())
}