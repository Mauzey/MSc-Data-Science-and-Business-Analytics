# Q3: Using SQL to extract data from a database

# import and setup
import sqlite3

connection = sqlite3.connect('simplefolks.sqlite')
cursor = connection.cursor()

# get table names from the database
print("Table names:")
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
print(cursor.fetchall(), '\n')

# get information about the 'people' table
print("Information about the 'people' table:")
cursor.execute("PRAGMA table_info(people);")
print(cursor.fetchall(), '\n')

# get all names in the 'people' table
print("All names in the 'people' table:")
cursor.execute("SELECT name FROM people")
print(cursor.fetchall(), '\n')

# get names of individuals in the 'people' table, where 'age' < 30
print("Individuals who are younger than 30 in the 'people' table:")
cursor.execute("SELECT name FROM people WHERE age < 30")
print(cursor.fetchall(), '\n')

# get names of individuals in the 'people' table, where 'sex' = 'M'
print("Males in the 'people' table:")
cursor.execute("SELECT name FROM people WHERE sex == 'M'")
print(cursor.fetchall(), '\n')

# find the average age of people in the 'people' table
print("Average age of individuals in the 'people' table:")
cursor.execute("SELECT Avg(age) FROM people")
print(cursor.fetchall())