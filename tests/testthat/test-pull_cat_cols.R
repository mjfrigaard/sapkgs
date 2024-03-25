describe("pull_cat_cols() pull_cols_test data", {
  it("fixture data (characters and factors)", {
    test_data <- readRDS(test_path("fixtures", "test_data.rds"))
    expect_equal(pull_cat_cols(test_data),
        c(chr_var = "chr_var", fct_var = "fct_var", ord_var = "ord_var"))
  })
})

describe("pull_cat_cols() nulls", {
  it("test logical columns", {
  null_tbl <- col_maker(col_type = c("log"), size = 10, missing = FALSE)
  expect_null(pull_cat_cols(null_tbl))
  })
  it("test integer columns", {
  null_tbl <- col_maker(col_type = c("int"), size = 10, missing = FALSE)
  expect_null(pull_cat_cols(null_tbl))
  })
  it("test double columns", {
  null_tbl <- col_maker(col_type = c("dbl"), size = 10, missing = FALSE)
  expect_null(pull_cat_cols(null_tbl))
  })
})
