#' Check if package is installed, if not install it
#'
#' @param pkg name of package (a character vector)
#'
#' @export check_pkg_inst
#'
#' @description
#' Check if `pkg` is installed with `require()`. If not, package is
#' installed with `install.packages(quietly = TRUE)`.
#'
#'
#' @examples
#' # remove.packages('janitor')
#' check_pkg_inst("janitor")
check_pkg_inst <- function(pkg) {
  # convert pkg to character vector if 
  # it's not already
  libs <- as.character(pkg)
  
  # initialize vector to track which packages 
  # need to be installed
  need <- character()
  
  # Loop through each package
  for (lib in libs) {
    # attempt to load the package quietly
    if (!require(lib, character.only = TRUE, quietly = TRUE)) {
      # if loading fails, add to the list of 
      # packages to install
      need <- c(need, lib)
    }
  }
  
  # if there are packages that need to be installed
  if (length(need) > 0) {
    # suppress warnings during installation
    suppressWarnings({
      # install missing packages
      sapply(need, function(x) install.packages(x, quiet = TRUE, verbose = FALSE))
    })
    
    # attempt to load the namespaces of the installed packages quietly
    sapply(need, function(x) requireNamespace(x, quietly = TRUE))
  }
}
# tidyverse version -----
# check_pkg_inst <- function(pkg) {
#   libs <- as.character(pkg)
#   req <- purrr::map_vec(.x = libs, .f = require,
#                        quietly = TRUE,
#                        character.only = TRUE)
#   need <- libs[req == FALSE]
#   if (length(need) > 0) {
#     suppressWarnings(
#      purrr::walk(.x = need,
#                 .f = install.packages,
#                 quiet = TRUE, verbose = FALSE)
#     )
#      purrr::map(.x = need,
#                 .f = requireNamespace,
#                 quietly = TRUE)
#   }
# }
