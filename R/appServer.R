#' App Server
#'
#' @importFrom shiny reactive renderPrint reactiveValuesToList
#'
#' @export appServer
appServer <- function(input, output, session) {
  # pkg module ----
  pkg <- mod_pkg_server("pkg")

  # dataset module ----
  dataset <- mod_ds_server("ds", pkg_input = pkg)

  # # column module ----
  # plot_values <- mod_cols_server(id = "cols", ds_input = dataset)
  # # plot module ----
  # mod_plot_server("plot", plot_inputs = plot_values)

  # variables module ----
  vars_data <- mod_vars_server(id = "vars", ds_input = dataset)
  # graph module ----
  mod_graph_server("graph", graph_data = vars_data)

}
