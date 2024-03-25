# ui module
mod_abc_ui <- function(id) {
  ns <- NS(id)
  tagList(
    column(
      width = 3,
      offset = 2,
      numericInput(
        inputId = ns("num"),
        label = "Alphabet Number",
        value = 5,
        min = 1,
        max = 26
      )
    ),
    column(
      width = 6,
      br(),
      uiOutput(
        outputId = ns("txt")
      ),
      verbatimTextOutput(ns("out"))
    )
  )
}

# server module
mod_abc_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # reactive
    letter <- reactive({
      LETTERS[input$num]
    })
    # super script
    sup_scrpt <- reactive({
      num_super_script(x = input$num)
    })
    # output
    output$txt <- renderUI({
      HTML(
        paste0(
          em(
            "The ", code(input$num), code(sup_scrpt()),
            " letter in the alphabet is: ", code(letter())
          )
        )
      )
    })
    output$out <- renderPrint({
      HTML(
        paste0(
          em(
            "The ", code(input$num), code(sup_scrpt()),
            " letter in the alphabet is: ", code(letter())
          )
        )
      )
    })
  })
}
