-- database: TechNova_Solutions.db

-- 1) Creating Tables:

-- 1. Employees Table: Create a table to store employee details, ensuring each employee has a unique identifier, first and last name, email address, hire date, and optional department information.
CREATE TABLE Employees (
    Employee_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    First_Name TEXT     NOT NULL,
    Last_Name TEXT      NOT NULL,
    Email TEXT          NOT NULL UNIQUE,
    Hire_Date DATE      NOT NULL,
    Department TEXT
);


-- 2. Departments Table: Design a table to store department details, including a unique identifier and department name. Each department should have a manager, who is one of the employees.
CREATE TABLE Departments (
    Department_ID INTEGER    PRIMARY KEY AUTOINCREMENT,
    Department_Name TEXT,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);

-- 3. Projects Table: Develop a table to manage projects, where each project has a unique identifier, name, start date, and optional end date. Each project should be managed by an employee.
CREATE TABLE Projects (
    Project_ID INTEGER   PRIMARY KEY AUTOINCREMENT,
    Project_Name TEXT    NOT NULL UNIQUE,
    Start_Date DATE      NOT NULL,
    End_Date DATE,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);

-- *******************************************************

-- 2) Altering Tables:

-- 1. Add a column to the Employees table to store phone numbers.
ALTER TABLE Employees ADD COLUMN Phone_Number TEXT;


-- 2. Make sure that every department has a name by including a NOT NULL constraint on the DepartmentName column.
CREATE TABLE newDepartments (
    Department_ID INTEGER    PRIMARY KEY AUTOINCREMENT,
    Department_Name TEXT     NOT NULL,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);

INSERT INTO newDepartments (Department_ID, Department_Name, Manager_ID)
SELECT Department_ID,Department_Name, Manager_ID
FROM Departments;

-- Write a script to drop the Departments table only if it exists, as it's no longer needed.
DROP TABLE IF EXISTS Departments;


-- 3. Rename the newDepartments table to Departments as before.
ALTER TABLE newDepartments RENAME TO Departments;


-- 4. Rename the Hire_Date column in the Employees table to Start_Date.
ALTER TABLE Employees RENAME COLUMN Hire_Date TO Start_Date;


-- 5. Remove the Department column from the Employees table, as it is redundant.
ALTER TABLE Employees DROP COLUMN Department;

-- *******************************************************

-- 3) Dropping Tables:

-- 1. Drop the Departments table entirely from the database.
DROP TABLE IF EXISTS Departments;


-- 2. Create a temporary table named TempProjects for testing purposes and then drop it.
CREATE TEMPORARY TABLE TempProjects (
    Temp_ID INTEGER  PRIMARY KEY,
    Temp_Name VARCHAR(50)
);

DROP TABLE TempProjects;

-- *******************************************************

-- 4) Indexes:

-- 1. Create an index on the Email column in the Employees table to speed up email searches.
CREATE INDEX idx_email ON Employees(Email);


-- 2. Create a composite index on the LastName and FirstName columns in the Employees table to improve full name searches.
CREATE INDEX idx_fullname ON Employees(Last_Name, First_Name);


-- 3. Drop the index on the Email column if it is no longer needed.
DROP INDEX IF EXISTS idx_email;