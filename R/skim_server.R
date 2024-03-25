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
#' @importFrom skimr skim_tee
#' @importFrom lobstr tree
#'
skim_server <- function(input, output, session) {

    var <- mod_select_data_server(id = "var", pkg = "datasets", filter = is.numeric)

    output$out <- shiny::renderPrint(
                      skimr::skim_tee(var()),
                      width = 80)

    output$vals <- shiny::renderPrint({
      vals <- shiny::reactiveValuesToList(x = input, all.names = TRUE)
      lobstr::tree(vals)
      })

  }
