# import
library(readr)
library(tidyr)

data <- read_csv('Session-4/Module_Marks_Invented_Example.csv')

# place all the marks in one column named 'marks', with
#   another column named 'source' indicating the source of the
#   marks
marks_long <- gather(data, 'source', 'marks')

# separate the 'source' column of 'marks_long' into two columns
#   named 'module' and 'component'
marks_long_2 <- marks_long %>%
  separate(source, c('module', 'component'), '\\.')

# define 'component' as a factor, called 'component_f', with
#   levels 'C', 'E', and 'F' with labels 'Coursework',
#   'Examination', and 'Overall'
marks_long_3 <- marks_long_2 %>%
  mutate(component_f = factor(component, levels=c('C', 'E', 'F'),
                              labels=c('Coursework', 'Examination',
                                       'Overall')))

# produce a boxplot
ggplot(marks_long_3, aes(x=component_f, y=marks, fill=component_f)) +
  geom_boxplot() +
  scale_fill_manual(values = c('orange', 'yellow', 'magenta')) +
  scale_y_continuous(breaks = c(30,40,50,60,70,100),
                     minor_breaks = c(30,40,50,60,70,80,90,100),
                     limits = c(30,100)) +
  facet_grid(. ~ module) +
  labs(x = 'Component',
       y = 'Mark (%)') +
  theme(axis.text.x = element_text(size=14, angle=90, vjust=0.5,
                                   hjust=1),
        legend.position = 'none')
