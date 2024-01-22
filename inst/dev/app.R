library(shiny)
library(gargoyle)
source("modules.R")
source("appUI.R")
source("appServer.R")

demoApp <- function() {
  shinyApp(
    ui = appUI,
    server = appServer
  )
}
demoApp()
