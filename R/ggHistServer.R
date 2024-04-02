#' ggHistServer: A Shiny Module Server Function for Generating Histograms
#'
#' This function defines the server-side logic for a Shiny module that creates 
#' interactive histograms based on reactive data inputs. It utilizes ggplot2 for 
#' plotting and allows dynamic adjustment of the number of bins in the histogram. 
#' The module expects reactive expressions for data and the plot title, ensuring 
#' updates are handled automatically as inputs change.
#'
#' @param id A character string or numeric ID that corresponds to the namespace
#'   of the Shiny module. This ID is used to differentiate outputs and inputs 
#'   within the module server function.
#' @param x A reactive expression that returns the data to be used for the histogram.
#'   This data should be a numeric vector. The function enforces this by checking 
#'   that `x` is indeed a reactive expression.
#' @param title A reactive expression providing the title for the histogram plot.
#'   Defaults to a reactive expression that returns the string "Histogram". This
#'   title is dynamically updated in the plot output based on the value of the
#'   reactive expression.
#'
#' @details The module server function internally generates a reactive plot object
#'   based on the input data (`x`) and dynamically adjusts the histogram's appearance
#'   according to user inputs for the number of bins. The title of the plot is also 
#'   reactive, updating as the input `title` changes. Additionally, the function 
#'   renders a textual output showing the current input values and exports test 
#'   values for `x` and the internally generated plot object for debugging purposes.
#'
#' @return The function does not explicitly return a value but registers reactive 
#'   output elements for a histogram plot (`output$hist`) and a text representation 
#'   of the current inputs (`output$vals`) within the Shiny application.
#'
#' @export
ggHistServer <- function(id, x, title = reactive("Histogram")) {
  
  stopifnot(is.reactive(x))
  stopifnot(is.reactive(title))

  moduleServer(id, function(input, output, session) {
    
    gg2_plot <- reactive({
      ggplot2::ggplot(
          mapping =
            ggplot2::aes(purrr::as_vector(x()))
        ) +
          ggplot2::geom_histogram(bins = input$bins) +
          ggplot2::labs(
            title = paste0(title(), " [bins = ", input$bins, "]"),
            y = "Count",
            x = names(x())
          ) +
          ggplot2::theme_minimal()
    })

      
    observe({
      output$hist <- renderPlot({gg2_plot()}, res = 124)
    }) |> 
      bindEvent(c(x(), title(), input$bins))
    
    output$vals <- renderPrint({
        x <- reactiveValuesToList(input,
          all.names = TRUE
        )
        print(x, width = 30, max.levels = NULL)},
      width = 30)
    
  })
  
}
