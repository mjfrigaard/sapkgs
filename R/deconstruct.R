#' Deconstruct R objects
#'
#' @param x R object passed to `dput()`
#' @param quotes include quotes in the output
#' @param console logical, used in the console? If `FALSE`, then output is printed
#' with `base::noquote()`. If `TRUE`, output is returned with `cat()`
#'
#' @return Deparsed object
#' @export deconstruct
#'
#'
#' @examples
#' x <- deconstruct(names(mtcars), return = TRUE)
#' x
#' deconstruct(names(mtcars))
deconstruct <- function(x, return = FALSE, quote = TRUE) {
  raw_obj <- capture.output(dput(x, control = "all"))
  if (isFALSE(quote)) {
    obj_noquote <- gsub(pattern = '"', replacement = "", x = raw_obj)
    decon_noquote <- paste0(obj_noquote, collapse = "")
    decon_obj <- gsub("\\s+", " ", decon_noquote)
  } else {
    obj_quote <- gsub(pattern = '"', replacement = "'", x = raw_obj)
    decon_quote <- paste0(obj_quote, collapse = "")
    decon_obj <- gsub("\\s+", " ", decon_quote)
  }
  if (isFALSE(return)) {
    base::cat(decon_obj)
  } else {
    return(noquote(decon_obj))
  }
}