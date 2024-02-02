binary_vec_test <- data.frame(
  log = c(TRUE, FALSE, TRUE),
  log_na = c(TRUE, FALSE, NA),
  int = c(0L, 1L, 0L),
  int_na = c(0L, 1L, NA),
  chr = c("item:A", "item:B", "item:A"),
  chr_na = c("item:A", "item:B", NA),
  fct = structure(c(1L, 2L, 1L),
        levels = c("group A", "group B"),
        class = "factor"),
  fct_na = structure(c(1L, 2L, NA),
        levels = c("group A", "group B"),
        class = "factor"),
  ord = structure(c(1L, 2L, 1L),
        levels = c("level 1", "level 2"),
        class = c("ordered", "factor")),
  ord_na = structure(c(1L, 2L, NA),
        levels = c("level 1", "level 2"),
        class = c("ordered", "factor")))

saveRDS(object = binary_vec_test, "tests/testthat/fixtures/binary_vec_test.rds")
