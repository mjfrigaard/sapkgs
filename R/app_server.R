#' app (server)
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
app_server <- function(input, output, session) {

    ds <- mod_data_server(id = "data")

    mod_var_server(id = "vars", ds = ds)

    mod_cols_server(id = "cols", ds = ds)

    output$vals <- renderPrint({
      vals <- reactiveValuesToList(x = input, all.names = TRUE)
      lobstr::tree(vals)
      })

  }
