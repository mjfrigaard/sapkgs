# File: ./tests/testthat/test-shinytest2-gghistApp.R
# derived from: https://rstudio.github.io/shinytest2/articles/robust.html#example
# App file: ./app.R
library(shinytest2)
remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)
library(vdiffr)

testthat::test_that("{shinytest2}: gghistApp", {
  testthat::skip_if_not_installed("vdiffr")

  app <- AppDriver$new(app_dir = system.file("dev", "gghistApp",
                                             package = "msst2ap"),
                       height = 750, width = 1200)

  # Verify initial data
  app_init_data <- app$get_value(input = "data-dataset")
  # waldo::compare(app_init_data, "BOD")
  testthat::expect_equal(
    object = app_init_data,
    expected = "BOD")

  # Verify initial variable
  app_init_var <- app$get_value(input = "var-var")
  # waldo::compare(app_init_var, "Time")
  testthat::expect_equal(
    object = app_init_var,
    expected = "Time")

  # Verify exported `x()` data
  app$set_inputs(`data-dataset` = "mtcars")
  app_exp_x_01 <- app$get_value(export = "hist-x")
  # waldo::compare(app_exp_x_01, mtcars[1])
  testthat::expect_equal(
    object = app_exp_x_01,
    expected = mtcars[1])

  # Verify exported `plot_obj()` variable
  app$set_inputs(`var-var` = "wt")
  app_exp_plot_obj_01 <- app$get_value(export = "hist-plot_obj")
  # waldo::compare(app_exp_plot_obj_01,
  #                purrr::as_vector(app_exp_plot_obj_01))
  testthat::expect_equal(
    object = app_exp_plot_obj_01,
    expected = purrr::as_vector(app_exp_plot_obj_01))

  # Verify `hist-bins` changes
  app$set_inputs(`hist-bins` = 15)
  app_set_bins_01 <- app$get_value(input = "hist-bins")
  # waldo::compare(app_set_bins_01, 15L)
  testthat::expect_equal(
    object = app_set_bins_01,
    expected = 15)

  # Verify `hist-plot_obj` changes
  plot_obj_15 <- app$get_value(export = "hist-plot_obj")
  # this will compare the two plots with the same code used to generate
  # the graph in the gghistServer() module:

    # plot_obj_test <- purrr::as_vector(mtcars['wt'])
    # p1 <- ggplot2::ggplot(
    #       mapping =
    #         ggplot2::aes(plot_obj_15)) +
    #         ggplot2::geom_histogram(bins = 15) +
    #         ggplot2::labs(
    #           title = paste0("Histogram ", " [bins = ", 15, "]"),
    #           y = "Count",
    #           x = names(plot_obj_15)) +
    #         ggplot2::theme_minimal()
    # p2 <- ggplot2::ggplot(
    #       mapping =
    #         ggplot2::aes(plot_obj_test)) +
    #         ggplot2::geom_histogram(bins = 15) +
    #         ggplot2::labs(
    #           title = paste0("Histogram ", " [bins = ", 15, "]"),
    #           y = "Count",
    #           x = names(plot_obj_test)) +
    #         ggplot2::theme_minimal()
    # waldo::compare(x = p1, y = p2)

  # the results show the only differences are the mapped x value names:
  # `old$mapping$x`: `~plot_obj_15`
  # `new$mapping$x`: `~plot_obj_test`

  vdiffr::expect_doppelganger(
    title = "hist-plot_obj-15",
    fig = plot_obj_15)

  ## Update `data` to USArrests
  app$set_inputs(`data-dataset` = "USArrests")
  app_exp_x_02 <- app$get_value(export = "hist-x")
  testthat::expect_equal(
    object = app_exp_x_02,
    expected = USArrests[1])

  ## Update `var` to UrbanPop
  app$set_inputs(`var-var` = "UrbanPop")
  app_exp_plot_obj_02 <- app$get_value(export = "hist-plot_obj")
  testthat::expect_equal(
    object = app_exp_plot_obj_02,
    expected = purrr::as_vector(app_exp_plot_obj_02))

  ## Update `bins` to 12
  app$set_inputs(`hist-bins` = 12)
  app_set_bins_02 <- app$get_value(input = "hist-bins")
  expect_equal(
    object = app_set_bins_02,
    expected = 12)

  # Verify `hist-plot_obj` changes
  plot_obj_12 <- app$get_value(export = "hist-plot_obj")
  vdiffr::expect_doppelganger(
    title = "hist-plot_obj-12",
    fig = plot_obj_12)

  app$stop()

})
