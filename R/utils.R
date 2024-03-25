#' Inverted versions of `%in%`
#'
#' @export
#'
#' @name not-in
#'
#' @examples
#' 1 %nin% 1:10
#' "A" %nin% 1:10
`%nin%` <- function(x, table) {
  match(x, table, nomatch = 0) == 0
}

#' Test comment helper
#'
#' @export
#'
#' @param test test name
#' @param msg test message
#'
#' @name test_cmt
#'
#' @examples
#' test_cmt("some test", "test message")
test_cmt <- function(test, msg) {
  cat("\n\t", glue::glue("  {test}: {msg}"), "\n")
}

