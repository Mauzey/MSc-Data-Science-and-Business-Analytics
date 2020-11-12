#' Statistical Summaries of a Numeric Data Set
#'
#' This function provides statistical summaries of
#' a numeric data set.
#' It calls the \code{statsCalculate} function.
#' It also plots a histogram using the \code{ggplot2} package.
#'
#' @param vec A numeric vector containing the data
#' @inheritParams statsCalculate
#'
#' @return A named vector of numerical summaries and the number of \code{NA}:
#' \describe{
#' \item{Mean}{The mean of the data.}
#' \item{Standard Deviation}{The standard deviation of the data.}
#' \item{NAs}{The number of missing data}
#' }
#'
#' @author Luciana Dalla Valle \email{luciana.dallavalle@@plymouth.ac.uk}, Julian Stander \email{J.Stander@@plymouth.ac.uk}
#' @import ggplot2
#' @export
#' @examples
#' x <- rnorm(100)
#' dataSummary(x)
#'
dataSummary <- function(vec, na.rm = TRUE){
  #
  # Check the inputs are of the correct form
  #
  if(!is.numeric(vec)) stop("You must provide a numeric vector", call. = FALSE)
  #
  if(!is.logical(na.rm)) stop("na.rm must be a logical (TRUE/FALSE) value", call. = FALSE)
  #
  if(length(vec) <= 1) warning(paste("Some summaries may be incorrect as length of input vector is", length(vec)), call. = FALSE)
  #
  # get the numeric summaries
  #
  vecSummaries <- statsCalculate(vec, na.rm = na.rm)
  #
  # add the number of missing values
  #
  out <- c(vecSummaries, "NAs" = sum(is.na(vec)))
  #
  # Plot a histogram using ggplot2
  #
  df_vec <- data.frame(vec = vec)
  gg_vec <- ggplot(df_vec, aes(x = vec)) + geom_histogram()
  print(gg_vec)

  return(out)

}
