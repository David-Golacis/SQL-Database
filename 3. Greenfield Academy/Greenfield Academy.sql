-- 1) Grant Statement

-- 1. Create a new database called student_management.
-- CREATE DATABASE student_management;


-- 2. Create two tables in the database:
-- 2a. students: Stores information about students (id, name, age, grade).USE student_management;
-- CREATE TABLE students (
--     id INTEGER PRIMARY KEY,
--     name TEXT,
--     age INTEGER,
--     grade TEXT
-- );

-- 2b. teachers: Stores information about teachers (id, name, subject).
-- CREATE TABLE teachers (
--     id INTEGER PRIMARY KEY,
--     name TEXT,
--     subject TEXT
-- );


-- 3. Create a user named teacher_user without any initial privileges.
-- CREATE LOGIN teacher_user WITH PASSWORD = 'Password.123';
-- CREATE USER teacher_user FOR LOGIN teacher_user;


-- 4. Write a query to grant SELECT and INSERT privileges to teacher_user on the students table.
-- GRANT SELECT, INSERT ON dbo.students TO teacher_user;


-- 5. Verify that teacher_user can now select and insert records in the students table but cannot delete or update any records.
-- SELECT * FROM dbo.students;
-- INSERT INTO dbo.students (ID, name, age, grade) VALUES (1, 'John Doe', 16, '10th Grade');
-- DELETE FROM dbo.students WHERE id = 1;
-- UPDATE dbo.students SET grade = '11th Grade' WHERE id = 1;



-- *******************************************************


-- 2) Revoke Statement

-- 1. Use the same database student_management.
-- USE student_management;


-- 2. Create another user called admin_user.
-- CREATE LOGIN admin_user WITH PASSWORD = 'Password.123';
-- CREATE USER admin_user FOR LOGIN admin_user;


-- 3. Grant all privileges (SELECT, INSERT, UPDATE, DELETE) on both tables (students and teachers) to admin_user.
-- GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.students TO admin_user;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.teachers TO admin_user;


-- 4. Verify that admin_user can perform all operations.
-- SELECT * FROM students;
-- INSERT INTO dbo.students (ID, name, age, grade) VALUES (2, 'Jane Smith', 17, '11th Grade');
-- UPDATE students SET grade = '12th Grade' WHERE name = 'Jane Smith';
-- DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Jane Smith';


-- 5. Write a query to revoke the DELETE privilege from admin_user on the students table.
-- REVOKE DELETE ON dbo.students FROM admin_user;


-- 6. Verify that admin_user can no longer delete records from the students table but can still insert, update, and select records.SELECT * FROM students;
-- INSERT INTO students (ID, name, age, grade) VALUES (1, 'John Doe', 16, '10th Grade');
-- UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'John Doe';
-- DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'John Doe';



-- *******************************************************


-- 3) Roles and Privileges

-- 1. Create a new role called student_role and assign it SELECT privileges on the students table.
-- CREATE ROLE student_role;
-- GRANT SELECT ON dbo.students TO student_role;


-- 2. Create a new user student_user and assign them the student_role.
-- CREATE LOGIN student_user WITH PASSWORD = 'Password.123';
-- CREATE USER student_user FOR LOGIN student_user;
-- ALTER ROLE student_role ADD MEMBER student_user;


-- 3. Verify that student_user can only view the records in the students table but cannot make any changes.
-- SELECT * FROM dbo.students;
-- INSERT INTO students (ID, name, age, grade) VALUES (3, 'Test User', 18, '12th Grade');
-- UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
-- DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';


-- 4. Modify the student_role to also include INSERT privileges on the students table.
-- GRANT INSERT ON dbo.students TO student_role;


-- 5. Verify that student_user can now insert new records but still cannot delete or update them.
-- INSERT INTO students (ID, name, age, grade) VALUES (4, 'Test User', 18, '12th Grade');
-- UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
-- DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';


-- *******************************************************


-- 4) Creating Views

-- 1. Create a view named student_overview that shows the id, name, and grade columns from the students table.
-- CREATE VIEW dbo.student_overview AS 
-- SELECT id, name, grade
-- FROM students;


-- 2. Query the student_overview view to verify it displays the correct data.
-- SELECT * FROM student_overview;


-- 3. Modify the view to include a calculated field that shows age categorized as 'Minor' if the age is less than 18, and 'Adult' otherwise.
-- DROP VIEW IF EXISTS student_overview;

-- CREATE VIEW student_overview AS
-- SELECT 
--     id,
--     name,
--     grade,
--     CASE
--         WHEN age < 18 THEN 'Minor'
--         ELSE 'Adult'
--     END AS age_category
-- FROM students;

-- SELECT * FROM student_overview;


-- *******************************************************


-- 5) Stored Procedures

-- 1. Create a stored procedure named add_student that takes the name, age, and grade as parameters and inserts a new record into the students table.
-- CREATE PROCEDURE add_student
--     @student_id INTEGER,
--     @student_name VARCHAR(50),
--     @student_age INT,
--     @student_grade VARCHAR(10)
-- AS
--     SET NOCOUNT ON;
--     INSERT INTO students (ID, name, age, grade) 
--     VALUES (
--         @student_id,
--         @student_name,
--         @student_age,
--         @student_grade);


-- 2. Run the stored procedure to add a new student.
-- EXECUTE add_student @student_id = 1, @student_name = 'Alice Johnson', @student_age = 17, @student_grade = '12th Grade';
