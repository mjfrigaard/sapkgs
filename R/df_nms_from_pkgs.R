#' Get names of data.frames from package
#'
#' @param pkg
#'
#' @return named vector of data.frames in package
#' @export df_nms_from_pkgs
#'
#' @examples
#' df_nms_from_pkgs(pkg = "base")
#' df_nms_from_pkgs(pkg = "datasets")
df_nms_from_pkgs <- function(pkg) {
  pkg_pos <- paste0("package:", pkg)
  pkg_nms <- ls(pkg_pos)
  data <- lapply(pkg_nms, get, pkg_pos)
  df_names <- pkg_nms[vapply(data, is.data.frame, logical(1))]
  if (length(df_names) > 0) {
    return(df_names)
  }
  return(NULL)
}
