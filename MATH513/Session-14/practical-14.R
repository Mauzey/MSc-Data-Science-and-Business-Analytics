#
###
### Practical 14: t-test and ANOVA
###
#
#
## ------------------------------------------------------------------------
#
# Statistical Tests
#
## Comparing the Underlying Means of Two Groups
#
## ------------------------------------------------------------------------
#
# Let's read in the questionnaire data in the usual way
#
#
#
library(readr)
#
qd <- read_csv('data/MATH513_Questionnaire_Data.csv')
#
#
# Previously we have produced a boxplot of height stratified by sex
#
library(ggplot2)
#
ggplot(qd, aes(x = Sex, y = Height, fill = Sex)) + 
  geom_boxplot(varwidth = TRUE) +
  labs(x = "Gender", y = "Height (cms)") 
#
#
#
# We can ask: Is there an underlying difference in mean height between females and males?
#
# We are asking whether there is a difference between the mean height of females and 
# the mean height of males in the population.
#
# To answer this question, we can use a t-test
#
t.test(Height ~ Sex, data = qd, var.equal = TRUE)
#
#
# We need to focus on the p-value
#
t.test(Height ~ Sex, data = qd, var.equal = TRUE)$p.value
#
# If the p-value is less that 0.05, then there is an underlying difference 
# in mean height between females and males.
#
# In this case, the p-value is considerably less than 0.05. 
# Therefore, our conclusion is that the data supply evidence 
# that there is an underlying difference in mean height between 
# females and males.
#
# That is, we rejected H_0: mu_F = mu_M in favour of H_1: mu_F not = mu_F,
# in which mu_F/mu_M are the underlying/population mean heights of Females and Males
#
# We can obtain the same p-value using the lm function
#
m <- lm(Height ~ Sex, data = qd)
summary(m)
summary(m)$coefficient
#
# For a one-tailed test of H_0: mu_F >= mu_M versus H_1: mu_F < mu_M
#
t.test(Height ~ Sex, data = qd, var.equal = TRUE, alternative = "less")
#
# If the p-value is less that 0.05, we conclude that 
# the mean height of female is less than the mean height of males in 
# a wider population of students.
#
# What do you conclude here?
#
#------------------------------------------------------------------------------
# 
#
## Comparing the Underlying Means of More Than Two Groups
#
#
# ****** Statistical Tests: the analysis of variance or ANOVA
#                           to compare the underlying means of three or more groups ******
#
# The file hours_worked_profession.csv contains data on 53 people
# Each person was asked to record the number of hours he or she worked in a week (saved in hours_worked)
# Together with his or her profession (saved in group)
#
# * Read in the data *
#
hours_worked_df <- read_csv("hours_worked_profession.csv")
head(hours_worked_df, 17)
#
#
# The question of interest is: Is the underlying mean number of hours different 
# between these four groups?
# 
#
# Numerical and Graphical Summaries
#
library(ggplot2)
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  labs(x = "Group", y = "Hours worked each week")
#
# With the data points
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  geom_point() +
  labs(x = "Group", y = "Hours worked each week")
#
# Some of the points are overlapping
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  geom_count() + # Size of plotting character depends on number of overlapping points
  labs(x = "Group", y = "Hours worked each week")
#
# An alternative is to jitter (randomly disturb) the points
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  geom_jitter(position = position_jitter(width = 0.1, height = 0)) + # Jitter the points so that all overlapping points appear
  labs(x = "Group", y = "Hours worked each week")
#
# Next we produce what is sometimes called a strip plot
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, colour = group)) + 
  geom_jitter(position = position_jitter(width = 0.2, height = 0)) + # Jitter the points so that all overlapping points appear
  labs(x = "Group", y = "Hours worked each week") +
  coord_flip() # Swap the coordinates
#
#
# mean and standard deviation of all professionals
#
library(dplyr)
#
hours_worked_df %>% summarize(ave_g = mean(hours_worked),
                              sd_g = sd(hours_worked))
#
# group means and standard deviations
#
group_statistics <- hours_worked_df %>% 
  group_by(group) %>% # produce summaries for each group (profession)
  summarize(ave_g = mean(hours_worked), # sample average (location)
            sd_g = sd(hours_worked)) # sample standard deviation (spread)
#
group_statistics
#
# We can show these sample means on the boxplots:
#
# Method 1: use the summarized values calculated in group_statistics
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  geom_point(aes(y = ave_g), data = group_statistics, 
             col = "darkred", 
             shape = 18, 
             size = 3) + 
  # Use the data in group_statistics and in particular the sample means in ave_g
  labs(x = "Group", y = "Hours worked each week")
#
#
# Method 2: get ggplot to do the calculation for you using stat_summary 
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  stat_summary(fun = mean, # Show the sample means for each group
               geom = "point", 
               colour = "darkred", 
               shape = 18, 
               size = 3) + 
  # Here we add, as a point, the mean of the y values
  labs(x = "Group", y = "Hours worked each week") 
#
# Don't include the point in the legend
#
ggplot(hours_worked_df, aes(x = group, y = hours_worked, fill = group)) +
  geom_boxplot(varwidth = TRUE) + 
  stat_summary(fun = mean, geom = "point", 
               colour = "darkred", shape = 18, size = 3,
               show.legend = FALSE) + # Don't include this layer in the legend 
  # Here we add, as a point, the mean of the y values
  labs(x = "Group", y = "Hours worked each week") 
#
#----------------------------------------------------------------------
#
# One-way Analysis of Variance
#
# To answer the question: Is the underlying mean number of hours different 
# between these four groups?
# we perform a one-way analysis of variance.
# In fact, we are fitting a linear model, as met above.
# This can be done using the lm function.
#
#
m <- lm(hours_worked ~ group, data = hours_worked_df) # Fit a linear model
anova(m)
#
#
# Here, the p-value is
#
anova(m)$"Pr(>F)"[1]
#
# If the p-value is less that 0.05, which it is here, we conclude that
# there is a  difference between the underlying mean number of hours  
# between these four groups.
#
#
#--------------------------------------------------------------------------------
#
# Follow-up Analysis
#
# If we find that there is a difference between the underlying means of the
# groups, we should proceed by performing a follow-up analysis to see where the group differences are:
#
# First, we have to fit the model in a slightly different way, using * aov *
#
m_2 <- aov(hours_worked ~ group, data = hours_worked_df)
summary(m_2) # Also produces an ANOVA table
#
# Now, perform the * follow-up analysis *
#
# We compute * Tukey Honest Significant Differences *
#
#
TukeyHSD(m_2) # Follow-up: pair-wise comparisons
#
#
# We should look at the p-values in the p adj column.
# When the p-value is less that 0.05, we should conclude that there is an underlying differnce.  
# So here there are differences between GPs and accountants, 
# between lecturers and GPs and between plumbers and GPs.  GPs work a lot!!!
#  
# 