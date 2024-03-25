# check returns df ----
describe("select_class() returned objs", code = {
  it("df returned", {
    # define test data
    test_data <- data.frame(
      log_var = c(TRUE, FALSE, TRUE),
      int_var = c(1L, 2L, 3L),
      dbl_var = c(1.1, 2.2, 3.3),
      chr_var = paste0(rep("item:", times = 3), 1:3),
      ord_var = factor(
        x = paste(rep("level", times = 3), 1:3),
        levels = paste(rep("level", times = 3), 1:3),
        labels = paste(rep("level", times = 3), 1:3),
        ordered = TRUE
      ),
      fct_var = factor(
        x = paste(rep("group", times = 3), 1:3),
        levels = paste(rep("group", times = 3), 1:3),
        labels = paste(rep("group", times = 3), 1:3)
      )
    )
    # create list variable
    list_var <- list(
      log = c(TRUE, FALSE, TRUE),
      dbl = c(1.1, 2.2, 3.3),
      chr = paste0(rep("item:", times = 3), 1:3)
    )
    # add to df
    test_data$list_var <- list_var
    # create obj
    obj <- select_class(df = test_data, class = "logical")
    # test obj
    expect_s3_class(obj, "data.frame")
  })
  it("df returned", {
    test_data <- readRDS(test_path("fixtures", "test_data.rds"))
    expect_s3_class(
      select_class(df = test_data, class = "log"),
      class = c("tbl_df", "tbl", "data.frame")
    )
  })
  it("string returned", {
    test_data <- readRDS(test_path("fixtures", "test_data.rds"))
    obj <- select_class(
      df = test_data,
      class = "logical", return_tbl = FALSE
    )
    expect_type(obj, type = "character")
  })
  it("named vector returned", {
    test_data <- readRDS(test_path("fixtures", "test_data.rds"))
    obj <- select_class(
      df = test_data,
      class = "logical", return_tbl = FALSE
    )
    expect_named(obj, expected = "log_var")
  })
})



# check classes ----
describe("select_class() return classes", code = {
  ## check logical ----
    it("logical works", {
      test_data <- readRDS(test_path("fixtures", "test_data.rds"))
      # define obj
      obj <- select_class(df = test_data, class = "logical")
      # test type
      expect_type(obj[[1]], type = "logical")
    })
    ## check integer ----
    it("integer works", {
      test_data <- readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "integer")
      expect_type(obj[[1]], type = "integer")
      })

  ## check double ----
    it("double works", {
      test_data <-
        readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "double")
      expect_type(obj[[1]], type = "double")
    })
  ## check character ----
    it("character works", {
      test_data <-
        readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "character")
      expect_type(obj[[1]], type = "character")
    })
  ## check factor ----
    it("factor works", {
      test_data <- readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "factor")
      expect_s3_class(obj[[1]], class = "factor")
    })
  ## check factor (ordered) ----
    it("ordered works", {
      test_data <- readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "ordered")
      expect_s3_class(obj[[1]], class = "ordered")
    })
    ## check list ----
    it("list works", {
      test_data <- readRDS(test_path("fixtures", "test_data.rds"))
      obj <- select_class(df = test_data, class = "list")
      expect_type(obj[[1]], type = "list")
    })
})


describe("errors work", code = {
  # test error type ----
  it("select_class() type error", {
    test_data <-
      readRDS(test_path("fixtures", "test_data.rds"))
    expect_error( select_class(
      df = test_data,
      class = "array"
    ))
  })
  it("test empty table", {
    # test class of empty tibble
    expect_s3_class(
      select_class(
        df = tibble::tibble(
          int_var = c(1L, 81L, 161L, 242L, 322L, 403L),
          dbl_var = c(0.1, 0.68, 1.26, 1.84, 2.42, 3)), class = "character"),
      class = c("tbl_df", "tbl", "data.frame")
    )
    # test rows of empty tibble
    expect_equal(
      ncol(select_class(
        df = tibble::tibble(
          int_var = c(1L, 81L, 161L, 242L, 322L, 403L),
          dbl_var = c(0.1, 0.68, 1.26, 1.84, 2.42, 3)),
        class = "log"
      )),
      expected = 0L
    )
  })
})
