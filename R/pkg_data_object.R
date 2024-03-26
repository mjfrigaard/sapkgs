#' Get dataset from package
#'
#' @param ds name of dataset
#' @param pkg name of package
#'
#' @return data object
#'
#' @export 
#'
#' @examples
#' require(forcats)
#' pkg_data_object("gss_cat", "forcats")
#' require(dplyr)
#' pkg_data_object("starwars", "dplyr")
pkg_data_object <- function(ds, pkg) {
  # use 'gsub' to remove extra spaces and characters
  objname <- gsub(" .*", "", ds)
  
  # Load the namespace of the package
  e <- loadNamespace(pkg)
  
  # check if the data object exists within the environment of 
  # the loaded package
  if (!exists(ds, envir = e)) {
    dataname <- gsub("^.*\\(|\\)$", "", ds)
    # create a new environment for loading the data if it doesn't 
    # exist in the package's namespace
    e <- new.env()
    # Load the data into the new environment
    data(list = dataname, package = pkg, envir = e)
  }
  
  # retrieve the data object from the environment
  data_obj <- get(objname, envir = e)
  return(data_obj)
}
# tidyverse version -----
# pkg_data_object <- function(ds, pkg) {
#   objname <- stringr::str_remove_all(ds, " .*")
#   e <- loadNamespace(pkg)
#   if (!exists(ds, envir = e)) {
#     dataname <- stringr::str_replace_all(ds, "^.*\\(|\\)$", "")
#     e <- new.env()
#     data(list = dataname, package = pkg, envir = e)
#   }
#   data_obj <- get(objname, envir = e)
#   return(data_obj)
# }
