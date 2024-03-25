testServer(mod_abc_server, {
  # Test initial value
  expect_equal(input$num, NULL)
  cat("\n Test 1 initial input$num = NULL: ", is.null(input$num), "\n")
  # set inputs
  session$setInputs(num = 3)
  # Test set inputs
  expect_equal(input$num, 3)
  cat("\n Test 2 setInputs(num = 3):", input$num, "\n")
  # Test super script
  expect_equal(object = sup_scrpt(), expected = "rd")
  cat("\n Test 3 sup_scrpt(): = 'rd':", sup_scrpt(), "\n")
  # Test letter
  expect_equal(object = letter(), expected = "C")
  cat("\n Test 4 letter() = C:", letter(), "\n")
  # Test output
  expect_true(is.list(output$txt))
  print(output$txt)
})
