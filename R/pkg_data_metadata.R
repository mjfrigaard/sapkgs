# https://stackoverflow.com/questions/28221755/how-to-split-a-r-data-frame-into-vectors-unbind
#' Get package datasets metadata
#'
#' @param package name of package (a character vector)
#' @param allClass logical (include all classes of data?)
#' @param incPackage logical (include package name in result?)
#' @param maxTitle maximum length of dataset title
#'
#' @description
#' This is a variation on the `vcdExtra::datasets()` function.
#' Read more here:
#' https://github.com/friendly/vcdExtra/blob/master/R/datasets.R
#'
#'
#' @return `data.frame` with 6 variables (`dataset`, `title`, `dimensions`,
#' `obs`, `vars`, `display_title`)
#'
#' @export pkg_data_metadata
#'
#'
#' @examples
#' require(tidyr)
#' pkg_data_metadata("tidyr")
pkg_data_metadata <- function(package, allClass = FALSE,
                     incPackage = length(package) > 1,
                     maxTitle = NULL) {
  # make sure requested packages are available and loaded
  for (i in seq_along(package)) {
    if (!isNamespaceLoaded(package[i])) {
      if (requireNamespace(package[i], quietly = TRUE)) {
        cat(paste("Loading package:", package[i], "\n"))
      } else {
        stop(paste("Package", package[i], "is not available"))
      }
    }
  }
  dsitems <- data(package = package)$results
  wanted <- c("Package", "Item", "Title")

  ds <- as.data.frame(dsitems[, wanted], stringsAsFactors = FALSE)

  getData <- function(x, pkg) {
    objname <- gsub(" .*", "", x)
    e <- loadNamespace(pkg)
    if (!exists(x, envir = e)) {
      dataname <- sub("^.*\\(", "", x)
      dataname <- sub("\\)$", "", dataname)
      e <- new.env()
      data(list = dataname, package = pkg, envir = e)
    }
    get(objname, envir = e)
  }

  getDim <- function(i) {
    data <- getData(ds$Item[i], ds$Package[i])
    if (is.null(dim(data))) length(data) else paste(dim(data), collapse = "x")
  }
  getClass <- function(i) {
    data <- getData(ds$Item[i], ds$Package[i])
    cl <- class(data)
    if (length(cl) > 1 && !allClass) cl[length(cl)] else cl
  }

  ds$dim <- unlist(lapply(seq_len(nrow(ds)), getDim))

  ds$class <- unlist(lapply(seq_len(nrow(ds)), getClass))
  if (!is.null(maxTitle)) ds$Title <- substr(ds$Title, 1, maxTitle)
  if (incPackage) {
    ds[c("Package", "Item", "class", "dim", "Title")]
  } else {
    ds[c("Item", "class", "dim", "Title")]
  }
  # named cols
  ds_cols <- dplyr::select(
    .data = ds,
    package = Package,
    dataset = Item,
    title = Title,
    dimensions = dim
  )
  # observations and variables
  ds_obs_vars <- tidyr::separate(
    data = ds_cols,
    col = dimensions,
    into = c("obs", "vars"),
    sep = "x",
    remove = TRUE
  )
  # tibble
  tbl_out <- tibble::as_tibble(ds_obs_vars)
  return(tbl_out)
}
