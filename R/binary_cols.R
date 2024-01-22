#' Binary checks (helper)
#'
#' @param x a vector
#' @param type type of column to return.
#'
#' @return TRUE/FALSE if binary
#' @export check_binary_vec
#'
#'
#' @examples
#' require(palmerpenguins)
#' check_binary_vec(palmerpenguins::penguins$sex, type = "fct")
#' check_binary_vec(palmerpenguins::penguins$species, type = "fct")
check_binary_vec <- function(x, type) {
  check_log_binary <- function(x) {
    all(na.omit(x) %in% TRUE:FALSE)
  }
  check_int_binary <- function(x) {
    all(na.omit(x) %in% 0:1)
  }
  check_chr_binary <- function(x) {
    length(unique(na.omit(x))) == 2
  }
  check_fct_binary <- function(x) {
    length(levels(na.omit(x))) == 2
  }
  switch(type,
    log = check_log_binary(x),
    int = check_int_binary(x),
    chr = check_chr_binary(x),
    fct = check_fct_binary(x)
  )
}

#' Create vector of binary columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of binary columns
#' @export make_binary_vec
#'
#' @importFrom purrr set_names map_vec
#' @importFrom cli cli_alert_info
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' make_binary_vec(
#'   df = dplyr::select(
#'     palmerpenguins::penguins,
#'     dplyr::where(is.factor)
#'   ),
#'   type = "fct"
#' )
make_binary_vec <- function(df, type) {
  if (ncol(df) < 1) {
    # cli::cli_alert_info(glue::glue("No {type} binary columns!"))
    return(purrr::set_names(vector(mode = "character")))
  } else {
    nms <- names(df)
    # set names in names
    dm_nms <- purrr::set_names(nms)
    bin_set <- purrr::map_vec(
      .x = df,
      .f = check_binary_vec,
      type = type
    )
    if (sum(bin_set) < 1) {
      # cli::cli_alert_info(glue::glue("No {type} binary values!"))
      bins <- purrr::set_names(vector(mode = "character"))
    } else {
      # cli::cli_alert_success(glue::glue("{type} binary values!"))
      bins <- purrr::set_names(dm_nms[bin_set])
    }
  }
  return(bins)
}

