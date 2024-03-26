describe("datasetApp() standalone app function works", {
  it("setting app inputs work", {

    ds_app <- datasetApp()
    testServer(app = ds_app, expr = {
      session$setInputs(`dataset-dataset` = "chickwts")
      cat("\n\toutput$data:\n", output$data, "\n")

      expect_equal(input$`dataset-dataset`, "chickwts")
      test_cmt("datasetApp", "input$`dataset-dataset`")

      expect_true(is.data.frame(data()))
      test_cmt("datasetApp", "is.data.frame(data())")

      expect_equal(names(data()), names(chickwts))
      test_cmt("datasetApp", "names(data())")

      expect_equal(class(output$data), "character")
      test_cmt("datasetApp", "class(output$data)")
    })

  })
})
