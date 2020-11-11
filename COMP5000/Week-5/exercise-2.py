# Exercise 2
# Create a table containing id, name, and height (as a float)

# import and setup
import sqlite3

connection = sqlite3.connect()
cursor = connection.cursor()

# create the table
command = """
        CREATE TABLE people (
            id integer PRIMARY KEY,
            name VARCHAR(200),
            height float
        );
        """
cursor.execute(command)

# add first entry to the table
command = """
        INSERT INTO people (id, name, height)
        VALUES (100, 'John', 160.2);
        """
cursor.execute(command)

# add second entry to the table
command = """
        INSERT INTO people (id, name, height)
        VALUES (101, 'Mary', 151.5);
        """
cursor.execute(command)

# save changes and close the database
connection.commit()
connection.close()