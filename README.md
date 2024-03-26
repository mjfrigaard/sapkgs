
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `st2ap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `st2ap` is to demonstrate how to build and test a shiny
application using `usethis`, `shiny::testServer()`, and `shinytest2`.

## Installation

``` r
install.packages('remotes')
remotes::install_github(
  "https://github.com/mjfrigaard/sapkgs", ref = "st2ap")
```

## Run the app

``` r
st2ap::strApp()
```

# Unit tests

    #> tests/testthat/

# Shiny server tests

Check the shiny `testServer()` tests for `mod_var_input_server()` and
`mod_display_plot_server()` in

    #> tests/testthat/
