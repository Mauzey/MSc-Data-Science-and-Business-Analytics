# import
library(ggplot2)

# create R objects for data vectors
cattle <- c(348, 407, 1064, 750, 593, 1867, 471, 935, 1443)
sheep <- c(110, 179, 303, 173, 182, 458, 151, 140, 222)

# save all observations except the 6th and 9th elements
cattle_new <- cattle[-c(6,9)]
sheep_new <- sheep[-c(6,9)]

# creata a dataframe for 'cattle_new' and 'sheep_new'
df <- data.frame(cattle_new, sheep_new)

# plot the dataframe using appropriate labels and title,
#   colouring the dots in blue
ggplot(df, aes(x=cattle_new, y=sheep_new)) +
  geom_point(col = 'blue') +
  labs(x = 'No. of Cattle',
       y = 'No. of Sheep',
       title = 'Summary of Livestock on Devonshire Farms')

# calculate the sample mean and median for both 'cattle_new' and 'sheep_new'
mean_cattle_new <- mean(cattle_new)
mean_sheep_new <- mean(sheep_new)
median_cattle_new <- median(cattle_new)
median_sheep_new <- median(sheep_new)

# manually calculate the mean of 'cattle_new'
sum_cattle_new <- sum(cattle_new)
len_cattle_new <- length(cattle_new)
manual_mean_cattle_new <- sum_cattle_new/len_cattle_new
