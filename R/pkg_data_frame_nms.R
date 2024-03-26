#' Get names of data.frames from package
#'
#' @param pkg name of package
#'
#' @return named vector of data.frames in package
#' @export pkg_data_frame_nms
#'
#' @examples
#' pkg_data_frame_nms(pkg = "base")
#' pkg_data_frame_nms(pkg = "datasets")
#' pkg_data_frame_nms(pkg = "lubridate")
pkg_data_frame_nms <- function(pkg) {
  # check if the package is installed and load it
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    stop(paste0("Package '", pkg, "' is not installed."))
  }
  # make sure the package namespace is loaded, 
  # without printing messages
  if (!isNamespaceLoaded(pkg)) {
    requireNamespace(pkg, quietly = TRUE)
  }
  # get the position of the package in the search path
  pkg_pos <- paste0("package:", pkg)
  # list all objects in the package namespace
  pkg_nms <- ls(pkg_pos)
  # initialize an empty vector to hold names of data frames
  df_names <- character()
  # loop through each name to check if it's a data frame
  for (nm in pkg_nms) {
    # get object
    obj <- get(nm, envir = asNamespace(pkg))
    if (is.data.frame(obj)) {
      # check 
      df_names <- c(df_names, nm)
    }
  }
  # return the names of the data frames
  # or NULL if none are found
  if (length(df_names) > 0) {
    names(df_names) <- df_names
    return(df_names)
  } else {
    return(NULL)
  }
}
# pkg_data_frame_nms <- function(pkg) {
#   check_pkg_inst(pkg)
#   check_pkg_ns(pkg, quiet = TRUE)
#   pkg_pos <- paste0("package:", pkg)
#   pkg_nms <- ls(pkg_pos)
#   pkg_objects <- purrr::map2(.x = pkg_nms, .y = pkg_pos, .f = get)
#   df_set <- purrr::map_vec(.x = pkg_objects,.f = is.data.frame)
#   df_names <- pkg_nms[df_set]
#   if (length(df_names) > 0) {
#     return(df_names)
#   }
#   return(NULL)
# }