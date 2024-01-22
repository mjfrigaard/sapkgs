#' Make x, y, color plot title
#'
#' @param x x variable
#' @param y y variable
#' @param color color variable
#'
#' @return String for plot title
#' 
#' @export make_x_y_color_title
#'
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_scatter_color(
#'   df = mini_dmnds,
#'   x_var = "carat",
#'   y_var = "price",
#'   col_var = "cut",
#'   alpha = 1 / 3,
#'   size = 2
#' ) +
#' ggplot2::labs(title =
#'   make_x_y_color_title(
#'     x = "carat",
#'     y = "price",
#'    color = "cut"))
make_x_y_col_facet_title <- function(x, y, color, facets) {
  x_chr <- stringr::str_replace_all(
    snakecase::to_title_case(x), "_", " "
  )
  y_chr <- stringr::str_replace_all(
    snakecase::to_title_case(y), "_", " "
  )
  color_chr <- stringr::str_replace_all(
    snakecase::to_title_case(color), "_", " "
  )
  facet_chr <- stringr::str_replace_all(
    snakecase::to_title_case(facets), "_", " "
  )
  glue::glue("{x_chr} vs. {y_chr} by {color_chr} & {facet_chr}")
}