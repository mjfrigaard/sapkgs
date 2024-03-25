library(shiny)
options(shiny.testmode = TRUE)
gghistApp <- function() {
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      shiny::mainPanel(
        histogramOutput("hist"),
        shiny::code("app vals"),
        shiny::verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- datasetServer("data")

    x <- selectVarServer("var", data)

    gghistServer("hist", x)

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

  }

  shiny::shinyApp(ui, server)
}
gghistApp()
