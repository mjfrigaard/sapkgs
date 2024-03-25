options(shiny.testmode = TRUE)
selectVarApp <- function(filter = is.numeric) {
  ui <- shiny::fluidPage(
            datasetInput("data", is.data.frame),
            selectVarInput("var"),
            shiny::tableOutput("out"),
            shiny::verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {

    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)

    output$out <- shiny::renderTable(head(var()))

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

    shiny::exportTestValues(
      var = var(),
      data = data()
    )

  }

  shiny::shinyApp(ui, server)
}

selectVarApp()
