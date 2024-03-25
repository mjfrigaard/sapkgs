#' Dataset app
#'
#'
#' @description
#' This standalone app function is from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @section filter:
#' This application includes an argument for filtering objects "*limit the options to built-in datasets that are either data frames (filter = is.data.frame) or matrices (filter = is.matrix)*" displayed in the `selectInput()`.
#'
#' @section reactive values:
#' The `renderPrint()` output contains the output from `shiny::reactiveValuesToList()`
#' and contains the`inputId`s for the modules in the application.
#'
#' @return shiny application
#' @export
#'
#' @importFrom shiny tableOutput renderTable shinyApp
#' @importFrom shiny reactiveValuesToList renderPrint verbatimTextOutput
datasetApp <- function(filter = NULL) {
  ui <- shiny::fluidPage(
    datasetInput("dataset", filter = is.data.frame),
    shiny::tableOutput("data"),
    shiny::verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {

    data <- datasetServer("dataset")
    output$data <- shiny::renderTable(head(data()))

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }
  shiny::shinyApp(ui, server)
}
