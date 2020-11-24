# Q3: Inserting into a Database

# Import and Setup
import pandas as pd
import sqlite3
import sys

N_EMPL = 30  # Number of employees
EMPL_ID = None  # Employee ID to edit

# Create a connection to the database
connection = sqlite3.connect('flujab-info.db')
cursor = connection.cursor()

while True:
    # Ensure an appropriate employee ID is selected by the user
    while EMPL_ID is None:
        try:
            EMPL_ID = int(input("Enter employee ID to edit (0-{}): ".format(N_EMPL)))
            if EMPL_ID > N_EMPL:
                print("Please enter an integer between 0 and {}".format(N_EMPL))
                EMPL_ID = None
        except ValueError:
            print("Please enter an integer between 0 and {}".format(N_EMPL))

    # Update the selected record
    cursor.execute("""
        UPDATE hr_info
        SET had_flujab = 1
        WHERE staff_number = ?
    """, (EMPL_ID,))

    # Ask the user if they wish to edit another record
    while True:
        user_input = input("Would you like to edit another employee record? (y/n)").lower()

        # Process user input - ensure that either 'y' or 'n' is provided
        if (user_input == 'y') or (user_input == 'n'):
            break
        else:
            print("Please answer yes (\'y\') or no (\'n\')")

    # If user wishes to edit another record, restart loop
    if user_input == 'y':
        EMPL_ID = None
    # Otherwise, break loop and terminate application
    else:
        break


# query = """
#     SELECT had_flujab
#     FROM hr_info
# """
# cursor.execute(query)
# result = pd.DataFrame(cursor.fetchall(), columns=['had_flujab'])
# print(result.head())
