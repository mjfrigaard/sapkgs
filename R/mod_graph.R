#' Plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_graph_ui
#'
#' @importFrom shiny NS tagList tags column fluidRow
#' @importFrom shiny plotOutput verbatimTextOutput
mod_graph_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # fluidRow(
    #   column(
    #     width = 12,
    #     verbatimTextOutput(outputId = ns("vals"))
    #   )
    # ),
    fluidRow(
      column(
        width = 6,
        sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7)
        ),
      column(
        width = 6,
        sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3)
        )
    ),
    fluidRow(
      column(
        width = 12,
        plotOutput(outputId = ns("graph"))
      )
    )
  )
}

#' Plot server module
#'
#' @param id module id
#' @param graph_data a `data.frame` from `mod_vars`
#'
#' @return shiny server module
#' @export mod_graph_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom ggplot2 labs theme_minimal theme
mod_graph_server <- function(id, graph_data) {

  moduleServer(id, function(input, output, session) {

        output$vals <- renderPrint({
            c(input$alpha, input$size)
           }) |>
          bindEvent(graph_data(),
                           ignoreNULL = TRUE)

          observe({
              output$graph <- renderPlot({
                 gg_scatter_color_facet(
                     df = graph_data(),
                     x_var = names(graph_data())[1],
                     y_var = names(graph_data())[2],
                     col_var = names(graph_data())[3],
                     facet_var = names(graph_data())[4],
                     alpha = input$alpha,
                     size = input$size)
                })
              }) |>
             bindEvent(graph_data(),
                              input$alpha, input$size,
                              ignoreNULL = TRUE)

  })
}










