################################################################
#
###
### Practical 3: Data manipulation and tidyr
###
#
## ------------------------------------------------------------------------
#
# Reading in and working with data from a file
#
# First specify the working directory
# This is where R will look for any file that you ask it to read in
#
# If you have RStudio installed on your machine or you are using the University 
# machines and your working directory is in your memory stick on the "D" drive:
#setwd("D://MATH513")
#
# You may have a different working directory
#
# The IMPORTANT POINT is that any file that you read in is there
#
## ------------------------------------------------------------------------
#
# Reading in a file
#
# Let's read in the questionnaire data 
#
# The data are supplied in the file "MATH513_Questionnaire_Data.csv"
#
# Please have a look at that file
#
# There are many ways of reading data into R
#
# One of the easiest ways of reading a comma separated variable file into R
# is to use the function read_csv from the readr package, which you may have to install on your own machine
#
## install.packages("readr", repos = "http://www.stats.bris.ac.uk/R/")  # Install the package on your own machine
#
# Load the readr package
#
library(readr)
#
# Read in the data in the file "MATH513_Questionnaire_Data.csv"

qd <- read_csv('../data/MATH513_Questionnaire_Data.csv')
#
# See the first few rows
#
head(qd) 
#
# Variable or column names
#
names(qd) 
#
# Dimension, number of rows and number of columns
#
dim(qd)
nrow(qd)
ncol(qd)
#
## ------------------------------------------------------------------------
## ------------------------------------------------------------------------
## ------------------------------------------------------------------------
## ------------------------------------------------------------------------
#
# Manipulating data
#
# The dplyr package provides us with excellent tools for manipulating data
# You may have to install this package on your own machine
#
## install.packages("dplyr", repos = "http://www.stats.bris.ac.uk/R/")  # Install the package on your own machine
#
# Load the dplyr package
#
library(dplyr)
#
#
# We will work with the qd data frame that contains the data in the file MATH513_Questionnaire_Data.csv
#
# Let's remind ourselves of the columns or variables of the qd data frame and its structure
#
str(qd)
#
## ------------------------------------------------------------------------
#
# We can **arrange** the data frame in increasing order according to a variable
#
arrange(qd, Height) # Arranged by increasing order of height
#
# Alternatively, the code can be written using the "pipe": %>%
qd %>% arrange(Height)
#
#
# Decreasing order is also possible
#
arrange(qd, desc(Height)) # Arranged by decreasing order of height
#
# Alternative code:
qd %>% arrange(desc(Height))
#
#
# Arrange by one variable, splitting ties on another
#
qd2 <- arrange(qd, Height, Travel_time)
qd2 
# Not all variables shown
#
# Alternative code: 
qd2 <- qd %>% arrange(Height, Travel_time)
qd2
#
#
# Select Height and Travel_time
#
select(qd2, Height, Travel_time)
#
# Alternative code: 
qd2 %>% select(Height, Travel_time)
#
#
## ------------------------------------------------------------------------
#
# We can define a new variable using *mutate*
#
# Here we define Speed as Distance divided by Travel_time
#
qd3 <- mutate(qd, Speed = Distance / Travel_time)
qd3$Speed # Miles per minute
#
# Alternative code: 
qd3 <- qd %>% mutate(Speed = Distance / Travel_time)
qd3$Speed
#
#
# Miles per hour, as well
#
qd3 <- mutate(qd, Speed = Distance / Travel_time, Speed_mph = 60 * Speed)
# Note that we can make use of a defined variable within mutate
qd3$Speed_mph
#
# Someone's very quick!
#
# Alternative code: 
qd3 <- qd %>% mutate(Speed = Distance / Travel_time, Speed_mph = 60 * Speed)
qd3$Speed_mph
#
#
## ------------------------------------------------------------------------
#
# We can *rename* a variable
#
# Here we rename Speed_mph as s
#
qd4 <- rename(qd3, s = Speed_mph)
#
qd4$s
qd4$Speed_mph # No longer there!
#
# Alternative code: 
qd4 <- qd3 %>% rename(s = Speed_mph)
qd4$s
qd4$Speed_mph # No longer there!
#
## ------------------------------------------------------------------------
#
# We can *summarise* variables - reminder
#
# We can use the "pipe" "%>%" to chain results.
#
# We can use the function n to count the number of observations
#
# Here we also arrange the results according to the standard deviations, in descending order
#
qd %>% group_by(Sex) %>% 
  summarise(ave = mean(Height), sd = sd(Height), n = n()) %>% 
  arrange(desc(sd))
