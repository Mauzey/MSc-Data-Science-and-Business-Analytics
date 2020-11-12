# Install and Import Package ----------------------------------------------
install.packages('../myfirstRpack_1.0.0.9000.zip', repos=NULL)
library(myfirstRpack)

# Using the Package -------------------------------------------------------
# Run examples
example(statsCalculate)

# Use 'statsCalculate' to calculate the mean and standard deviation of the right
#   eye measurement from the eye data
statsCalculate(eye_data$Right_Eye_Measurement)
# or, better yet:
with(eye_data, statsCalculate(Right_Eye_Measurement))

# Use 'dataSummary()' to calculate the mean, standard deviation, and number of
#   missing values of the left eye measurement from the eye data and plot the
#   associated histogram
dataSummary(eye_data$Left_Eye_Measurement)
# or, better yet:
with(eye_data, dataSummary(Left_Eye_Measurement))
