# Import and Setup ------------------------------------

library(RSQLite)
library(dplyr)
library(forcats)
library(ggplot2)

# connect to the 'sailing' database
sailing <- dbConnect(drv = SQLite(), dbname='Session-7/sailing.sqlite3')

sailing # print database connection information

dbListTables(sailing) # list tables in the database

# view the content of each table
for (table in dbListTables(sailing)){
  explain(tbl(sailing, table)) # print the SQL used
  print(tbl(sailing, table)) # print table content
  
  rm(table) # delete the iterator variable
}

# Questionnaire Table ---------------------------------

# list observations for 'PortCleanliness' and 'CleanlinessOnBoard'
#   and create a new variable, 'ave_clean', calculated as the
#   average of the observations listed above
qtnr <- tbl(sailing, 'Questionnaire') %>%
  select(PortCleanliness, CleanlinessOnBoard) %>%
  mutate(ave_clean = (PortCleanliness + CleanlinessOnBoard) / 2)

# PersonalInfo Table ----------------------------------

# calculate the average and standard deviation of passengers'
#   ages for each job type
tbl(sailing, 'PersonalInfo') %>%
  group_by(Job) %>%
  summarise(ave_age = mean(Age), sd_age = sd(Age))

# list non-UK passengers aged less than 70 years old and
#   transform 'Gender' into a factor
for70 <- collect(tbl(sailing, 'PersonalInfo')) %>%
  filter(Foreign == 1, Age < 70) %>%
  mutate(Gender_f = factor(Gender,
                           levels = c(1, 2),
                           labels = c('Male', 'Female')))

# produce a histogram of age by gender
ggplot(for70, aes(x = Age, fill = Gender_f)) +
  geom_histogram() +
  facet_grid(Gender_f ~ .) +
  labs(x = "Age", y = "Count",
       title = "Gender vs. Age",
       subtitle = "Non-UK passengers younger than 70 y/o")

# produce a boxplot of age by gender
ggplot(for70, aes(x = Gender_f, y = Age, fill = Gender_f)) +
  geom_boxplot() +
  labs(x = "", y = "Age",
       title = "Gender vs. Age",
       subtitle = "Non-UK passengers younger than 70 y/o")

# Combined Tables -------------------------------------

# merge the three tables: 'PersonalInfo', 'PassengersInfo',
#   and 'Questionnaire' via 'ID', using inner joins
combined <- tbl(sailing, 'PersonalInfo') %>%
  inner_join(tbl(sailing, 'PassengersInfo'), by = 'ID') %>%
  inner_join(tbl(sailing, 'Questionnaire'), by = 'ID')

# add a variable that is the sum of the answers to the first
#   five questionnaire questions: 'PortCleanliness', 'PortComfort',
#   'PortStaff', 'Security', and 'Accessibility'
combined <- collect(combined) %>%
  mutate(Q1_5_Sum = PortCleanliness + PortComfort + PortStaff +
           Security + Accessibility)

# convert 'Job' into a factor, 'Job_f'
combined <- combined %>%
  mutate(Job_f = factor(Job))

# create a new variable, 'Job_f_2', combining the categories
#   of 'Job'
combined <- combined %>%
  mutate(
    Job_f_2 = fct_collapse(
      Job_f,
      'student' = 'student',
      'retired' = 'retired',
      'professional' = c('artisan', 'businessman', 'clerical',
                         'consultant', 'engineer', 'freelance',
                         'ITtechnician', 'journalist', 'lawyer',
                         'lecturer', 'manager', 'nurse',
                         'photographer', 'physician', 'programmer',
                         'retailer', 'teacher', 'technician',
                         'worker'),
      'not_working' = c('howsewife', 'unemployed')
    )
  )

# illustrate how the sum of the answers to the first five
#   questionnaire questions depends on 'Job_f_2'
ggplot(combined, aes(x = Job_f_2, y = Q1_5_Sum, colour = Job_f_2)) +
  geom_boxplot() +
  labs(x = "Occupation", y = "Combined Answers to Q1-5",
       title = "Relationship Between Occupation and Questionnaire Responses",
       subtitle = "Using the sum of answers to questions 1 to 5",
       colour = "Occupation")

# create a scatterplot of 'Price' on the horizontal axis and
#   'Q1_5_Sum' on the vertical axis, adding a regression line
ggplot(combined, aes(x = Price, y = Q1_5_Sum)) +
  geom_point() +
  geom_smooth(method = 'lm', formula = y~x) +
  labs(x = "Price (£)", y = "Combined Answers to Q1-5",
       title = "Relationship Between Occupation and Ticket Price",
       subtitle = "Using the sum of answers to questions 1 to 5")

# calculate the pearson's product moment correlation coefficient
#   between 'Price' and 'Q1_5_Sum', and perform a suitable
#   statistical test
with(combined, cor(Price, Q1_5_Sum))
with(combined, cor.test(Price, Q1_5_Sum))

# show separate scatterplots of 'Price' and 'Q1_5_Sum' for
#   each category of 'Job_f_2'
ggplot(combined, aes(x = Price, y = Q1_5_Sum, colour = Job_f_2)) +
  geom_point() +
  geom_smooth(method = 'lm', formula = y~x) +
  facet_grid(. ~ Job_f_2) +
  labs(x = "Price (£)", y = "Combined Answers to Q1-5",
       title = "Relationship Between Proce and Questionnaire Responses",
       subtitle = "Using the sum of answers to questions 1 to 5, stratified by job category") +
  theme(legend.position = 'none',
        axis.text.x = element_text(angle = 90, vjust = 0.5,
                                   hjust = 1))



