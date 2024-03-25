#' Skim app (UI)
#'
#' @return UI function for `shinyApp()`
#'
#' @export
#'
#' @importFrom shiny fluidPage sidebarLayout
#' @importFrom shiny sidebarPanel shinyApp
#' @importFrom shiny mainPanel verbatimTextOutput renderPrint
skim_ui <- function() {
  shiny::tagList(
    shiny::fluidPage(
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          mod_select_data_ui(id = "var", pkg = "datasets")
      ),
      shiny::mainPanel(
        shiny::h3(shiny::code("skimVarApp")),
        shiny::verbatimTextOutput("out"),
        shiny::verbatimTextOutput("vals")
      )
    )
    )
  )
}
