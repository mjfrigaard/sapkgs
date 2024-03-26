describe("selectVarApp() standalone app function works", {
  it("setting app inputs work", {
    sv_app <- selectVarApp()
    testServer(app = sv_app, expr = {
      session$setInputs(`var-var` = "Ozone",
                        `data-dataset` = "airquality")

    cat("\n\toutput$out:\n", output$out, "\n")
    expect_true(object = is.reactive(var))
    test_cmt("selectVarApp", "is.reactive(var)")

    expect_equal(input$`var-var`, expected = "Ozone")
    test_cmt("selectVarApp", "input$`var-var`")

    expect_true(is.reactive(data))
    test_cmt("selectVarApp", "is.reactive(data)")

    expect_true(is.data.frame(data()))
    test_cmt("selectVarApp", "is.data.frame(data())")

    expect_equal(data()[[input$`var-var`]], airquality[["Ozone"]])
    test_cmt("selectVarApp", "data()[[input$`var-var`]]")
    })
  })
})

