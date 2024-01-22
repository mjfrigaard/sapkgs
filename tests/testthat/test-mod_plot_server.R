testServer(app = mod_plot_server,
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

  # Test 1 plot_inputs() is.list: ----
  testthat::expect_true(
    object = is.list(plot_inputs()))
  cat("\nmod_plot_server plot_inputs() [is.list] >>", class(plot_inputs()))

  # Test 2 is.data.frame(plot_inputs()$df): ----
  testthat::expect_true(
    object = is.data.frame(plot_inputs()$df))
    cat("\nmod_plot_server [class(plot_inputs()$df)] >>", class(plot_inputs()$df))

  # Test 3 plot_inputs()$x_var = bill_length_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$x_var, expected = "bill_length_mm")
    cat("\nmod_plot_server plot_inputs()$x_var = [bill_length_mm] >>", plot_inputs()$x_var)

  # Test 4 plot_inputs()$y_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$y_var, expected = "bill_depth_mm")
    cat("\nmod_plot_server plot_inputs()$y_var = [bill_depth_mm] >>", plot_inputs()$y_var)

  # Test 5 plot_inputs()$col_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$col_var, expected = "sex")
    cat("\nmod_plot_server plot_inputs()$col_var = [sex] >>", plot_inputs()$col_var)

  # Test 6 plot_inputs()$facet_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$facet_var, expected = "species")
    cat("\nmod_plot_server plot_inputs()$facet_var = [species] >>", plot_inputs()$facet_var)

  # Test 7 plot_inputs()$size = 2: ----
  testthat::expect_equal(
    object = plot_inputs()$size, expected = 2L)
    cat("\nmod_plot_server plot_inputs()$size = [2] >>", plot_inputs()$size)

  # Test 8 plot_inputs()$alpha = 0.5: ----
  testthat::expect_equal(
    object = plot_inputs()$alpha, expected = 0.5)
    cat("\nmod_plot_server plot_inputs()$alpha = [0.5] >>", plot_inputs()$alpha)

  # Test 9 plot_inputs() names: ----
  testthat::expect_equal(
    object = names(plot_inputs()),
    expected = c("df", "x_var", "y_var",
                 "col_var", "facet_var",
                 "alpha", "size"))
    cat("\n\tmod_plot_server names(plot_inputs())")
})

