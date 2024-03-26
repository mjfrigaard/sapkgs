## code to prepare `dates_df` dataset goes here
require(lubridate)
dates_df <- data.frame(
  date = Sys.Date() - 100,
  datetime = Sys.time() + 100000,
  duration = lubridate::duration(num = as.numeric(lubridate::today()),
                                 units = "seconds"),
  posixct = as.POSIXct(Sys.time() + 100000),
  posixlt = as.POSIXlt(Sys.time() + 100000),
                       tz = "GMT")
usethis::use_data(dates_df, overwrite = TRUE)
