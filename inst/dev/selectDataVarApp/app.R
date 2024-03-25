selectDataVarApp <- function(filter = is.numeric) {
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        selectDataVarUI("var")
        ),
      shiny::mainPanel(
        shiny::tableOutput("out"),

        shiny::verbatimTextOutput("vals")
        )
    )
  )
  server <- function(input, output, session) {
    var <- selectDataVarServer("var", filter)
    output$out <- shiny::renderTable(head(var()))

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

  }
  shiny::shinyApp(ui, server)
}

selectDataVarApp()
