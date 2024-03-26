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