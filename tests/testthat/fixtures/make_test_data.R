# define test data
test_data <- data.frame(
  log_var = c(TRUE, FALSE, TRUE),
  int_var = c(1L, 2L, 3L),
  dbl_var = c(1.1, 2.2, 3.3),
  chr_var = paste0(rep("item:", times = 3), 1:3),
  ord_var = factor(
    x = paste(rep("level", times = 3), 1:3),
    levels = paste(rep("level", times = 3), 1:3),
    labels = paste(rep("level", times = 3), 1:3),
    ordered = TRUE
  ),
  fct_var = factor(
    x = paste(rep("group", times = 3), 1:3),
    levels = paste(rep("group", times = 3), 1:3),
    labels = paste(rep("group", times = 3), 1:3)
  )
)
# create list variable
list_var <- list(
  log = c(TRUE, FALSE, TRUE),
  dbl = c(1.1, 2.2, 3.3),
  chr = paste0(rep("item:", times = 3), 1:3)
)
# add to df
test_data$list_var <- list_var

saveRDS(object = test_data, "tests/testthat/fixtures/test_data.rds")
