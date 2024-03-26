test_that("find_vars", {
    expect_equal(
    object = find_vars(airquality,
                            filter = is.double),
    expected = names(airquality)[vapply(airquality, is.double, logical(1))])
    test_cmt("find_vars", "is.double()")
  expect_equal(
    object = find_vars(mtcars,filter = is.character),
    expected = character())
  test_cmt("find_vars", "is.character()")

  expect_error(object =
      find_vars(state.abb, filter = is.character))
  test_cmt("find_vars", "error: data")

  expect_error(object =
      find_vars(mtcars, filter = is.miracle))
  test_cmt("find_vars", "error: filter")
})
