# Q4: Statistical Analysis with Python

# import
import pandas as pd

data = pd.read_csv('oil-rig-spills.csv')  # import data

fluid_phase_types = ['Gas', 'Non-Process', 'Oil', 'Condensate', '2-Phase']  # define fluid phase types

# print summary statistics for each phase type
for phase_type in fluid_phase_types:
    print("Leakage Analysis for Phase Type: {}".format(phase_type))
    print("\tMean: {}".format(
        data.loc[data['Fluid Phase'] == phase_type]['Leak Size (kg)'].mean()
    ))
    print("\tSum.: {}\n".format(
        data.loc[data['Fluid Phase'] == phase_type]['Leak Size (kg)'].sum()
    ))

severity_classification = ['Minor', 'Significant', 'Major']  # define severity classification types

# print a statistical summary for each class of severity
print("Statistical Summary of Spill Severity:")
for classification in severity_classification:
    count = data.loc[data['Severity'] == classification, 'Severity'].count()  # observation count for the classification

    # print the observation count and its percentage of the entire dataset
    print("\t{}: {} observations ({}%)".format(
        classification, count, round(count/data.shape[0] * 100)
    ))
