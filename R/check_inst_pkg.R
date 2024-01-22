#' Check if package is loaded, if not load it
#'
#' @description
#' Check if `pkg` is installed. If not, package is installed with
#' `install.packages(dependencies = TRUE)` and loaded with
#' `library(pkg, character.only = TRUE)`
#'
#' @param pkg name of package (a character vector)
#'
#' @return Package: `'name'` loaded or Loading package: `'name'`
#'
#' @export check_inst_pkg
#'
#'
#' @examples
#' check_inst_pkg("plotly")
check_inst_pkg <- function(pkg) {
  # Check if the package is installed
  if (!require(pkg, character.only = TRUE)) {
    # Install the package if it's not installed
    withr::local_options(list(rlib_restart_package_not_found = FALSE))
    install.packages(pkg, quiet = TRUE, verbose = FALSE)
    # Load the package
    library(pkg, character.only = TRUE)
  } else {
    message(sprintf("Package '%s' is already installed.", pkg))
  }
}

