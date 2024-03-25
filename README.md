# Testing (outside of a package)

This is a small example of testing outside of a package environment. You'll find the following files:

```
├── README.md
├── app.R
├── modules.R
├── sapkgs.Rproj
├── tests
│   ├── testthat
│   │   ├── _snaps
│   │   ├── test-mod_abc_server.R
│   │   └── test-num_super_script.R
│   └── testthat.R
└── utils.R

4 directories, 8 files
```

## Testing module server functions

`app.R` and `tests/testthat/test-mod_abc_server.R` show how `shiny::testServer()` works in an application *with* modules.  

The `tests/testthat.R` file contains the code to run the tests:

``` r
library(testthat)
source("app.R")
test_dir(path = "tests/testthat/")
```

```verbatim
✔ | F W  S  OK | Context
⠏ |          0 | mod_abc_server                            
 Test 1 initial input$num = NULL:  TRUE 

 Test 2 setInputs(num = 3): 3 

 Test 3 sup_scrpt(): = 'rd': rd 

 Test 4 letter() = C: C 
$html
<em>
  The 
  <code>3</code>
  <code>rd</code>
   letter in the alphabet is: 
  <code>C</code>
</em>

$deps
list()

✔ |          5 | mod_abc_server
✔ |         10 | num_super_script                                                                   

══ Results ══════════════════════════════════════════════════════════
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 15 ]
```

Note that this is currently set to test the application with modules.

## Testing shiny server function

For more information on testing outside of the package environment, see this discussion on GitHub: https://github.com/r-lib/testthat/issues/659.

