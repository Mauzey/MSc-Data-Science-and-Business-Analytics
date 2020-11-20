#
###
### Practical 4: Introduction to ggplot2, a sophisticated plotting engine
###
#
## ------------------------------------------------------------------------
#
# ***** Some simple data with which to work *****
#
# Our initial example will be based on the child data
#
# ** We've seen some of this code before **
#
# Here are the data from six children that we worked with before
#
age <- c(53, 43, 58, 38, 49, 55) # The age of each child in months
height <- c(98, 91, 104, 89, 97, 99) # The corresponding height of each child in cms
sex <- c("M","M","M","F","F","F") # The corresponding sex of each child
#
# We have additional data: the town in which each child lives
#
town <- c("Town 1", "Town 1", "Town 2", "Town 2", "Town 3", "Town 3")
#
# Some data preparation
#
# Make sex into a factor, because "F" and "M" are characters and not numbers
#
sex_f <- factor(sex,
                levels = c("F", "M"), # We can choose the order
                labels = c("Female", "Male")) # Matching labels
#
# Similarly, make town into a factor
#
town_f <- factor(town)
#
# Put all the data into a data frame to keep them together in a neat way
#
df <- data.frame(age, height, sex_f, town_f)
#
# and look at it
#
df
str(df) # Note that internally factors are saved as numbers
#
###############################################################################
#
# ***** ggplot2 *****
#
# ggplot2 is a very sophisticated plotting package
#
# gg stands for "grammar of graphics"
#
# As always our approach will be STEP BY STEP
#
# We have already met ggplot2 briefly
#
# On your own computer you may need to install the ggplot2 package
# This package contains all the ggplot2 functions and associated data sets
# (You do not need to install ggplot2 on a university machine)
#
# One way of installing the ggplot2 package is using the following line,
# which has been commented out because you will usually not need to run it
#
## install.packages("ggplot2", repos = "http://www.stats.bris.ac.uk/R/")  # Install the package on your own machine
#
# Load the package
#
library(ggplot2)
#
## ------------------------------------------------------------------------
#
# ****** Scatter Plots ******
#
# An example, without spoken explanation, to show what is possible
#
ggplot(df, aes(x = age, y = height, col = sex_f)) + # The aesthetics are features of the plot; look into the data frame df for the data
  geom_point() + # Plot using points
  labs(title = "Data from Children",
       subtitle = "You can specify a subtitle", # and a subtitle
       caption = "You can also specify a caption", # and a caption
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender") +
  geom_smooth(method = "lm", se = FALSE) + # Add a smooth curve
  facet_grid(sex_f ~ .) # A separate plot for females and males
#
# We are plotting height against age
# We have a separate graph or facet for each gender
# We add regression lines
#
## ------------------------------------------------------------------------
#
# Let's build this up step by step
#
# Set up the plot with **aesthetics** or **features**
# Here they are the age data on the x axis and the height data on the y axis
#
# Remember the contents of df
#
df
#
# *** Basic plot ***
#
# * Set up the plot *
# * Use a geometry to show the points *
#
ggplot(df, aes(x = age, y = height)) + # This sets up the plot
  geom_point() # This "geometry" plots points
#
# Add a * main title * and * label the axes *
#
ggplot(df, aes(x = age, y = height)) +
  geom_point() +
  labs(title = "Data from Children", # Main title
       x = "Age (months)", # Label for the x aesthetic
       y = "Height (cms)") # Label for the y aesthetic
#
# You can also add a subtitle, and a caption, which often provides information about the data source
#
ggplot(df, aes(x = age, y = height)) +
  geom_point() +
  labs(title = "Data from Children",
       subtitle = "You can specify a subtitle", # and a subtitle
       caption = "You can also specify a caption", # and a caption
       x = "Age (months)", y = "Height (cms)")
#
# Add a * smooth curve *
#
ggplot(df, aes(x = age, y = height)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")  +
  geom_smooth(span = 1) # Add a smooth curve "geometry"; span controls how wiggly the curve is
#
# The blue line is an estimate of the underlying relationship between height and age
# The band is an indication of how reliable this estimate is
# The narrower the band, the more reliable is the estimate
#
# The plot suggests that a straight line model would do well
# A straight line model is an example of a *l*inear *m*odel
#
# Now add a * straight line *
#
ggplot(df, aes(x = age, y = height)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")  +
  geom_smooth(method = "lm") # Add a straight line (or linear model)
#
# Use a * different colour * for Females and Males
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) + # Different colour for Females and Males; colour can be abbreviated as col
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")
#
# Specify a more meaningful * legend title *
# Here the legend is defined by the colour aesthetic
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)",
       colour = "Child Gender")    # Legend title, because the colour aesthetic defined the legend
