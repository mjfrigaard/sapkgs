library(shinytest2)
# remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)

test_that("mstsap::selectVarApp", {
  app <- AppDriver$new(system.file("dev", "selectVarApp",
                       package = "mstsap"),
    height = 800,
    width = 1200
  )
  app$view()
  app$set_inputs(`data-dataset` = "mtcars")
  app$set_inputs(`var-var` = "wt")
  app_values <- app$get_values()
  expect_true(
    object = is.data.frame(app_values$export$data))
  expect_true(
    object = is.numeric(app_values$export$var))
  
})
