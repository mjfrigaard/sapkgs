library(shiny)

# source("modules.R")

selectVarApp <- function(filter = is.numeric) {
  ui <- fluidPage(
    datasetInput("data", is.data.frame),
    selectVarInput("var"),
    verbatimTextOutput("out"),
    verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {
    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)

    output$out <- renderPrint(var())

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
  shinyApp(ui, server, options = list("test.mode" = TRUE))
}

selectVarApp()
