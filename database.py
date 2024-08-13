# database.py

import sqlite3

def create_connection():
    return sqlite3.connect("club_management.db")

def execute_query(connection, query, params=None):
    """
    Execute a SQL query.

    Parameters:
        connection: SQLite database connection
        query: SQL query to execute
        params: Parameters for the query (optional)
    """
    cursor = connection.cursor()
    cursor.execute(query, params)
    connection.commit()

def execute_query_fetchone(connection, query, params=None):
    """
    Execute a SELECT query and fetch a single result.

    Parameters:
        connection: SQLite database connection
        query: SQL query to execute
        params: Parameters for the query (optional)

    Returns:
        result: Result of the query (single row)
    """
    cursor = connection.cursor()
    cursor.execute(query, params)
    result = cursor.fetchone()
    return result

def execute_insert_query(connection, query, parameters=None):
    """
    Execute an INSERT query on the database.

    Parameters:
        connection (sqlite3.Connection): Database connection.
        query (str): SQL query string.
        parameters (tuple): Parameters to be passed to the query.

    Returns:
        int: The last inserted row ID.
    """
    with connection:
        cursor = connection.cursor()
        cursor.execute(query, parameters)
        return cursor.lastrowid

def execute_query_fetchall(connection, query, parameters=None):
    """
    Execute a SQL query on the database and fetch all results.

    Parameters:
        connection (sqlite3.Connection): Database connection.
        query (str): SQL query string.
        parameters (tuple): Parameters to be passed to the query.

    Returns:
        list: List of tuples representing the result set.
    """
    with connection:
        cursor = connection.cursor()
        cursor.execute(query, parameters)
        return cursor.fetchall()

# Add more functions for database operations as needed.
