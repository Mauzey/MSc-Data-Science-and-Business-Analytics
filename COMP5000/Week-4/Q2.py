# Q2: SQL Queries

# import and setup
import sqlite3
import pandas as pd

connection = sqlite3.connect('sakila.db')
cursor = connection.cursor()


# task 1: construct an sql query to extract the titles of the films
def get_film_titles():
    """
    extract the 'title' from the 'film' table

    :return: (dataframe) query results
    """
    query = """
            SELECT title
            FROM film
            """
    cursor.execute(query)
    result = cursor.fetchall()

    return pd.DataFrame(result, columns=['Film_Title'])


# task 2: construct an sql query to extract the distinct ratings (e.g. PG) of the films
def get_ratings():
    """
    extract distinct instances of 'rating' from the 'film' table

    :return: (dataframe) query results
    """
    query = """
            SELECT DISTINCT rating
            FROM film
            """
    cursor.execute(query)
    result = cursor.fetchall()

    return pd.DataFrame(result, columns=['Rating'])


# task 3: construct an sql query to extract the films with PG rating
def get_pg_films():
    """
    extract film 'title' from the 'film' table, where 'rating' is 'PG'

    :return: (dataframe) query results
    """
    query = """
            SELECT title
            FROM film
            WHERE rating == 'PG'
            """
    cursor.execute(query)
    result = cursor.fetchall()

    return pd.DataFrame(result, columns=['Film_Title'])


# task 4: construct an sql query to count the number of films with different ratings
def get_rating_counts():
    """
    extract a count of films for each 'rating' from the 'film' table

    :return: (dataframe) query results
    """
    query = """
            SELECT rating, COUNT(*)
            FROM film
            GROUP BY rating
            """
    cursor.execute(query)
    result = cursor.fetchall()

    return pd.DataFrame(result, columns=['Rating', 'Film_Count'])


# task 5: construct an sql query to extract the name of the file and the film category
def get_film_categories():
    """
    extract 'film.name' and 'film.category' from the tables 'film' and 'film_category', respectively

    :return: (dataframe) query results
    """
    query = """
            SELECT film.title, category.name
            FROM film
            INNER JOIN film_category ON film_category.film_id = film.film_id
            INNER JOIN category ON film_category.category_id = category.category_id
            """
    cursor.execute(query)
    result = cursor.fetchall()

    return pd.DataFrame(result, columns=['Film_Title', 'Film_Category'])


print('\n', get_film_titles().head())
print('\n', get_ratings().head())
print('\n', get_pg_films().head())
print('\n', get_rating_counts().head())
print('\n', get_film_categories().head())
