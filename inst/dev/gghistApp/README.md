# gghistApp

This shiny application is a modified version of the [`histogramApp()`](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) to use `ggplot2` functions. 

The `selectVarServer()` module server function has been slightly altered to return a single column `data.frame` (as opposed to the original vector):

``` r
selectVarServer <- function(id, data, filter = is.numeric) {
  stopifnot(shiny::is.reactive(data))
  stopifnot(!shiny::is.reactive(filter))

  shiny::moduleServer(id, function(input, output, session) {

    shiny::observe({
      shiny::updateSelectInput(
        session, "var",
        choices = find_vars(data(), filter))
    }) |>
      shiny::bindEvent(data())

    return(
      shiny::reactive({
        if (input$var %in% names(data())) {
          data()[input$var]
        } else {
          NULL
        }
      }) |>
      shiny::bindEvent(input$var)
    )

  })
}
```

The `gghistServer()` module server function can use `histogramOutput()` UI function and the output from `selectVarServer()`: 

``` r
gghistServer <- function(id, x, title = reactive("Histogram")) {

    stopifnot(shiny::is.reactive(x))
    stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {

    plot_obj <- shiny::reactive({
                  shiny::req(x())
                purrr::as_vector(x())})

    output$hist <- shiny::renderPlot({
      shiny::req(x())
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
      shiny::bindEvent(c(x(), input$bins),
        ignoreNULL = TRUE)
        
    shiny::exportTestValues(
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
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
      ),
      shiny::mainPanel(
        histogramOutput("hist"),
        shiny::verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- datasetServer("data")

    x <- selectVarServer("var", data)

    gghistServer("hist", x)

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

  }

  shiny::shinyApp(ui, server)
}
gghistApp()
```


