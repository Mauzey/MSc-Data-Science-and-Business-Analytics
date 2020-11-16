#
###
### Practical 13: Summary statistics, linear regression and correlation
###
#
## ------------------------------------------------------------------------
#
#
# Here are the data from six children that we worked with in previous sessions
#
age <- c(53, 43, 58, 38, 49, 55) # The age of each child in months
height <- c(98, 91, 104, 89, 97, 99) # The height of each child in cms
#
# We put all these data into a data frame df
#
df <- data.frame(age, height)
df
#
## ------------------------------------------------------------------------
#
# Summary statistics
#
# Reminder of measures of location: mean and median
#
library(dplyr) # Provides us with the summarise function
#
# Mean age and height
#
df %>% summarise(mean_age  = mean(age),
                 mean_height = mean(height))
#
# Median age and height
# The median is a better measure of location when there are outlying points
#
df %>% summarise(median_age  = median(age),
                 median_height = median(height)) 
#
# Show these summaries graphically
#
library(ggplot2) # For powerful graphics
#
# An advanced plot to show the mean and median
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() + 
  # Vertical lines with x-intercepts
  geom_vline(aes(xintercept = mean(age), col = "mean")) + # need to map the color of mean inside the aestetics
  geom_vline(aes(xintercept = median(age), col = "median")) + # need to map the color of median inside the aestetics
  # Horizontal lines with y-intercepts
  geom_hline(aes(yintercept = mean(height), col = "mean")) + 
  geom_hline(aes(yintercept = median(height), col = "median")) +
  # Define the colour scale manually; this is the colour to be used for the mean and for the median
  scale_color_manual(name = "Statistics", values = c("mean" = "blue", "median" = "red")) + # create a legend
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
## ------------------------------------------------------------------------
#
# Measures of spread
#
# The variance is a measure of spread
#
df %>% summarise(var_age  = var(age))
#
# Unfortunately the units of the variance are the SQUARE OF THE ORIGINAL UNITS
# So here the units of the variance are MONTHS SQUARED
#
# "Month squared" are hard to understand :-(
#
# For this reason we work with the standard deviation, which is the square root of the variance 
# the units of which are the same as the ORIGINAL UNITS
# Thus the standard deviation is a measure of spread that is easier to understand than the variance
#
df %>% summarise(sd_age  = sd(age))
#
# We can confirm that this is the square root of the variance
#
df %>% summarise(var_age  = var(age), 
                 sd_age  = sd(age), 
                 sd_age_2 = sqrt(var_age))
#
# The interquartile range (IQR) is a better measure of spread than the standard deviation
# WHEN THERE ARE OUTLYING POINTS
#
df %>% summarise(IQR_age  = IQR(age))
#
## ------------------------------------------------------------------------
#
# The linear model
#
# A straight line takes the form
# y = beta_0 + beta_1 x
#
# beta_0 is the intercept: it's where the line meets the y-axis at x = 0
#
# beta_1 is the slope: it's the increase in y for a increase in x of one unit
#
# The simple linear regression model allows for error
#
# y = beta_0 + beta_1 x + error
#
# This is an example of a *l*inear *m*odel
#
# x is referred to as an explanatory variable or an independent variable
# y is referred to as the response variable or the dependent variable
#
# Here,
# age is the explanatory variable or the independent variable
# height is the response variable or the dependent variable
#
# We want to understand how height depends on age, or how height responds to age
#
# Plot the data again
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() + 
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
#
# ****** Fit the simple linear regression model ******
#
# height = beta_0 + beta_1 age + error
#
# This is an example of a *l*inear *m*odel
# A linear model can be fitted in R using the lm function
#
# We will save the results in the R object m
#
m <- lm(height ~ age, data = df) # Looks for height and age in the data frame df
#
# Look at the results
#
m 
#
# Extract the coefficients
# These are the estimates of beta_0 and beta_1
# Referred to as beta_0 hat and beta_1 hat
#
coef(m) 
#
# So beta_0 hat, the estimate of beta_0, is
#
coef(m)[1] # Estimated intercept, beta_0 hat
#
# The beta_1 hat, the estimate of beta_1, is
#
coef(m)[2] # Estimated slope, beta_1 hat
#
# We can add the fitted line to the plot
#
# Here's one way of doing this
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, col = "blue") +
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
#
# Another more general way to add the fitted line is to compute the fitted values
#
# Here, fitted values are the estimated values of height at each observed values of age
#
# There are several ways of computing fitted values
# 
# We will use the add_predictions function from the modelr package
#
library(modelr)
#
df_with_fitted_values <- df %>% 
  add_predictions(m) # Add the fitted values or predictions from m

