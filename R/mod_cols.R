#' Column Selection UI Module
#'
#' @description This function creates a UI module for selecting columns for X,
#' Y, Color, and Facet variables in a dataset. It generates four dropdown menus
#' for each selection, initially filled with no choices.
#'
#' @param id A unique identifier for the module's namespace.
#' @return Returns a UI element consisting of four dropdown menus for selecting
#' columns.
#'
#' @section Details:
#' The function provides UI elements for selecting columns that will later be
#' used in plotting or data analysis tasks. It is meant to be used in conjunction
#' with `mod_cols_server` to dynamically update the choices based on the dataset
#' provided to the server function.
#'
#' @seealso \code{\link[shiny]{selectInput}}, \code{\link[shiny]{NS}}, \code{\link[shiny]{tagList}}
#'
#' @export
mod_cols_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("x"),
      label = "Select X Column",
      choices = c("", NULL)
    ),
    selectInput(
      inputId = ns("y"),
      label = "Select Y Column",
      choices = c("", NULL)
    ),
    selectInput(
      inputId = ns("color"),
      label = "Select Color Column",
      choices = c("", NULL)
    ),
    selectInput(
      inputId = ns("facet"),
      label = "Select Facet Column",
      choices = c("", NULL)
    )
  )
}

#' Column Selection Server Module
#'
#' @description This server module handles the logic for dynamically updating
#' the column selection choices in the UI based on the dataset provided. It
#' filters and updates the choices for X, Y, Color, and Facet columns based on
#' their appropriate data types.
#'
#' @param id A unique identifier for the module's namespace, matching the `id`
#' used in `mod_cols_ui`.
#'
#' @param ds A reactive expression returning the dataset to be used for updating
#'  column choices.
#'
#' @return Does not return a value but updates the UI elements for column
#' selection dynamically.
#'
#' @section Details:
#' The function filters columns based on their data types (numeric for X and Y,
#' binary for Color, and suitable for Faceting) using a helper function
#' `pull_cols`. It then observes these reactive values to update the respective
#'  UI elements accordingly.
#'
#' @seealso \code{\link[shiny]{moduleServer}}, \code{\link[shiny]{reactive}}, \code{\link[shiny]{observe}},
#' \code{\link[shiny]{updateSelectInput}}, \code{\link[shiny]{bindEvent}}
#'
#' @export
mod_cols_server <- function(id, ds) {
  moduleServer(id, function(input, output, session) {
    # pull numeric x and y columns from data
    num_cols <- reactive({
      pull_cols(df = ds(), type = "num")
    })
    # update x input
    observe({
      updateSelectInput(
        session = session,
        inputId = "x",
        selected = num_cols()[1],
        choices = num_cols()
      )
    }) |>
      bindEvent(num_cols())
    # update y input
    observe({
      updateSelectInput(
        session = session,
        inputId = "y",
        selected = num_cols()[2],
        choices = num_cols()
      )
    }) |>
      bindEvent(num_cols())

    # pull binary/color columns from data
    bin_cols <- reactive({
      pull_cols(df = ds(), type = "bin")
    })
    # update color input
    observe({
      updateSelectInput(
        session = session,
        inputId = "color",
        choices = bin_cols()
      )
    }) |>
      bindEvent(bin_cols())

    # pull facet columns from data
    facet_cols <- reactive({
      pull_cols(df = ds(), type = "facet")
    })
    # update facet inputs
    observe({
      updateSelectInput(
        session = session,
        inputId = "facet",
        choices = facet_cols()
      )
    }) |>
      bindEvent(facet_cols())
  })
}
