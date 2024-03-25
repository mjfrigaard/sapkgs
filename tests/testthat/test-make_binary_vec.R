describe("make_binary_vec() works", {
  it("logical", {
    test_data <- data.frame(log_var = c(TRUE, FALSE, TRUE))
    expect_equal(
      object = make_binary_vec(test_data, type = 'log'),
      expected = c(log_var = "log_var"))
  })
it("integer", {
  test_data <- data.frame(int_var = c(1L, 0L, 1L))
  expect_equal(
    object = make_binary_vec(test_data, type = "int"),
    expected = c(int_var = 'int_var'))
  })
it("character", {
  test_data <- data.frame(chr_var = c('TRUE', 'FALSE', 'TRUE'))
    expect_equal(
      object = make_binary_vec(test_data, type = 'chr'),
      expected = c(chr_var = "chr_var"))
})
it("factor", {
  test_data <- data.frame(fct_var = structure(c(2L, 1L, 1L, NA),
    levels = c("female", "male"), class = "factor"))
  expect_equal(
      make_binary_vec(test_data, type = "fct"),
      expected = c(fct_var = "fct_var"))
  })
})
