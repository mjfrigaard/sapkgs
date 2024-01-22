#' Select variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_cols_ui
#'
#' @importFrom shiny NS tagList selectInput
#' @importFrom shiny sliderInput textInput
#'
mod_cols_ui <- function(id) {
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
        ),
        selectInput(
          inputId = ns("col"),
          label = "Color variable:",
          choices = NULL
        ),
        selectInput(
          inputId = ns("facet"),
          label = "Facet variable:",
          choices = NULL
        )
      ),
      column(
        width = 6,
        sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7
        ),
        sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3
        )
      )
    ),
  fluidRow(
      column(
        width = 6,
          verbatimTextOutput(ns("vals"))
          )
      )
  )
}


#' Select variables Server module
#'
#' @param id module id
#' @param ds_input pkg data from
#'
#' @section Returned object (`ds_input`):
#'
#' The returned object passed to `ds_input` is the result of:
#'
#' ```
#' get(x = input$dataset, pos = paste0("package:", pkg_input()))
#' ```
#'
#' * Where `pkg_input()` is the return value from `mod_pkg_server()`, and
#' `input$dataset` is the reactive value from `mod_ds_server()`
#'
#'
#' @return shiny server module
#' @export mod_cols_server
#'
#' @importFrom janitor clean_names
#' @importFrom shiny NS moduleServer reactive observe bindCache
#' @importFrom shiny bindEvent renderPrint updateSelectInput
#'
mod_cols_server <- function(id, ds_input) {

  stopifnot(is.reactive(ds_input))

  moduleServer(id, function(input, output, session) {

    pkg_data <- reactive({
                    janitor::clean_names(ds_input())
                      }) |>
                bindEvent(ds_input(),
                  ignoreNULL = TRUE)

    observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1])
      }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2])
      }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1])
      }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1])
      }) |>
      bindEvent(pkg_data(),
        ignoreNULL = TRUE)

       return(
          reactive({
            list(
              df = janitor::clean_names(ds_input()),
              x_var = input$x,
              y_var = input$y,
              col_var = input$col,
              facet_var = input$facet,
              alpha = input$alpha,
              size = input$size)
            }) |>
          # bind to event
          bindEvent(c(ds_input(),
                             input$x, input$y,
                             input$col, input$facet,
                             input$alpha, input$size))
        )

  })
}


