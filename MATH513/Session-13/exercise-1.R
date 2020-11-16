# Import and Setup --------------------------------------------------------

library(ggplot2)
library(dplyr)
library(modelr)

# Exercise 1 - Simple Linear Regression -----------------------------------

# The 'alr3' package has been removed from the CRAN repository. The dataset has 
#   to be loaded from the archive as a result:
load('forbes.rda')
head(forbes)


# Plot Pressure vs. Temp
ggplot(forbes, aes(x = Pressure, y = Temp)) + 
  geom_point() + theme_minimal() +
  labs(x = "Pressure (in. of Mercury)", y = "Temperature (Degrees Farenheight)",
       title = "Pressure vs. Temperature at Various Locations in the Alps",
       caption = "Source: Data acquired from the 'alp3' package archive (version 2.0.8)")


# Summarize the mean, median, variance, standard deviation, and interquartile 
#   range for both variables
forbes %>% summarise(
  mean_pressure = mean(Pressure), median_pressure = median(Pressure),
  var_pressure = var(Pressure), sd_pressure = sd(Pressure),
  iqr_pressure = IQR(Pressure),
  
  mean_temp = mean(Temp), median_temp = median(Temp), var_temp = var(Temp),
  sd_temp = sd(Temp), iqr_temp = IQR(Temp)
)
# The same output can be achieved using the 'with' method
with(forbes, mean(Pressure))


# Fit a Simple Linear Regression Model
m <- lm(Temp ~ Pressure, data = forbes)
coef(m)

# Show the fitted line on the plot created earlier
ggplot(forbes, aes(x = Pressure, y = Temp)) + 
  geom_point() + theme_minimal() +
  geom_smooth(method = 'lm', se = F, col = 'blue') +
  labs(x = "Pressure (in. of Mercury)", y = "Temperature (Degrees Farenheight)",
       title = "Pressure vs. Temperature at Various Locations in the Alps",
       caption = "Source: Data acquired from the 'alp3' package archive (version 2.0.8)")


# Compute the fitted values and include them with the original data
forbes_with_fitted_values <- forbes %>%
  add_predictions(m)

ggplot(forbes_with_fitted_values, aes(x = Pressure, y = Temp)) + 
  geom_point() + theme_minimal() +
  geom_point(aes(y = pred), col = 'green', pch = 17, size = 3) +
  geom_line(aes(y = pred), col = 'blue') + 
  labs(x = "Pressure (in. of Mercury)", y = "Temperature (Degrees Farenheight)",
       title = "Pressure vs. Temperature at Various Locations in the Alps",
       caption = "Source: Data acquired from the 'alp3' package archive (version 2.0.8)")


# Create a plot with confidence and prediction intervals
forbes_confidence <- with(forbes_with_fitted_values,
                          data.frame(Temp, Pressure, predict(m, interval = 'confidence')))
forbes_prediction <- with(forbes_with_fitted_values,
                          data.frame(Temp, Pressure, predict(m, interval = 'prediction')))

ggplot(forbes, aes(x = Pressure, y = Temp)) +
  geom_point() + theme_minimal() +
  geom_smooth(method = 'lm', se = T, col = 'blue') +  # 'se = T shows confidence intervals automatically
  # Add the calculated lower confidence interval limits
  geom_line(aes(x = Pressure, y = lwr), data = forbes_confidence, colour = 'blue') +
  # Add the calculated upper confidence interval limits
  geom_line(aes(x = Pressure, y = upr), data = forbes_confidence, colour = 'blue') +
  # Add the calculated lower prediction interval limits
  geom_line(aes(x = Pressure, y = lwr), data = forbes_prediction, colour = 'red') +
  # ADd the calculated upper prediction interval limits
  geom_line(aes(x = Pressure, y = upr), data = forbes_prediction, colour = 'red') +
  labs(x = "Pressure (in. of Mercury)", y = "Temperature (Degrees Farenheight)",
       title = "Pressure vs. Temperature at Various Locations in the Alps",
       caption = "Source: Data acquired from the 'alp3' package archive (version 2.0.8)")


# Compute residuals and include them with the original data and fitted values
forbes_with_fitted_values_and_residuals <- forbes_with_fitted_values %>%
  add_residuals(m)

# Plot pressure vs. residuals - This is to check the assumptions of the model:
#   * That the error term is symmetrically distributed about 0
#   * That the spread of the distribution is constant
ggplot(forbes_with_fitted_values_and_residuals, aes(x = Pressure, y = resid)) +
  scale_y_continuous(limits = c(-2, 2)) +  # Symmetric y scale about 0
  geom_hline(aes(yintercept = 0)) +  # Horizontal line at 'y=0'
  geom_point() + theme_minimal() +
  labs(x = "Pressure (in. of Mercury)", y = "Residuals",
       title = "Pressure vs. Residuals",
       caption = "Source, Data acquired from the 'alp3' package archive (version 2.0.8)")

# Plot the residuals against the fitted (predicted) values
ggplot(forbes_with_fitted_values_and_residuals, aes(x = pred, y = resid)) +
  scale_y_continuous(limits = c(-2, 2)) +
  geom_hline(aes(yintercept = 0)) +
  geom_point() + theme_minimal() +
  labs(x = "Fitted Values", y = "Residuals",
       title = "Fitted (predicted) Values vs. Residuals",
       caption = "Source, Data acquired from the 'alp3' package archive (version 2.0.8)")


# Use a test of correlation to determine whether there is an underlying linear 
#   dependency between Temp and Pressure
with(forbes, cor(Pressure, Temp))
with(forbes, cor.test(Pressure, Temp))
