# here are results from 10 students
results <- c(5, 5, 2, 4, 3, 5, 5, 1, 2, 5)

# convert these results into a factor with labels: 'Strongly Disagree', 'Disagree',
#   'Neutral', 'Agree', and 'Strongly Agree'
results_factor <- factor(results, levels = c(1,2,3,4,5),
                         labels = c('Strongly Disagree',
                                    'Disagree',
                                    'Neutral',
                                    'Agree',
                                    'Strongly Agree'))

# tabulate these results
results_table <- table(results_factor)

# create a factor in reverse order and tabulate it
rev_results_factor <- factor(results, levels = c(5,4,3,2,1),
                             labels = c('Strongly Agree',
                                        'Agree',
                                        'Neutral',
                                        'Disagree',
                                        'Strongly Disagree'))
rev_results_table <- table(rev_results_factor)
