
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Mastering Shiny Test Server App Package (`mstsap`)

<!-- badges: start -->
<!-- badges: end -->

`mstsap` is a collection of tests using
[`testthat`](https://testthat.r-lib.org/) and
[`testServer()`](https://search.r-project.org/CRAN/refmans/shiny/html/testServer.html).

The modules and applications in `mstsap` come from the [Shiny modules
chapter](https://mastering-shiny.org/scaling-modules.html) of [Mastering
Shiny](https://mastering-shiny.org/index.html).

## Installation

``` r
install.packages('remotes')
remotes::install_github(
  "https://github.com/mjfrigaard/sapkgs", ref = "mstsap")
```

## Utility function tests

There is a single utility function in `mstsap`: `find_vars()`

    #> tests/testthat/
    #> └── test-find_vars.R

``` r
testthat::test_file("tests/testthat/test-find_vars.R")
```

``` default
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
```

## `testServer()` tests

    #> tests/testthat/
    #> ├── test-datasetApp.R
    #> ├── test-datasetServer.R
    #> ├── test-selectDataVarApp.R
    #> ├── test-selectDataVarServer.R
    #> ├── test-selectVarApp.R
    #> └── test-selectVarServer.R

``` default
🐝 Your tests are the bee's knees 🐝
```
