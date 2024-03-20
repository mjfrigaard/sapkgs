
describe(description = "", code = {
  
  describe(description = "", code = {
    
    it("find_vars returns correct variable names", {
      df <- data.frame(a = 1:10, b = letters[1:10], c = rnorm(10), d = factor(1:10))
      expect_equal(find_vars(df, is.numeric), c("a", "c"))
      expect_equal(find_vars(df, is.character), "b")
      expect_equal(find_vars(df, is.factor), "d")
    })
  })  
  
  it("find_vars returns empty for no matches", {
    df <- data.frame(a = 1:10, b = letters[1:10])
    expect_equal(find_vars(df, function(x) FALSE), character(0))
  })
})




it("find_vars works with empty data frames", {
  df <- data.frame()
  expect_equal(find_vars(df, is.numeric), character(0))
})

ir("find_vars works with lists", {
  lst <- list(a = 1:10, b = letters[1:10], c = rnorm(10))
  expect_equal(find_vars(lst, is.numeric), c("a", "c"))
})
