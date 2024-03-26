# gghistApp

This shiny application is a modified version of the [`histogramApp()`](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) to use `ggplot2` functions. 

The `selectVarServer()` module server function has been slightly altered to return a single column `data.frame` (as opposed to the original vector):

``` r
selectVarServer <- function(id, data, filter = is.numeric) {
  stopifnot(is.reactive(data))
  stopifnot(!is.reactive(filter))

  moduleServer(id, function(input, output, session) {

    observe({
      updateSelectInput(
        session, "var",
        choices = find_vars(data(), filter))
    }) |>
      bindEvent(data())

    return(
      reactive({
        if (input$var %in% names(data())) {
          data()[input$var]
        } else {
          NULL
        }
      }) |>
      bindEvent(input$var)
    )

  })
}
```

The `gghistServer()` module server function can use `histogramOutput()` UI function and the output from `selectVarServer()`: 

``` r
gghistServer <- function(id, x, title = reactive("Histogram")) {

    stopifnot(is.reactive(x))
    stopifnot(is.reactive(title))

  moduleServer(id, function(input, output, session) {

    plot_obj <- reactive({
                  req(x())
                purrr::as_vector(x())})

    output$hist <- renderPlot({
      req(x())
      ggplot2::ggplot(
        mapping =
          ggplot2::aes(plot_obj())) +
          ggplot2::geom_histogram(bins = input$bins) +
          ggplot2::labs(
            title = paste0(title(), " [bins = ", input$bins, "]"),
            y = "Count",
            x = names(x())) +
          ggplot2::theme_minimal()
    }, res = 124) |>
      bindEvent(c(x(), input$bins),
        ignoreNULL = TRUE)
        
    exportTestValues(
      x = x(),
      plot_obj = plot_obj()
    )

  })
}
```

The standalone application function also includes a printed call to `reactiveValuesToList()` in the UI:

``` r
library(shiny)
options(shiny.testmode = TRUE)
gghistApp <- function() {
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      mainPanel(
        histogramOutput("hist"),
        verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- datasetServer("data")

    x <- selectVarServer("var", data)

    gghistServer("hist", x)

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

  }

  shinyApp(ui, server)
}
gghistApp()
```


