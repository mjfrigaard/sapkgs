library(shiny)

selectDataVarApp <- function(filter = is.numeric) {
  options(width = 65)
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        selectDataVarUI("var")
        ),
      mainPanel(
        tags$br(),
        verbatimTextOutput("out"),
        verbatimTextOutput("vals")
        )
    )
  )
  server <- function(input, output, session) {
    var <- selectDataVarServer("var", filter)
    output$out <- renderPrint(var())

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })
  }
  shinyApp(ui, server)
}

selectDataVarApp()