#
#
#
## ------------------------------------------------------------------------
#
# Joining data frames
#
# Let's create two data frames and then join them in different ways
#
# Using dplyr's tibble function is more efficient than
# the base R function data.frame
#
a <- tibble(x1 = c("A", "B", "C"), x2 = c(1, 2, 3))
a
#
# The second data frame
#
b <- tibble(x1 = c("A", "B", "D"), x3 = c(4, 5, 6))
b
#
# *Left join* them by x1: join matching rows from b to a
#
left_join(a, b, by = "x1")
#
# * Right join* them by x1: join matching rows from a to b
#
right_join(a, b, by = "x1")
#
# *Inner join* them by x1: retain only the rows in both data frames
#
inner_join(a, b, by = "x1")
#
# *Full join* them by x1: retain all values and all rows
#
full_join(a, b, by = "x1")
#
# There is no problem if the variable names in the data frames are different
#
b_var <- tibble(x1_var = c("A", "B", "D"), x3 = c(4, 5, 6)) # x1 is now called x1_var
b_var
#
left_join(a, b_var, by = c("x1" = "x1_var")) # Join by x1 in a and x1_var in b_var
right_join(a, b_var, by = c("x1" = "x1_var"))
inner_join(a, b_var, by = c("x1" = "x1_var"))
full_join(a, b_var, by = c("x1" = "x1_var"))
#
## ------------------------------------------------------------------------
#
# Changing *wide* data into *long* data
#
# This can be very important for summarizing and plotting data
#
# Let's read in a wide data set and look at it
#
# Make sure that you've set the working directory appropriately
#
library(readr)
wide <- read_csv('../data/wide_data.csv')
wide
names(wide)
#
# There are three observations on each patient
#
# It's often useful to have all the observations in one variable,
# with another variable indicating the observation number
# 
# This can be achieved using the function gather from the tidyr package, which you may have to install at home
#
## install.packages("tidyr", repos = "http://www.stats.bris.ac.uk/R/")  # Install the package on your home machine
#
# Load the tidyr package
#
library(tidyr)
#
# Place the information in columns 2 to 4 into a column or variable called "Value", 
# with a column or variable "Observation" recording the observation number
#
long <- gather(wide, "Observation", "Value", 2:4)
long
#
# The opposite of gather is spread
#
spread(long, "Observation", "Value")
#
# It's much easier to compute summaries using the long form
#
# The maximum value for each patient
#
long %>% group_by(Patient) %>% summarise(maximum = max(Value))
#
# The interquartile range for each observation
# The interquartile range is another measure of spread that is more robust to outliers than the standard deviation
#
long %>% group_by(Observation) %>% summarise(spread = IQR(Value))
#
# Plotting the data is easier too
#
library(ggplot2)
#
ggplot(long, aes(x = Observation, y = Value, group = Patient, col = Patient)) + 
  geom_point() +
  geom_line()
#
# Each patient is considered a separate "group"
# geom_line joins up the points in each group
#
## ------------------------------------------------------------------------
#
# The ifelse function can be very useful
#
# Here are some examples
#
ifelse(qd$Height > 170, "tall", "less tall")
# if Height in qd > 170 then return "tall", else return "less tall"
# Here are the data to remind us:
#
qd$Height
#
# In fact, Observation_1 was taken at 5 months, Observation_2 at 8 months and Observation_3 at 12 months
#
# We now define a variable Observation_time that records these times
#
long_with_times <- long %>% mutate(Observation_time = 
                                     ifelse(Observation == "Observation_1", 5,
                                            ifelse(Observation == "Observation_2", 8, 12)))
#
long_with_times
#
# Now plot
#
ggplot(long_with_times, 
       aes(x = Observation_time, y = Value, group = Patient, colour = Patient)) + 
  geom_point() +
  geom_line() +
  labs(x = "Observation time (months)")
#
#

