#' Get packages with data.frames
#'
#' @return named vector of packages with `data.frame` objects
#' @export pkg_nms_with_dfs
#'
#' @importFrom purrr map_vec
#'
#' @examples
#' require(dplyr)
#' require(tidyr)
#' pkg_nms_with_dfs()
pkg_nms_with_dfs <- function() {
  all_pkgs <- search_list_pkgs()
  df_pkg_set <- purrr::map_vec(.x = all_pkgs, check_df_in_pkg)
  df_pkgs <- all_pkgs[df_pkg_set]
  return(df_pkgs)
}
