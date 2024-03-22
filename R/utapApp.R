#' unit test app
#'
#' @description
#' Select a dataset and variable from the package and view the variable types
#'
#'
#'
#' @export utapApp
#'
#' @import shiny
#' @import bslib
#'
utapApp <- function() {
  shinyApp(
    ui = app_ui,
    server = app_server
    )
}
