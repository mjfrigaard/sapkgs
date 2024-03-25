#' Data-masking app
#'
#' From https://mastering-shiny.org/action-tidy.html#data-masking
#'
#' @return shiny app
#'
#' @export app12.2
#'
#' @importFrom shiny shinyApp fluidPage selectInput
#' @importFrom shiny numericInput tableOutput verbatimTextOutput
#' @importFrom shiny reactive renderTable reactiveValuesToList
#' @importFrom dplyr filter
#'
#' @examples
#' # app12.2()
app12.2 <- function() {
  num_vars <- c("carat", "depth", "table", "price", "x", "y", "z")
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::h3(
        shiny::tags$a(
          href = "https://mastering-shiny.org/action-tidy.html#data-masking",
          "12.2 Data-masking"
        )
      ),
      shiny::selectInput("var", "Variable", choices = num_vars),
      shiny::numericInput("min", "Minimum", value = 4),
      shiny::tableOutput("output"),
      shiny::verbatimTextOutput("vals")
    ),
    server = function(input, output, session) {
      data <- shiny::reactive(
        ggplot2::diamonds |>
          dplyr::filter(.data[[input$var]] > .env$input$min)
      )

      output$output <- shiny::renderTable(head(data()))

      output$vals <- shiny::renderPrint(
        unlist(
          shiny::reactiveValuesToList(x = input, all.names = TRUE)
        )
      )
    }
  )
}
