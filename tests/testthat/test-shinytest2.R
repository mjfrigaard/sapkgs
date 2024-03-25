library(shinytest2)

test_that("{shinytest2} recording: histogramApp", {
  app <- AppDriver$new(name = "histogramApp", height = 657, width = 1069)
  app$set_inputs(`data-dataset` = "attitude")
  app$set_inputs(`var-var` = "privileges")
  app$set_inputs(`hist-bins` = 11)
  app$set_inputs(`hist-bins` = 12)
  app$set_inputs(`hist-bins` = 13)
  app$set_inputs(`hist-bins` = 14)
  app$set_inputs(`hist-bins` = 15)
  app$expect_values()
})
