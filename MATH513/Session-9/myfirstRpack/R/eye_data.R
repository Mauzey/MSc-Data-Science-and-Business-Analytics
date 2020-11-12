#' The eye data
#'
#' The eye data is a nice and useful data set.
#' It reports logMar measurements from a group of children,
#' together with their age
#'
#' @format A data.frame with 1500 rows and 4 columns:
#' \describe{
#'  \item{Age}{Child age (years)}
#'  \item{Age_Group}{Child age group (years)}
#'  \item{Right_Eye_Measurement}{logMar measurement for right eye}
#'  \item{Left_Eye_Measurement}{logMar measurement for left eye}
#' }
#'
#' @examples
#' with(eye_data, mean(Right_Eye_Measurement))
#' with(eye_data, mean(Left_Eye_Measurement))
#'
#' @source Data provided by Mario, but disclosure protected
"eye_data"
