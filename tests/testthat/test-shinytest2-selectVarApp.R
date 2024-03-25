library(shinytest2)
remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)

testthat::test_that("{shinytest2}: selectVarApp", {
  app <- AppDriver$new(app_dir = system.file("dev", "selectVarApp",
                                             package = "msst2ap"),
                       height = 600, width = 600)

  app$set_inputs(`data-dataset` = "mtcars")
  app$set_inputs(`var-var` = "wt")

  app_values <- app$get_values()

  testthat::expect_true(
    object = is.data.frame(app_values$export$data))

  testthat::expect_true(
    object = ncol(app_values$export$var) == 1)

  app$stop()
})
