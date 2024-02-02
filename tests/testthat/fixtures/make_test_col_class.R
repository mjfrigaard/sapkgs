test_col_class <- data.frame(
           log_var = c(TRUE, FALSE, TRUE),
           int_var = c(1L, 2L, 3L),
           dbl_var = c(1.1, 2.2, 3.3),
           chr_var = c("item:1", "item:2", "item:3"),
           ord_var = factor(x = c("level 1", "level 2", "level 3"),
                            levels = c("level 1", "level 2", "level 3"),
                            labels = c("level 1", "level 2", "level 3"),
                            ordered = TRUE),
          fct_var = factor(x = c("group 1", "group 2", "group 3"),
                            levels = c("group 1", "group 2", "group 3"),
                            labels = c("group 1", "group 2", "group 3")))
list_var <- list(log = c(TRUE, FALSE, TRUE),
                          dbl = c(1.1, 2.2, 3.3),
                          chr = c("item:1", "item:2", "item:3"))
test_col_class$list_var <- list_var

rm(list_var)

saveRDS(object = test_col_class, "tests/testthat/fixtures/test_col_class.rds")
