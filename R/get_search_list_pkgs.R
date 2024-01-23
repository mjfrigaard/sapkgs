#' Get all packages on search list
#'
#' @return All items from `search()` with a `package:` prefix
#' @export get_search_list_pkgs
#'
#' @description
#' This function is meant to be used in combination with `check_df_in_pkg()`
#'
#' @seealso [check_df_in_pkg()]
#'
#' @importFrom purrr set_names
#'
#' @examples
#' get_search_list_pkgs()
#'
get_search_list_pkgs <- function() {
  all_srch_lst <- search()
  all_pkgs <- grep(pattern = "package:", x = all_srch_lst, value = TRUE)
  pkgs <- gsub(pattern = ".*:|.GlobalEnv|datasets",
      replacement = "",
      x = all_pkgs)
  pkgs_chr <- pkgs[nzchar(pkgs)]
  pkg_nms <- purrr::set_names(pkgs_chr)
  return(pkg_nms)
}
