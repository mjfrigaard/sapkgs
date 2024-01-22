# appUI -------------------------------------------------------------------
appUI <- function() {
  require(janitor)
  require(palmerpenguins)
  require(NHANES)
      tagList(
        fluidPage(
          title = "gargoyle App",
          sidebarLayout(
            sidebarPanel(
              # pkg input ----
              mod_pkg_ui("pkg"),
              # dataset input  ----
              mod_ds_ui("ds")
            ),
            mainPanel(
              h3(code("gargoyle"),"App"),
              tags$br(),
              # column inputs ----
              mod_cols_ui(id = "cols"),
              # graph outputs  ----
              mod_graph_ui("plot")
            )
          )
        )
      )
    }