#
df_with_fitted_values 
#
# Let's add these values "by hand" to a scatter plot
#
ggplot(df_with_fitted_values , aes(x = age, y = height)) + 
  geom_point() +
  geom_point(aes(y = pred), col = "blue", pch = 17, size = 3) + # Add the fitted values as points; we don't need to specify the x values again
  geom_line(aes(y = pred), col = "blue") + # Add the fitted values as a line
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")

#
# This method of visualizng the fitted values may not work for more complicated models
# We'll see how to proceed in the case of a more complicated model below
#
# Of course, the fit is not perfect, so we can estimate the errors, which we now show
#
ggplot(df_with_fitted_values , aes(x = age, y = height)) + 
  geom_point() +
  geom_point(aes(y = pred), col = "blue", pch = 17, size = 3) + # Add the fitted values as points; we don't need to specify the x values again
  geom_line(aes(y = pred), col = "blue") + # Add the fitted values as a line
  geom_segment(aes(x = age, y = height, xend = age, yend = pred), col = "red") + # Estimated errors
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# The estimate of the errors are referred to as "residuals"
#
# Here's one way to add the residuals to the data frame
#
df_with_fitted_values_and_residuals <- df_with_fitted_values  %>%
  add_residuals(m)
#
df_with_fitted_values_and_residuals
#
# We now plot these residuals against the age values
#
# We do this to check the assumptions of the model
# These are that the error term is symmetrically distributed about zero
# and the spread of this distribution is constant.
#
ggplot(df_with_fitted_values_and_residuals, aes(x = age, y = resid)) + 
  geom_point() +
  labs(x = "Age (months)", 
       y = "Residuals", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# We should make the y-axis symmetric about 0
# We should also show 0
#
#
ggplot(df_with_fitted_values_and_residuals, aes(x = age, y = resid)) + 
  geom_point() +
  scale_y_continuous(limits = c(-2, 2)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Age (months)", 
       y = "Residuals", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# We hope to see no obvious pattern
#
# Now plot the residuals against the fitted (or predicted) values
#
ggplot(df_with_fitted_values_and_residuals, aes(x = pred, y = resid)) + 
  geom_point() +
  scale_y_continuous(limits = c(-2, 2)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Fitted Values", 
       y = "Residuals", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# Again we hope to see no obvious pattern
#
## ------------------------------------------------------------------------
#
# Theory tells us that residuals themselves have non-constant variance
# This problem can be overcome by using * standardized residuals *
#
# Standardized residuals can be sensitive to outliers
# This problem can be overcome using * studentized residuals *
#
# These alternative residuals can be found as follows:
#
# Standardized residuals
#
e_standardized <- rstandard(m)
e_standardized
#
# Studentized residuals
#
e_studentized <- rstudent(m)
e_studentized
#
# Here we plot standardized residuals against the x_i's (the values of the explanatory variable):
#
df_with_fitted_values_and_residuals_2 <- cbind(df_with_fitted_values_and_residuals,
                                               e_standardized, # Include the alternative residuals
                                               e_studentized)
#
# Plot standardized residuals against the values of x and against fitted values
#
ggplot(df_with_fitted_values_and_residuals_2, aes(x = age, y = e_standardized)) +
  geom_point() +
  scale_y_continuous(limits = c(-2.5, 2.5)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Age (months)",
       y = "Standardized residuals",
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
ggplot(df_with_fitted_values_and_residuals_2, aes(x = pred, y = e_standardized)) +
  geom_point() +
  scale_y_continuous(limits = c(-2.5, 2.5)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Fitted values",
       y = "Standardized residuals",
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# Plot studentized residuals against the values of x and against fitted values
#
ggplot(df_with_fitted_values_and_residuals_2, aes(x = age, y = e_studentized)) +
  geom_point() +
  scale_y_continuous(limits = c(-2.5, 2.5)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Age (months)",
       y = "Studentized residuals",
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
ggplot(df_with_fitted_values_and_residuals_2, aes(x = pred, y = e_studentized)) +
  geom_point() +
  scale_y_continuous(limits = c(-2.5, 2.5)) + # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) + # Horizontal line at 0
  labs(x = "Fitted values",
       y = "Studentized residuals",
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# We can check the approximate normality of the studentized residuals using a quantile-quantile plot:
#
library(car)
qqPlot(e_studentized, ylab = "Studentized residuals")
#
# The majority of the points should lie within the envelope
#
## ------------------------------------------------------------------------
## ------------------------------------------------------------------------
#
# ***** Performing inference about our model *****
#
# We can get more information about our model
#
summary(m)
#
# The Multiple R-squared value tells us the proportion of information in the data that is explained by x
#
# The values in the column Pr(>|t|) are p-values
# The second of these p-values allows us to answer the question
# Is there an underlying linear relationship between height (in general, y) and age (in general, x)?
# Null hypothesis H_0: there is no underlying linear relationship.../the model is not useful
# Alternative hypothesis H_1: there is an underlying linear relationship.../the model is useful
# In the case of simple linear regression (one explanatory variable)
# The second p-value under Pr(>|t|) is the same as the p-value associated with the F-statistic
# This is not the case in multiple linear regression (when there is more than one explanatory variable)
# This will be seen when we deal with a more complicated model below
#
#
# In general, for a test at the 5% level of significance,
# we'd reject H_0 in favour of H_1
# if the p-value < 0.05
#
# What do we conclude here?
#
## ------------------------------------------------------------------------
#
# We can also get confidence intervals for the parameters beta_0 and beta_1
#
confint(m)
#
# These intervals contain the estimates of beta_0 and beta_1
#
coef(m)
#
# The wider the interval the less reliable is the estimate
#
# In general, the more data that we have, the narrow confidence intervals will be
#
## ------------------------------------------------------------------------
#
# ***** Predictions *****
#
# We used the function add_predictions to add predictions provided by a model to a data frame
#
# The function predict allows us to be even more sophisticated, as we shall illustrate step by step
#
# We can predict the value of height (in general, y), called height hat (in general, y hat), at any value of age (in general, x)
#
# Here we predict the value of height at age = 40, using the model m that we have fitted to the data
#
#
# Here's our data plot again
#
ggplot(df, aes(x = age, y = height)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, col = "blue") +
  geom_vline(xintercept = 40, col = "red") +
  labs(x = "Age (months)",
       y = "Height (cms)",
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# Now for the prediction
#
predict(m, newdata = data.frame(age = 40)) # Predict at age = 40
#
# Note that the age (in general, x) values at which we want to predict have to be placed in a data frame
#
# This allows us to predict at more than one value
# such as at age = 40 and age = 45
#
predict(m, newdata = data.frame(age = c(40, 45))) # Predict at age = 40 and age = 45
#
# We can have predictions with *** confidence intervals ***
#
# Confidence intervals can be thought of as telling us how reliable our estimate of 
# the ** underlying relationship **
# beta_0 + beta_1 age (in general, beta_0 + beta_1 x) is
#
# The larger the interval, the less reliable the estimate
#
predict(m, newdata = data.frame(age = c(40, 45)), interval = "confidence") 
# Predictions with confidence intervals
#
# A prediction interval is similar, but it tells us about
# a ** new ** data value height^new = beta_0 + beta_1 age + error (in general, y^new = beta_0 + beta_1 x + error)
#
predict(m, newdata = data.frame(age = c(40, 45)), interval = "prediction") 
# Predictions with prediction intervals
#
# Prediction intervals are WIDER than confidence intervals (because of the error term)
#
# So, in general, a confidence interval tells us about estimating the underlying relationship beta_0 + beta_1 x, while
# a prediction interval tells us about estimating a new data value y^new = beta_0 + beta_1 x + error
#
#
## ------------------------------------------------------------------------
#
# We can display confidence intervals for beta_0 + beta_1 age (in general, beta_0 + beta_1 x) and
# prediction intervals for height^new = beta_0 + beta_1 age + error (in general, y^new = beta_0 + beta_1 x + error) graphically
#
# The following code does this
#
# First, create a data frame in which the confidence intervals are added to df
#
df_confidence <- data.frame(age, height, predict(m, interval = "confidence"))
df_confidence
#
# Next, create a data frame in which the predictions intervals are added to df
#
df_prediction <- data.frame(age, height, predict(m, interval = "prediction"))
df_prediction
#
# Now, plot the data and show the confidence intervals automatically
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, col = "blue") + # Confidence intervals shown automatically
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# Add the confidence intervals that we have computed
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, col = "blue") +
  # Add the lower confidence interval limits
  geom_line(aes(x = age, y = lwr), # We're plotting age on the x-axis and lwr on the y-axis
            data = df_confidence, # We use the data in the data frame df_confidence
            colour = "blue") + # We're plotting in blue
  # Add the upper confidence interval limits
  geom_line(aes(x = age, y = upr), # We're plotting age on the x-axis and upr on the y-axis
            data = df_confidence, # We use the data in the data frame df_confidence
            colour = "blue") + # We're plotting in blue
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# Next, also add the prediction intervals that we have also computed
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, col = "blue") +
  # Add the lower confidence interval limits
  geom_line(aes(x = age, y = lwr), data = df_confidence, colour = "blue") +
  # Add the upper confidence interval limits
  geom_line(aes(x = age, y = upr), data = df_confidence, colour = "blue") + 
  # Add the lower prediction interval limits
  geom_line(aes(x = age, y = lwr), # We're plotting age on the x-axis and upr on the y-axis
            data = df_prediction, # We use the data in the data frame df_prediction
            colour = "red") + # We're plotting in red
  # Add the upper prediction interval limits
  geom_line(aes(x = age, y = upr), # We're plotting age on the x-axis and upr on the y-axis
            data = df_prediction, # We use the data in the data frame df_prediction
            colour = "red") + # We're plotting in red
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# You should be able to provide an interpretation of this graph
#
## ------------------------------------------------------------------------
#
# Correlation
#
# Let's plot height against age again
#
ggplot(df, aes(x = age, y = height)) + 
  geom_point() + 
  labs(x = "Age (months)", 
       y = "Height (cms)", 
       title = "Data from Children",
       subtitle = "Random sample of size 6")
#
# The correlaton coefficient provides a measure of linear association or dependence 
# between the variables age (in general, x) and height (in general, y)
#
# The correlation coefficient takes values between -1 and 1
#
# Values of the correlation coefficient near 1 suggest a strong positive linear relationship 
# between the two variables age (in general, x) and height (in general, y): as one increases, so does the other
#
# Values of the correlation coefficient near -1 suggest a strong negative linear relationship 
# between the two variables age (in general, x) and height (in general, y): as one increases, the other decreases
#
# Here's the estimate of the correlation between age (in general, x) and height (in general, y)
#
with(df, cor(age, height))
# Working with the data in df, apply the function cor to age and height
#
# We can ask ourselves a more general question
# Is there linear dependency between age (in general, x) and height (in general, y) 
# in a much larger population of children
#
# The answer to this question is provided by the p-value, 
# with its usual interpretation
# For a test at the 5% level of significance,
# we'd reject H_0: rho = 0 in favour of H_1: rho not = 0,
# in which rho is the underlying/population correlation between the variables,
# if the p-value < 0.05
#
with(df, cor.test(age, height))
#
# What do you conclude?
#
## ------------------------------------------------------------------------
## ------------------------------------------------------------------------
