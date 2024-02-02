test_that("check_binary_vec logical works", {
  # test logical
  expect_equal(
    object = check_binary_vec(x = c(TRUE, FALSE, NA),
      type = "log"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(TRUE, TRUE),
      type = "log"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(NA, NA, NA),
      type = "log"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(FALSE, FALSE),
      type = "log"),
    expected = TRUE
  )
})

test_that("check_binary_vec integer works", {
  # test
  expect_equal(
    object = check_binary_vec(x = c(0L, 1L, 0L),
      type = "int"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(0L, 1L, NA_integer_),
      type = "int"
    ),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(0L, 0L, NA_integer_),
      type = "int"
    ),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(0L, 0L),
      type = "int"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c(1L, 2L, NA_integer_),
      type = "int"),
    expected = FALSE
  )
  expect_equal(
    object = check_binary_vec(x = c(1L, 2L),
      type = "int"),
    expected = FALSE
  )
})

test_that("check_binary_vec character works", {
  # test characters
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "FALSE", NA_character_),
      type = "chr"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "FALSE"),
      type = "chr"),
    expected = TRUE
  )
  expect_equal(
    object = check_binary_vec(
      x = c("TRUE", "FALSE", "MAYBE", NA_character_),
      type = "chr"),
    expected = FALSE
  )
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "FALSE", "MAYBE"),
      type = "chr"),
    expected = FALSE
  )
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "TRUE", NA_character_),
      type = "chr"),
    expected = FALSE
  )
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "TRUE", NA_character_),
      type = "chr"),
    expected = FALSE
  )
  expect_equal(
    object = check_binary_vec(x = c("TRUE", "TRUE"),
      type = "chr"),
    expected = FALSE
  )
})

test_that("check_binary_vec factor works", {
  # test factors
  expect_equal(
    object = check_binary_vec(
      x = factor(x = c("group 1", "group 2", NA_character_, "group 1"),
                 levels = c("group 1", "group 2")),
      type = "fct"
    ),
    expected = TRUE
  )

  expect_equal(
    object = check_binary_vec(
      x = factor(c("group 1", "group 2", "group 1", "group 2"),
                 levels = c("group 1", "group 2")),
      type = "fct"
    ),
    expected = TRUE
  )

  expect_equal(
    object = check_binary_vec(
      x = factor(c("group 1", "group 2", "group 3", NA_character_),
                levels = c("group 1", "group 2", "group 3")),
      type = "fct"
    ),
    expected = FALSE
  )

  expect_equal(
    object = check_binary_vec(
      x = factor(c("group 1", "group 2", "group 1"),
                 levels = c("group 1", "group 2")),
      type = "fct"
    ),
    expected = TRUE
  )

  expect_equal(
    object = check_binary_vec(
      x = factor(c("group 1", "group 2"),
                levels = c("group 1", "group 2")),
      type = "fct"),
    expected = TRUE
  )

  expect_equal(object = check_binary_vec(
      x = factor(c("hot", "cold"),
      levels = c("hot", "cold", "warm")),
    type = "fct"),
    expected = FALSE
  )
})
