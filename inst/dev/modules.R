library(shiny)
require(debugApp)
library(gargoyle)


# mod_pkg -----------------------------------------------------------------
mod_pkg_ui <- function(id) {
  df_pkgs <- pkg_nms_with_dfs()
  ns <- NS(id)
  tagList(
    selectInput(ns("pkg"),
      label = "Pick a package",
      choices = df_pkgs
    )
  )
}

mod_pkg_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive({
      req(c(input$pkg))
      input$pkg
    })
  })
}


# mod_ds ------------------------------------------------------------------
mod_ds_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("dataset"),
      label = "Pick a dataset",
      choices = NULL
    )
  )
}

mod_ds_server <- function(id, pkg_input) {
  moduleServer(id, function(input, output, session) {
    observe({
      df_names <- df_nms_from_pkgs(pkg = pkg_input())
      updateSelectInput(
        session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1]
      )
    }) |>
      bindEvent(pkg_input(), ignoreNULL = TRUE)

    reactive({
      req(input$dataset, pkg_input())
      get(
        x = input$dataset,
        pos = paste0("package:", pkg_input())
      )
    }) |>
      bindCache(c(pkg_input(), input$dataset)) |>
      bindEvent(input$dataset)
  })
}


# mod_cols ----------------------------------------------------------------

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
    )
  )
}

mod_cols_server <- function(id, ds_input) {
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

    return(
      reactive({
        req(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        ))

        list(
          df = janitor::clean_names(ds_input()),
          x_var = input$x,
          y_var = input$y,
          col_var = input$col,
          facet_var = input$facet,
          alpha = input$alpha,
          size = input$size
        )
      }) |>
        # bind to cache
        bindCache(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        )) |>
        # bind to event
        bindEvent(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        ))
    )
  })
}


# mod_graph ----------------------------------------------------------------
mod_graph_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        plotOutput(outputId = ns("graph"))
      )
    ),
    fluidRow(
      column(
        width = 12,
        verbatimTextOutput(ns("vals"))
      )
    )
  )
}

mod_graph_server <- function(id, ds_input, col_inputs) {
  moduleServer(id, function(input, output, session) {
    plot_data <- reactive({
      if (sum(col_inputs() %in% names(janitor::clean_names(ds_input()))) == 4) {
        list(
          df = janitor::clean_names(ds_input()),
          x_var = col_inputs()$x_var,
          y_var = col_inputs()$y_var,
          col_var = col_inputs()$col_var,
          facet_var = col_inputs()$facet_var,
          alpha = col_inputs()$alpha,
          size = col_inputs()$size
        )
      } else {
        NULL
      }
    }) |>
      bindEvent(c(ds_input(), col_inputs()),
        ignoreNULL = TRUE
      )

    observe({
      output$graph <- renderPlot({
        req(plot_data())
        gg_color_scatter_facet(
          df = janitor::clean_names(ds_input()),
          x_var = col_inputs()$x_var,
          y_var = col_inputs()$y_var,
          col_var = col_inputs()$col_var,
          facet_var = col_inputs()$facet_var,
          alpha = col_inputs()$alpha,
          size = col_inputs()$size
        )
      })
    }) |>
      bindEvent(plot_data(),
        ignoreNULL = TRUE
      )
  })
}
