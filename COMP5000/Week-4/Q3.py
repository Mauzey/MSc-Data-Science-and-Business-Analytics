# Q3: SQL and Python

# import and setup
import sqlite3
import pandas as pd

connection = sqlite3.connect('student_record.db')
cursor = connection.cursor()


# task: create a script where the user can input an sql query, which is then executed
def execute_query(query, head=False):
    """
    execute a defined query

    :param head: (bool) return dataframe head
    :param query: (string) the query to be executed

    :return: (dataframe) query results
    """
    print("[INFO] Executing Query...")

    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return pd.DataFrame(result)
    except sqlite3.OperationalError:
        print('[ERROR] Invalid query submitted, please check for mistakes and try again')


user_query = input("Enter an SQL Query:\n")
print(execute_query(user_query, head=False))
