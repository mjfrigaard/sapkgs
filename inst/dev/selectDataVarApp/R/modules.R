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

selectVarInput <- function(id) {
  shiny::selectInput(
    shiny::NS(id, "var"),
    label = "Variable",
    choices = NULL
  )
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

find_vars <- function(data, filter = is.vector) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}

selectDataVarUI <- function(id) {
  shiny::tagList(
    datasetInput(
      shiny::NS(id, "data"),
        filter = is.data.frame),
    selectVarInput(
      shiny::NS(id, "var"))
  )
}
selectDataVarServer <- function(id, filter = is.numeric) {

  shiny::moduleServer(id, function(input, output, session) {
    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)
    var

  })
}
