
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `st2ap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `st2ap` is to demonstrate how to build and test a shiny
application using `usethis`, `shiny::testServer()`, and `shinytest2`.

## Installation

You don’t want to install this package, but you might want to download
it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/testing-shiny/) to learn about
it’s contents).

## Run the app

``` r
st2ap::strApp()
```

# Unit tests

    #> tests/testthat/
    #> ├── test-appServer.R
    #> ├── test-binary_app_inputs.R
    #> ├── test-cat_app_inputs.R
    #> ├── test-check_binary_vec.R
    #> ├── test-check_facet_vec.R
    #> ├── test-facet_app_inputs.R
    #> ├── test-get_col_types.R
    #> ├── test-make_binary_vec.R
    #> ├── test-make_facet_vec.R
    #> ├── test-mod_cols_server.R
    #> ├── test-mod_ds_server.R
    #> ├── test-mod_pkg_server.R
    #> ├── test-mod_plot_server.R
    #> ├── test-num_app_inputs.R
    #> ├── test-pkgDataApp.R
    #> ├── test-pull_binary_cols.R
    #> ├── test-pull_cat_cols.R
    #> ├── test-pull_facet_cols.R
    #> ├── test-pull_numeric_cols.R
    #> └── test-pull_type_cols.R

# Shiny server tests

Check the shiny `testServer()` tests for `mod_var_input_server()` and
`mod_display_plot_server()` in

    #> tests/testthat/
    #> ├── test-mod_cols_server.R
    #> ├── test-mod_ds_server.R
    #> ├── test-mod_pkg_server.R
    #> └── test-mod_plot_server.R
