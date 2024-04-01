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
#'
histogramServer <- function(id, x, title = reactive("Histogram")) {
  stopifnot(is.reactive(x))
  stopifnot(is.reactive(title))

  moduleServer(id, function(input, output, session) {

    output$hist <- renderPlot({
      req(x())
      main <- paste0(title(), " [bins =", input$bins, "]")
      hist(purrr::as_vector(x()),
        breaks = input$bins,
        main = main)
    }, res = 96)

  })
}
