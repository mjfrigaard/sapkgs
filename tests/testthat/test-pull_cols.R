describe("pull_cols() works", {
  it("binary columns", {
    test_data <- data.frame(log_var = c(TRUE, FALSE, TRUE),
                             int_var = c(0L, 1L, 0L),
                             dbl_var = c(1.1, 2.2, 3.3),
                             chr_var = c("item:1", "item:2", "item:3"),
                             ord_var = c("level 1", "level 2", "level 3"),
                             fct_var = as.factor(c("group 1", "group 2", "group 3")))
  expect_equal(pull_cols(test_data, "bin"),
    expected = c(log_var = "log_var", int_var = 'int_var'))
  })
  it("numeric columns", {
    test_data <- data.frame(log_var = c(TRUE, FALSE, TRUE),
                             int_var = c(1L, 2L, 3L),
                             dbl_var = c(1.1, 2.2, 3.3),
                             chr_var = c("item:1", "item:2", "item:3"),
                             ord_var = c("level 1", "level 2", "level 3"),
                             fct_var = as.factor(c("group 1", "group 2", "group 3")))
  expect_equal(pull_cols(test_data, "num"),
    expected = c(dbl_var = "dbl_var", int_var = "int_var"))
  })
  it("categorical columns", {
    test_data <- data.frame(log_var = c(TRUE, FALSE, TRUE),
                             int_var = c(1L, 2L, 3L),
                             dbl_var = c(1.1, 2.2, 3.3),
                             chr_var = c("item:1", "item:2", "item:3"),
                             ord_var = c("level 1", "level 2", "level 3"),
                             fct_var = as.factor(c("group 1", "group 2", "group 3")))
    expect_equal(pull_cols(test_data, "cat"),
      expected = c(chr_var = "chr_var", fct_var = "fct_var", ord_var = "ord_var"))
  })
  it("facet columns", {
    test_data <- data.frame(log_var = c(TRUE, FALSE, TRUE),
                             int_var = c(1L, 2L, 3L),
                             dbl_var = c(1.1, 2.2, 3.3),
                             chr_var = c("item:1", "item:2", "item:3"),
                             ord_var = c("level 1", "level 2", "level 3"),
                             fct_var = as.factor(c("group 1", "group 2", "group 3")))
    expect_equal(pull_cols(test_data, "facet"),
      expected = c(chr_var = "chr_var", ord_var = "ord_var", fct_var = "fct_var"))
  })
})
