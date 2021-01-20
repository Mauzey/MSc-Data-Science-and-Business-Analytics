
# Tutorial 02: Reading in Data and Data Manipulation ------------------------------------------------------------------------

# There are many ways of reading data into R. One of the easiest ways of reading a comma separated variable file into R is to use
# the function 'read_csv()' from the 'readr' package. Which you may have to install on your own machine:
install.packages('readr', repos = "http://www.stats.bris.ac.uk/r/")

library(readr)  # load the 'readr' package

qd <- read_csv("./data/MATH513_Questionnaire_Data.csv")  # read in the .csv file

head(qd)  # inspect the first few rows
names(qd)  # inspect the variable names

# Inspect the dimensions of the data (rows and columns)
dim(qd)
nrow(qd)
ncol(qd)


# Reading Data from Excel Worksheets ----------------------------------------------------------------------------------------

# R can read in data from a variety of software, including Excel. Here we illustrate how to read in data from an excel worksheet.
# It's usually safer practice to convert an Excel worksheet into a .csv file
#
# Here, we red in the data directly from Excel using the 'readxl' package
install.packages('readxl', repos = "http://www.stats.bris.ac.uk/R/")
library(readxl)

# Read in data from Excel using the 'read_excel()' function
qd_excel <- read_excel('./data/MATH513_Questionnaire_Data.xlsx',
                       sheet = "MATH513_Questionnaire_Data")  # specify the sheet to import

head(qd_excel)  # inspect the first few rows
names(qd_excel)  # variable names


# Manipulating Data ---------------------------------------------------------------------------------------------------------

# The `dplyr` package provides us with excellent tools for manipulating data:
install.packages('dplyr', repos = "http://www.stats.bris.ac.uk/R/")
library(dplyr)

# We can filter rows based on a condition:
filter(qd, Sex == 'Male')
filter(qd, Sex == 'Male' & Height > 170)

# We can summarise variables:
summarise(qd, ave = mean(Height))

# The previous code shows you the rounded result. To see decimal places you need to transform the result into a dataframe
as.data.frame(summarise(qd, ave = mean(Height)))

summarise(qd, sd = sd(Height))  # standard deviation of height
summarise(qd, ave = mean(Height), sd = sd(Height))  # multiple summary statistics

count(qd, Sex)  # we can count the number of values

# We can summarize grouped variables:
group_by(qd, Sex)

# ... and chain commands together using the pipe operator (%>%)
qd %>%
  group_by(Sex) %>%
  summarise(ave = mean(Height), sd = sd(Height))

# We can use the 'n()' function to count the number of observations
qd %>%
  group_by(Sex) %>%
  summarise(ave = mean(Height), sd = sd(Hegiht), n = n())
