selectDataVarApp <- function(filter = is.numeric) {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        selectDataVarUI("var")
        ),
      mainPanel(
        tableOutput("out"),

        verbatimTextOutput("vals")
        )
    )
  )
  server <- function(input, output, session) {
    var <- selectDataVarServer("var", filter)
    output$out <- renderTable(head(var()))

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })

  }
  shinyApp(ui, server)
}

selectDataVarApp()
