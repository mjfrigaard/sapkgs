#' Dataset UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_ds_ui
#'
#' @importFrom shiny NS tagList selectInput code p verbatimTextOutput
#'
mod_ds_ui <- function(id) {
  ns <- NS(id)
  tagList(
  selectInput(ns("dataset"),
    label = "Pick a dataset",
    choices = NULL)
    )
}

#' Dataset server module
#'
#' @param id module id
#' @param pkg_input selected package
#'
#' @return shiny server module
#' @export mod_ds_server
#'
#'
#' @section Returned object (`pkg_input`):
#'
#' The returned value passed to `pkg_input` is the result of the
#' `get_pkgs_with_dfs()`, which returns a character vector of all packages with
#' a `data.frame` or `tibble` in their exports.
#'
#' `mod_pkg_server` is the precursor to `mod_ds_server`, and is intended
#' to be return a character vector of packages (see example below):
#'
#' ```
#' pkg <- mod_pkg_server("pkg")
#'
#' mod_ds_server("ds", pkg_input = pkg)
#' ```
#'
#' @importFrom shiny req moduleServer reactive
#' @importFrom shiny renderPrint observe bindEvent bindCache
mod_ds_server <- function(id, pkg_input) {

  moduleServer(id, function(input, output, session) {

     observe({
      df_names <- get_pkg_df_names(pkg = pkg_input())
      updateSelectInput(session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1])
    }) |>
      bindEvent(pkg_input(), ignoreNULL = TRUE)

     reactive({
          req(input$dataset,  pkg_input())
                get(x = input$dataset,
                    pos = paste0("package:", pkg_input()))
                }) |>
                  bindCache(c(pkg_input(), input$dataset)) |>
                  bindEvent(input$dataset)

  })
}
