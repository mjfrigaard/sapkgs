# run app for package
pkgload::load_all(
  export_all = FALSE,
  helpers = TRUE,
  attach_testthat = TRUE)
library(debugApp)
options(shiny.fullstacktrace = TRUE)
debugApp::launchApp()
# rsconnect::deployApp()
