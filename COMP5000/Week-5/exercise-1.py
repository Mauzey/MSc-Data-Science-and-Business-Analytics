# Exercise 1
# Write a Python script to extract student grades from a database and plot a histogram

# import and setup
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import sqlite3

connection = sqlite3.connect('student_grade.db')
cursor = connection.cursor()

query = """
        SELECT * FROM grade
        """
cursor.execute(query)
data = pd.DataFrame(cursor.fetchall(), columns=['Student_ID', 'Grade'])

ax = sns.displot(data.Grade)
plt.show()