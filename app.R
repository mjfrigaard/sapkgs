# run app for package
pkgload::load_all(
  export_all = FALSE,
  helpers = TRUE,
  attach_testthat = TRUE)
library(msst2ap)
msst2ap::histogramApp()
# deploy this application with
# rsconnect::deployApp()
