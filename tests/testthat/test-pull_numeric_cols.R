describe("pull_numeric_cols() test_data", {
  it("test numeric columns", {
  test_data <- readRDS(testthat::test_path("fixtures", "test_data.rds"))
  testthat::expect_equal(pull_numeric_cols(test_data),
    c(dbl_var = "dbl_var", int_var = "int_var")
  )
  })
})
describe("pull_numeric_cols() helpers data", {
  it("test no integer/double", {
  null_tbl <- col_maker(col_type = c("log", "chr", "fct",  "ord"), size = 10,
                        missing = FALSE)
  expect_null(object = pull_numeric_cols(null_tbl))
  })
})
