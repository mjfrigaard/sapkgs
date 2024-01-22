# In mod_plot_server_alt(), I define the plot() reactive prior to rendering,
# which allows for more tests to be run on the plot() object:

mod_plot_server_alt <- function(id, plot_inputs) {

  moduleServer(id, function(input, output, session) {

      plot <- reactive({
                  gg_color_scatter_facet(
                  df = plot_inputs()$df,
                  x_var = plot_inputs()$x_var,
                  y_var = plot_inputs()$y_var,
                  col_var = plot_inputs()$col_var,
                  facet_var = plot_inputs()$facet_var,
                  alpha = plot_inputs()$alpha,
                  size = plot_inputs()$size)
            }) |>
          bindEvent(plot_inputs(),
                           ignoreNULL = TRUE)

       observe({
           output$graph <- renderPlot({ plot() })
            }) |>
                bindEvent(plot(), ignoreNULL = TRUE)

  })
}

testServer(app = mod_plot_server_alt,
  args = list(
           reactive(
             list(
              df = palmerpenguins::penguins,
              x_var = "bill_length_mm",
              y_var = "bill_depth_mm",
              col_var = "sex",
              facet_var = "species",
              alpha = 0.5,
              size = 2)
             )
    ), expr = {

  # Test plot() is.ggplot: ----
  testthat::expect_equal(
    object = ggplot2::is.ggplot(plot()),
    expected = TRUE)
  cat("\nTest ggplot2::is.ggplot: >>", ggplot2::is.ggplot(plot()), "\n")

  # Test 4 print plot() ----
  # view plot
  suppressWarnings(print(plot()))
  cat("\nTest print plot(): >>\n")
})
