# Q3: Inserting into a Database
# SETUP FILE - RUN THIS SCRIPT BEFORE Q3.py

# Import and Setup
import sqlite3
import sys

N_EMPL = 30  # Number of employees

# Create the database and connect
connection = sqlite3.connect('flujab-info.db')
cursor = connection.cursor()


# Define schema for, and create hr_info table
command = """
    CREATE TABLE hr_info (
        staff_number INTEGER PRIMARY KEY,
        had_flujab INTEGER
    );
"""
cursor.execute(command)


# Populate the hr_info table
for i in range(0, N_EMPL):
    cursor.execute("""
        INSERT INTO hr_info (staff_number, had_flujab)
        VALUES (?, ?)
    """, (str(i), str(0)))
connection.commit()


print("Successfully created and populated database flujab-info.db")
connection.close()
sys.exit(0)
