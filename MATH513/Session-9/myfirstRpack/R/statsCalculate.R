#' Mean and Standard Deviation of a Numeric Data Set
#'
#' This function provides two statistical summaries of
#' a numeric data set.
#' These comprise a measure of location in the form of a mean
#' and a measure of spread in the form of a standard deviation.
#'
#' @param x A numeric vector containing the data.
#' @param na.rm Should \code{NA} be removed?  Default value \code{TRUE}.
#'
#' @return A named vector of numerical summaries and the number of \code{NA}:
#' \describe{
#' \item{Mean}{The mean of the data.}
#' \item{Standard Deviation}{The standard deviation of the data.}
#' }
#'
#' @author Luciana Dalla Valle \email{luciana.dallavalle@@plymouth.ac.uk}, Julian Stander \email{J.Stander@@plymouth.ac.uk}
#' @export
#' @examples
#' x <- rnorm(100)
#' statsCalculate(x)
#'
statsCalculate <- function(x, na.rm = TRUE){
  #
  # Check that the input is sensible
  #
  if(!is.numeric(x)) stop("You must provide a numeric vector", call. = FALSE)
  #
  # Perform the calculations
  #
  xMean <- mean(x, na.rm = na.rm)
  xSd <- sd(x, na.rm = na.rm)
  #
  # Return the results
  #
  c("Mean" = xMean, "Standard_Deviation" = xSd)
}
