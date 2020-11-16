# Import and Setup --------------------------------------------------------

cargo <- 1:18
weight <- c(0.4, 0.4, 3.1, 0.6, 4.7, 1.7, 9.4, 10.1, 11.6, 12.6, 10.9, 23.1,
            23.1, 21.6, 23.1, 1.9, 26.8, 29.9)
volume <- c(53, 23, 19, 34, 24, 65, 44, 31, 29, 58, 37, 46, 50, 44, 56, 36, 58, 51)
n_items <- c(158, 163, 37, 157, 59, 123, 46, 117, 173, 112, 111, 114, 134, 73,
             168, 143, 202, 124)
loading_time <- c(64, 60, 71, 61, 54, 77, 81, 93, 93, 51, 76, 96, 77, 93, 95,
                  54, 168, 99)

shipping <- data.frame(cargo, weight, volume, n_items, loading_time)
rm(cargo, weight, volume, n_items, loading_time)

# Exercise 3 - Multiple Regression ----------------------------------------

# Fit the model
m <- lm(loading_time ~ weight + volume + n_items, data = shipping)
coef(m)
summary(m)  # The p-values for 'volume' and 'n_items' are greater than 0.05,
            #   which indicates no statistically significant effect. Therefore,
            #   they can be removed:

# Remove the 'volume' and 'n_items' variables, and re-fit the model
m <- lm(loading_time ~ weight, data = shipping)
coef(m)
summary(m)


# Produce a plot showing the relationship between 'weight' and 'loading_time',
#   illustrating the dependence of loading time on weight. Use the cargo 
#   numbers as the plotting characters
ggplot(shipping, aes(x = weight, y = loading_time)) +
  theme_minimal() +
  geom_text(aes(label = cargo)) +
  geom_smooth(method = 'lm', se = F) +
  labs(x = "Weight", y = "Loading Time",
       title = "Weight vs. Loading Time")


# Produce residual plots
shipping_w_fitted_vals <- shipping %>%
  add_predictions(m)

shipping_w_fitted_vals_and_residuals <- shipping_w_fitted_vals %>%
  add_residuals(m)
  
# Plot weight vs. residuals - This is to check the assumptions of the model:
#   * That the error term is symmetrically distributed about 0
#   * That the spread of the distribution is constant
ggplot(shipping_w_fitted_vals_and_residuals, aes(x = weight, y = resid)) +
  theme_minimal() + scale_y_continuous(limits = c(-70, 70)) +
  geom_hline(aes(yintercept = 0)) +
  geom_text(aes(label = cargo)) +
  labs(x = "Weight", y = "Residuals")

# Plot the residuals against the fitted (predicted) values
ggplot(shipping_w_fitted_vals_and_residuals, aes(x = pred, y = resid)) +
  theme_minimal() + scale_y_continuous(limits = c(-70, 70)) +
  geom_hline(aes(yintercept = 0)) +
  geom_text(aes(label = cargo)) +
  labs(x = "Fitted (predicted) Values", y = "Residuals")


# Plot the relationship between 'weight' and 'loading_time' again, with a 
#   second regression line excluding the 17th observation (the outlier)
ggplot(shipping, aes(x = weight, y = loading_time)) +
  theme_minimal() +
  geom_text(aes(label = cargo)) +
  geom_smooth(method = 'lm', se = F) +
  geom_smooth(data = shipping[-17,], method = 'lm', se = F, colour = 'red') +
  labs(x = "Weight", y = "Loading Time",
       title = "Weight vs. Loading Time")
