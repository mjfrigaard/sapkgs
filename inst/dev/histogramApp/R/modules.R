# dataset module ----
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
# selectVar module ----
selectVarInput <- function(id) {
  selectInput(
    NS(id, "var"),
    label = "Variable",
    choices = NULL
  )
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
# find vars utility function ----
find_vars <- function(data, filter = is.vector) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}
# histogram module ----
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
histogramServer <- function(id, x, title = reactive("Histogram")) {
  stopifnot(is.reactive(x))
  stopifnot(is.reactive(title))

  moduleServer(id, function(input, output, session) {
    output$hist <- renderPlot({
        req(x())
        main <- paste0(title(), " [", input$bins, "]")
        hist(purrr::as_vector(x()),
          breaks = input$bins,
          main = main
        )
      }, res = 96)

    output$data <- renderPrint({
      req(x())
      print(head(x()))
    })
  })
}
