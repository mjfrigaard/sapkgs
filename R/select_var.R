#' Select variable input UI
#'
#' @param id namespaced id
#'
#' @return module UI function
#' @export mod_select_var_ui
#'
#' @importFrom shiny NS h5 code tagList selectInput
#'
mod_select_var_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h5(shiny::code("mod_select_var")),
    shiny::selectInput(ns("select_var"),
      label = "Variable",
      choices = NULL
    )
  )
}

#' Select variable module server
#'
#' @param id namespaced id
#' @param data selected dataset
#' @param filter function for filtering data object
#'
#' @export mod_select_var_server
#'
#' @importFrom shiny moduleServer observe updateSelectInput
#' @importFrom shiny bindEvent reactive
#'
mod_select_var_server <- function(id, data, filter = is.numeric) {
  shiny::moduleServer(id, function(input, output, session) {
    shiny::observe({
      shiny::updateSelectInput(session,
        inputId = "select_var",
        choices = find_vars(
          data = data(),
          filter = filter
        )
      )
    }) |>
      shiny::bindEvent(data())

    shiny::reactive(data()[[input$select_var]])
  })
}
