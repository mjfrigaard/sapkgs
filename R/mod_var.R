mod_var_ui <- function(id) {
  ns <- NS(id)
  tagList(
    verbatimTextOutput(outputId = ns("out"))
  )
}

mod_var_server <- function(id, ds) {
   moduleServer(id, function(input, output, session) {
    output$out <- renderPrint({
      str(
       ds()
      )
    })
   })
}
