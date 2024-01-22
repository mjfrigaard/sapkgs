#' Point plot (scatter-plot)
#'
#' @param df input dataset (tibble or data.frame)
#' @param x_var x variable (supplied to `ggplot2::aes(x = )`)
#' @param y_var y variable (supplied to `ggplot2::aes(y = )`)
#' @param ... other arguments passed to `ggplot2::geom_point()`, outside of `ggplot2::aes()`
#'
#' @return A `ggplot2` plot object
#' 
#' @export gg_scatter
#' 
#' @importFrom rlang .data
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_scatter(
#'   df = mini_dmnds,
#'   x_var = "carat",
#'   y_var = "price",
#'   alpha = 1 / 3,
#'   color = "#000000",
#'   size = 2
#' )
gg_scatter <- function(df, x_var, y_var, ...) {
  base <- gg_base(df = df, x_var = x_var, y_var = y_var)

  base +
    ggplot2::geom_point(...) +

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
}