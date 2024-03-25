#' Select data module UI
#'
#' @param id namespaced id
#'
#' @return UI module
#' @export mod_select_data_ui
#'
#' @importFrom shiny h4 code NS tagList
#'
mod_select_data_ui <- function(id, pkg) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h4(shiny::code("mod_select_data_ui")),
        mod_ds_input_ui(id = ns("data"),
                        pkg = pkg,
                        filter = is.data.frame),
        mod_select_var_ui(id = ns("var")
      )
  )
}

#' Select data module UI
#'
#'
#' @param id namespaced id
#' @param filter function passed to variable from dataset
#'
#' @return UI module
#' @export mod_select_data_server
#'
mod_select_data_server <- function(id, pkg, filter = is.numeric) {

  shiny::moduleServer(id, function(input, output, session) {

    data <- mod_ds_input_server(id = "data", pkg = pkg)

    var <- mod_select_var_server(id = "var",
                                 data = data,
                                 filter = filter)

    var
  })
}
