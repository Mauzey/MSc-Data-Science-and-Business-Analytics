
# Install and Load Packages ---------------------------

# load base package manually
library(datasets) # for example datasets
?datasets
library(help="datasets")

# Some Sample Datasets --------------------------------

# iris data
?iris
iris

# UCBAdmissions
?UCBAdmissions
UCBAdmissions

# Titanic
?Titanic
Titanic

# state.x77
?state.x77
state.x77

# swiss
?swiss
swiss

# Clean Up --------------------------------------------

# clear environment
rm(list = ls())

# clear packages
p_unload(all) # remove all add-ons
detach("package:datasets", unload=TRUE) # for base

# clear plots
dev.off() # but only if there IS a plot

# clear console
cat("\014") # ctrl + l
