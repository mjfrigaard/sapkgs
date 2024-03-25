describe("pull_binary_cols() works", {
  it("logical works", code = {
  test_data <- data.frame(log = log_maker(size = 2))
  expect_equal(pull_binary_cols(test_data),
    expected = c(log = "log"))
  })
  it("test logical with only TRUE and NA", code = {
  test_data <- data.frame(log = log_maker(size = 2, missing = TRUE))
  expect_equal(pull_binary_cols(test_data),
    expected = c(log = "log"))
  })
  it("test integer with only number and missing", code = {
    test_data <- data.frame(int = int_maker(size = 2, missing = TRUE))
    expect_equal(pull_binary_cols(test_data), expected = NULL)
  })
  it("test integer with only numbers", code = {
  test_data <- data.frame(int = int_maker(size = 2, missing = FALSE))
  expect_equal(pull_binary_cols(test_data),
    expected = NULL
    )
  })
  it("test integer with binary values (0, 1, NA)", code = {
    test_data <- data.frame(int = c(0L, 1L))
    expect_equal(pull_binary_cols(test_data),
    expected = c(int = "int"))
  })
  it("test integer with binary values and missing (0, 1, NA)", code = {
    test_data <- data.frame(int = c(0L, 1L, NA_integer_))
    expect_equal(pull_binary_cols(test_data),
    expected = c(int = "int"))
  })
  it("test character works (with missing)", code = {
  test_data <- data.frame(chr = chr_maker(size = 3, lvls = 2, missing = TRUE))
  expect_equal(pull_binary_cols(test_data),
    expected = c(chr = 'chr'))
  })
  it("character works", code = {
  test_data <- data.frame(chr = chr_maker(size = 3, lvls = 2))
  expect_equal(pull_binary_cols(test_data),
    expected = c(chr = 'chr'))
  })
  it("factor works (with missing)", code = {
  test_data <- data.frame(fct = fct_maker(size = 3, lvls = 2, missing = TRUE))
  expect_equal(pull_binary_cols(test_data),
    expected = c(fct = 'fct'))
  })
})

