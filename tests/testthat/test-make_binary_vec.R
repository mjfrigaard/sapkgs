test_that("make_binary_vec() logical works", {
  binary_vec_test <- readRDS(test_path("fixtures", "binary_vec_test.rds"))
  expect_equal(
    object = binary_vec_test[, grepl(pattern = "log", x = names(binary_vec_test))] |>
      make_binary_vec(type = "log"),
    expected = setNames(object = c("log", "log_na"), nm = c("log", "log_na"))
  )
})
test_that("make_binary_vec() integer works", {
  binary_vec_test <- readRDS(test_path("fixtures", "binary_vec_test.rds"))
  expect_equal(
    object = binary_vec_test[, grepl(pattern = "int", x = names(binary_vec_test))] |>
      make_binary_vec(type = "int"),
    expected = setNames(object = c("int", "int_na"), nm = c("int", "int_na"))
  )
})
test_that("make_binary_vec() character works", {
  binary_vec_test <- readRDS(test_path("fixtures", "binary_vec_test.rds"))
  expect_equal(
    object = binary_vec_test[, grepl(pattern = "chr", x = names(binary_vec_test))] |>
      make_binary_vec(type = "chr"),
    expected = setNames(object = c("chr", "chr_na"), nm = c("chr", "chr_na"))
  )
})
test_that("make_binary_vec() factor works", {
  binary_vec_test <- readRDS(test_path("fixtures", "binary_vec_test.rds"))
  expect_equal(
    object = binary_vec_test[, grepl(pattern = "fct", x = names(binary_vec_test))] |>
      make_binary_vec(type = "fct"),
    expected = setNames(object = c("fct", "fct_na"), nm = c("fct", "fct_na"))
  )
})
test_that("make_binary_vec() ordered works", {
  binary_vec_test <- readRDS(test_path("fixtures", "binary_vec_test.rds"))
  expect_equal(
    object = binary_vec_test[, grepl(pattern = "ord", x = names(binary_vec_test))] |>
      make_binary_vec(type = "ord"),
    expected = setNames(object = c("ord", "ord_na"), nm = c("ord", "ord_na"))
  )
})
