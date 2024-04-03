# app/main.R

box::use(
  # shiny functions
  shiny[
    NS, fluidPage, sidebarLayout, sidebarPanel, 
    mainPanel, fluidRow, column, tags, icon,
    plotOutput, moduleServer, renderPlot
  ],
  # bslib functions
  bslib[
    layout_sidebar, bs_theme, sidebar, card, 
    card_body, card_title, card_header
  ]
)

# import modules ----
box::use(
  ## load inputs module
  app / view / inputs,
  ## load display module 
  app / view / display,
  ## load clicks module 
  app / view / clicks,
  ## load message module 
  app / view / message,
)

#' rtapp ui
#' @export
ui <- function(id) {
  ns <- NS(id)
  layout_sidebar(theme = bs_theme(
      # Controls the default grayscale palette
      bg = "#202123", 
      fg = "#B8BCC2",
      # Controls the accent (e.g., hyperlink, button, etc) colors
      primary = "#EA80FC", 
      secondary = "#48DAC6",
      base_font = c("Grandstander", "sans-serif"),
      code_font = c("Hack", "monospace"),
      heading_font = "'Helvetica Neue', Helvetica, sans-serif",
      # Can also add lower-level customization
      "input-border-color" = "#EA80FC"),
    sidebar = sidebar(
        # use inputs module UI 
        inputs$ui(ns("vals"))
        ),
    card(
      card_header(
          tags$em(
            "These data were obtained from",
            tags$a("IMBD", href = "http://www.imbd.com/"), "and",
            tags$a("Rotten Tomatoes", href = "https://www.rottentomatoes.com/"),
            ". The data represent 651 randomly sampled movies released between
            1972 to 2014 in the United States."
          )
        ),
        # use clicks module UI
        # clicks$ui(ns("clicks")),
        # use message module UI
        # message$ui(ns("message")),
        # example info button
        tags$button(id = "help-button", icon("info"),
          # add 'onclick' after rhino::build_sass()
          # and rhino::build_js()
          onclick = "App.showHelp()"),
        # use display module UI 
        display$ui(ns("disp"))
      )
    )
}

#' rtapp server
#' @export
server <- function(id) {
  
  moduleServer(id, function(input, output, session) {
    # use inputs module server
    selected_vars <- inputs$server(id = "vals")
    # use display module server
    display$server(
      id = "disp",
      var_inputs = selected_vars
    )
  })
  
  moduleServer(id, function(input, output, session) {
    # clicks$server("clicks")
    # message$server("message")
  })
  
}
