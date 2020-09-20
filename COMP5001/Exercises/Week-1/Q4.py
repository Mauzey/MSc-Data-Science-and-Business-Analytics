# import
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

# import data and convert the 'Incident Date' column from type 'object' to 'datetime64'
df = pd.read_csv('COMP5001\Exercises\Week-1\q4_data.csv', parse_dates=['Incident Date'],
    date_parser=lambda x: pd.to_datetime(x, infer_datetime_format=True))

# rename columns
df.columns = ['HCR_No', 'Installation_Name', 'Operator', 'Incident_Date', 'Leak_Size', 'Fluid_Phase', 'Severity']

# calculate the mean, sum, and standard deviation of leak sizes
leak_mean = df['Leak_Size'].mean()
leak_sum = df['Leak_Size'].sum()
leak_std = df['Leak_Size'].std()

# calculate the percenage of spills with 'Significant' severity
severity_count = df['Severity'].value_counts()
significant_percent = 100 * (severity_count['Significant'] / (severity_count['Minor'] + severity_count['Significant'] + severity_count['Major']))

print('{}% of documented spills were deemed \'Significantly Severe\''.format(round(significant_percent)))

# plot a histogram of the leak sizes
sns.histplot(df['Leak_Size'], color='#bc5090')

# configure the plot and show it
plt.xscale('log')
plt.xlabel('Leak Size (kg)')
plt.ylabel('Count')
plt.title('Histogram of the Size of Oil Rig Spills')
plt.show()