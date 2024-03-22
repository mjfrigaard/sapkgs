# check returns df ----
describe("select_class() returned objects", code = {
  it("df returned", {
    # define test data
    test_col_class <- data.frame(
      log_var = c(TRUE, FALSE, TRUE),
      int_var = c(1L, 2L, 3L),
      dbl_var = c(1.1, 2.2, 3.3),
      chr_var = c("item:1", "item:2", "item:3"),
      ord_var = factor(
        x = c("level 1", "level 2", "level 3"),
        levels = c("level 1", "level 2", "level 3"),
        labels = c("level 1", "level 2", "level 3"),
        ordered = TRUE
      ),
      fct_var = factor(
        x = c("group 1", "group 2", "group 3"),
        levels = c("group 1", "group 2", "group 3"),
        labels = c("group 1", "group 2", "group 3")
      )
    )
    list_var <- list(
      log = c(TRUE, FALSE, TRUE),
      dbl = c(1.1, 2.2, 3.3),
      chr = c("item:1", "item:2", "item:3")
    )
    test_col_class$list_var <- list_var
    # create object
    object <- select_class(df = test_col_class, class = "logical")
    # test object
    expect_s3_class(object, "data.frame")
  })
  it("df returned", {
    test_data <- col_maker(
      col_type = c("log", "int", "dbl", "chr"),
      size = 6, missing = FALSE
    )
    expect_s3_class(select_class(df = test_data, class = "log"),
      class = c("tbl_df", "tbl", "data.frame")
    )
  })
  it("string returned", {
    test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))
    object <- select_class(
      df = test_col_class,
      class = "logical", return_tbl = FALSE
    )
    expect_type(object = object, type = "character")
  })
  it("named vector returned", {
    test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))
    object <- select_class(
      df = test_col_class,
      class = "logical", return_tbl = FALSE
    )
    expect_named(object = object, expected = "log_var")
  })
})



