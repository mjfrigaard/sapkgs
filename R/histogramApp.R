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
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      mainPanel(
        histogramOutput("hist"),
        verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {
    data <- datasetServer("data")
    x <- selectVarServer("var", data)
    histogramServer("hist", x)

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

  }
  shinyApp(ui, server)
}
