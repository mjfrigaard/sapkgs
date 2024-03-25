#' Tidy-selection and data-masking (version 2)
#'
#' From: https://mastering-shiny.org/action-tidy.html#tidy-selection-and-data-masking
#'
#' @return shiny app
#'
#' @export app12.3.2v2
#'
#' @importFrom shiny shinyApp fluidPage selectInput tableOutput
#' @importFrom shiny renderTable req renderPrint
#' @importFrom dplyr group_by across all_of summarise
#'
#' @examples
#' # app12.3.2v2()
app12.3.2v2 <- function() {
  shiny::shinyApp(
  ui = shiny::fluidPage(
  shiny::selectInput("vars_g", "Group by", names(mtcars), multiple = TRUE),
  shiny::selectInput("vars_s", "Summarise", names(mtcars), multiple = TRUE),
  shiny::tableOutput("data"),
  shiny::verbatimTextOutput("vals")
),

  server = function(input, output, session) {
  output$data <- shiny::renderTable({
    mtcars |>
      dplyr::group_by(
        dplyr::across(
          dplyr::all_of(input$vars_g))) |>
      dplyr::summarise(
        dplyr::across(
          dplyr::all_of(input$vars_s), mean), n = dplyr::n())
    })
      output$vals <- shiny::renderPrint(
        unlist(
          shiny::reactiveValuesToList(x = input, all.names = TRUE)
        )
      )
  }
)
}
