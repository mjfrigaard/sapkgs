find_vars <- function(data, filter) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}

datasetInput <- function(id, filter = NULL) {
  names <- ls("package:datasets")
  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }
  selectInput(
    NS(id, "dataset"),
    label = "Pick a dataset",
    choices = names)
}

datasetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive({
          get(input$dataset, "package:datasets")
        })
  })
}

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
        session = session,
        inputId = "var",
        choices = find_vars(data(), filter))
    }) |>
      bindEvent(data())
    reactive(data()[[input$var]])
  })
}
