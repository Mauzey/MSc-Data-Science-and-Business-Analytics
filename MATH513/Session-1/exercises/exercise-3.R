# create a data frame containing variables 'production' and 'costs'
production <- c(2, 4, 6, 6, 10, 8, 5, 7, 11, 12)
costs <- c(7, 11, 12, 19, 22, 20, 16, 13, 24, 20)

df <- data.frame(production, costs)

# plot this data
ggplot(df, aes(x=production, y=costs)) +
  geom_point() +
  labs(x = 'Production (1,000 Units)',
       y = 'Costs (£1,000s)')

# plot production and cost against time
month <- c(1:10)
df <- cbind(df, month)

# production vs. time
ggplot(df, aes(x=month, y=production)) +
  geom_line() +
  labs(x = 'Time (months)',
       y = 'Production (1,000 Units)',
       title = 'Production over Time')

# costs vs. time
ggplot(df, aes(x=month, y=costs)) +
  geom_line() +
  labs(x = 'Time (months)',
       y = 'Costs (£1,000s)',
       title = 'Costs over Time')

# plot production vs. cost, with the month ID as the data point
ggplot(df, aes(x=production, y=costs, label=rownames(df))) +
  geom_text() +
  labs(x = 'Production (1,000 Units)',
       y = 'Costs (£1,000)',
       title = 'Production vs. Costs over Time')
