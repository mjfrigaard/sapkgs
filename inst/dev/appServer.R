# appServer ---------------------------------------------------------------
appServer <- function(input, output, session) {
      gargoyle::init("tf_ds", "tf_cols", "tf_plot")
      env_vars <- new.env()

      # pkg module ----
      observe({
        env_vars$pkg <- mod_pkg_server("pkg")
        return(env_vars$pkg)
        gargoyle::trigger("tf_ds")
      }) |>
        bindEvent(env_vars)

      # dataset module ----
      observe({
        env_vars$dataset <- mod_ds_server("ds",
          pkg_input = env_vars$pkg
        )
        return(env_vars$dataset)
        gargoyle::trigger("tf_cols")
      }) |>
        bindEvent(
          gargoyle::watch("tf_ds")
        )

      # column select module ----
      observe({
        env_vars$plot_values <- mod_cols_server(
          id = "cols",
          ds_input = env_vars$dataset
        )
        return(env_vars$plot_values)
        gargoyle::trigger("tf_plot")
      }) |>
        bindEvent(
          gargoyle::watch("tf_cols")
        )

      # plot module ----
      observe({
        mod_graph_server("plot",
          ds_input = env_vars$dataset,
          col_inputs = env_vars$plot_values
        )
      }) |>
        bindEvent(
          gargoyle::watch("tf_plot")
        )
}
