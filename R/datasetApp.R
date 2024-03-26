#' Dataset app
#'
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame`
#' or `is.matrix`)
#'
#' @description
#' This module function comes from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @section Reactive values:
#' The only changes to this application include a call to `verbatimTextOutput()` in the UI, which renders the contents of `reactiveValuesToList()` in the server. The `renderPrint()` output contains the `inputId`s for the modules in the application.
#'
#' @return shiny application
#' @export
#'
#' @import shiny
datasetApp <- function(filter = NULL) {
  ui <- fluidPage(

    datasetInput("dataset", filter = filter),

    tableOutput("data"),
    verbatimTextOutput("vals")

  )

  server <- function(input, output, session) {

    data <- datasetServer("dataset")

    output$data <- renderTable(head(data()))

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }

  shinyApp(ui, server)

}
