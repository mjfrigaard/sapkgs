datasetApp <- function(filter = NULL) {
  ui <- fluidPage(
    datasetInput("dataset", filter = is.data.frame),
    tableOutput("data"),

    # for printing reactive values in application modules
    verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {
    data <- datasetServer("dataset")
    output$data <- renderTable(head(data()))

    # for printing reactive values in application modules
    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }
  shinyApp(ui, server)
}
datasetApp()
