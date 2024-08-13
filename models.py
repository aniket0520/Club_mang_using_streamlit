# models.py

class Admin:
    def __init__(self, admin_id, username, password):
        self.admin_id = admin_id
        self.username = username
        self.password = password

class Student:
    def __init__(self, student_id, name, email, department):
        self.student_id = student_id
        self.name = name
        self.email = email
        self.department = department
