#' Dataset input UI
#'
#' @param id namespaced id
#' @param filter filter data by ...
#' @param pkg name of package
#'
#' @return options for choices in `shiny::selectInput()`
#' 
#' @export mod_ds_input_ui
#'
#'
mod_ds_input_ui <- function(id, pkg, filter = NULL) {
  pkg_pos <- paste0("package:", pkg)
  names <- ls(pkg_pos)
  if (!is.null(filter)) {
    data <- lapply(names, get, pkg_pos)
    names <- names[vapply(data, filter, logical(1))]
  }
  ns <- NS(id)
  tagList(
    h5(shiny::code("mod_ds_input")),
    selectInput(
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
#'
mod_ds_input_server <- function(id, pkg) {
  moduleServer(id, function(input, output, session) {
    pkg_pos <- paste0("package:", pkg)
    reactive(
      get(x = input$ds_input, pos = pkg_pos)
    )
  })
}
