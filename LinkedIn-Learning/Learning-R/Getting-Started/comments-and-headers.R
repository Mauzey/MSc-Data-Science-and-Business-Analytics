
# Installing and Load Packages ------------------------

# load base packages manually
library(datasets) # for example, datasets

# Load and Prepare Data -------------------------------

?iris
df <- iris
head(df)

# Comment Out Lines -----------------------------------

# use comments to disable commands
hist(df$Sepal.Width,
     col = "#CD0000", # red3
     # border = NA, # no borders
     main = "Histogram of Sepal Width",
     xlab = "Sepal Width (in cm)")

# THIS IS A LEVEL 1 HEADER ----------------------------
## This Is a Level 2 Header ---------------------------
### This is a level 3 header. -------------------------

# Clean Up --------------------------------------------

# Clear environment
rm(list = ls()) 

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L
