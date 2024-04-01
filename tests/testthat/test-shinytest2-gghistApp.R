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
    # Verify initial data
  init_data <- app$get_value(input = "data-dataset")
  expect_equal(object = init_data,
    expected = "BOD")
  # Verify initial variable
  init_var <- app$get_value(input = "var-var")
  expect_equal(object = init_var,
    expected = "Time")
  
  app$set_input(`data-dataset` = "mtcars")
  app_hist_x <- app$get_value(export = "hist-x")
    expect_equal(
      object = app_hist_x,
      expected = mtcars[1])
  # # confirm initial values
  # init_ds <- app$get_value(input = 'data-dataset')
  # init_var <- app$get_value(input = 'var-var')
  # init_bins <- app$get_value(input = 'hist-bins')
  # expect_true(
  #   init_var %in% names(get(init_ds, "package:datasets"))
  # )
  # expect_true(is.numeric(init_bins))
  # expect_equal(
  #   app$get_value(output = 'hist-hist')$alt,
  #   "Plot object")
  # # app$view()
  # # Verify initial objects
  # exp_values <- app$get_values()$export
  # waldo::compare(exp_values[[1]], airquality)
  # expect_equal(exp_values[[1]], airquality)  
  # # compare x in server to x in ggHistServer()
  # expect_true(
  #   is.data.frame(app$get_value(export = 'hist-x')))
  # expect_true(
  #   is.data.frame(app$get_value(export = 'x')))
  # expect_equal(
  #   ncol(init_values$export$x), 
  #   ncol(init_values$export$`hist-x`))
  # app$stop()

})
