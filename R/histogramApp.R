#' Histogram App
#'
#'
#' @description
#' This module function comes from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @section Histogram App:
#' The `histogramApp()` is built using the `datasetInput()`/`datasetServer()`,
#' `selectVarInput()`/`selectVarServer()` and `histogramOutput()`/`histogramServer()`
#'  modules.
#'
#' @return shiny app
#'
#' @export histogramApp
#'
#' @importFrom shiny fluidPage sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel
histogramApp <- function() {
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      shiny::mainPanel(
        histogramOutput("hist"),
        shiny::verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {
    data <- datasetServer("data")
    x <- selectVarServer("var", data)
    histogramServer("hist", x)

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

  }
  shiny::shinyApp(ui, server)
}
