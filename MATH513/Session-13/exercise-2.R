# Import and Setup --------------------------------------------------------

town <- 1:10
advertising <- c(2, 6, 8, 8, 12, 16, 20, 20, 22, 26)
population <- c(41, 93, 78, 102, 96, 112, 119, 131, 118, 185)
sales <- c(58, 105, 88, 118, 117, 137, 157, 169, 149, 202)

shops <- data.frame(town, advertising, population, sales)
rm(town, advertising, population, sales)

# Exercise 2 - Multiple Regression ----------------------------------------

# Plot the annual sales against advertising, illustrating the dependence of 
#   sales on advertising using a smooth curve
ggplot(shops, aes(x = advertising, y = sales)) +
  geom_point() + theme_minimal() +
  geom_smooth() +
  labs(x = "Advertising (£'000s)", y = "Sales (£'000s)",
       title = "Advertising Cost vs. Sales Revenue")

# Plot annual sales against population, illustrating the dependence of sales
#   on population using a smooth curve
ggplot(shops, aes(x = population, y = sales)) +
  geom_point() + theme_minimal() +
  geom_smooth() +
  labs(x = "Population (000s)", y = "Sales (£'000s)",
       title = "Advertising Cost vs. Sales Revenue")

# Fit a linear model, in light of the linear relationships observed in the 
#   graphs above
m <- lm(sales ~ advertising + population, data = shops)

summary(m)  # The second p-value (0.1373) is less than 0.05
            # This indicates that advertising does have an effect on sales for
            #   all similar shops


# Produce a prediction for sales, together with a confidence and prediction 
#   interval, if:
#     * £10,000 is spent on advertising on a town with a population of 140,000
#     * £30,000 is spent on advertising on a town with a population of 200,000
predict(m, newdata = data.frame(advertising = c(10, 30),
                                population = c(140, 200)), interval = 'confidence')
predict(m, newdata = data.frame(advertising = c(10, 30),
                                population = c(140, 200)), interval = 'prediction')
