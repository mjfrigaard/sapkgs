# packages --------------------------------------------------------
library(shiny)
library(testthat)

# utils -----------------------------------------------------------
source("utils.R")

# modules ---------------------------------------------------------
source("modules.R")


# standalone shiny app function
launchApp <- function() {
  shinyApp(
    ui = fluidPage(
      h2("ABC App"),
      fluidRow(
        mod_abc_ui("x")
      )
    ),
    server = function(input, output, session) {
      mod_abc_server("x")
    }
  )
}
launchApp()
