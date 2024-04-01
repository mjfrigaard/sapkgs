# histogramOutput ----
histogramOutput <- function(id) {
  tagList(
    numericInput(
      NS(id, "bins"),
      label = "bins",
      value = 10,
      min = 1,
      step = 1
    ),
    plotOutput(
      NS(id, "hist"))
  )
}
# ggSelectVarServer ----
ggSelectVarServer <- function(id, data, filter = is.numeric) {
  stopifnot(is.reactive(data))
  stopifnot(!is.reactive(filter))

  moduleServer(id, function(input, output, session) {

    observe({
      updateSelectInput(
        session, "var",
        choices = mstsap::find_vars(data(), filter))
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

# ggHistServer (exported test values) ----
ggHistServer <- function(id, x, title = reactive("Histogram")) {
  stopifnot(is.reactive(x))
  stopifnot(is.reactive(title))

  moduleServer(id, function(input, output, session) {
    plot_obj <- reactive({
      req(x())
      purrr::as_vector(x())
    })

    output$hist <- renderPlot({
        req(x())
        ggplot2::ggplot(
          mapping =
            ggplot2::aes(plot_obj())
        ) +
          ggplot2::geom_histogram(bins = input$bins) +
          ggplot2::labs(
            title = paste0(title(), " [bins = ", input$bins, "]"),
            y = "Count",
            x = names(x())
          ) +
          ggplot2::theme_minimal()},
      res = 124
    ) |>
      bindEvent(c(x(), input$bins),
        ignoreNULL = TRUE
      )

    output$vals <- renderPrint({
        x <- reactiveValuesToList(input,
          all.names = TRUE
        )
        print(x, width = 30, max.levels = NULL)},
      width = 30)

    exportTestValues(
      x = x(),
      plot_obj = plot_obj()
    )
  })
}
