library(shinytest2)
library(chromote)

test_that("{shinytest2} recording: histogramApp", {
  app_pth <- system.file("dev", "histogramApp",
                                  package = "msst2ap")
  app <- AppDriver$new(app_pth, height = 750, width = 1200)
  # app$view()
  app$set_inputs(`data-dataset` = "attitude")
  app$set_inputs(`var-var` = "privileges")
  app$set_inputs(`hist-bins` = 15)
  app_values <- app$get_values()
  expect_equal(
    rlang::is_function(app_values$export$data),
    shiny::is.reactive(app_values$export$data))
  expect_equal(
    rlang::is_function(app_values$export$x),
    shiny::is.reactive(app_values$export$x))
  app_logs <- app$get_logs()
  ds_msg <- subset(app_logs,
                   message == "Setting inputs: 'data-dataset'")
  expect_equal(nrow(ds_msg), 1L)
  var_msg <- subset(app_logs, 
                    message == "Setting inputs: 'var-var'")
  expect_equal(nrow(var_msg), 1L)
  hist_msg <- subset(app_logs, 
                     message == "Setting inputs: 'hist-bins'")
  expect_equal(nrow(hist_msg), 1L)
  app$stop()
})