#
# Separate * linear regressions * (straight line models) for each gender
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) # Straight line model with no standard errors or confidence bands
# geom_smooth "inherits" the aesthetics from aes(x = age, y = height, colour = sex_f)
# This means that, just as different points were used for each gender, different lines are used
#
# Now * separate plots * or *facets * for each gender
#
# * Row by row *
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ .) # A grid of plots with each row representing a gender
# The general syntax is: what is to be plotted in the rows ~ what is to be plotted in the columns
# The . means "nothing", so that here we have a grid of plots with sex_f being plotted in the rows
# and that's all!
#
# Now * column by column *, instead of row by row
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ sex_f) # Each column represents a gender
#
# Include the town information in the plot
# So * rows and columns * defined by different variables
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(town_f ~ sex_f) # Each row represents a town, each column represents a gender
#
# Of course the data set is very small, so in some plots there are no points:
#
with(df, table(town_f, sex_f)) # With the data from df, cross tabulate town_f and sex_f

# The * other way around *
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) # Each row represents a gender, each column represents a town
#
## ------------------------------------------------------------------------
#
# Instead of facet_grid, we can use * facet_wrap *, which just * wraps the plots around *
# We can specify the number of rows (or columns)
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ town_f, # Different plot for each level of town_f, wrapped around,
             nrow = 2) # using two rows
#
# Use *** different scales ***
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ town_f + sex_f, # Different plot for every level of town_f and sex_f, wrapped around,
             ncol = 3, # using three columns
             scales = "free") # Free scales
#
## ------------------------------------------------------------------------
#
# *** Specifying Our Own Scales ***
#
# Here we * specify the scale on the y-axis *
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  scale_y_continuous(breaks = c(80, 85, 90, 95, 100, 105, 110), # labelled breaks or white horizontal lines
                     minor_breaks = NULL, # No non-labelled horizontal lines
                     limits = c(80, 110)) # Specify the limits of the y-axis
#
#
# We can assign the colour * scale * manually
# In this example, Females are red and Males are blue
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender") +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ town_f,
             scales = "free") + # A different scale is used for the x-axis of each plot
  scale_colour_manual(values = c("Female" = "red", "Male" = "blue"))  # Assign the colours manually
#
# We can reverse the legend order, if we wish
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point() +
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender") +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ town_f,
             scales = "free") + # A different scale is used for the x-axis of each plot
  scale_colour_manual(guide = guide_legend(reverse = TRUE), # Reverse the legend order
                      values = c("Female" = "red", "Male" = "blue"))
#
## ------------------------------------------------------------------------
#
# ****** The use of theme ******
#
# We can * fine tune * a ggplot graph by adding a * theme *
#
# * theme * allow us to have complete control over our plots
# We can only touch the surface of this very detailed topic
#
# Here is an example (which may not look nice!)
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point(size = 4) + # Specify the size of all points
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  theme(plot.title = element_text(size = 28, color = "darkblue"), # Customize the main title
        axis.title = element_text(size = 20, color = "red"), # Customize the titles of both axes
        axis.text = element_text(size = 14, color = "green"), # Customize the text of both axes
        legend.title = element_text(size = 24, color = "pink"), # Customize the legend title
        legend.text = element_text(size = 22), # Customize the legend text
        strip.text = element_text(size = 18, color = "brown"), # Customize the facet text
        panel.background = element_rect(fill = 'darkgrey') # Customize the panel background
  )
