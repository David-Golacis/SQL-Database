# SQL Databases

## Projects

A series of relational databases have been prepared using SQLite and Microsoft SQL Server.


### SQLite Requirements:
 - Install SQLite3 onto OS
 - (If using VSCode) install SQLite3 Editor by yy0931 extension


## 1. TechNova Solutions (SQLite)

### Background

TechNova Solutions is a technology consulting firm that manages various projects for clients, has multiple departments, and employs a diverse workforce. You have been tasked with designing a relational database for TechNova Solutions to effectively manage employees, departments, and projects. The goal is to create, modify, and optimise the database structure while ensuring data integrity.


### Developing Database

Two empty files were created in VS Code: TechNova_Solutions.db and TechNova_Solutions.sql. The first file stores data, and the second file runs queries. The SQLite3 Editor extension was used to check if queries were executed successfully.

Inside the SQL file, the following problems were solved:
 - Creating various tables in a single database
 - Altering table structure
 - Dropping tables, or columns
 - Establishing indexes


### Creating Tables

Employees table: Create a table to store employee details, ensuring each employee has a unique identifier, first and last name, email address, hire date, and optional department information.
```
CREATE TABLE Employees (
    Employee_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    First_Name TEXT     NOT NULL,
    Last_Name TEXT      NOT NULL,
    Email TEXT          NOT NULL UNIQUE,
    Hire_Date DATE      NOT NULL,
    Department TEXT
);
```

Departments table: Design a table to store department details, including a unique identifier and department name. Each department should have a manager, who is one of the employees.
```
CREATE TABLE Departments (
    Department_ID INTEGER    PRIMARY KEY AUTOINCREMENT,
    Department_Name TEXT,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);
```

Projects table: Develop a table to manage projects, where each project has a unique identifier, name, start date, and optional end date. Each project should be managed by an employee.
```
CREATE TABLE Projects (
    Project_ID INTEGER   PRIMARY KEY AUTOINCREMENT,
    Project_Name TEXT    NOT NULL UNIQUE,
    Start_Date DATE      NOT NULL,
    End_Date DATE,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);
```


### Altering Tables

Add a column to the Employees table to store phone numbers.
```
ALTER TABLE Employees ADD COLUMN Phone_Number TEXT;
```

Make sure that every department has a name by including a NOT NULL constraint on the DepartmentName column.
```
-- Create a temp table to house old data with new constraints, as SQLite does not support amending table constraints.
CREATE TABLE newDepartments (
    Department_ID INTEGER    PRIMARY KEY AUTOINCREMENT,
    Department_Name TEXT     NOT NULL,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);

-- Transfer data to temp table
INSERT INTO newDepartments (Department_ID, Department_Name, Manager_ID)
SELECT Department_ID,Department_Name, Manager_ID
FROM Departments;

-- Drop the Departments table only if it exists, as it's no longer needed.
DROP TABLE IF EXISTS Departments;

-- Rename the newDepartments table to Departments as before.
ALTER TABLE newDepartments RENAME TO Departments;
```

Rename the HireDate column in the Employees table to StartDate.
```
ALTER TABLE Employees RENAME COLUMN Hire_Date TO Start_Date;
```

Remove the Department column from the Employees table, as it is no longer needed.
```
ALTER TABLE Employees DROP COLUMN Department;
```


### Dropping Tables

Drop the Departments table entirely from the database.
```
DROP TABLE IF EXISTS Departments;
```

Create a temporary table named TempProjects for testing purposes and then drop it.
```
CREATE TEMPORARY TABLE TempProjects (
    Temp_ID INTEGER  PRIMARY KEY,
    Temp_Name VARCHAR(50)
);

DROP TABLE TempProjects;
```

Write a script to drop the Employees table only if it exists.
```
DROP TABLE IF EXISTS Employees;
```


### Index

Create an index on the Email column in the Employees table to speed up email searches.
```
CREATE INDEX idx_email ON Employees(Email);
```

Create a composite index on the LastName and FirstName columns in the Employees table to improve full name searches.
```
CREATE INDEX idx_fullname ON Employees(Last_Name, First_Name);
```

Drop the index on the Email column if it is no longer needed.
```
DROP INDEX IF EXISTS idx_email;
```

