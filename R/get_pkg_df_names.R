#' Get names of data.frames from package
#'
#' @param pkg
#'
#' @return named vector of data.frames in package
#' @export get_pkg_df_names
#'
#' @examples
#' get_pkg_df_names(pkg = "base")
#' get_pkg_df_names(pkg = "datasets")
get_pkg_df_names <- function(pkg) {
  pkg_pos <- paste0("package:", pkg)
  pkg_nms <- ls(pkg_pos)
  data <- lapply(pkg_nms, get, pkg_pos)
  df_names <- pkg_nms[vapply(data, is.data.frame, logical(1))]
  if (length(df_names) > 1) {
    return(df_names)
  }
  return(NULL)
}
