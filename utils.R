num_super_script <- function(x) {
      num <- as.numeric(x)
      if (num < 0) {
        stop("not a valid number")
      } else if (num > 26) {
        stop("not a valid number")
      } else if (num == 0) {
        super_script <- ""
      } else if (num == 1 | num == 21) {
        super_script <- "st"
      } else if (num == 2 | num == 22) {
        super_script <- "nd"
      } else if (num == 3 | num == 23) {
        super_script <- "rd"
      } else {
        super_script <- "th"
      }
    return(super_script)
}
