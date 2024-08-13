# student.py

import streamlit as st
from database import create_connection, execute_query_fetchone

def student_login():
    st.title("Student Login")

    username = st.text_input("Username")
    password = st.text_input("Password", type="password")

    if st.button("Login"):
        # Add your authentication logic here
        connection = create_connection()

        # Convert both passwords to lowercase for case-insensitive matching
        query = "SELECT * FROM students WHERE username = ? AND password = ?"
        params = (username, password)

        student = execute_query_fetchone(connection, query, params)

        if student:
            st.success("Login successful!")
            student_homepage(student)
        else:
            st.error("Invalid username or password")

def student_homepage(student):
    st.title("Student Homepage")

    # Display student information
    st.write(f"Welcome, {student['username']}!")

    # Add more components and logic here based on student requirements

# Example usage:
# if __name__ == "__main__":
#     student_login()
