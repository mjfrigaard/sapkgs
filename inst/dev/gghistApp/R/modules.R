

# dataset module ----------------------------------------------------------

datasetInput <- function(id, filter = NULL) {
  names <- ls("package:datasets")

  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }

  selectInput(
    NS(id, "dataset"),
    "Pick a dataset",
    choices = names)
}

datasetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive(get(input$dataset, "package:datasets"))
  })
}

# selectVar module --------------------------------------------------------

selectVarInput <- function(id) {

  selectInput(
    NS(id, "var"),
    label = "Variable",
    choices = NULL)

}

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

## find_vars --------------------------------------------------------
find_vars <- function(data, filter = is.vector) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}

# histogramOutput (ui) ---------------------------------------------------------

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
      NS(id, "hist")),
    code("module vals"),
    verbatimTextOutput(
      NS(id, "vals"))

  )
}


# gghistServer (server) --------------------------------------------------

gghistServer <- function(id, x, title = reactive("Histogram")) {

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

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

    exportTestValues(
      x = x(),
      plot_obj = plot_obj()
    )

  })
}
