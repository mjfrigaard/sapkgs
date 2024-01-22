#' Colored point plot (scatter-plot) with facets (with bugs!)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param y_var y variable (supplied to `ggplot2::aes(y = )`)
#' @param col_var color variable (supplied to `ggplot2::geom_point(ggplot2::aes(color = ))`)
#' @param facet_var facet variable (supplied to `ggplot2::geom_point(ggplot2::aes(color = ))`)
#' @param ... other arguments passed to (`ggplot2::facet_wrap(vars())`)
#'
#' @return A `ggplot2` plot object
#'
#' @export gg_color_scatter_facet
gg_color_scatter_facet <- function(df, x_var, y_var,
                                col_var = NULL, facet_var = NULL,
                                ...) {
  # browser()
  # missing both color and facet vars
  if (is.null(col_var) & is.null(facet_var)) {
      ggplot2::ggplot(
        data = df,
        mapping = ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]])
      ) +
        ggplot2::geom_point(...) +
        # add labels
        ggplot2::labs(
          title = make_x_y_title(x = x_var, y = y_var),
          x = stringr::str_replace_all(
            snakecase::to_title_case(x_var), "_", " "
          ),
          y = stringr::str_replace_all(
            snakecase::to_title_case(y_var), "_", " "
          )
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")


    # no facet, but has color
  } else if (!is.null(col_var) & is.null(facet_var)) {

      ggplot2::ggplot(
        data = df,
        mapping = ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]])
      ) +
        # add ... for alpha and size passed to points
        ggplot2::geom_point(
          ggplot2::aes(colour = .data[[col_var]], group = .data[[col_var]]), ...
        ) +
        # add labels
        ggplot2::labs(
          title = make_x_y_color_title(x = x_var, y = y_var, color = col_var),
          x = stringr::str_replace_all(
            snakecase::to_title_case(x_var), "_", " "
          ),
          y = stringr::str_replace_all(
            snakecase::to_title_case(y_var), "_", " "
          ),
          color = stringr::str_replace_all(
            snakecase::to_title_case(col_var), "_", " "
          )
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")

    # no color, but has facet
  } else if (is.null(col_var) & !is.null(facet_var)) {

      ggplot2::ggplot(
        data = df,
        mapping = ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]])
      ) +
        # add ... for alpha and size passed to points
        ggplot2::geom_point(...) +
        # add facet layer
        ggplot2::facet_wrap(ggplot2::vars(.data[[facet_var]])) +
        # add labels
        ggplot2::labs(
          title = make_x_y_title(x = x_var, y = y_var),
          x = stringr::str_replace_all(
            snakecase::to_title_case(x_var), "_", " "
          ),
          y = stringr::str_replace_all(
            snakecase::to_title_case(y_var), "_", " "
          )
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")

  } else {

      # has both color and facet vars
      ggplot2::ggplot(
        data = df,
        mapping = ggplot2::aes(
          x = .data[[x_var]],
          y = .data[[y_var]])
      ) +
        # points layer
        # add ... for alpha and size passed to points
        ggplot2::geom_point(
          ggplot2::aes(
            colour = .data[[col_var]],
            group = .data[[col_var]]), ...
        ) +
        # add facet layer
        ggplot2::facet_wrap(ggplot2::vars(.data[[facet_var]])) +
        # add labels
        ggplot2::labs(title =
            make_x_y_col_facet_title(x = x_var,
                                     y = y_var,
                                     color = col_var,
                                     facets = facet_var),
          x = stringr::str_replace_all(
            snakecase::to_title_case(x_var), "_", " "
          ),
          y = stringr::str_replace_all(
            snakecase::to_title_case(y_var), "_", " "
          ),
          color = stringr::str_replace_all(
            snakecase::to_title_case(col_var), "_", " "
          ),
          group = stringr::str_replace_all(
            snakecase::to_title_case(facet_var), "_", " "
          )
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")

  }
}


# # debug gg_color_scatter_facet --------------------------------------------
# plot_values_test <- list(
#   # data from palmerpenguins::penguins
#   df = janitor::clean_names(palmerpenguins::penguins),
#   # columns from NHANES::NHANES
#   x_var = "poverty",
#   y_var = "weight",
#   col_var = "survey_yr",
#   facet_var = "race1",
#   size = 2L,
#   alpha = 0.75
# )
#
# plot <- gg_color_scatter_facet(
#   df = plot_values_test$df,
#   x_var = plot_values_test$x_var,
#   y_var = plot_values_test$y_var,
#   col_var = plot_values_test$col_var,
#   facet_var = plot_values_test$facet_var,
#   alpha = plot_values_test$alpha,
#   size = plot_values_test$size
# )
# print(plot)
