# Q1: Plotting data from a .csv file

# import and setup
import seaborn as sns
import pandas as pd

data = pd.read_csv('household-waste.csv')

# rename columns
data.columns = ['Area', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015']

# adjust area values
data.loc[0, 'Area'] = 'Plymouth'
data.loc[1, 'Area'] = 'England'

# drop '2015' column as it contains no observations
data = data.drop(['2015'], axis = 1)

# melt individual year columns into year/percentage
data = pd.melt(data, id_vars = ['Area'], var_name = 'Year', value_name = 'Recycling_Percentage')

# convert 'Year' column from object to integer
data['Year'] = pd.to_numeric(data['Year'])

# convert 'Recycling_Percentage' column from object to float, and remove the percentage symbol
data['Recycling_Percentage'] = pd.to_numeric(data['Recycling_Percentage'].str[:-1])

# plot 'Year' vs. 'Recycling_Percentage', grouped by 'Area'
sns.lineplot(data=data, x='Year', y='Recycling_Percentage', hue='Area')