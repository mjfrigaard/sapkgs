#' Launch App
#'
#' Standalone app function for `tsap` package.
#'
#' @return shiny app
#'
#' @import shiny
#'
#' @export launchApp
#'
launchApp <- function() {
    shinyApp(
      ui = appUI,
      server = appServer)

}
