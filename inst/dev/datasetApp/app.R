datasetApp <- function(filter = NULL) {
  ui <- shiny::fluidPage(
    datasetInput("dataset", filter = is.data.frame),
    shiny::tableOutput("data"),

    # for printing reactive values in application modules
    shiny::verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {
    data <- datasetServer("dataset")
    output$data <- shiny::renderTable(head(data()))

    # for printing reactive values in application modules
    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }
  shiny::shinyApp(ui, server)
}
datasetApp()
