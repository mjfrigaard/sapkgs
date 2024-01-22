require(dplyr)
require(tibble)

# create test data
test_data <- tibble::tibble(
               LOG = log_maker(size = 6),
               INT = int_maker(size = 6),
               DBL = dbl_maker(size = 6),
               CHR = chr_maker(size = 6, lvls = 4),
               FCT = fct_maker(size = 6, lvls = 4),
               ORD = ord_maker(size = 6, lvls = 4))

testServer(mod_vars_server,
  args = list(ds_input = reactive(test_data)), expr = {
  testthat::expect_true(object = is.data.frame(pkg_data()))
  cat("\nTest 1 is.data.frame(pkg_data()) >>", is.data.frame(pkg_data()))

  testthat::expect_equal(
    object = pull_numeric_cols(df = pkg_data()),
    expected = setNames(nm = c("dbl", "int")))
cat("\nTest 2 numeric = dbl, int >>", pull_numeric_cols(pkg_data()))

  testthat::expect_equal(
    object = pull_binary_cols(df = pkg_data()),
    expected = setNames(nm = c("log")))
cat("\nTest 3 binary = log >>", pull_binary_cols(pkg_data()))

  testthat::expect_equal(
    object = pull_facet_cols(df = pkg_data()),
    expected = setNames(nm = c("chr", "fct", "ord")))
cat("\nTest 4 facet = chr, fct, ord >>", pull_facet_cols(pkg_data()))

})


# })

# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 5: x_var() -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$x_var, expected = "bill_length_mm")
#     cat("\nTest 5: x_var = bill_length_mm >>", session$returned()$x_var, "\n")
# })
#
# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 6: y_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$y_var, expected = "bill_depth_mm")
#     cat("\nTest 6: y_var = bill_depth_mm >>", session$returned()$y_var, "\n")
# })
#
# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 7: col_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$col_var, expected = "sex")
#     cat("\nTest 7: col_var = sex >>", session$returned()$col_var, "\n")
# })
#
# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 8: facet_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$facet_var, expected = "species")
#     cat("\nTest 8: facet_var = species >>", session$returned()$facet_var, "\n")
# })
#
# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 9: size -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#        object = session$returned()$size, expected = 3)
#     cat("\nTest 9: size = 3 >>", session$returned()$size, "\n")
# })
#
# testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 10: alpha -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$alpha, expected = 1/2)
#     cat("\nTest 10: size = 1/2 >>", session$returned()$alpha, "\n")
# })
