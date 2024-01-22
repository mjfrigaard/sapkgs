#' App UI
#'
#'
#' @export appUI
appUI <- function() {
  tagList(
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          # pkg input ----
          mod_pkg_ui("pkg"),
          # dataset input  ----
          mod_ds_ui("ds")
        ),
        mainPanel(
          tags$br(),
          # column inputs ----
          mod_cols_ui(id = "cols"),
          
          # variable inputs ----
          # mod_vars_ui(id = "vars"),
          
          # plot outputs  ----
          mod_plot_ui("plot")
          
          # graph outputs  ----
          # mod_graph_ui("graph")
        )
      )
    )
  )
}



