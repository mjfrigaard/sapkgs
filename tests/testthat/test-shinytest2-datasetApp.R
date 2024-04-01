library(shinytest2)
# remotes::install_github("rstudio/chromote", 
#                         force = TRUE, 
#                         quiet = TRUE)
library(chromote)

test_that("mstsap::datasetApp", {
  app_pth <- system.file("dev", "datasetApp", package = "mstsap")
  app <- AppDriver$new(app_dir = app_pth, height = 600, width = 800)
  waldo::compare(x = app$get_window_size(), 
                 y = list(width = 800L, height = 600L))
  expect_equal(
    object = app$get_window_size(), 
    expected = list(width = 800L, height = 600L))
  waldo::compare(x = app$get_dir(), y = app_pth)
  expect_equal(
    object = app$get_dir(),
    expected = app_pth)
  app$set_inputs(`dataset-dataset` = "attitude")
  app_values <- app$get_values()
  # str(app_values)
  waldo::compare(x = app_values$input$`dataset-dataset`,
                 y = "attitude")
  expect_equal(
    object = app_values$input$`dataset-dataset`,
    expected = "attitude")
  app$stop()
})
