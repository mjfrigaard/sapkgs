#' Histogram UI module
#'
#' @description
#' This module function comes from the [Case study: histogram](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) section of Mastering Shiny.
#'
#' @param id shiny module ui id
#'
#' @return shiny ui module
#' @export histogramOutput
#'
#' @importFrom shiny tagList numericInput
#' @importFrom shiny NS plotOutput verbatimTextOutput
histogramOutput <- function(id) {
  tagList(
    numericInput(
      NS(id, "bins"),
      label = "bins",
      value = 10,
      min = 1,
      step = 1
    ),
    plotOutput(
      NS(id, "hist"))
  )
}
