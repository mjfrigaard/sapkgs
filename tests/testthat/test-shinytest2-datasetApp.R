library(shinytest2)
# remotes::install_github("rstudio/chromote", force = TRUE, quiet = TRUE)
library(chromote)

test_that("{shinytest2}: datasetApp", {
  app <- AppDriver$new(app_dir = system.file("dev", "datasetApp", 
                       package = "mstsap"), height = 600, width = 800)
  app$set_inputs(`dataset-dataset` = "attitude")
  app_values <- app$get_values()
  waldo::compare(x = app_values$input$`dataset-dataset`,
                 y = "attitude")
  expect_equal(
    object = app_values$input$`dataset-dataset`,
    expected = "attitude")
  app$stop()
})