#
# Another * similar example *
#
ggplot(df, aes(x = age, y = height, colour = sex_f)) +
  geom_point(size = 4) + # Specify the size of all points
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)", colour = "Child Gender")  +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  scale_colour_manual(values = c("Female" = "red", "Male" = "blue"))  + # Assign the colours manually
  theme(plot.title = element_text(size = 28, color = "darkblue"), # Customize the main title
        axis.title.x = element_text(size = 20, color = "red"), # Customize the titles of ***** x-axis *****
        axis.text.x = element_text(size = 14, color = "green"), # Customize the text of ***** x-axis *****
        axis.title.y = element_text(size = 10, color = "black"), # Customize the titles of ***** y-axis *****
        axis.text.y = element_text(size = 7, color = "purple", angle = 90, hjust = 0.5), # Customize the text of ***** y-axis *****: rotate by 90 degrees and line up with ticks
        strip.text.x = element_text(size = 18, color = "brown"), # Customize the facet text in ***** x-direction *****
        strip.text.y = element_text(size = 30, color = "yellow"), # Customize the facet text in ***** y-direction *****
        panel.background = element_rect(fill = 'darkgrey')) # Customize the panel background
#
# * Additional examples of themes * are provided towards the end and are for self-study
#
###############################################################################
#
# ***** Other Plots *****
#
# *** Other plots: the Boxplot ***
#
# * Read in the questionnaire data * (see Session 2 for details)
#
# Please note: you may have to set your working directory to the place where MATH513_Questionnaire_Data.csv has been saved
#
# If you have RStudio installed on your machine or you are using the University 
# machines and your working directory is in your memory stick on the "D" drive:
#setwd("D://MATH513")
#
#
# *** You may have a different working directory ***
#
library(readr)
#
qd <- read_csv("data/MATH513_Questionnaire_Data.csv") 
#
#
# A boxplot shows the median and lower and upper quartiles
#
# We will produce * boxplots of Height stratified by Sex *
#
ggplot(qd, aes(x = Sex, y = Height)) +
  geom_boxplot() +
  labs(x = "Gender", y = "Height (cms)")
#
# * Colour the boxplot borders *
#
ggplot(qd, aes(x = Sex,
               y = Height,
               colour = Sex)) + # Colour the borders according to Sex
  geom_boxplot() +
  labs(x = "Gender", y = "Height (cms)")
#
# * Fill the boxplots with a colour *
#
ggplot(qd, aes(x = Sex,
               y = Height,
               fill = Sex)) + # Fill the boxplot with a colour according to Sex
  geom_boxplot() +
  labs(x = "Gender", y = "Height (cms)")
#
# Is there an underlying difference in Height between the two Sexes?  We will answer this in the next sessions
#
## ------------------------------------------------------------------------
#
# *** Other plots: the Histogram ***
#
# We will produce a * histogram * of the Height values from the questionnaire data
#
# * Histogram *
#
ggplot(qd, aes(x = Height)) +
  geom_histogram() + # the geom_histogram "geometry" produces this histogram
  labs(x = "Height (cms)", title = "Student Heights")
#
# A histogram divides the x-axis up into bins and counts the number of data points that lie in each bin
#
# You can * change the number of bins *
#
ggplot(qd, aes(x = Height)) +
  geom_histogram(bins = 10) + # specify the number of bins
  labs(x = "Height (cms)", title = "Student Heights")
#
# Here's a * histogram of Height for each Sex *
#
ggplot(qd, aes(x = Height)) +
  geom_histogram() +
  labs(x = "Height (cms)") +
  facet_grid(Sex ~ .) # One facet for each value of Sex
