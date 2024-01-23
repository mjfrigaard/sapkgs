#' Get packages with data.frames
#'
#' @return named vector of packages with `data.frame` objects
#' @export get_pkgs_with_dfs
#'
#' @importFrom purrr map_vec
#'
#' @examples
#' require(dplyr)
#' require(tidyr)
#' get_pkgs_with_dfs()
get_pkgs_with_dfs <- function() {
  all_pkgs <- get_search_list_pkgs()
  df_pkg_set <- purrr::map_vec(.x = all_pkgs, check_df_in_pkg)
  df_pkgs <- all_pkgs[df_pkg_set]
  return(df_pkgs)
}
