#' Check if package namespace is loaded, if not load it
#'
#' @param pkg name of package (a character vector)
#' @param quiet logical, print messages
#'
#' @return Package: `'name'` loaded or Loading package: `'name'`
#' @export check_pkg_ns
#'
#' @description
#' Check if `pkg` is installed with `isNamespaceLoaded()`. If not, package is
#' installed with `requireNamespace(quietly = TRUE)`.
#'
#'
#' @examples
#' # remove from ns
#' unloadNamespace("box")
#' # with single pkg
#' check_pkg_ns("box")
#' # remove again
#' unloadNamespace("box")
#' # with multiple pkgs
#' pkgs <- c("snakecase", "box")
#' check_pkg_ns(pkgs)
check_pkg_ns <- function(pkg, quiet = FALSE) {
  if (!quiet) {
    # with messages
    if (!isNamespaceLoaded(pkg)) {
      if (requireNamespace(pkg, quietly = FALSE)) {
        cli::cli_inform(paste0(pkg, " namespace loaded\n"))
      } else {
        cli::cli_abort(paste0(pkg, " not available"))
      }
    } else {
      cli::cli_inform(paste0("Package ", pkg, " loaded\n"))
    }
  } else {
    # without messages
    if (!isNamespaceLoaded(pkg)) {
      if (!requireNamespace(pkg, quietly = TRUE)) {
        cli::cli_abort(paste0(pkg, " not available"))
      }
    }
  }
}
# check_pkg_ns <- function(pkg, quiet = FALSE) {
#   if (isFALSE(quiet)) {
#     # with messages
#     if (!isNamespaceLoaded(pkg)) {
#       if (requireNamespace(pkg, quietly = FALSE)) {
#         cat(paste0(pkg, " namespace loaded\n"))
#       } else {
#         stop(paste0(pkg, " not available"))
#       }
#     } else {
#       cat(paste0("Package ", pkg, " loaded\n"))
#     }
#   } else {
#     # without messages
#     if (!isNamespaceLoaded(pkg)) {
#       if (requireNamespace(pkg, quietly = TRUE)) {
#       } else {
#         stop(paste0(pkg, " not available"))
#       }
#     }
#   }
# }
