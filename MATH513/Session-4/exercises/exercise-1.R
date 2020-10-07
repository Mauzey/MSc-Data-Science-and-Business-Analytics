# import
library(dplyr)
library(ggplot2)

cattle <- c(348, 407, 1064, 750, 593, 1867, 471, 935, 1443)
sheep <- c(110, 179, 303, 173, 182, 458, 151, 140, 222)
location <- c('North', 'South', 'South', 'North', 'South',
              'North', 'North', 'North', 'South')
holidays <- c('No', 'No', 'Yes', 'Yes', 'No', 'Yes', 'No',
              'No', 'Yes')

# define categorical variables 'location' and 'holidays'
#   as factors
location_f <- factor(location, levels=c('North', 'East',
                     'South', 'West'))
holidays_f <- factor(holidays, levels=c('Yes', 'No'))

# create a dataframe including these newly defined variables
#   as well as the 'cattle' and 'sheep' variables from before
farms_df <- data.frame(cattle, sheep, location_f, holidays_f) %>%
  rename('location'='location_f', 'holidays'='holidays_f')

# plot the data
ggplot(farms_df, aes(x=cattle, y=sheep, colour=holidays)) +
  geom_point() +
  labs(title = 'Livestock on Devon Farms',
       x = 'Number of Cattle',
       y = 'Number of Sheep',
       colour = 'Working Farm Holidays') +
  geom_smooth(method='lm', se=FALSE) +
  facet_wrap(~ holidays + location,
             nrow = 2, ncol = 2,
             scales = 'free') +
  scale_colour_manual(guide = guide_legend(reverse = TRUE),
                      values = c('Yes' = 'green',
                                 'No' = 'darkred')) +
  theme(plot.title = element_text(color='red'),
        axis.title.x = element_text(color='orange'),
        axis.title.y = element_text(color='green'),
        axis.text.x = element_text(color='blue'),
        axis.text.y = element_text(color='magenta', angle=-90,
                                   hjust=0.5),
        legend.position = 'none',
        strip.text = element_text(color='darkred'))
