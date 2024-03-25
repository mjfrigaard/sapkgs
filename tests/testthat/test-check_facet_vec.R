describe("check_facet_vec() works", {
  it("test character (4 unique values)", {
    test_data <- chr_maker(size = 10, lvls = 4)
    chr_test <- check_facet_vec(x = test_data, type = "chr")
    expect_equal(object = chr_test, expected = TRUE)
  })
  it("test character (4 unique values and missing)", {
    test_data <- chr_maker(size = 10, lvls = 4, missing = TRUE)
    chr_test <- check_facet_vec(x = test_data, type = "chr")
    expect_equal(object = chr_test, expected = TRUE)
  })
  it("test character (4 unique values and missing)", {
    test_data <- chr_maker(size = 10, lvls = 4, missing = TRUE)
    chr_test <- check_facet_vec(x = test_data, type = "chr")
    expect_equal(object = chr_test, expected = TRUE)
  })
})
