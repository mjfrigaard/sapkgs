#' Column type names
#'
#' @param data `data.frame`/`tibble`
#' @param type any `is.[type]` function (i.e., `is.numeric`,
#' `is.character`, `is.logical`, etc.)
#'
#' @return data.frame/tibble filtered by function
#' @export col_type_nms
#'
#' @importFrom lubridate is.POSIXt is.POSIXct is.POSIXlt
#' @importFrom lubridate is.duration is.difftime is.Date
#'
#' @examples
#' col_type_nms(mtcars, "int")
col_type_nms <- function(data, type) {
  stopifnot(is.data.frame(data))
  switch(EXPR = type,
    log = names(data)[vapply(data, is.logical, logical(1))],
    int = names(data)[vapply(data, is.integer, logical(1))],
    dbl = names(data)[vapply(data, is.double, logical(1))],
    chr = names(data)[vapply(data, is.character, logical(1))],
    fct = names(data)[vapply(data, is.factor, logical(1))],
    lst = names(data)[vapply(data, is.list, logical(1))],
    posixt = names(data)[vapply(data, lubridate::is.POSIXt, logical(1))],
    posixct = names(data)[vapply(data, lubridate::is.POSIXct, logical(1))],
    posixlt = names(data)[vapply(data, lubridate::is.POSIXlt, logical(1))],
    duration = names(data)[vapply(data, lubridate::is.duration, logical(1))],
    difftime = names(data)[vapply(data, lubridate::is.difftime, logical(1))],
    date = names(data)[vapply(data, lubridate::is.Date, logical(1))]
    )
}


#' Column type names
#'
#' @param data `data.frame`/`tibble`
#' @param type one of "numerics", "dates", "characters", "factors", "list"
#'
#' @return data.frame/tibble filtered by function
#' @export pull_col_types
#'
#' @importFrom purrr set_names
#' @importFrom lubridate setdiff
#'
#' @examples
#' require(dplyr)
#' pull_col_types(movies, "numerics")
#' pull_col_types(movies, "dates")
#' pull_col_types(starwars, "lists")
pull_col_types <- function(data, type) {
  stopifnot(is.data.frame(data))
  if (type == "logicals") {
    logs <- col_type_nms(data = data, type = "log")
    purrr::set_names(x = logs)
  } else if (type == "numerics") {
    ints <- col_type_nms(data = data, type = "int")
    dbls <- col_type_nms(data = data, type = "dbl")
    nums <- unique(c(ints, dbls))
    dates <- col_type_nms(data = data, type = "date")
    posixts <- col_type_nms(data = data, type = "posixt")
    posixcts <- col_type_nms(data = data, type = "posixct")
    posixlts <- col_type_nms(data = data, type = "posixlt")
    all_dates <- unique(c(dates, posixts, posixcts, posixlts))
    only_nums <- nums[nums %nin% all_dates]
    purrr::set_names(x = only_nums)
  } else if (type == "dates") {
    dates <- col_type_nms(data = data, type = "date")
    posixts <- col_type_nms(data = data, type = "posixt")
    posixcts <- col_type_nms(data = data, type = "posixct")
    posixlts <- col_type_nms(data = data, type = "posixlt")
    all_dates <- unique(c(dates, posixts, posixcts, posixlts))
    purrr::set_names(x = all_dates)
  } else if (type == "characters") {
    chrs <- col_type_nms(data = data, type = "chr")
    purrr::set_names(x = chrs)
  } else if (type == "factors") {
    fcts <- col_type_nms(data = data, type = "fct")
    purrr::set_names(x = fcts)
  } else if (type == "lists") {
    lsts <- col_type_nms(data = data, type = "lst")
    purrr::set_names(x = lsts)
  } else {
    nms <- colnames(data)
    purrr::set_names(x = nms)
  }
}

