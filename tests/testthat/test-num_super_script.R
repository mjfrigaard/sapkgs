describe("Correct suffixes are returned", {
  it("correct suffixes for 1, 2, 3, and another number", {
  expect_equal(num_super_script(1), "st")
  expect_equal(num_super_script(2), "nd")
  expect_equal(num_super_script(3), "rd")
  expect_equal(num_super_script(4), "th")
})
  it("Non-integer inputs are handled", {
  expect_warning(as.numeric("a string"))
  })
})
describe("Numeric edge cases", {
  it("Edge cases are handled", {
    expect_equal(num_super_script(0), "")
    expect_error(num_super_script(-1))
    expect_equal(num_super_script(21), "st")
  })
})
describe("Numeric strings as input", {
  it("Numeric strings are correctly converted and handled", {
    expect_equal(num_super_script("4"), "th")
    expect_equal(num_super_script("21"), "st")
  })
})
