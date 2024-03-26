#' Skim app (UI)
#'
#' @return UI function for `shinyApp()`
#'
#' @export
#'
skim_ui <- function() {
  tagList(
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          mod_select_data_ui(id = "var", pkg = "datasets")
      ),
      mainPanel(
        h3(code("skimVarApp")),
        verbatimTextOutput("out"),
        verbatimTextOutput("vals")
      )
    )
    )
  )
}
