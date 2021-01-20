
# Tutorial 01:  Introduction ------------------------------------------------------------------------------------------------

# We type our R commands into a file so that they can be used again or modified. Please keep saving your work in the usual
# way.
#
# Lines beginning with '#' are comment lines that we include to remind ourselves (and tell others) what we are doing.
#
# Commands are processed in the R console. Commands can be sent through to the R console using 'CTRL+ENTER', or by clicking on
# the 'Run' button in the top right corner of the editor.

citation()  # to cite R

# We will use a number of contributed packages. These should be installed on University machines. On personal machines, they can
# be installed through 'Packages' and then 'Install' in the bottom right window of RStudio. They can also be installed using the
# command line:
install.packages('devtools', repos = "http://www.stats.bris.ac.uk/R/")  # Bristol is the nearest R package repository

# Any line starting with '#' is a comment line; it is not interpreted by R


# Inputting Data by Hand ----------------------------------------------------------------------------------------------------

# The 'c()' function collects data together. R is based on functions such as c(). All functions are defined using round brackets

age <- c(53, 43, 58, 38, 49, 55)  # 'age' is an R object containing data. This is age data, the units of which are months
age  # To inspect an R object, just enter its name

height <- c(98, 91, 104, 89, 97, 99)  # another example. This is height data, the units of which are centimeters
height

age[2]  # we can access individual elements of an R object or vector using square brackets
age[2:4]  # '2:4' is a sequence from 2 to 4

age[c(3,5)]  # collect the 3rd and 5th elements using the 'c()' function
age[-c(3,5)]  # collect all elements except the 3rd and 5th


# Creating a Dataframe ------------------------------------------------------------------------------------------------------

# Dataframes are very important objects within R. It allows us to keep related data together
df <- data.frame(age, height)
df  # rows correspond to individual observations and columns correspond to variables

View(df)  # open the dataframe in the RStudio viewer
names(df)  # return the column names

# To access individual columns, use the '$' operator
df$age
df$height

# or, alternatively:
df['age']
df[['height']]


# Basic Plotting ------------------------------------------------------------------------------------------------------------

# Plotting 'height' on the vertical axis against 'age' on the horizontal axis
library(ggplot2)  # load the 'ggplot2' package

# We tell 'ggplot2' where to look for the data and the general features (i.e. aesthetics) of the graph. That is, what to plot on
# the x and y axis
ggplot(df, aes(x = age, y = height)) +
  # the type of plot to create (size = 3 increases the size of the data points) (col = 'red' colours the data points)
  geom_point(size = 3, col = 'red') +
  labs(x = "Age (months)", y = "Height (cms)",  # add labels for both axes
       title = "Child Age vs. Height",  # add a title to the plot
       subtitle = "Random sample size of 6")  # add a subtitle


# Summary Statistics --------------------------------------------------------------------------------------------------------

mean(age)  # the sample mean
sum(age) / length(age)  # it's the sum of the values, divided by the number of values (sample size)

median(age)  # the sample median. The median is less sensitive to outlying points than the sample mean
sort(age)  # we can check the median by sorting the values


# Getting Help --------------------------------------------------------------------------------------------------------------

?mean
help('median')


# Factors -------------------------------------------------------------------------------------------------------------------

sex <- c('M', 'M', 'M', 'F', 'F', 'F')  # the sex of each child
sex

# 'M' and 'F' are characters that label the sex of each child. To allow R to work with data like this, comprising of labels, 
# we convert the R object into a factor:
sex_f <- factor(sex)
sex_f
table(sex_f)  # we can tabulate using 'table()'

df_2 <- data.frame(age, height, sex_f)  # compile all of the data into a dataframe
df_2
str(df_2)  # inspect the structure of the dataframe



# Factors will be very important to use later in this module. Here is another example:
agreement <- c(0, 1, 1, 0, 0, 0, 0, 0, 0, 0)  # 0 = 'No' and 1 = 'Yes'
agreement

# Convert to a factor with appropriate labels
agreement_f <- factor(agreement, levels = c(0,1), labels = c('No', 'Yes'))
# or, slightly shorter:
agreement_f <- factor(agreement, levels = 0:1, labels = c('No', 'Yes'))
table(agreement_f)

# We can impose a different order:
agreement_f <- factor(agreement, levels = c(1, 0), labels = c('Yes', 'No'))
agreement_f
table(agreement_f)
