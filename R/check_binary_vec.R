#' Binary checks (helper)
#'
#' @param x a vector
#' @param type type of column to return.
#'
#' @return `TRUE`/`FALSE` if binary
#'
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
  check_ord_binary <- function(x) {
    length(levels(na.omit(x))) == 2
  }
  switch(type,
    log = check_log_binary(x),
    int = check_int_binary(x),
    chr = check_chr_binary(x),
    fct = check_fct_binary(x),
    ord = check_ord_binary(x)
  )
}
