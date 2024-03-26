library(shiny)
options(shiny.testmode = TRUE)
gghistApp <- function() {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      mainPanel(
        histogramOutput("hist"),
        code("app vals"),
        verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- datasetServer("data")

    x <- selectVarServer("var", data)

    gghistServer("hist", x)

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

  }

  shinyApp(ui, server)
}
gghistApp()
