#' Skim app (server)
#'
#' @param input shiny server inputs
#' @param output shiny server inputs
#' @param session shiny server inputs
#'
#' @return shiny server argument for `shinyApp()`
#'
#' @export
#'
#'
skim_server <- function(input, output, session) {

    var <- mod_select_data_server(id = "var", pkg = "datasets", filter = is.numeric)

    output$out <- renderPrint(
                      skimr::skim_tee(var()),
                      width = 80)

    output$vals <- renderPrint({
      vals <- reactiveValuesToList(x = input, all.names = TRUE)
      lobstr::tree(vals)
      })

  }
