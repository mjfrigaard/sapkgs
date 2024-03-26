#' Get dataset structures from R package
#'
#' @param pkg name of package(s)
#'
#' @return dataset structure `tibble`
#'
#' @section The returned object has the following columns:
#'    * `Package`: name of package
#'    * `Dataset`: name of dataset
#'    * `Class`: class of dataset
#'    * `Columns`: total columns
#'    * `Rows`: total rows
#'
#' @export
#'
#' @examples
#' require(forcats)
#' pkg_data_str("forcats")
#' require(dplyr)
#' pkg_data_str(c("dplyr", "forcats"))
pkg_data_str <- function(pkg) {
  data_results <- pkg_data_results(pkg = pkg)
  if (!is.logical(data_results[["Item"]])) {
    # data_results contains data objects
    ds_list <- purrr::map2(
      .x = data_results[["Item"]],
      .y = data_results[["Package"]],
      .f = pkg_data_object, .progress = TRUE
    )
    class_tbl <- dplyr::mutate(data_results,
      Class = purrr::map(.x = ds_list, .f = class) |>
        purrr::map(paste0, collapse = ", ") |> unlist()
    )
    df_tbl <- dplyr::filter(
      class_tbl,
      stringr::str_detect(Class, "data.frame")
    )
    if (nrow(df_tbl) == 0) {
      # df_tbl does not contain 'data.frame' classes
      data_results <- tibble::as_tibble(
        data.frame(
          matrix(
            nrow = 1, ncol = 6, byrow = TRUE,
            dimnames = list(
              NULL,
              c("Package", "Item", "Title",
                "Class", "Columns", "Rows")
            )
          ),
          row.names = NULL
        )
      )
      return(data_results)
    } else {
      # df_tbl contains 'data.frame' classes
      dplyr::mutate(df_tbl,
        Columns = purrr::map(.x = ds_list, .f = ncol) |>
          purrr::map(paste0, " columns") |> unlist(),
        Rows = purrr::map(.x = ds_list, .f = nrow) |>
          purrr::map(paste0, " rows") |> unlist()
      )
    }
  } else {
    # data_results does not contains data objects
    return(data_results)
  }
}
