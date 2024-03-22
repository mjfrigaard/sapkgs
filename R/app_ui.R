#' app (UI)
#'
#' @return UI function for `shinyApp()`
#'
#' @export app_ui
#'
#' @keywords internal
#'
app_ui <- function() {
  tagList(
    page_sidebar(
      title = "utap",
      sidebar = sidebar(
        title = h5(strong("Inputs")),
        mod_data_ui("data"),
        mod_cols_ui("cols")
      ),
      card(
        mod_var_ui("vars"),
        verbatimTextOutput(outputId = "vals")
      )
    )
  )
}
