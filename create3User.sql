-- Create a Database
create database TestDB;
SHOW PROCESSLIST;


-- check user
select user ,host from mysql.user


-- Create 3 users for that database 
-- Create User 1 (Admin with all permissions)
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'Useradmin@1';

-- Create User 2 (Read-Only permissions)
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'Userread@2';

-- Create User 3 (Write-Only permissions)
CREATE USER 'user3'@'localhost' IDENTIFIED BY 'Userwrite@3';


-- Give all permission to user 1 ....read to user2 write to user3
GRANT ALL PRIVILEGES ON TestDB.* TO 'user1'@'localhost';
GRANT SELECT ON TestDB.* TO 'user2'@'localhost';
GRANT INSERT, UPDATE, DELETE ON TestDB.* TO 'user3'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'user1'@'localhost';
SHOW GRANTS FOR 'user2'@'localhost';
SHOW GRANTS FOR 'user3'@'localhost';


-- Log in as user1 (Admin):

mysql -u user1 -p

-- Log in as user2 (Read-Only User):

mysql -u user2 -p

-- Log in as user3 (Write-Only User):

mysql -u user3 -p

-- Example Table : user 1  Viewing the data

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    branch VARCHAR(50)
);


SELECT * FROM students;

-- User 1: Inserting new data
INSERT INTO students (student_id, name, age, branch)
VALUES (101, 'Ujjwal Kamila', 20, 'CSE');

-- User 1: Updating data
UPDATE students SET branch = 'IT' WHERE student_id = 101;

-- User 1: Deleting data
DELETE FROM students WHERE student_id = 101;

-- User 1: Creating another table (to check admin privileges)
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(50)
);







-- User 2: Viewing the data
SELECT * FROM students;

-- User 2: Cannot Insert, Update, or Delete
-- INSERT INTO students (student_id, name, age, branch)  -- Will be denied
-- UPDATE students SET branch = 'ECE' WHERE student_id = 101;    -- Will be denied
-- DELETE FROM students WHERE student_id = 101;                    -- Will be denied







-- User 3: Cannot View the Data
-- SELECT * FROM students;   -- Will be denied

-- User 3: Inserting new data
INSERT INTO students (student_id, name, age, branch)
VALUES (102, 'Jane Smith', 21, 'ECE');

-- User 3: Updating data
UPDATE students SET branch = 'ME' WHERE student_id = 102;

-- User 3: Deleting data
DELETE FROM students WHERE student_id = 102;
