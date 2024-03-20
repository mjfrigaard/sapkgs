#' Skim data variable app
#'
#' @description
#' Select a dataset and variable from the package and view
#' a `skimr::skim()` output.
#'
#'
#' @export skimVarApp
#' 
#' @import shiny
#' @import bslib
#'
skimVarApp <- function(filter = is.numeric) {
  shinyApp(
    ui = skim_ui, 
    server = skim_server
    )
}
