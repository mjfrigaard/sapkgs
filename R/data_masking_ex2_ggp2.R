#' Data-masking ggplot2 app 2
#'
#' From https://mastering-shiny.org/action-tidy.html#example-ggplot2
#'
#' @return shiny app
#'
#' @export app12.2.2v2
#'
#' @importFrom shiny shinyApp fluidPage selectInput
#' @importFrom shiny numericInput tableOutput verbatimTextOutput
#' @importFrom shiny reactive plotOutput renderPlot renderPrint
#' @importFrom shiny reactiveValuesToList
#' @importFrom ggplot2 ggplot aes geom_point
#' @importFrom ggforce position_auto
#'
#' @examples
#' # app12.2.2v2()
app12.2.2v2 <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::h3(
        shiny::tags$a(
          href = "https://mastering-shiny.org/action-tidy.html#example-ggplot2",
          "12.2.2 Example: ggplot2 (version 2)"
        )
      ),
      shiny::selectInput("x", "X variable", choices = names(iris)),
      shiny::selectInput("y", "Y variable", choices = names(iris)),
      shiny::selectInput("geom", "geom", c("point", "smooth", "jitter")),
      shiny::plotOutput("plot"),
      shiny::verbatimTextOutput("vals")
    ),
    server = function(input, output, session) {
      plot_geom <- shiny::reactive({
        switch(input$geom,
          point = ggplot2::geom_point(),
          smooth = ggplot2::geom_smooth(se = FALSE),
          jitter = ggplot2::geom_jitter()
        )
      })

      output$plot <- shiny::renderPlot(
        {
          ggplot2::ggplot(
            iris,
            ggplot2::aes(.data[[input$x]], .data[[input$y]])
          ) +
            plot_geom()
        },
        res = 96
      )

      output$vals <- shiny::renderPrint(
        unlist(
          shiny::reactiveValuesToList(x = input, all.names = TRUE)
        )
      )
    }
  )
}
