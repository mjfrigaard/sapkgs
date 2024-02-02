test_that("%nin% works", {
  expect_false(
    object = "A" %nin% LETTERS)
  expect_false(
    object = 1 %nin% 1:10)
  expect_true(
    object = 1 %nin% 2:10)
})
