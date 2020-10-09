# import
library(readr)
library(ggplot2)

personal_data <- read.csv('Session-3/PersonalInfo.csv')
passenger_data <- read.csv('Session-3/PassengersInfo.csv')
question_data <- read.csv('Session-3/Questionnaire.csv')

# use the passenger data to calculate interesting summary
#   statistics about the passengers split down into sensible
#   groups such as the mean, variance, standard deviation,
#   minimum and maximum price paid for different travel times
#   and purposes
passenger_data %>%
  group_by(FirstTime, WorkHoliday) %>%
  summarise(aver_price = mean(Price),
            var_price = var(Price),
            sd_price = sd(Price),
            min_price = min(Price),
            max_price = max(Price))

# create a single dataframe obtained by merging the three
#   datasets: 'PersonalInfo', 'PassengersInfo', and 'Questionnaire'
#   on the primary key 'ID', retaining only the rows in all
#   dataframes
combined_data <- inner_join(personal_data, passenger_data,
                            by = 'ID')
combined_data <- inner_join(combined_data, question_data,
                            by = 'ID')

# create a new variable 'job_2' combining the categories of
#   'job' into 'student', 'professional', 'not_working', and
#   'retired'
combined_data <- combined_data %>%
  mutate(Job_2 = 
           ifelse(Job == 'howsewife', 'not_working',
           ifelse(Job == 'unemployed', 'not_working',
           ifelse(Job == 'retired', 'retired',
           ifelse(Job == 'student', 'student',
                  'professional')))))

table(combined_data$Job_2)

# transform variables 'Propensity', 'FirstTime', 'WorkHoliday',
#   'Job_2', and 'Gender' into factors
combined_data <- combined_data %>%
  mutate(Job_2_f = factor(Job_2)) %>%
  mutate(WorkHoliday_f = factor(WorkHoliday,
                                labels = c('Holiday',
                                           'Work'))) %>%
  mutate(Propensity_f = factor(Propensity,
                               labels = c('Yes', 'No'))) %>%
  mutate(FirstTime_f = factor(FirstTime,
                              labels = c('No', 'Yes'))) %>%
  mutate(Gender_f = factor(Gender,
                           labels = c('Male', 'Female')))

# produce the following plots:

# * a histogram of 'Price', coloured according to 'Propensity'
#   and faceted by 'FirstTime' and 'WorkHoliday'
ggplot(combined_data, aes(x=Price, fill=Propensity_f)) +
  geom_histogram() +
  facet_grid(WorkHoliday_f ~ FirstTime_f) +
  labs(title = "Price vs. WorkHoliday and FirstTime wrt Propensity")

# * a boxplot of 'Age' stratified by 'Job_2' and faceted by
#   'Gender'
ggplot(combined_data, aes(x=Job_2_f, y=Age, fill=Job_2_f)) +
  geom_boxplot(varwidth = TRUE) +
  facet_grid(. ~ Gender_f) +
  scale_fill_discrete(name = 'Job Status') +
  labs(x = 'Occupation',
       y = 'Age (years)',
       title = 'Distribution of Age, Stratified by Job and Gender') +
  theme(axis.text.x = element_text(size = 6.5,
                                   angle = 75,
                                   vjust = 0.7))

# create a global satisfaction indicator, called 'Score', as
#   the sum of the scores of all 14 questions, and create a
#   boxplot of this 'Score', stratified by 'Gender' and faceted
#   by 'WorkHoliday' and 'FirstTime'
combined_data <- combined_data %>%
  mutate(Score = PortCleanliness + PortComfort + PortStaff +
           Security + Accessibility + Disabled + Cost +
           SeatAvailability + JourneyTime + CleanlinessOnBoard +
           ComfortOnBoard + StaffOnBoard + ServiceOnBoard +
           FoodOnBoard)

ggplot(combined_data, aes(x=Gender_f, y=Score, fill=Gender_f)) +
  geom_boxplot() +
  facet_grid(WorkHoliday_f ~ FirstTime_f) +
  scale_fill_discrete(name = 'Gender') +
  labs(x = 'Gender',
       y = 'Score',
       title = 'Score, Stratified by Gender, WorkHoliday, and FirstTime')
