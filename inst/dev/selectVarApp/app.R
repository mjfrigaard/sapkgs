options(shiny.testmode = TRUE)
selectVarApp <- function(filter = is.numeric) {
  ui <- fluidPage(
            datasetInput("data", is.data.frame),
            selectVarInput("var"),
            tableOutput("out"),
            verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {

    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)

    output$out <- renderTable(head(var()))

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

    exportTestValues(
      var = var(),
      data = data()
    )

  }

  shinyApp(ui, server)
}

selectVarApp()
