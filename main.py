# main.py

import streamlit as st
from admin_login import admin_login, admin_dashboard
from student_login import student_login, student_homepage

def main():
    st.title("University Club Management System")

    user_type = st.radio("Select User Type", ("Admin", "Student"))

    if user_type == "Admin":
        admin_login()
    elif user_type == "Student":
        student_login()

if __name__ == "__main__":
    main()
