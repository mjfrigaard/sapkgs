library(shiny)

source("modules.R")

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

datasetApp()
