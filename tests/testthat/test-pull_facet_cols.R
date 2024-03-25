describe("test characters", {
  it("4 unique values, missing", {
    test_data <- chr_maker(size = 10, lvls = 4, missing = TRUE)
    expect_equal(object = check_facet_vec(x = test_data, type = "chr"),
      expected = TRUE)
  })
  it("5 unique values", {
    test_data <- chr_maker(size = 10, lvls = 5)
    expect_equal(object = check_facet_vec(x = test_data, type = "chr"),
      expected = FALSE)
  })

  it("test character (5 unique values, missing)", {
    test_data <- chr_maker(size = 10, lvls = 5, missing = TRUE)
    expect_equal(object = check_facet_vec(x = test_data, type = "chr"),
      expected = FALSE)
  })
})

describe("check_facet_vec() factor", {
  it("test factor (4 levels)", {
  test_data <- fct_maker(size = 10, lvls = 4)
  expect_equal(check_facet_vec(x = test_data, type = "fct"),
    expected = TRUE)
  })
  it("test factor (4 levels, missing)", {
  test_data <- fct_maker(size = 10, lvls = 4, missing = TRUE)
  expect_equal(object = check_facet_vec(x = test_data, type = "fct"),
    expected = TRUE)
  })
  it("test factor (5 levels)", {
  test_data <- fct_maker(size = 10, lvls = 5)
  expect_equal(object = check_facet_vec(x = test_data, type = "fct"),
    expected = FALSE)
  })
  it("test factor (5 levels, missing)", {
  test_data <- fct_maker(size = 10, lvls = 5, missing = TRUE)
  expect_equal(object = check_facet_vec(x = test_data, type = "fct"),
    expected = FALSE)
  })
  it("test factor (4 levels, 5 represented, with missing = 5 unique)", {
    test_data <- factor(c("group 1", "group 2", "group 3",
          NA_character_, "group 4", "group 5"),
        levels = c("group 1", "group 2", "group 3",
          "group 4"))
    expect_equal(object = check_facet_vec(x = test_data, type = "fct"),
      expected = TRUE)
  })
  it("test factor (5 levels, 4 represented, with missing = 4 unique)", {
    test_data <- factor(c("group 1", "group 2", "group 3",
          NA_character_, "group 4"),
        levels = c("group 1", "group 2", "group 3",
          "group 4", "group 5"))
  test_facet <- check_facet_vec(x = test_data, type = "fct")
  expect_equal(object = test_facet,
    expected = TRUE)
  })
})

describe("check_facet_vec() ordered", {
  it("test ordered factor (4 levels)", {
    test_data <- ord_maker(size = 10,lvls = 4)
    expect_equal(object = check_facet_vec(x = test_data, type = "ord"),
      expected = TRUE)
  })
  it("test ordered factor (4 levels, missing)", {
  test_data <- ord_maker(size = 10, lvls = 4, missing = TRUE)
  expect_equal(object = check_facet_vec(test_data, type = "ord"),
    expected = TRUE)
  })
  it("test ordered factor (6 levels)", {
    test_data <- ord_maker(size = 10, lvls = 5)
    expect_equal(object = check_facet_vec(x = test_data, type = "ord"),
      expected = FALSE)
  })
  it("test ordered factor (5 levels, missing)", {
    test_data <- ord_maker(size = 10, lvls = 5, missing = TRUE)
    expect_equal(object = check_facet_vec(x = test_data, type = "ord"),
      expected = FALSE)
  })
  it("test ordered factor (4 levels, 5 represented, missing)", {
    test_data <- factor(c("level 1", "level 2", "level 3",
                 NA_character_, "level 4", "level 5",
                 "level 6"),
                  levels = c("level 1", "level 2", "level 3",
                    "level 4"),
                  ordered = TRUE)
    expect_equal(object = check_facet_vec(x = test_data, type = "ord"),
      expected = TRUE)
  })
  it("test ordered factor (5 levels, 4 represented, missing)", {
    test_data <- factor(c("level 1","level 2", "level 3",
                          NA_character_, "level 4"),
                        levels = c("level 1", "level 2", "level 3",
                                   "level 4", "level 5"))
  expect_equal(object = check_facet_vec(x = test_data, type = "ord"),
    expected = TRUE)
  })
})
