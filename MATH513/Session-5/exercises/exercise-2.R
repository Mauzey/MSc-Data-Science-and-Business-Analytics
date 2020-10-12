# import
library(ggplot2)
library(dplyr)

# here is a simple data set that contains three missing values
x <- c(2, 6, NA, 5, 2, 1, NA, 6, 6, 7, NA, 4, 0)

# -----------------------------------------------------

# write a function called 'display_data()' that takes a numeric
#   data vector as input, and produces a histogram of that data
display_data <- function(x){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # returns a histogram of the provided 'x' data
  
  # convert input data to dataframe for use with ggplot
  df <- data.frame(x = x)
  
  # create and return a histogram of the data
  return(
    ggplot(data = df, aes(x = x)) +
      geom_histogram()
  )
}

display_data(x)

# -----------------------------------------------------

# modify your function so that you also pass through a label
#   'x_lab' for the x-axis. set "my data" by default
display_data <- function(x, x_lab = "my_data"){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # x_lab: a string which is used as the x-axis label
  # returns a histogram of the provided 'x' data
  
  # convert input data to data frame for use with ggplot
  df <- data.frame(x = x)
  
  # create and return a histogram of the data
  return(
    ggplot(data = df, aes(x = x)) +
      geom_histogram() +
      labs(x = x_lab)
  )
}

display_data(x, "X-Axis Label")

# -----------------------------------------------------

# write a function, 'summarize_data' that uses dplyr to compute
#   and return the sample minimum, mean, standard deviation,
#   and maximum of the provided data, as well as the number of
#   missing values
summarise_data <- function(x, na.rm = TRUE){
  # x: a numeric data vector that may contain missing values
  #   coded as 'NA'
  # na.rm: a boolean value that dictates whether or not missing
  #   values are included in calculations
  # the function returns a data frame containing the minimum,
  #   mean, standard deviation, and maximum of the input data
  #   as well as the number of missing values
  
  # convert input data to a data frame
  df <- data.frame(x = x)
  
  # return a summary of the data
  return(
    summarise(df,
              min = min(x, na.rm = na.rm),
              avg = mean(x, na.rm = na.rm),
              std = sd(x, na.rm = na.rm),
              max = max(x, na.rm = na.rm),
              NAs = sum(is.na(x)))
  )
}

summarise_data(x)
summarise_data(x, FALSE)

# -----------------------------------------------------

# modify the function so that it also returns the sample size
#   and the standard error
summarise_data <- function(x, na.rm = TRUE){
  # input:
  #   x: (numeric) data vector that may contain missing values
  #   na.rm: (bool) include missing values in calculations
  # returns:
  #   data frame containing a statistical summary of data 'x'
  
  # convert input data to a data frame
  df <- data.frame(x = x)
  
  # return a summary of the data
  return(
    summarise(df,
              min = min(x, na.rm = na.rm),
              avg = mean(x, na.rm = na.rm),
              std = sd(x, na.rm = na.rm),
              max = max(x, na.rm = na.rm),
              NAs = sum(is.na(x)),
              ste = sd(x, na.rm = na.rm) / sqrt(sum(!is.na(x))),
              size = sum(!is.na(x)))
  )
}

summarise_data(x)
summarise_data(x, FALSE)




