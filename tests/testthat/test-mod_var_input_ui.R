test_that("mod var input ui works", {
  ui <- mod_var_input_ui("test")
  expect_true(is(ui, "shiny.tag.list"))
})

