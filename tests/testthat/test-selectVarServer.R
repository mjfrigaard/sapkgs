testServer(selectVarServer,
  args = list(data = reactive(mtcars),
              filter = is.numeric), expr = {
  # args = list(data = mtcars,
  #             filter = is.numeric), expr = {

  expect_true(
    is.reactive(data))
  test_cmt("selectVarServer", "is.reactive(data())")
})

testServer(selectVarServer,
  args = list(data = reactive(chickwts),
              filter = is.numeric), expr = {
  expect_equal(
    find_vars(data(), is.factor),
    "feed")
  test_cmt("selectVarServer", "find_vars()")
})

testServer(selectVarServer,
  args = list(data = reactive(chickwts),
              filter = is.numeric), expr = {
  session$setInputs(var = "weight")
  expect_equal(input$var,
      "weight")
  test_cmt("selectVarServer", "input$var")

  session$setInputs(var = "feed")
  expect_equal(session$returned(),
      chickwts[["feed"]])
  test_cmt("selectVarServer", "session$returned()")

})
