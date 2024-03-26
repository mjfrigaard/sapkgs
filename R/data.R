#' Movie reviews
#'
#' The movies dataset combines data from IMDB and Rotten Tomatoes on a random
#' sample of 651 movies released in the US between 1970 and 2014. Read more
#' about these data here: https://github.com/rstudio-education/shiny-course/
#'
#' Course: https://rstudio-education.github.io/shiny-course/
#'
#' @format A data frame with 651 rows and 34 variables:
#' \describe{
#'   \item{title}{title of movie}
#'   \item{title_type}{Type of title: Documentary, Feature Film, or TV Movie}
#'   \item{genre}{One of: Drama, Comedy, Horror, Documentary, Action & Adventure, Art House & International, Musical & Performing Arts, Mystery & Suspense, Animation, Science Fiction & Fantasy & Other}
#'   \item{runtime}{time of movie in minutes}
#'   \item{mpaa_rating}{One of: R, PG-13, PG, Unrated, G & NC-17}
#'   \item{studio}{Name of studio}
#'   \item{thtr_rel_date}{Date: YYYY-MM-DD HH:MM:SS}
#'   \item{thtr_rel_year}{YYYY}
#'   \item{thtr_rel_month}{MM}
#'   \item{thtr_rel_day}{DD}
#'   \item{dvd_rel_date}{Date: YYYY-MM-DD HH:MM:SS}
#'   \item{imdb_rating}{Numeric rating: ranging from 1.9 to 9}
#'   \item{imdb_num_votes}{Number of IMDB votes}
#'   \item{critics_rating}{Rotten, Certified Fresh & Fresh}
#'   \item{critics_score}{Numeric rating: ranging from 1 to 100}
#'   \item{audience_rating}{Upright & Spilled}
#'   \item{audience_score}{Numeric rating: ranging from 11 to 97}
#'   \item{best_pic_nom}{no & yes}
#'   \item{best_pic_win}{no & yes}
#'   \item{best_actor_win}{no & yes}
#'   \item{best_actress_win}{no & yes}
#'   \item{best_dir_win}{no & yes}
#'   \item{top200_box}{no & yes}
#'   \item{director}{Name of director}
#'   \item{actor1}{Name of actor #1}
#'   \item{actor2}{Name of actor #2}
#'   \item{actor3}{Name of actor #3}
#'   \item{actor4}{Name of actor #4}
#'   \item{actor5}{Name of actor #5}
#'   \item{imdb_url}{URL for IMDB movie}
#'   \item{rt_url}{URL for Rotten tomatoes movie}
#' }
"movies"
