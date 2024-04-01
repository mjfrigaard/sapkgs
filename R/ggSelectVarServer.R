#' `ggSelectVarServer()`: Shiny Module Server Function for Selecting Variables
#'
#' `ggSelectVarServer()` creates a server-side module for a Shiny application
#' that allows users to select a variable from a reactive dataset. The choices
#' for the variables are filtered based on a provided function. By default, 
#' it filters for numeric variables. It observes changes to the dataset and 
#' updates the variable choices dynamically.
#' 
#' @section Updates to selectVarServer: 
#' This shiny application is a modified version of the [`histogramApp()`](https://mastering-shiny.org/scaling-modules.html#case-study-histogram) to 
#' use `ggplot2` functions.  The `selectVarServer()` module server function has
#' been slightly altered to return a single column `data.frame` (as opposed to
#' the original vector):
#'
#' @param id A unique identifier for the module's namespace.
#' @param data A reactive expression that returns a dataset. This dataset is
#'   used to populate the choices in the select input based on the filter 
#'   criteria.
#' @param filter A function used to determine which variables in the dataset
#'   should be made available for selection. By default, it filters for 
#'   numeric variables. This function should not be reactive.
#'
#' @return Returns a reactive expression that contains the selected 
#'   variable's values from the dataset. If no variable is selected or if
#'   the selected variable is not found in the dataset, it returns `NULL`.
#'   
#' @export
#'
ggSelectVarServer <- function(id, data, filter = is.numeric) {
  stopifnot(is.reactive(data))
  stopifnot(!is.reactive(filter))

  moduleServer(id, function(input, output, session) {

    observe({
      updateSelectInput(
        session, "var",
        choices = mstsap::find_vars(data(), filter))
    }) |>
      bindEvent(data())

    return(
      reactive({
        if (input$var %in% names(data())) {
          data()[input$var]
        } else {
          NULL
        }
      }) |>
      bindEvent(input$var)
    )

  })
}