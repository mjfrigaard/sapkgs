#' Histogram server module
#'
#' @description
#' This module function comes from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @param id shiny module server id
#'
#' @return shiny server module
#' @export histogramServer
#'
#' @importFrom shiny tagList numericInput NS plotOutput renderPlot req
#' @importFrom purrr as_vector
#'
histogramServer <- function(id, x, title = reactive("Histogram")) {
  stopifnot(shiny::is.reactive(x))
  stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {

    output$hist <- shiny::renderPlot({
      shiny::req(x())
      main <- paste0(title(), " [bins =", input$bins, "]")
      hist(purrr::as_vector(x()),
        breaks = input$bins,
        main = main)
    }, res = 96)

  })
}
