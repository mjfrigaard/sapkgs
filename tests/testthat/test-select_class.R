test_that(desc = "select_class() return df works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "logical")

  expect_s3_class(object, "data.frame")

})

test_that(desc = "select_class() return vector works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "logical", return_tbl = FALSE)

  expect_type(object = object, type = "character")

})

test_that(desc = "select_class() return vector works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "logical", return_tbl = FALSE)

  expect_named(object = object, expected = "log_var")

})


test_that(desc = "select_class() logical works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "logical")

  expect_type(object = object[[1]], type = "logical")

})

test_that(desc = "select_class() integer works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "integer")

  expect_type(object = object[[1]], type = "integer")

})

test_that(desc = "select_class() double works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "double")

  expect_type(object = object[[1]], type = "double")

})

test_that(desc = "select_class() character works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "character")

  expect_type(object = object[[1]], type = "character")

})

test_that(desc = "select_class() factor works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "factor")

  expect_s3_class(object = object[[1]], class = "factor")

})

test_that(desc = "select_class() ordered works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "ordered")

  expect_s3_class(object = object[[1]], class = "ordered")

})

test_that(desc = "select_class() list works", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))

  object <- select_class(df = test_col_class, class = "list")

  expect_type(object = object[[1]], type = "list")

})

test_that("select_class() type error", {

  test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))
  # test type error
  expect_error(
    object = select_class(df = test_col_class, class = "array"))
})
