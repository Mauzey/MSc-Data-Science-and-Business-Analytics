# here is a simple data set that contains three missing values
x <- c(2, 6, NA, 5, 2, 1, NA, 6, 6, 7, NA, 4, 0)

# -----------------------------------------------------

# write a function called 'mean_NA' that automatically removes
#   missing values
mean_NA <- function(x){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # the function returns the sample mean of the non-missing
  #   values
  mean(x, na.rm = TRUE)
}

mean_NA(x)

# -----------------------------------------------------

# copy and modify the function to return the minimum, mean,
#   standard deviation, and maximum of the input data
statistics_NA <- function(x){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # the function returns the minimum, mean, standard deviation,
  #   and maximum of the input data
  min <- min(x, na.rm = TRUE)
  avg <- mean(x, na.rm = TRUE)
  std <- sd(x, na.rm = TRUE)
  max <- max(x, na.rm = TRUE)
  
  return(list(min = min, avg = avg, std = std, max = max))
}

statistics_NA(x)
statistics_NA(x)$max

# -----------------------------------------------------

# modify the function so that it also returns the number of NAs
statistics_NA <- function(x){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # the function returns the minimum, mean, standard deviation,
  #   and maximum of the input data as well as the number of
  #   missing values
  min <- min(x, na.rm = TRUE)
  avg <- mean(x, na.rm = TRUE)
  std <- sd(x, na.rm = TRUE)
  max <- max(x, na.rm = TRUE)
  
  NAs <- sum(is.na(x))
  
  return(list(min = min, avg = avg, std = std, max = max,
              NAs = NAs))
}

statistics_NA(x)

# -----------------------------------------------------

# include 'na.rm' as an argument of your function, set to TRUE
#   by default. pass this argument into the calculations made
#   within the function
statistics_NA <- function (x, na.rm = TRUE){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # na.rm: a boolean value that dictates whether or not missing
  #   values are included in calculations
  # the function returns the minimum, mean, standard deviation,
  #   and maximum of the input data as well as the number of
  #   missing values
  min <- min(x, na.rm = na.rm)
  avg <- mean(x, na.rm = na.rm)
  std <- sd(x, na.rm = na.rm)
  max <- max(x, na.rm = na.rm)
  
  NAs <- sum(is.na(x))
  
  return(list(min = min, avg = avg, std = std, max = max,
              NAs = NAs))
}

statistics_NA(x, na.rm = FALSE)








