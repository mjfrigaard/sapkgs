#' Select variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_vars_ui
#'
#'
mod_vars_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 6,
        selectInput(
          inputId = ns("x"),
          label = "X variable:",
          choices = NULL
        ),
        selectInput(
          inputId = ns("y"),
          label = "Y variable:",
          choices = NULL
        )
      ),
      column(
        6,
        selectInput(
          inputId = ns("col"),
          label = "Color variable:",
          choices = NULL
        ),
        selectInput(
          inputId = ns("facet"),
          label = "Group variable:",
          choices = NULL
        )
      )
    )
    # fluidRow(
    #   column(
    #     width = 6,
    #     verbatimTextOutput(ns("vals"))
    #   )
    # ),
  )
}


#' Select variables Server module
#'
#' @param id module id
#' @param ds_input pkg data from
#'
#' @section Returned object (`graph_values`):
#'
#' The returned object passed to `ds_input` is the result of:
#'
#' ```
#' get(x = input$dataset, pos = paste0("package:", pkg_input()))
#' ```
#'
#' * The `ds_input` is converted to `pkg_data()` and used to populate the
#' `selectInput()`s for the `x`, `y`, `color`, and `facet` inputs.
#'
#'
#' @return shiny server module
#' @export mod_vars_server
#'
#'
mod_vars_server <- function(id, ds_input) {
  moduleServer(id, function(input, output, session) {
    pkg_data <- reactive({
      janitor::clean_names(ds_input())
    }) |>
      bindEvent(ds_input(),
        ignoreNULL = TRUE
      )

    observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1]
      )
    }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2]
      )
    }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1]
      )
    }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1]
      )
    }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    df_vars <- reactive({
      cols <- c(input$x, input$y, input$col, input$facet)
      if (sum(cols %in% names(pkg_data())) == 4) {
        dplyr::select(
          .data = pkg_data(),
          dplyr::all_of(c(
            input$x, input$y,
            input$col, input$facet
          ))
        )
      }
    }) |>
      bindEvent(
        c(
          pkg_data(),
          input$x, input$y,
          input$col, input$facet
        ),
        ignoreNULL = TRUE
      )

    return(
      reactive({
        cols <- c(input$x, input$y, input$col, input$facet)
        if (sum(cols %in% names(pkg_data())) == 4) {
          dplyr::select(
            .data = pkg_data(),
            dplyr::all_of(c(
              input$x, input$y,
              input$col, input$facet
            ))
          )
        }
      }) |>
        bindEvent(
          c(
            pkg_data(),
            input$x, input$y,
            input$col, input$facet
          ),
          ignoreNULL = TRUE
        )
    )
  })
}