# check classes ----
describe("select_class() return classes", code = {
  # check logical ----
  describe("logical classes", code = {
    it("select_class() logical works", {
      test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))
      # define object
      obj <- select_class(df = test_col_class, class = "logical")
      # test type
      expect_type(object = obj[[1]], type = "logical")
      # define the object
      obj <- select_class(df = col_maker(
              col_type = c("log", "int", "dbl", "chr"),
              size = 6,
              missing = FALSE,
              lvls = 4
            ), class = "log")
      # test class
      expect_true(is.logical(obj[[1]]))
      expect_equal(
        select_class(
          df = col_maker(
            col_type = c("log", "int", "dbl", "chr"),
            size = 6,
            missing = FALSE,
            lvls = 4
          ),
          class = "log",
          return_tbl = FALSE
        ),
        expected = c(log_var = "log_var")
      )
    })
    # check integer ----
    describe("integer classes", code = {
      it("select_class() integer works", {
        test_col_class <-
          readRDS(test_path("fixtures", "test_col_class.rds"))
        object <-
          select_class(df = test_col_class, class = "integer")
        expect_type(object = object[[1]], type = "integer")
        expect_equal(
          select_class(df = test_col_class, class = "integer") |>
            lapply(is.integer) |> unlist() |> unique(),
          expected = TRUE
        )
        int_test <- col_maker(
          col_type = c("log", "int", "dbl", "chr"),
          size = 6,
          missing = FALSE,
          lvls = 4
        )
        expect_equal(
          select_class(df = int_test, class = "int") |>
            unlist() |>
            is.integer(),
          expected = TRUE
        )
        expect_equal(
          select_class(
            df = int_test,
            class = "int",
            return_tbl = FALSE
          ),
          expected = c(int_var = "int_var")
        )
      })
    })
  })

  # check double ----
  describe("integer double", code = {
    it("select_class() double works", {
      test_col_class <-
        readRDS(test_path("fixtures", "test_col_class.rds"))
      object <-
        select_class(df = test_col_class, class = "double")
      expect_type(object = object[[1]], type = "double")
      expect_equal(
        select_class(df = test_col_class, class = "double") |>
          lapply(is.double) |> unlist() |> unique(),
        expected = TRUE
      )
      dbl_test <- col_maker(
        col_type = c("log", "int", "dbl", "chr"),
        size = 6,
        missing = FALSE,
        lvls = 4
      )
      expect_equal(
        select_class(
          df = dbl_test,
          class = "double"
        ) |>
          unlist() |>
          is.double(),
        expected = TRUE
      )
      expect_equal(
        select_class(
          df = dbl_test,
          class = "double",
          return_tbl = FALSE
        ),
        expected = c(dbl_var = "dbl_var")
      )
    })
  })
  # check character ----
  describe("character works", code = {
    it("character", {
      test_col_class <-
        readRDS(test_path("fixtures", "test_col_class.rds"))
      object <- select_class(df = test_col_class, class = "character")
      expect_type(object = object[[1]], type = "character")
      expect_equal(
        select_class(df = test_col_class, class = "character") |>
          lapply(is.character) |> unlist() |> unique(),
        expected = TRUE
      )
      chr_test <- col_maker(
        col_type = c("log", "int", "dbl", "chr"),
        size = 6,
        missing = FALSE,
        lvls = 4
      )
      expect_equal(
        select_class(
          df = chr_test,
          class = "character"
        ) |>
          unlist() |>
          is.character(),
        expected = TRUE
      )
      expect_equal(
        select_class(
          df = chr_test,
          class = "character", return_tbl = FALSE
        ),
        expected = c(chr_var = "chr_var")
      )
    })
  })

  # check factor ----
  describe("factor works", code = {
    it("select_class() factor works", {
      test_col_class <- col_maker(
        col_type = c(
          "log", "int", "dbl", "chr",
          "fct", "ord"
        ),
        size = 3,
        missing = FALSE
      )
      object <- select_class(df = test_col_class, class = "factor")
      expect_s3_class(object = object[[1]], class = "factor")
      expect_equal(
        select_class(df = test_col_class, class = "factor") |>
          lapply(is.factor) |> unlist() |> unique(),
        expected = TRUE
      )
      fct_test <- col_maker(
        col_type = c("int", "chr", "fct"),
        size = 6,
        missing = FALSE,
        lvls = 4
      )
      expect_equal(
        select_class(
          df = fct_test,
          class = "factor"
        ) |>
          unlist() |>
          is.factor(),
        expected = TRUE
      )
      expect_equal(
        select_class(
          df = fct_test,
          class = "factor",
          return_tbl = FALSE
        ),
        expected = c(fct_var = "fct_var")
      )
    })
  })

  # check factor (ordered) ----
  describe("ordered works", code = {
    it("ordered", {
      test_col_class <- col_maker(
        col_type = c(
          "log", "int", "dbl", "chr",
          "fct", "ord"
        ),
        size = 3,
        missing = FALSE
      )
      object <- select_class(df = test_col_class, class = "ordered")
      expect_s3_class(object = object[[1]], class = "ordered")
      expect_equal(
        select_class(df = test_col_class, class = "ordered") |>
          lapply(is.ordered) |> unlist() |> unique(),
        expected = TRUE
      )
      ord_test <- col_maker(
        col_type = c("int", "chr", "fct", "ord"),
        size = 6,
        missing = FALSE,
        lvls = 4
      )
      expect_equal(
        select_class(
          df = ord_test,
          class = "ord"
        ) |>
          dplyr::pull(ord_var) |>
          is.ordered(),
        expected = TRUE
      )
      expect_equal(
        select_class(
          df = ord_test,
          class = "ord",
          return_tbl = FALSE
        ),
        expected = c(ord_var = "ord_var")
      )
    })
  })

  describe("list works", code = {
    # check list ----
    it("list", {
      test_col_class <- readRDS(test_path("fixtures", "test_col_class.rds"))
      object <- select_class(df = test_col_class, class = "list")
      expect_type(object = object[[1]], type = "list")
      test_col_class <- tibble::tibble(
        list_var = list(
          fct_maker(size = 3),
          ord_maker(size = 3)
        ),
        log_var = log_maker(size = 2),
        int_var = int_maker(size = 2),
        dbl_var = dbl_maker(size = 2),
        chr_var = chr_maker(size = 2)
      )
      expect_equal(
        select_class(df = test_col_class, class = "list") |>
          lapply(is.list) |> unlist() |> unique(),
        expected = TRUE
      )
      list_test <- tibble::tibble(
        list_var = list(fct_maker(size = 3), ord_maker(size = 3)),
        int = int_maker(size = 2),
        chr = chr_maker(size = 2)
      )
      expect_equal(
        select_class(
          df = list_test,
          class = "list"
        ) |>
          dplyr::pull(list_var) |>
          is.list(),
        expected = TRUE
      )
      expect_equal(
        select_class(
          df = list_test,
          class = "list",
          return_tbl = FALSE
        ),
        expected = c(list_var = "list_var")
      )
    })
  })
})


describe("errors work", code = {
  # test error type ----
  it("select_class() type error", {
    test_col_class <-
      readRDS(test_path("fixtures", "test_col_class.rds"))
    expect_error(object = select_class(
      df = test_col_class,
      class = "array"
    ))
    # test type error
    expect_error(object = select_class(
      df = col_maker(
        col_type = c(
          "log", "int",
          "dbl", "chr",
          "fct", "ord"
        ),
        size = 3,
        missing = FALSE
      ),
      class = "array"
    ))
  })
  it("test empty table", {
    # test class of empty tibble
    expect_s3_class(
      select_class(
        df = col_maker(
          col_type = c("int", "dbl"),
          size = 6, missing = FALSE
        ),
        class = "log"
      ),
      class = c("tbl_df", "tbl", "data.frame")
    )
    # test rows of empty tibble
    expect_equal(
      ncol(select_class(
        df = col_maker(
          col_type = c("int", "dbl"),
          size = 6, missing = FALSE
        ),
        class = "log"
      )),
      expected = 0L
    )
  })
})
