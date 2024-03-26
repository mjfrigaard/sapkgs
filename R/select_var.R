#' Select variable input UI
#'
#' @param id namespaced id
#'
#' @return module UI function
#' 
#' @export mod_select_var_ui
#'
#'
mod_select_var_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h5(code("mod_select_var")),
    selectInput(ns("select_var"),
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
#'
mod_select_var_server <- function(id, data, filter = is.numeric) {
  moduleServer(id, function(input, output, session) {
    observe({
      updateSelectInput(session,
        inputId = "select_var",
        choices = find_vars(
          data = data(),
          filter = filter
        )
      )
    }) |>
      bindEvent(data())

    reactive(data()[[input$select_var]])
  })
}
