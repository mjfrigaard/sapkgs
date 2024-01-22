#' Create plot_inputs() list (for debugging and testing)
#'
#' @return list of plot inputs
#'
#'
#' @export get_plot_inputs_list
#'
#' @examples
#' get_plot_inputs_list(pkg = "palmerpenguins", ds = "penguins")
get_plot_inputs_list <- function(pkg, ds) {
    require(palmerpenguins)
    require(NHANES)
    # get packages with data.frames/tibbles
    all_pkgs <- pkg_nms_with_dfs()
    # select package
    pkg_select <- all_pkgs[pkg]
    # select dataset from package
    ds_pkgs <- df_nms_from_pkgs(pkg_select)
    names(ds_pkgs) <- ds_pkgs
    ds_select <- ds_pkgs[ds]
    # get dataset
    dataset <- janitor::clean_names(
      get(x = ds_select, pos = paste0("package:", pkg_select)))
    # rename to ds_input
    ds_input <- dataset
    # get numeric x var
    x_var <- pull_numeric_cols(ds_input)[1]
    # get numeric y var
    y_var <- pull_numeric_cols(ds_input)[2]
    # get color (binary) var
    col_var <- pull_binary_cols(ds_input)[1]
    # get facet var
    facet_var <- pull_facet_cols(ds_input)[1]
    # set size
    size <- 2L
    # set alpha
    alpha <- 0.75
    # create plot_inputs
    plot_values <- list(
      'df' = ds_input,
      'x_var' = x_var,
      'y_var' = y_var,
      'col_var' = col_var,
      'facet_var' = facet_var,
      'size' = size,
      'alpha' = alpha
      )
    plot_inputs <- plot_values
    return(plot_inputs)
}
