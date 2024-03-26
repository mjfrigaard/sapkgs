#' Variable input UI module
#'
#' @description
#' "*allows the user to select variables of specified type from a given reactive dataset.*"
#'
#' This module function comes from the [Case study: selecting a numeric variable](https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable) section of Mastering Shiny.
#'
#' @param id module id
#'
#'
#' @return module UI variable input
#' @export
#'
#' @importFrom shiny selectInput NS
selectVarInput <- function(id) {

  selectInput(
    NS(id, "var"),
    label = "Variable",
    choices = NULL)

}

#' Variable input server module
#'
#' @description
#' This module function comes from the [Server inputs](https://mastering-shiny.org/scaling-modules.html#server-inputs) section of Mastering Shiny.
#'
#' @section stopifnot():
#'
#' *check that each input to your module is either reactive or constant. If you don’t, and the user supplies the wrong type, they’ll get a cryptic error message. You can make the life of module user much easier with a quick and dirty call to `stopifnot()`*
#'
#' @section returned variable validation:
#' The returned value from `selectVarServer()` has been
#'
#'
#'
#' @param id module id
#' @param data reactive data object to retrieve variables from
#' @param filter passed to `find_vars()`, i.e., the type of variables to list (*this will be set by the caller of the module, so doesn’t need to be reactive*
#'
#' @return shiny server function
#' @export
#'
#' @importFrom shiny moduleServer observe updateSelectInput
#' @importFrom shiny bindEvent reactive is.reactive req
#' @importFrom purrr set_names
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
