
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sapkgs/utap

<!-- badges: start -->
<!-- badges: end -->

The goal of the `utap` application is to demonstrate how to perform unit
tests for Shiny utility functions with
[`testthat`](https://testthat.r-lib.org/).

## Installation

``` r
install.packages('remotes')
remotes::install_github('mjfrigaard/sapkgs')
```

# R files

``` default
R/
├── check_binary_vec.R
├── check_facet_vec.R
├── make_binary_vec.R
├── make_facet_vec.R
├── nin.R
├── pull_binary_cols.R
├── pull_cat_cols.R
├── pull_cols.R
├── pull_facet_cols.R
├── pull_numeric_cols.R
├── select_class.R
└── utap-package.R
```

# Unit tests

    #> tests/testthat/
    #> ├── test-check_binary_vec.R
    #> ├── test-check_facet_vec.R
    #> ├── test-make_binary_vec.R
    #> ├── test-nin.R
    #> ├── test-pull_binary_cols.R
    #> ├── test-pull_cat_cols.R
    #> ├── test-pull_cols.R
    #> ├── test-pull_facet_cols.R
    #> ├── test-pull_numeric_cols.R
    #> └── test-select_class.R

# Unit test results

``` default
==> devtools::test()

ℹ Testing utap
✔ | F W  S  OK | Context
✔ |         23 | check_binary_vec           
✔ |          3 | check_facet_vec            
✔ |          4 | make_binary_vec            
✔ |          3 | nin                        
✔ |          9 | pull_binary_cols           
✔ |          4 | pull_cat_cols              
✔ |          4 | pull_cols                  
✔ |         15 | pull_facet_cols            
✔ |          2 | pull_numeric_cols          
✔ |         14 | select_class               

══ Results ═════════════════════════════════
Duration: 1.2 s

[ FAIL 0 | WARN 0 | SKIP 0 | PASS 81 ]
```
