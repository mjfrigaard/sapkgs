#' Dataset input UI
#'
#' @param id namespaced id
#' @param filter filter data by ...
#' @param pkg name of package
#'
#' @return options for choices in `shiny::selectInput()`
#' @export mod_ds_input_ui
#'
#' @importFrom shiny NS tagList selectInput code h5
#'
mod_ds_input_ui <- function(id, pkg, filter = NULL) {
  pkg_pos <- paste0("package:", pkg)
  names <- ls(pkg_pos)
  if (!is.null(filter)) {
    data <- lapply(names, get, pkg_pos)
    names <- names[vapply(data, filter, logical(1))]
  }
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::h5(shiny::code("mod_ds_input")),
    shiny::selectInput(
      inputId = ns("ds_input"),
      label = "Pick a dataset", choices = names
    )
  )
}

#' Dataset input Server
#'
#' @param id namespaced id
#'
#' @return module server function
#' @export mod_ds_input_server
#'
#' @importFrom shiny moduleServer reactive
#'
mod_ds_input_server <- function(id, pkg) {
  shiny::moduleServer(id, function(input, output, session) {
    pkg_pos <- paste0("package:", pkg)
    shiny::reactive(
      get(x = input$ds_input, pos = pkg_pos)
    )
  })
}
