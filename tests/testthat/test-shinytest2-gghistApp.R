# File: ./tests/testthat/test-shinytest2-ggHistApp.R
# derived from: https://rstudio.github.io/shinytest2/articles/robust.html#example
# App file: ./app.R
library(shinytest2)
# remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)
library(vdiffr)

test_that("{shinytest2}: ggHistApp", {
  skip_if_not_installed("vdiffr")
  app_pth <- system.file("dev", "ggHistApp",
                                  package = "msst2ap")
  app <- AppDriver$new(app_pth,
                       height = 750, width = 1200)
  # app$view()
  # initial values----
  # verify initial values 
  init_ds <- app$get_value(input = 'data-dataset')
  init_var <- app$get_value(input = 'var-var')
  # is the variable from the dataset?
  expect_true(
    init_var %in% names(get(init_ds, "package:datasets"))
  )
  init_bins <- app$get_value(input = 'hist-bins')
  expect_true(is.numeric(init_bins))
  
  # set values ----
  # dataset
  app$set_inputs(`data-dataset` = 'mtcars')
  new_data <- app$get_value(input = "data-dataset")
  # Verify new data
  expect_equal(object = new_data,
    expected = "mtcars")
  app$set_inputs(`var-var` = 'disp')
  new_var <- app$get_value(input = "var-var")
  # Verify new variable
  expect_equal(object = new_var,
    expected = "disp")
  
  # Exported objects ----
  exp_values <- app$get_values()$export
  # check reactives/functions
  expect_true(shiny::is.reactive(exp_values$react_data))
  expect_true(shiny::is.reactive(exp_values$react_x))
  expect_true(rlang::is_function(exp_values$react_data))
  expect_true(rlang::is_function(exp_values$react_x))
  # check data 
  expect_true(is.data.frame(exp_values$data))
  expect_true(ncol(exp_values$x) == 1)
  expect_equal(exp_values$data, mtcars)
  expect_equal(exp_values$x, mtcars['disp'])
  

  # Verify plot ----
  # Verify plot object
  gg2_plot <- app$get_value(output = "hist-hist")
  expect_equal(gg2_plot$alt, "Plot object")
  ## verify mtcars_disp_plot ---- 
  vdiffr::expect_doppelganger(
    title = "mtcars_disp_plot",
    fig = ggplot2::ggplot(data = exp_values$data,
            mapping =
            ggplot2::aes(x = disp)
        ) + 
          ggplot2::geom_histogram(bins = exp_values$`hist-bins`) +
          ggplot2::labs(
            title = paste0(exp_values$`hist-title`, 
                           " [bins = ",
                           exp_values$`hist-bins`, "]"),
            y = "Count",
            x = names(exp_values$x)
          ) +
          ggplot2::theme_minimal()
    )
  ## verify usaarrests_plot ---- 
  app$set_inputs(`data-dataset` = "USArrests")
  app$set_inputs(`var-var` = 'UrbanPop')
  app$set_inputs(`hist-bins` = 15)
  # export values 
  exp_values <- app$get_values()$export
  vdiffr::expect_doppelganger(
    title = "usaarrests_plot",
    fig = ggplot2::ggplot(data = exp_values$data,
            mapping =
            ggplot2::aes(x = UrbanPop)
        ) + 
          ggplot2::geom_histogram(bins = exp_values$`hist-bins`) +
          ggplot2::labs(
            title = paste0(exp_values$`hist-title`, 
                           " [bins = ",
                           exp_values$`hist-bins`, "]"),
            y = "Count",
            x = names(exp_values$x)
          ) +
          ggplot2::theme_minimal()
    )
  ## verify bod_demand_plot ---- 
  app$set_inputs(`data-dataset` = "sleep")
  app$set_inputs(`var-var` = 'extra')
  app$set_inputs(`hist-bins` = 8)
  # export values 
  exp_values <- app$get_values()$export
  vdiffr::expect_doppelganger(
    title = "sleep_extra_plot",
    fig = ggplot2::ggplot(data = exp_values$data,
            mapping =
            ggplot2::aes(x = extra)
        ) + 
          ggplot2::geom_histogram(bins = exp_values$`hist-bins`) +
          ggplot2::labs(
            title = paste0(exp_values$`hist-title`, 
                           " [bins = ",
                           exp_values$`hist-bins`, "]"),
            y = "Count",
            x = names(exp_values$x)
          ) +
          ggplot2::theme_minimal()
    )
})
