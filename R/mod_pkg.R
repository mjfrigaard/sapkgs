#' Package UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' 
#' @export mod_pkg_ui
#'
#'
mod_pkg_ui <- function(id) {
  # df_pkgs <- pkg_nms_with_dfs()
  # limit this to only two packages 
  df_pkgs <- c("palmerpenguins", "NHANES")
  ns <- NS(id)
  tagList(
  selectInput(ns("pkg"),
    label = "Pick a package",
    choices = df_pkgs)
    )
}

#' Package server module
#'
#' @param id module id
#'
#' @return shiny server module
#'
#'
#' @section Using `mod_pkg_server`:
#'
#' `mod_pkg` is the intended to be used with `mod_ds`.
#'
#' ```
#' pkg <- mod_pkg_server("pkg")
#'
#' mod_ds_server("ds", pkg_input = pkg)
#' ```
#' 
#' #' @export mod_pkg_server
#'

mod_pkg_server <- function(id) {

  moduleServer(id, function(input, output, session) {

      reactive({
          req(c(input$pkg))
            input$pkg
        })

  })
}
