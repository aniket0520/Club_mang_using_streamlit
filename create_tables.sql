-- create_tables.sql

--Create admins table
CREATE TABLE IF NOT EXISTS admins (
    admin_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

-- Create clubs table
CREATE TABLE IF NOT EXISTS clubs (
    club_id INTEGER PRIMARY KEY,
    club_name TEXT NOT NULL,
    description TEXT NOT NULL,
    contact_info TEXT,
    membership_count INTEGER DEFAULT 0
);

-- Create students table
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

-- Create events table
CREATE TABLE IF NOT EXISTS events (
    event_id INTEGER PRIMARY KEY,
    event_name TEXT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    location TEXT NOT NULL,
    description TEXT NOT NULL
);

-- Create memberships table
CREATE TABLE IF NOT EXISTS memberships (
    membership_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    membership_status TEXT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);

-- Insert data into admins table
INSERT INTO admins (username, password) VALUES ('anichat', 'abcd');

-- Insert data into clubs table
INSERT INTO clubs (club_name, description, contact_info) VALUES
  ('Chess Club', 'Play chess and improve your skills', 'chess@example.com'),
  ('Coding Club', 'Explore the world of programming', 'coding@example.com');

-- Insert data into students table
INSERT INTO students (username, password) VALUES
  ('john_doe', 'password123'),
  ('jane_smith', 'password456');

-- Insert data into events table
INSERT INTO events (event_name, date, time, location, description) VALUES
  ('Chess Tournament', '2023-12-01', '15:00:00', 'Chess Hall', 'Annual chess competition'),
  ('Coding Workshop', '2023-11-25', '14:00:00', 'Coding Lab', 'Learn Python programming');

-- Insert data into memberships table
INSERT INTO memberships (student_id, club_id, membership_status) VALUES
  (1, 1, 'active'),  -- john_doe joins Chess Club
  (2, 2, 'active');  -- jane_smith joins Coding Club
-- Triggers for clubs table
CREATE TRIGGER IF NOT EXISTS update_club_membership_count
AFTER INSERT ON memberships
BEGIN
    UPDATE clubs
    SET membership_count = membership_count + 1
    WHERE club_id = NEW.club_id;
END;

CREATE TRIGGER IF NOT EXISTS update_club_membership_count_delete
AFTER DELETE ON memberships
BEGIN
    UPDATE clubs
    SET membership_count = membership_count - 1
    WHERE club_id = OLD.club_id;
END;

-- Trigger for students table
CREATE TRIGGER IF NOT EXISTS create_student_membership
AFTER INSERT ON students
BEGIN
    INSERT INTO memberships (student_id, club_id, membership_status)
    VALUES (NEW.student_id, (SELECT club_id FROM clubs ORDER BY club_id LIMIT 1), 'active');
END;

-- Trigger for memberships table
CREATE TRIGGER IF NOT EXISTS check_student_membership_existence
BEFORE INSERT ON memberships
BEGIN
    SELECT 1 FROM memberships
    WHERE student_id = NEW.student_id AND club_id = NEW.club_id;

    -- Assuming RAISE EXCEPTION is not supported, you can use RAISE(IGNORE)
    -- or use SELECT RAISE(IGNORE) to ignore the error and continue execution.
END;
