#' Data-masking dplyr app
#'
#' From https://mastering-shiny.org/action-tidy.html#example-dplyr
#'
#' @return shiny app
#'
#' @export app12.2.3
#'
#' @importFrom shiny shinyApp fluidPage selectInput
#' @importFrom shiny numericInput tableOutput verbatimTextOutput
#' @importFrom shiny reactive plotOutput renderPlot renderPrint
#' @importFrom shiny reactiveValuesToList
#' @importFrom ggplot2 ggplot aes geom_point
#' @importFrom ggforce position_auto
#'
#' @examples
#' # app12.2.3()
app12.2.3 <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::h3(
        shiny::tags$a(
          href = "https://mastering-shiny.org/action-tidy.html#example-dplyr",
          "12.2.3 Example: dplyr"
        )
      ),
      shiny::selectInput("var", "Select variable", choices = names(mtcars)),
      shiny::sliderInput("min", "Minimum value", 0, min = 0, max = 100),
      shiny::selectInput("sort", "Sort by", choices = names(mtcars)),
      shiny::tableOutput("data"),
      shiny::verbatimTextOutput("vals")
    ),

    server = function(input, output, session) {

      shiny::observe({
        rng <- range(mtcars[[input$var]])
        shiny::updateSliderInput(session = session,
          inputId = "min",
          value = rng[[1]],
          min = rng[[1]],
          max = rng[[2]]
        )
      }) |>
        shiny::bindEvent(input$var)

      output$data <- shiny::renderTable({
        mtcars |>
          dplyr::filter(.data[[input$var]] > input$min) |>
          dplyr::arrange(.data[[input$sort]]) |>
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