#
# Perhaps even nicer, with * different colours *
#
ggplot(qd, aes(x = Height, fill = Sex)) + # Fill the histogram bars with a different colour
  geom_histogram() +
  labs(x = "Height (cms)") +
  facet_grid(Sex ~ .) # One facet for each value of Sex
#
# Please note that these histograms would be much better if the sample size were larger
#
###############################################################################
#
# * Logarithmic scales *
#
# Logarithmic scales go up in powers
#
# Let's plot Travel_time against Distance from the questionnaire data frame qd
#
ggplot(qd, aes(x = Distance, y = Travel_time)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Distance (miles)", y = "Time (minutes)")
#
# The bottom left corner is very squashed, so use a logarithmic scale
# on both the x and y axes
#
ggplot(qd, aes(x = Distance, y = Travel_time)) +
  geom_point() +
  geom_smooth() +
  scale_x_log10() + # logarithmic scale on the x-axis
  scale_y_log10() + # logarithmic scale on the y-axis
  labs(x = "Distance (miles)", y = "Time (minutes)")
#
# The scale on the axes goes up in powers of ten
#
# The bottom left corner is no longer squashed, so the detail that it contains can be seen
#
###############################################################################
#
# ***** Converting a Continuous Variable into a Factor *****
#
# This can be very useful to produce faceted plots
#
# Let's consider the range of the Age data
#
range(qd$Age)
#
# Split age into * age groups *
#
cut(qd$Age,
    breaks = c(12, 20, 22, 24, 30, 45), # Define the groups
    right = FALSE) # Intervals like [a,b), not closed on the right
#
# Compare
#
qd$Age
#
# Add a variable with this * age group * information to the data frame
#
library(dplyr) # For the mutate function
#
qd <- qd %>%
  mutate(Age_f = cut(Age,
                     breaks = c(12, 20, 22, 24, 30, 45),
                     right = FALSE))
#
# Tabulate
#
table(qd$Age_f)
#
# Produce a * histogram of Height faceted by Age_f *, the factor version of Age containing the * age group * information
#
ggplot(qd, aes(x = Height, fill = Age_f)) +
  geom_histogram() +
  labs(x = "Height (cms)", fill = "Age Group") +
  facet_grid(Age_f ~ .)
#
#
# Again, these histograms would be much better if the sample size were larger
#
###############################################################################
###############################################################################
###############################################################################
#
# ***** Additional Material for Self-Study *****
#
# Here are some additional examples of * themes *, also showing how we can control legends
#
# This plot also illustrates * two legends *
#
ggplot(df, aes(x = age, y = height,
               colour = sex_f, # ***** Use different colours for sex_f *****
               shape = town_f)) + # ***** Use different shapes for town_f *****
  geom_point(size = 4) + # Specify the size of all points
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")  + # No legend labels here
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  scale_colour_manual("Child Gender", values = c("Female" = "red", "Male" = "blue"))  + # Assign the colours manually
  scale_shape_manual("Town", values = c("Town 1" = 15, "Town 2" = 16, "Town 3" = 17))  + # Assign the shapes (plotting characters) manually
  theme(plot.title = element_text(size = 28, color = "darkblue"), # Customize the main title
        axis.title.x = element_text(size = 20, color = "red"), # Customize the titles of x-axis
        axis.text.x = element_text(size = 14, color = "green"), # Customize the text of x-axis
        axis.title.y = element_text(size = 10, color = "black"), # Customize the titles of y-axis
        axis.text.y = element_text(size = 7, color = "purple", angle = 90, hjust = 0.5), # Customize the text of y-axis: rotate by 90 degrees and line up with ticks
        strip.text.x = element_text(size = 18, color = "brown"), # Customize the facet text in x-direction
        strip.text.y = element_text(size = 30, color = "yellow"), # Customize the facet text in y-direction
        panel.background = element_rect(fill = 'darkgrey')) # Customize the panel background
#
# * We can remove one of the legends *
#
ggplot(df, aes(x = age, y = height, colour = sex_f, shape = town_f)) +
  geom_point(size = 4) + # Specify the size of all points
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")  + # No legend labels here
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  scale_colour_manual("Child Gender", values = c("Female" = "red", "Male" = "blue"), # Assign the colours manually
                      guide = FALSE)  + # ***** BUT don't show the legend *****
  scale_shape_manual("Town", values = c("Town 1" = 15, "Town 2" = 16, "Town 3" = 17))  + # Assign the shapes (plotting characters) manually
  theme(plot.title = element_text(size = 28, color = "darkblue"), # Customize the main title
        axis.title.x = element_text(size = 20, color = "red"), # Customize the titles of x-axis
        axis.text.x = element_text(size = 14, color = "green"), # Customize the text of x-axis
        axis.title.y = element_text(size = 10, color = "black"), # Customize the titles of y-axis
        axis.text.y = element_text(size = 7, color = "purple", angle = 90, hjust = 0.5), # Customize the text of y-axis: rotate by 90 degrees and line up with ticks
        strip.text.x = element_text(size = 18, color = "brown"), # Customize the facet text in x-direction
        strip.text.y = element_text(size = 30, color = "yellow"), # Customize the facet text in y-direction
        panel.background = element_rect(fill = 'darkgrey')) # Customize the panel background
#
# * We can remove all of the legends in one step *
#
ggplot(df, aes(x = age, y = height, colour = sex_f, shape = town_f)) +
  geom_point(size = 4) + # Specify the size of all points
  labs(title = "Data from Children",  subtitle = "You can specify a subtitle", caption = "You can also specify a caption",
       x = "Age (months)", y = "Height (cms)")  + # No legend labels here
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(sex_f ~ town_f) +
  scale_colour_manual("Child Gender", values = c("Female" = "red", "Male" = "blue"))  + # Assign the colours manually
  scale_shape_manual("Town", values = c("Town 1" = 15, "Town 2" = 16, "Town 3" = 17))  + # Assign the shapes (plotting characters) manually
  theme(plot.title = element_text(size = 28, color = "darkblue"), # Customize the main title
        axis.title.x = element_text(size = 20, color = "red"), # Customize the titles of x-axis
        axis.text.x = element_text(size = 14, color = "green"), # Customize the text of x-axis
        axis.title.y = element_text(size = 10, color = "black"), # Customize the titles of y-axis
        axis.text.y = element_text(size = 7, color = "purple", angle = 90, hjust = 0.5), # Customize the text of y-axis: rotate by 90 degrees and line up with ticks
        strip.text.x = element_text(size = 18, color = "brown"), # Customize the facet text in x-direction
        strip.text.y = element_text(size = 30, color = "yellow"), # Customize the facet text in y-direction
        panel.background = element_rect(fill = 'darkgrey'), # Customize the panel background
        legend.position = "none")  # ***** This removes all legends *****
#
###############################################################################
#
# * Adding lines to graphs *
#
# We can, for example, show also the sample mean and median on the histogram of the  Height data
# This also illustrates an advanced technique about specifying colour scales
#
ggplot(qd, aes(x = Height)) +
  geom_histogram() +
  geom_vline(aes(xintercept = mean(Height), col = "mean")) + # need to map the color of mean inside the aestetics
  geom_vline(aes(xintercept = median(Height), col = "median")) + # need to map the color of median inside the aestetics
  labs(x = "Height (cms)", title = "Student Heights") +
  scale_color_manual(name = "Statistics", # creates a legend, with the specified title
                     values = c(mean = "blue", # Specifying the colours
                                median = "red"))
#
###############################################################################
#
# More examples of * converting a continuous variable into a discrete one *
#
# We can use ggplot2's cut_interval for a quicker
# (but possibly cruder) way of converting a continuous variable to a discrete one
#
cut_interval(qd$Age, 4) # Approximately equal ranges
#
cut_number(qd$Age, 4) # Approximately equal numbers
table(cut_number(qd$Age, 4) )
#
cut_width(qd$Age, width = 2) # Specify the width

