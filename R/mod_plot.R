#' Plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_plot_ui
#'
#' @importFrom shiny NS tagList tags column fluidRow
#' @importFrom shiny plotOutput verbatimTextOutput
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(width = 12,
        plotOutput(outputId = ns("graph")
          )
        )
      )
    )
}

#' Plot server module
#'
#' @param id module id
#' @param plot_inputs list from `mod_cols`
#'
#' @return shiny server module
#' @export mod_plot_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom ggplot2 labs theme_minimal theme
mod_plot_server <- function(id, plot_inputs) {

  stopifnot(is.reactive(plot_inputs))

  moduleServer(id, function(input, output, session) {

       observe({
           output$graph <- renderPlot({
              gg_color_scatter_facet(
                  df = plot_inputs()$df,
                  x_var = plot_inputs()$x_var,
                  y_var = plot_inputs()$y_var,
                  col_var = plot_inputs()$col_var,
                  facet_var = plot_inputs()$facet_var,
                  alpha = plot_inputs()$alpha,
                  size = plot_inputs()$size)
             })
       }) |>
          bindEvent(plot_inputs(),
                           ignoreNULL = TRUE)

  })
}










