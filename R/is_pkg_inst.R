#' Check if a package is installed, if not install it
#'
#'
#' Check if `pkg` is installed with `rlang::is_installed()`. If not, package
#' is installed with `pak::pkg_install()`.
#'
#' @param pkg name of package (a character vector)
#'
#' @examples
#' p <- c("emoji", "palmerpenguins")
#'  if (any(p  %in% loadedNamespaces())) {
#'   remove.packages(p)
#'  }
#' is_pkg_inst(c("emoji", "palmerpenguins"))
#' 
#' @export
#' 
is_pkg_inst <- function(pkg) {
  inst_check <- function(x) {
    if (!rlang::is_installed(pkg = x)) {
      withr::local_options(list(rlib_restart_package_not_found = FALSE))
      pak::pkg_install(pkg = x,
        ask = FALSE,
        dependencies = NA,
        lib = .libPaths()[[1L]])
      library(package = x, quietly = TRUE,
        lib.loc = .libPaths()[[1L]])
    } else if (rlang::is_installed(pkg = x)) {
      library(package = x, quietly = TRUE,
        lib.loc = .libPaths()[[1L]],
        character.only = TRUE)
    } else {
      cli::cli_abort("Package {pkg} not available")
    }
  }
  purrr::walk(.x = pkg, .f = inst_check)
  cli::cli_alert_success("Package {pkg} installed and loaded")
}