#' Make x,y plot title
#'
#' @param x x variable
#' @param y y variable
#' @param color color variable
#'
#' @return String for plot title
#'
#' @export make_x_y_title
#'
#' @examples
#' diamonds <- ggplot2::diamonds
#' mini_dmnds <- diamonds[sample(nrow(diamonds), 10000), ]
#' gg_base(df = mini_dmnds, x_var = "carat", y_var = "price") +
#' ggplot2::labs(title = make_x_y_title(x = "carat", y = "price"))
make_x_y_title <- function(x, y) {
  x_chr <- stringr::str_replace_all(
    snakecase::to_title_case(x), "_", " "
  )
  y_chr <- stringr::str_replace_all(
    snakecase::to_title_case(y), "_", " "
  )
  glue::glue("{x_chr} vs. {y_chr}")
}