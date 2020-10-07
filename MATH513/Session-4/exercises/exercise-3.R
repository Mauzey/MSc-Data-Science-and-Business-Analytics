# import
library(readxl)
library(ggplot2)
library(scales)

data <- read_excel('Session-4/companies.xlsx', sheet = 'Sheet1')

# create a new variable, 'net_income_diff' as the difference
#   between the net income for 2014 and 2015
data <- data %>%
  mutate(net_income_diff = net_income_2015 - net_income_2014)

# proudce a scatterplot of the net income difference against
#   the number of employees. add a smooth curve to your
#   scatter plot
ggplot(data, aes(x=n_empl, y=net_income_diff)) +
  scale_y_continuous(label = comma) +
  geom_point() +
  geom_smooth(span = 1) +
  labs(x = 'Number of Employees',
       y = 'Net Income Difference (2014-2015')

# using only the companies with a positive number of employees
#   and a positive net income difference, modify the above
#   plot to use a logarithmic scale on both axes
filter(data, n_empl > 0 & net_income_diff > 0) %>%
  ggplot(aes(x=n_empl, y=net_income_diff)) +
  scale_x_log10(label = comma) + scale_y_log10(label = comma) +
  geom_point() +
  geom_smooth(span= 1) +
  labs(x = 'Number of Employees',
       y = 'Net Income Difference (2014-2015)')

# using all companies, create a factor 'sector_new' based on
#   the variable 'sector'
data <- data %>%
  mutate(sector_new = factor(sector, levels=1:4,
                             labels=c('Catering', 'Hotels',
                                      'Distribution',
                                      'Communications')))

# using all companies, produce a boxplot of 'n_empl' by
#   'sector_new'
ggplot(data, aes(x=sector_new, y=n_empl, colour=sector_new)) +
  geom_boxplot() +
  scale_y_log10(label = comma) +
  labs(x = 'Sector',
       y = 'Number of Employees') +
  theme(legend.position = 'None')

# using all companies, convert the continuous variable
#   'oper_result' into the continuous variable 'oper_result_millions'
#   by dividing by 1,000,000
data <- data %>%
  mutate(oper_result_millions = oper_result/1000000)

# using all companies, convert the continuous variable
#   'oper_result_millions' into the factor 'oper_result_new',
#   which breaks at -5, 0, 0.25, and 3 
data <- data %>%
  mutate(oper_result_new = cut(x=oper_result_millions,
                                    breaks=c(-5,0,0.25,3)))

# using all companies, produce histograms of 'n_empl' split
#   by 'oper_result_new', using a logarithmic scale for the
#   number of employees
ggplot(data, aes(x=n_empl, fill=oper_result_new)) +
  geom_histogram() +
  scale_x_log10(label = comma) +
  facet_grid(oper_result_new ~ .) +
  labs(x = 'Number of Employees',
       y = 'Count',
       fill = 'Operational Result (millions?)')
