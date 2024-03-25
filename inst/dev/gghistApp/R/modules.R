

# dataset module ----------------------------------------------------------

datasetInput <- function(id, filter = NULL) {
  names <- ls("package:datasets")

  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }

  shiny::selectInput(
    shiny::NS(id, "dataset"),
    "Pick a dataset",
    choices = names)
}

datasetServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    shiny::reactive(get(input$dataset, "package:datasets"))
  })
}

# selectVar module --------------------------------------------------------

selectVarInput <- function(id) {

  shiny::selectInput(
    shiny::NS(id, "var"),
    label = "Variable",
    choices = NULL)

}

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

## find_vars --------------------------------------------------------
find_vars <- function(data, filter = is.vector) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}

# histogramOutput (ui) ---------------------------------------------------------

histogramOutput <- function(id) {
  shiny::tagList(
    shiny::numericInput(
      shiny::NS(id, "bins"),
      label = "bins",
      value = 10,
      min = 1,
      step = 1
    ),
    shiny::plotOutput(
      shiny::NS(id, "hist")),
    shiny::code("module vals"),
    shiny::verbatimTextOutput(
      shiny::NS(id, "vals"))

  )
}


# gghistServer (server) --------------------------------------------------

gghistServer <- function(id, x, title = reactive("Histogram")) {

    stopifnot(shiny::is.reactive(x))
    stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {

    plot_obj <- shiny::reactive({
                  shiny::req(x())
                  purrr::as_vector(x())
                  })

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

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

    shiny::exportTestValues(
      x = x(),
      plot_obj = plot_obj()
    )

  })
}
