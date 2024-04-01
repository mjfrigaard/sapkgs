
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Mastering Shiny Shiny Test 2 App Package (`msst2ap`)

<!-- badges: start -->
<!-- badges: end -->

The goal of `msst2ap` is to demonstrate how to test a shiny app-package
using [`testthat`](https://testthat.r-lib.org/) and
[`shinytest2`](https://rstudio.github.io/shinytest2/)

All examples come from the [Modules chapter of Mastering
Shiny.](https://mastering-shiny.org/scaling-modules.html)

## Installation

You can install `msst2ap` from GitHub using the code below:

``` r
install.packages('remotes')
remotes::install_github(
  "https://github.com/mjfrigaard/sapkgs", ref = "msst2ap")
```

``` r
library(msst2ap)
```

## Set up

There are specific instructions for setting up `shinytest2` in the
[`shinytest2-setup.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/shinytest2-setup.Rmd).

## Utility function/`testServer()` tests

Tests for the utility functions are in [`unit-tests.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/unit-tests.Rmd).
Test for the module server functions and standalone app functions are in
the [`testserver-tests.Rmd`
vignette](https://github.com/mjfrigaard/msst2ap/blob/main/vignettes/testserver-tests.Rmd).

## `shinytest2` tests

The output from `devtools::test()` is below:

``` default
==> devtools::test()

ℹ Testing msst2ap
✔ | F W S  OK | Context
✔ |         1 | shinytest2-datasetApp [17.3s]                                                                    
⠼ |         5 | shinytest2-ggHistApp                                                                               
  wt1   wt2   wt3   wt4   wt5   wt6   wt7   wt8   wt9  wt10  wt11  wt12  wt13 
2.620 2.875 2.320 3.215 3.440 3.460 3.570 3.190 3.150 3.440 3.440 4.070 3.730 
 wt14  wt15  wt16  wt17  wt18  wt19  wt20  wt21  wt22  wt23  wt24  wt25  wt26 
3.780 5.250 5.424 5.345 2.200 1.615 1.835 2.465 3.520 3.435 3.840 3.845 1.935 
 wt27  wt28  wt29  wt30  wt31  wt32 
2.140 1.513 3.170 2.770 3.570 2.780 
⠇ |         9 | shinytest2-ggHistApp                                                                              
 UrbanPop1  UrbanPop2  UrbanPop3  UrbanPop4  UrbanPop5  UrbanPop6  UrbanPop7 
        58         48         80         50         91         78         77 
 UrbanPop8  UrbanPop9 UrbanPop10 UrbanPop11 UrbanPop12 UrbanPop13 UrbanPop14 
        72         80         60         83         54         83         65 
UrbanPop15 UrbanPop16 UrbanPop17 UrbanPop18 UrbanPop19 UrbanPop20 UrbanPop21 
        57         66         52         66         51         67         85 
UrbanPop22 UrbanPop23 UrbanPop24 UrbanPop25 UrbanPop26 UrbanPop27 UrbanPop28 
        74         66         44         70         53         62         81 
UrbanPop29 UrbanPop30 UrbanPop31 UrbanPop32 UrbanPop33 UrbanPop34 UrbanPop35 
        56         89         70         86         45         44         75 
UrbanPop36 UrbanPop37 UrbanPop38 UrbanPop39 UrbanPop40 UrbanPop41 UrbanPop42 
        68         67         72         87         48         45         59 
UrbanPop43 UrbanPop44 UrbanPop45 UrbanPop46 UrbanPop47 UrbanPop48 UrbanPop49 
        80         80         32         63         73         39         66 
UrbanPop50 
        60 
✔ |        10 | shinytest2-ggHistApp [13.2s]
✔ |         2 | shinytest2-selectVarApp [10.5s]                                                                  
✔ |         1 | shinytest2 [5.0s]                                                                                

══ Results ════════════════════════════════════════════════════════════════════
Duration: 46.0 s
        
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 14 ]

🔥 Your tests are lit 🔥
```

### Known issue

The following warning is given when running `shinytest2` tests in an app
package:

``` default
Warning message:
In loadSupport(app_dir, renv = renv, globalrenv = globalrenv) :
  Loading R/ subdirectory for Shiny application, but this directory appears to 
contain an R package. Sourcing files in R/ may cause unexpected behavior.
```

Don’t worry–there is an [open issue on
GitHub](https://github.com/rstudio/shinytest2/issues/264) for this!
