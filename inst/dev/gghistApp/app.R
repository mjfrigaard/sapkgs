library(shiny)

options(shiny.testmode = TRUE)

ggHistApp <- function() {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        mstsap::datasetInput("data", is.data.frame),
        mstsap::selectVarInput("var"),
      ),
      mainPanel(
        histogramOutput("hist"),
        code("app vals"),
        verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- mstsap::datasetServer("data")
    x <- ggSelectVarServer("var", data)
    ggHistServer("hist", x)

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)
    
    exportTestValues(
      x = x(),
      data = data()
    )

  }

  shinyApp(ui, server)
}
ggHistApp()
