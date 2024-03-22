#' Data Selection UI Module
#'
#' @description This function creates a UI module for selecting datasets. It provides
#' a dropdown menu allowing the user to select between the 'penguins' dataset from
#' the `palmerpenguins` package and the 'starwars' dataset from the `dplyr` package.
#'
#' @param id A unique identifier for the module's namespace.
#'
#' @return Returns a UI element that is a dropdown menu for dataset selection.
#'
#' @section Details:
#' This function utilizes `shiny::selectInput` to create the dropdown menu. It is designed
#' to be used in conjunction with the `mod_data_server` function to provide the functionality
#' of selecting and displaying the dataset in a Shiny application.
#'
#' @seealso \code{\link[shiny]{selectInput}}, \code{\link[palmerpenguins]{penguins}},
#' \code{\link[dplyr]{starwars}}
#'
#' @export
mod_data_ui <- function(id) {
  ns <- NS(id)
  tagList(
      selectInput(
        inputId = ns("data"),
        label = "Select Data",
        choices = c('penguins', 'starwars')
      )
  )
}

#' Data Selection Server Module
#'
#' @description This function creates a server module to handle the selection of datasets
#' made through the UI module created by `mod_data_ui`. It outputs a reactive expression
#' that returns the dataset selected by the user.
#'
#' @param id A unique identifier for the module's namespace, matching the `id` used in
#' `mod_data_ui`.
#'
#' @return Returns a reactive expression containing the selected dataset.
#'
#' @section Details:
#' The function listens to the input from the UI module and returns the corresponding dataset
#' as a reactive expression. It supports selecting the 'penguins' dataset from the
#' `palmerpenguins` package or the 'starwars' dataset from the `dplyr` package.
#'
#' @seealso \code{\link[shiny]{moduleServer}}, \code{\link[shiny]{reactive}},
#' \code{\link[palmerpenguins]{penguins}}, \code{\link[dplyr]{starwars}}
#'
#' @export
mod_data_server <- function(id) {
  moduleServer(id, function(input, output, session) {
      reactive({
        if (input$data == "penguins") {
          palmerpenguins::penguins
        } else {
           dplyr::starwars
        }
      })
  })
}
