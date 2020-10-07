# import
library(readr)

data <- read_csv('Session-4/MATH513_Questionnaire_Data.csv')

# create a plot in order to understand how 'Travel_time' is
#   influenced by 'Distance'
ggplot(data, aes(x=Distance, y=Travel_time)) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = 'lm', se = FALSE, colour='red') +
  scale_x_log10() + scale_y_log10() +
  labs(x = 'Distance (miles)',
       y = 'Time (minutes)')
