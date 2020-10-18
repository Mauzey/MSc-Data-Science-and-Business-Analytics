# Q2: Plotting a Histogram from a JSON file

# import and setup
import seaborn as sns
import pandas as pd

data = pd.read_json(r'near-earth-asteroids-comets.json')

# drop rows with missing 'period_yr' values
data = data.dropna(subset=['period_yr'])

# plot histogram of 'period_yr'
ax = sns.distplot(data['period_yr'])
ax.set_yscale('log')