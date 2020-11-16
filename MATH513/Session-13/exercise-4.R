# Import and Setup --------------------------------------------------------

library(readr)
q_data <- read.csv('MATH513_Questionnaire_Data.csv')

# Exercise 4 - Transformations --------------------------------------------

ggplot(q_data, aes(x = Distance, y = Travel_time)) +
  theme_minimal() + geom_text(aes(label = as.numeric(row.names(q_data)))) +
  scale_x_log10() + scale_y_log10() +  # Logarithmic scale on both axis
  geom_smooth() +  # Add smooth curve w/ confidence bands
  geom_smooth(method = 'lm', se = F, colour = 'red') +  # Add regression line
  labs(x = "Distance (miles)", y = "Time (minutes)",
       title = "Distance vs. Time")


# Fit the model - Adding a small value (0.01) for cases where there are 
#   distances of 0
m <- lm(log(Travel_time) ~ log(Distance + 0.01), data = q_data)
coef(m)
summary(m)


# Re-fit the model, omitting the 16th observation
m_log_no_16 <- lm(log(Travel_time) ~ log(Distance + 0.01),
                  data = q_data, subset = -16)

# Use this model to produce confidence intervals, using the 'cofint()' function
confint(m_log_no_16)

# These intervals provide an indication of the reliability of the estimates of 
# ??0 and ??1. The wider the interval, the less reliable the estimate is
# 
# If the second of these confidence intervals contains 0.5, then the travel
# time may depend on the square root of the distance

# Produce a plot, omitting the 16th observation, which uses a square root scale 
#   on the x-axis and a standard linear scale on the y-axis. The square root 
#   scale spreads out values less than 1 and squashes values greater than 1
ggplot(q_data[-16,], aes(x = Distance, y = Travel_time)) +
  theme_minimal() +
  geom_text(aes(label = as.numeric(row.names(q_data[-16,])))) +
  scale_x_sqrt() +  # Square root scale on the x-axis
  geom_smooth() +
  geom_smooth(method = 'lm', se = F, colour = 'red') +
  labs(x = "Distance (miles", y = "Time (minutes)",
       title = "Distance vs. Time")

# Produce the same plot, also omitting the 5th observation
ggplot(q_data[-c(5, 16),], aes(x = Distance, y = Travel_time)) +
  theme_minimal() +
  geom_text(aes(label = as.numeric(row.names(q_data[-c(5, 16),])))) +
  scale_x_sqrt() +  # Square root scale on the x-axis
  geom_smooth() +
  geom_smooth(method = 'lm', se = F, colour = 'red') +
  labs(x = "Distance (miles", y = "Time (minutes)",
       title = "Distance vs. Time")

# Produce the same plot, also omitting the 7th observation
ggplot(q_data[-c(5, 7, 16),], aes(x = Distance, y = Travel_time)) +
  theme_minimal() +
  geom_text(aes(label = as.numeric(row.names(q_data[-c(5, 7, 16),])))) +
  scale_x_sqrt() +  # Square root scale on the x-axis
  geom_smooth() +
  geom_smooth(method = 'lm', se = F, colour = 'red') +
  labs(x = "Distance (miles", y = "Time (minutes)",
       title = "Distance vs. Time")
