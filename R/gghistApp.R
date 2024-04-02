#' `ggHistApp`: A Standalone Shiny Application for Dynamic Histogram Visualization
#'
#' `ggHistApp()` launches a Shiny application dedicated to generating dynamic 
#' histograms based on user-selected variables from a given dataset. The application
#' offers a sidebar for dataset and variable selection, and a main panel displaying
#' the histogram and the current application values in a textual format.
#'
#' @details The application UI is defined with a fluid layout containing a sidebar 
#' for input controls and a main panel for output displays. The sidebar allows users
#' to upload a dataset and select a variable from that dataset for histogram 
#' visualization. The `datasetInput()` and `selectVarInput()` functions 
#' provide UI elements for dataset upload and variable selection, respectively. 
#' 
#' @section Server side: 
#' On the server side, `datasetServer` handles the uploaded dataset, while 
#' `ggSelectVarServer()` manages the selection of a variable from this dataset to be 
#' used in the histogram. 
#' 
#' @section App function: 
#' The `ggHistServer()` module is then invoked to generate  and render the 
#' histogram based on the selected variable. Additionally, the  application 
#' provides a textual output (`output$vals`) that prints current input 
#' values, facilitating debugging and user interaction tracking.
#'
#' @return This function does not return a value but launches a Shiny application 
#' with specified UI and server logic, capable of interactive histogram generation.
#'
#' @export
#'
#' @examples
#' # Simply call the function to launch the app
#' if (interactive()) {
#'   ggHistApp()
#' }
#'
#' @note `ggHistApp()` function assumes `datasetInput()`, `selectVarInput()`,
#' and `datasetServer()` are loaded from `mstsap` which is a dependency of 
#' `msst2ap`. These components are  critical for the app's functionality, 
#' handling data upload, variable  selection,and histogram rendering.
#'
ggHistApp <- function() {
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        mstsap::datasetInput("data", filter = is.data.frame),
        mstsap::selectVarInput("var"),
      ),
      mainPanel(
        histogramOutput("hist"),
        code("app vals"),
        verbatimTextOutput("vals")
      )
    )
  )

  server <- function(input, output, session) {

    data <- mstsap::datasetServer("data")
    x <- ggSelectVarServer("var", data)
    ggHistServer("hist", x)

    output$vals <- renderPrint({
      x <- reactiveValuesToList(input,
                          all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
      }, width = 30)

  }

  shinyApp(ui, server)
}
