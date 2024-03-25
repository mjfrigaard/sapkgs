#' Data-masking user data
#'
#' From https://mastering-shiny.org/action-tidy.html#user-data
#'
#' @return shiny app
#'
#' @export app12.2.4
#'
#' @importFrom shiny shinyApp fluidPage selectInput fileInput
#' @importFrom shiny numericInput tableOutput verbatimTextOutput
#' @importFrom shiny reactive plotOutput renderPlot renderPrint
#' @importFrom shiny renderTable h3 tags
#' @importFrom shiny req updateSelectInput bindEvent observe
#' @importFrom shiny reactiveValuesToList updateNumericInput
#' @importFrom vroom vroom
#' @importFrom dplyr filter arrange
#'
#' @examples
#' # app12.2.4()
app12.2.4 <- function() {
    shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::h3(
        shiny::tags$a(
          href = "https://mastering-shiny.org/action-tidy.html#user-data",
          "12.2.4 User supplied data"
        )
      ),
    shiny::fileInput("data",
      shiny::tags$a(
      href = "https://raw.githubusercontent.com/mjfrigaard/msap/main/data-raw/mpg.csv",
          "Download example data data"),
        accept = ".csv"),
      shiny::selectInput("var", "var", character()),
      shiny::numericInput("min", "min", 1, min = 0, step = 1),
      shiny::tableOutput("output"),
      shiny::verbatimTextOutput("vals")
    ),
    server = function(input, output, session) {
      data <- shiny::reactive({
                shiny::req(input$data)
              vroom::vroom(input$data$datapath)
            })
        shiny::observe({
          shiny::updateSelectInput(session, "var", choices = names(data()))
        }) |>
          shiny::bindEvent(data())

        shiny::observe({
          val <- data()[[input$var]]
          shiny::updateNumericInput(session, "min", value = min(val))
        }) |>
          shiny::bindEvent(input$var)

        output$output <- shiny::renderTable({
          shiny::req(input$var)

          data() |>
            dplyr::filter(.data[[input$var]] > input$min) |>
            dplyr::arrange(.data[[input$var]]) |>
            head(10)
          })

      output$vals <- shiny::renderPrint(
        unlist(
          shiny::reactiveValuesToList(x = input, all.names = TRUE)
        )
      )
    }
  )
}
