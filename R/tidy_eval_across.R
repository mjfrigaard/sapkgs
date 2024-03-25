#' Tidy-selection and data-masking
#'
#' From: https://mastering-shiny.org/action-tidy.html#tidy-selection-and-data-masking
#'
#' @return shiny app
#'
#' @export app12.3.2
#'
#' @importFrom shiny shinyApp fluidPage selectInput tableOutput
#' @importFrom shiny renderTable req renderPrint
#' @importFrom dplyr group_by across all_of summarise
#'
#' @examples
#' # app12.3.2()
app12.3.2 <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::selectInput("vars", "Variables", names(mtcars), multiple = TRUE),
      shiny::tableOutput("count"),
      shiny::verbatimTextOutput("vals")

    ),
    server = function(input, output, session) {
      output$count <- shiny::renderTable({
        shiny::req(input$vars)

        mtcars |>
          dplyr::group_by(
            dplyr::across(
              dplyr::all_of(input$vars)))  |>
          dplyr::summarise(n = dplyr::n(),
            .groups = "drop")
      })

      output$vals <- shiny::renderPrint(
        unlist(
          shiny::reactiveValuesToList(x = input, all.names = TRUE)
        )
      )
    }
  )
}



