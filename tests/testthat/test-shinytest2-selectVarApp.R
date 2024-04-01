library(shinytest2)
# remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)

test_that("mstsap::selectVarApp", {
  app_pth <- system.file("dev", "selectVarApp", package = "mstsap")
  app <- AppDriver$new(app_pth, height = 1200, width = 1000)
  # app$view()
  expect_equal(app$get_window_size(), 
                 list(width = 1000L, height = 1200L))
  expect_equal(app$get_dir(), app_pth)
  app$set_inputs(`data-dataset` = "mtcars")
  app$set_inputs(`var-var` = "wt")
  app_values <- app$get_values()
  expect_true(
    object = is.data.frame(app_values$export$data))
  expect_true(
    object = is.numeric(app_values$export$var))
  app$stop()
})
