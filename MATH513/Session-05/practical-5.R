#
###
### Practical 5: function writing
###
#
#####################################################################
#
# This section illustrates some of the basics of function writing in R
#
#####################################################################
#
# Example of a simple function
#
# The ***** STANDARD ERROR ***** is an important statistical measure
#
# The standard error tells us how unreliable an estimate is.
# The standard error of the sample mean  
# is the standard deviation divided by the 
# square root of the sample size:
#
# standard error = standard deviation / square root of sample size
#
# The larger the standard error, the more unreliable (less accurate) is the sample mean
#
#
# Here is a function to compute the standard error of data in an R object x
#
#
my_se <- function(x){ # Take in x
  sd(x) / sqrt(length(x)) # Return the standard error
  # standard deviation / square root of sample size
}
#
#
# ------------------------------------------------------------------
#
# Let's apply it to some of the questionnaire data 
#
# Let's read in the data
#
# We can read in a csv file using the function read_csv from the pacakge readr
#
library(readr)
#
# Now read in the data
#
questionnaire_data <- read_csv("../data/MATH513_Questionnaire_Data.csv") 
#
# Check the variable names
#
names(questionnaire_data)
#
# Compute the sample mean height
#
mean(questionnaire_data$Height)
#
# How unreliable is this value?
#
my_se(questionnaire_data$Height)
#
# We'll discuss what this means in a little more detail later
#
# An alternative (recommended, as it's easier to read) way of making 
# an R function look into a data frame for an R object 
# is to use with:
#
with(questionnaire_data, my_se(Height))
# Working with the data in questionnaire_data, apply the function my_se to Height
#
# We can use a function that we have written, here my_se, in dplyr
#
library(dplyr)
#
questionnaire_data %>% summarise(Height_se = my_se(Height))
#
# Now let's make use of some of the power of dplyr
#
# Let's work out the standard error for Females and Males separately
#
questionnaire_data %>% group_by(Sex) %>%       
  summarise(Height_se = my_se(Height)) # sample standard error (how unreliable is the sample mean)
#
# Let's also compute and report the sample mean
#
questionnaire_data %>% group_by(Sex) %>%       
  summarise(Height_mean = mean(Height), # sample mean
            Height_se = my_se(Height)) %>% # sample standard error (how unreliable is the sample mean)
  as.data.frame() # this last line ensures all decimals are printed, by transforming the tibble into a data frame
#
# So the sample mean for Males has a higher standard error, and is therefore more unreliable (less accurate)
# than the sample mean for Females
#
# Let's confirm the values that our function my_se produces
#
questionnaire_data %>% group_by(Sex) %>%       
  summarise(Height_mean = mean(Height), # sample mean
            Height_se = my_se(Height), # sample standard error (how accurate is the sample mean)
            sd = sd(Height), # sample standard deviation
            n = n(), # sample size
            se = sd / sqrt(n)) %>% # standard error, calculated using sd and n, just to check my_se
  as.data.frame() # to ensure all decimals are printed
#
#
# Same answers for the standard error!
#
#
#####################################################################
#
# A more sophisticated function
#
trimmed_mean <- function(x, trim = 0.1){ # Take in x and trim, set by default to 0.1
  #
  # x and trim are the arguments of this function
  #
  # Function to work out the sample mean and trimmed mean
  # of data passed through in x
  # trim: the fraction (0 to 0.5) of observations to be trimmed from each end of x 
  # before the mean is computed
  #
  out_m <- mean(x) # Sample mean
  out_m_trimmed <- mean(x, trim = trim) # Trimmed mean
  #
  # Return these values in a list
  #
  return(list(M = out_m, M_TRIMMED = out_m_trimmed)) 
  # We can specify names for the returned objects
}
#
# ------------------------------------------------------------------
#
# Examples, applied to the speed of the group
#
questionnaire_data_2 <- questionnaire_data %>% 
  mutate(Speed = Distance / Travel_time, Speed_mph = 60 * Speed)
#
# Look at the values of speed in miles per hour
#
questionnaire_data_2$Speed_mph
#
trimmed_mean(questionnaire_data_2$Speed_mph) # Uses the default value of trim (0.1)
trimmed_mean(questionnaire_data_2$Speed_mph, trim = 0.2) # Sets trim = 0.2
#
# We can extract the individual elements of the results using $
#
results <- trimmed_mean(questionnaire_data_2$Speed_mph) 
results$M # Extract M, the sample mean
results$M_TRIMMED # Sample trimmed mean


results_2 <- trimmed_mean(questionnaire_data_2$Speed_mph, trim = 0.2) 
results_2$M
results_2$M_TRIMMED

#
# Compare these sample trimmed means
#
c(results$M_TRIMMED, results_2$M_TRIMMED)
#
# They are different, but the sample means are the same
#
c(results$M, results_2$M)
#
#
# ------------------------------------------------------------------
#
# It's worth noting that there are various ways of referring to the arguments of a function
#
# Above we used
#
trimmed_mean(questionnaire_data_2$Speed_mph, trim = 0.2)
#
# We can name each argument
#
args(trimmed_mean) # Check what the arguments are
#
trimmed_mean(x = questionnaire_data_2$Speed_mph, trim = 0.2) # Named arguments
#
# Naming the arguments allows us not to worry about the order in which they are specified
#
trimmed_mean(trim = 0.2, x = questionnaire_data_2$Speed_mph) # Works fine!
#
#
# ------------------------------------------------------------------
#
# ***** A way of documenting a function that will be of use later *****
#
# Documenting our functions is very important.
# It helps others to understand what the function does.
# It's important to note that "others" in this sentence can refer to "future you"!
#
# Here we present a way of documenting our function that will be useful later:

#' Statistical Summaries of a Numeric Data Set
#'
#' This function provides statistical summaries of
#' a numeric data set.
#'
#' @param x A numeric vector containing the data.
#' @param trim The fraction (0 to 0.5) of observations to be trimmed from each end of x before the mean is computed. Default is 0.1.
#'
#' @return A named vector of numerical summaries:
#' \describe{
#' \item{M}{The mean of the data.}
#' \item{M_TRIMMED}{The trimmed mean of the data.}
#' }
trimmed_mean <- function(x, trim = 0.1){ 
  #
  out_m <- mean(x) # Sample mean
  out_m_trimmed <- mean(x, trim = trim) # Trimmed mean
  #
  # Return these values in a list
  #
  return(list(M = out_m, M_TRIMMED = out_m_trimmed)) 
}
