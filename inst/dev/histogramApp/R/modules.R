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
      shiny::NS(id, "hist"))
  )
}
histogramServer <- function(id, x, title = reactive("Histogram")) {
  stopifnot(shiny::is.reactive(x))
  stopifnot(shiny::is.reactive(title))

  shiny::moduleServer(id, function(input, output, session) {
    output$hist <- shiny::renderPlot({
        shiny::req(x())
        main <- paste0(title(), " [", input$bins, "]")
        hist(purrr::as_vector(x()),
          breaks = input$bins,
          main = main
        )
      }, res = 96)

    output$data <- shiny::renderPrint({
      shiny::req(x())
      print(head(x()))
    })
  })
}
