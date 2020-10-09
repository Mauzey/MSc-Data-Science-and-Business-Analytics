# import
library(readxl)

data <- read_excel("Session-3/bank.xlsx")

# create a variable 'diff_sal' as the difference between
#   the current and initial salary
data <- data %>%
  mutate(diff_sal = curr_sal - init_sal)

# considering only men, calculate the mean of 'diff_sal' for
#   each job category
filter(data, gender == 'M') %>%
  group_by(job) %>%
  summarise(count = n(), mean_diff_sal = mean(diff_sal))

# create a new categorical variable 'curr_sal_new' which takes
#   the value 'high' when 'curr_sal' is greater than 20,000
#   and the value 'low' otherwise
data <- data %>%
  mutate(curr_sal_new = ifelse(curr_sal > 20000, 'high', 'low'))

# selecting only the variables 'town', 'gender', 'init_Sal',
#   and 'curr_sal', reshape the data frame to obtain one
#   variable indicating the type of salary 'sal_type' and one
#   variable indicating the value of the salary 'sal_value'.
#   finally, order the data frame by 'sal_value' in acending
#   order
data <- data %>%
  gather('sal_type', 'sal_value', 4:5) %>%
  select(town, gender, sal_type, sal_value) %>%
  arrange(sal_value)

# produce a histogram
plot_data <- data %>%
  mutate(sal_type = factor(sal_type,
                           levels = c('init_sal', 'curr_sal'),
                           labels = c('Initial Salary', 'Current Salary')))

ggplot(plot_data, aes(x=sal_value)) +
  geom_histogram() +
  facet_grid(sal_type ~ gender) +
  labs(x = 'Salary (£)',
       y = 'Count')

# produce a boxplot
ggplot(plot_data, aes(x=sal_type, y=sal_value)) +
  geom_boxplot() +
  facet_grid(. ~ gender) +
  labs(x = 'Type of Salary',
       y = 'Salary (£)')









