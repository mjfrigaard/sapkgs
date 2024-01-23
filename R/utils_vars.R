#' Select column class (helper)
#'
#' @description
#' Return column in data by `class()`
#'
#' @param df a `data.frame` or `tibble`
#' @param class class of column to return.
#'  One of:
#'   * `"log"`: logical
#'   * `"dbl"`: double
#'   * `"int"`: integer
#'   * `"chr"`: character
#'   * `"fct"`: factor
#'   * `"list"`: list
#'
#' @return `tibble` of columns matching `class` (empty `tibble` if no columns
#' of specified type
#' exist)
#' @export select_column_class
#'
#' @importFrom cli cli_abort cli_alert_info
#' @importFrom dplyr select where
#' @importFrom tibble as_tibble tibble
#' @importFrom glue glue
#' @importFrom purrr map list_cbind
#'
#' @examples
#' require(dplyr)
#' select_column_class(df = dplyr::starwars, class = "chr")
#' select_column_class(df = dplyr::starwars, class = c("chr", "list"))
#' select_column_class(df = mtcars, class = "chr")
#' select_column_class(df = mtcars, class = c("chr", "list"))
select_column_class <- function(df, class) {

  col_class <- function(df, class) {
    switch(class,
      log = dplyr::select(tibble::as_tibble(df), dplyr::where(is.logical)),
      int = dplyr::select(tibble::as_tibble(df), dplyr::where(is.integer)),
      dbl = dplyr::select(tibble::as_tibble(df), dplyr::where(is.double)),
      chr = dplyr::select(tibble::as_tibble(df), dplyr::where(is.character)),
      fct = dplyr::select(tibble::as_tibble(df), dplyr::where(is.factor)),
      ord = dplyr::select(tibble::as_tibble(df), dplyr::where(is.ordered)),
      list = dplyr::select(tibble::as_tibble(df), dplyr::where(is.list))
    )
  }

  cl <- unique(class)
  cl_check <- cl %nin% c("log", "int", "dbl", "chr", "fct", "ord", "list")
  if (any(cl_check)) {
    cli::cli_abort("Invalid `class` argument. Must be one of:\n
          'log', 'int', 'dbl', 'chr', 'fct', 'ord', 'list'")
  }

  col_list <- purrr::map(.x = class, .f = col_class, df = df)

  df_cols <- purrr::list_cbind(col_list, size = nrow(df))

  if (ncol(df_cols) < 1 || nrow(df_cols) < 1) {
    df_cols <- structure(list(),
      class = c("tbl_df", "tbl", "data.frame"),
      row.names = integer(0),
      names = character(0)
    )
    return(df_cols)
  } else {
    return(df_cols)
  }
}

#' Get column types
#'
#' @description
#' Return column in data by types
#'
#' @param df a `data.frame` or `tibble`
#' @param return_tbl logical, return tibble (`TRUE`) or named vector (`FALSE`)
#' @param type type of column to return
#'  One of:
#'   * `"log"`: logical
#'   * `"dbl"`: double
#'   * `"int"`: integer
#'   * `"chr"`: character
#'   * `"fct"`: factor
#'   * `"ord"`: factor (ordered)
#'   * `"list"`: list
#'
#' @return named vector or `tibble` of columns matching the `type` (empty vector or
#' `tibble` if no columns of specified type exist)
#'
#' @export get_column_class
#'
#' @importFrom purrr set_names
#'
#' @examples
#' require(dplyr)
#' require(tidyr)
#' get_column_class(dplyr::starwars, class = "chr")
#' get_column_class(dplyr::starwars, class = "chr", return_tbl = FALSE)
#' get_column_class(dplyr::starwars, class = "list")
#' get_column_class(dplyr::starwars, class = "list", return_tbl = FALSE)
#' get_column_class(tidyr::fish_encounters, "chr")
#' get_column_class(tidyr::fish_encounters, "chr", return_tbl = FALSE)
get_column_class <- function(df, class, return_tbl = TRUE) {
  if (isFALSE(return_tbl)) {
    col_types_df <- select_column_class(df, class = class)
    nms <- names(col_types_df)
    col_types <- purrr::set_names(nms)
  } else {
    col_types <- select_column_class(df, class = class)
  }
  return(col_types)
}

#' Binary checks (helper)
#'
#' @param x a vector
#' @param type type of column to return.
#'
#' @return TRUE/FALSE if binary
#' @export check_binary_vec
#'
#'
#' @examples
#' require(palmerpenguins)
#' check_binary_vec(palmerpenguins::penguins$sex, type = "fct")
#' check_binary_vec(palmerpenguins::penguins$species, type = "fct")
check_binary_vec <- function(x, type) {
  check_log_binary <- function(x) {
    all(na.omit(x) %in% TRUE:FALSE)
  }
  check_int_binary <- function(x) {
    all(na.omit(x) %in% 0:1)
  }
  check_chr_binary <- function(x) {
    length(unique(na.omit(x))) == 2
  }
  check_fct_binary <- function(x) {
    length(levels(na.omit(x))) == 2
  }
  switch(type,
    log = check_log_binary(x),
    int = check_int_binary(x),
    chr = check_chr_binary(x),
    fct = check_fct_binary(x)
  )
}

#' Create vector of binary columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of binary columns
#' @export make_binary_vec
#'
#' @importFrom purrr set_names map_vec
#' @importFrom cli cli_alert_info
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' make_binary_vec(
#'   df = dplyr::select(
#'     palmerpenguins::penguins,
#'     dplyr::where(is.factor)
#'   ),
#'   type = "fct"
#' )
make_binary_vec <- function(df, type) {
  if (ncol(df) < 1) {
    # cli::cli_alert_info(glue::glue("No {type} binary columns!"))
    return(purrr::set_names(vector(mode = "character")))
  } else {
    nms <- names(df)
    # set names in names
    dm_nms <- purrr::set_names(nms)
    bin_set <- purrr::map_vec(
      .x = df,
      .f = check_binary_vec,
      type = type
    )
    if (sum(bin_set) < 1) {
      # cli::cli_alert_info(glue::glue("No {type} binary values!"))
      bins <- purrr::set_names(vector(mode = "character"))
    } else {
      # cli::cli_alert_success(glue::glue("{type} binary values!"))
      bins <- purrr::set_names(dm_nms[bin_set])
    }
  }
  return(bins)
}

#' Binary app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of binary column names
#' @export pull_binary_cols
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' pull_binary_cols(palmerpenguins::penguins)
#' pull_binary_cols(dplyr::starwars)
pull_binary_cols <- function(df) {
  # logical
  log_bins <- get_column_class(df, "log") |>
    make_binary_vec("log")
  # integer
  int_bins <- get_column_class(df, "int") |>
    make_binary_vec("int")
  # character
  chr_bins <- get_column_class(df, "chr") |>
    make_binary_vec("chr")
  # factors
  fct_bins <- get_column_class(df, "fct") |>
    make_binary_vec("fct")
  # assemble
  all_bins <- list(log_bins, int_bins, chr_bins, fct_bins)
  # reduce
  bins_list <- purrr::compact(all_bins)
  # vector
  bins <- purrr::list_c(bins_list)
  return(bins)
}


#' Categorical app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of character and factor column names
#' @export pull_cat_cols
#'
#' @importFrom purrr compact list_c set_names
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' pull_cat_cols(palmerpenguins::penguins)
#' pull_cat_cols(dplyr::starwars)
pull_cat_cols <- function(df) {
  chrs <- get_column_class(df = df, class = "chr", return_tbl = FALSE)
  # factors
  fcts <- get_column_class(df = df, class = "fct", return_tbl = FALSE)
  # assemble
  all_chrs_fcts_list <- list(chrs, fcts)
  # reduce
  chrs_fcts_list <- purrr::compact(all_chrs_fcts_list)
  # vector
  chrs_fcts <- purrr::list_c(chrs_fcts_list) |> sort()
  if (is.null(chrs_fcts)) {
    NULL
  } else {
    # name
    cats <- purrr::set_names(chrs_fcts)
    return(cats)
  }
}

#' Facet checks (helper)
#'
#' @param x a vector
#' @param type type of column to return.
#'
#' @return TRUE/FALSE if facet variable (< 5 levels)
#' @export check_facet_vec
#'
#' @examples
#' require(NHANES)
#' check_facet_vec(NHANES::NHANES$Education, type = "fct")
#' levels(NHANES::NHANES$Education)
#' check_facet_vec(NHANES::NHANES$MaritalStatus, type = "fct")
#' levels(NHANES::NHANES$MaritalStatus)
check_facet_vec <- function(x, type) {
  check_chr_facet <- function(x) {
    length(unique(na.omit(x))) <= 4
  }
  check_fct_facet <- function(x) {
    length(unique(na.omit(x))) <= 4
  }
  switch(type,
    chr = check_chr_facet(x),
    ord = check_fct_facet(x),
    fct = check_fct_facet(x)
  )
}

#' Create vector of facet columns by type (helper)
#'
#' @param df  a `data.frame` or `tibble`
#' @param type type of column to return
#'
#' @return vector of facet columns (< 5 levels)
#' @export make_facet_vec
#'
#' @importFrom purrr set_names map_vec
#' @importFrom cli cli_alert_info
#'
#' @examples
#' require(NHANES)
#' require(dplyr)
#' facets <- make_facet_vec(
#'   df = dplyr::select(
#'     NHANES::NHANES,
#'     dplyr::where(is.factor)),
#'   type = "fct")
#' facets
make_facet_vec <- function(df, type) {
  if (ncol(df) < 1) {
    return(purrr::set_names(vector(mode = "character")))
  } else {
    nms <- names(df)
    # set names in names
    dm_nms <- purrr::set_names(nms)
    facet_set <- purrr::map_vec(
      .x = df,
      .f = check_facet_vec,
      type = type
    )
    if (sum(facet_set) < 1) {
      facets <- purrr::set_names(vector(mode = "character"))
    } else {
      facets <- purrr::set_names(dm_nms[facet_set])
    }
  }
  return(facets)
}

#' Facet app inputs
#'
#' @section Variables to use for facets:
#'
#' This function is designed to quickly determine which variables have an
#' appropriate number of categorical levels for using `ggplot2::facet_wrap()`
#' or `ggplot2::facet_grid()`
#'
#' @param df a `data.frame` or `tibble`
#'
#'
#' @return a named character vector or column from with < 5 unique levels
#' @export pull_facet_cols
#'
#' @importFrom purrr compact list_c
#'
#' @examples
#' require(dplyr)
#' require(NHANES)
#' pull_facet_cols(df = dplyr::starwars)
#' pull_facet_cols(df = NHANES::NHANES)
#'
#' str(dplyr::select(
#'   dplyr::starwars,
#'   dplyr::all_of(pull_facet_cols(df = dplyr::starwars))
#' ))
#' str(dplyr::select(
#'   NHANES::NHANES,
#'   dplyr::all_of(pull_facet_cols(df = NHANES::NHANES))
#' ))
pull_facet_cols <- function(df) {
  # get bins
  bins <- pull_binary_cols(df)
  # character
  chr_facets <- get_column_class(df, "chr") |> make_facet_vec("chr")
  # factors
  fct_facets <- get_column_class(df, "fct") |> make_facet_vec("fct")
  # assemble
  all_facets_list <- list(chr_facets, fct_facets)
  # reduce
  facets_list <- purrr::compact(all_facets_list)
  # vector
  all_facets <- purrr::list_c(facets_list)
  # reduce
  facets <- all_facets[all_facets %nin% bins]
  return(facets)
}


#' Numeric app inputs
#'
#' @param df a `data.frame` or `tibble`
#'
#' @return a named character vector of integer and double column names
#' @export pull_numeric_cols
#'
#' @importFrom purrr compact list_c set_names
#'
#' @examples
#' require(palmerpenguins)
#' require(dplyr)
#' pull_numeric_cols(palmerpenguins::penguins)
#' pull_numeric_cols(dplyr::starwars)
pull_numeric_cols <- function(df) {
  bins <- pull_binary_cols(df = df)
  facets <- pull_facet_cols(df = df)
  # assemble
  all_bins_facets_list <- list(bins, facets)
  # reduce
  bins_facets_list <- purrr::compact(all_bins_facets_list)
  # vector
  bins_facets <- purrr::list_c(bins_facets_list)
  # vector of doubles
  dbls <- get_column_class(df = df, class = "dbl", return_tbl = FALSE)
  # vector of integers
  ints <- get_column_class(df = df, class = "int", return_tbl = FALSE)
  # assemble
  all_dbls_ints_list <- list(dbls, ints)
  # # reduce
  dbls_ints_list <- purrr::compact(all_dbls_ints_list)
  # # vector
  dbls_ints <- purrr::list_c(dbls_ints_list)
  # reduce
  nums_nms <- dbls_ints[dbls_ints %nin% bins_facets]
  if (is.null(nums_nms)) {
    return(nums_nms)
  } else {
    # name
    nums <- purrr::set_names(nums_nms)
    return(nums)
  }
}

