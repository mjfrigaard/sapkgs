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
