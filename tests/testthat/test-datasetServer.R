testServer(datasetServer, expr = {

  expect_equal(input$dataset, NULL)
  test_cmt("datasetServer", "dataset$input is NULL")

  session$setInputs(dataset = "faithful")
  expect_equal(input$dataset, "faithful")
  test_cmt("datasetServer", "dataset$input")

  session$setInputs(dataset = "airquality")
  expect_equal(class(session$returned()), "data.frame")
  test_cmt("datasetServer", "class(session$returned())")

  session$setInputs(dataset = "WorldPhones")
  expect_true(is.matrix(session$returned()))
  test_cmt("datasetServer", "is.matrix(session$returned())")

  session$setInputs(dataset = "mtcars")
  expect_equal(typeof(session$returned()), typeof(mtcars))
  test_cmt("datasetServer", "typeof(session$returned())")
})
