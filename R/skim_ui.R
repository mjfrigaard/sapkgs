#' Skim app (UI)
#'
#' @return UI function for `shinyApp()`
#'
#' @export skim_ui
#' 
#' @keywords internal
#'
skim_ui <- function() {
  tagList(
    page_sidebar(
      title = "skimVarApp",
      sidebar = sidebar(
        title = h5(strong("Inputs")),
          mod_select_data_ui(id = "var", 
                             pkg = "datasets")
      ),
      card(
          verbatimTextOutput("out"),
          verbatimTextOutput("vals")
      )
    )
  )
}
