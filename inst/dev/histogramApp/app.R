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

histogramApp()
