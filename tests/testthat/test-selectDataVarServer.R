testServer(selectDataVarServer, args = list(filter = is.numeric), expr = {
  expect_true(is.reactive(data))
  test_cmt("selectDataVarServer", "is.reactive(data)")
  expect_true(is.reactive(var))
  test_cmt("selectDataVarServer", "is.reactive(var)")

})
