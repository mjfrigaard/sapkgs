#' Launch App
#'
#' Standalone app function for `debugApp` package.
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
