# Q1: Python Programming

# Import and Setup
import pandas as pd
import statistics

df = pd.read_csv('life-expectancy-females-2010-2014.csv')

"""
|
|   Write some Python code to compute the normalization scaling and 
|   standardization scaling to the list of life expectancies
|
"""
lifex = df['Life expectancy at birth for females, 2010-2014 (years)'].tolist()

nml_scaled = []
std_scaled = []
for x in lifex:
    # Calculate normalization scaling
    nml = (x - min(lifex)) / (max(lifex) - min(lifex))
    nml_scaled.append(nml)

    # Calculate standardization scaling
    std = (x - statistics.mean(lifex)) / statistics.stdev(lifex)
    std_scaled.append(std)
