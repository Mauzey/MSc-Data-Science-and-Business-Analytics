# Install and Load Packages ---------------------------

# install pacman ('package manager') if needed
if (!require("pacman")) install.packages("pacman")

# load contributed packages with pacman
pacman::p_load(pacman, party, psych, rio, tidyverse)

#   pacman...: for loading/unloading packages
#   party....: for decision trees
#   psych....: for many statistical procedures
#   rio......: for importing data
#   tidyverse: for so many reasons

# load base packages manually
library(datasets) # for example datasets

# Load and Prepare Data -------------------------------

# save data to data frame
# rename outcome as 'y'
# specify outcome with df$y

# import csv files with readr::read_csv() from tidyverse
(df <- read_csv("data/StateData.csv"))

# import other formats with rio::import() from rio
(df <- import("data/StateData.xlsx") %>% as_tibble())
# or...
df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code,
         psychRegions,
         instagram:modernDance) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

# Analyse Data ----------------------------------------

# by using standardized object and variable names, the same
#   code can be reused for different analyses

# decision tree using party::ctree
# df[, -1] excludes the state_code
fit <- ctree(y ~ ., data =df[, -1]) # create tree
fit %>% plot() # plot tree
fit %>% # predicted vs true
  predict() %>%
  table(df$y)

hc <- df %>% # get data
  dist %>% # compute distance/dissimilarity matrix
  hclust %>% # compute hierarchial clusters
  plot(labels = df$state_code) # plot dendrogram

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
