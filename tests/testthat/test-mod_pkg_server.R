testServer(mod_pkg_server, {

  testthat::expect_equal(input$pkg, NULL)
  cat("\nmod_pkg_server initial input$pkg = NULL\n")

  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_equal(
    object = input$pkg,
    expected = "palmerpenguins")
  tscmt("mod_pkg_server", "change pkg = palmerpenguins")

  session$setInputs(pkg = "NHANES")
  testthat::expect_equal(
    object = input$pkg,
    expected = "NHANES")
  tscmt("mod_pkg_server", "change pkg = NHANES")

  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_true(
    object = is.character(session$returned()))
  tscmt("mod_pkg_server", "class(returned())")

  session$setInputs(pkg = "NHANES")
  expect_equal(object = session$returned(),
    expected = "NHANES")
  tscmt("mod_pkg_server", "value returned()")
})
