# SQL Databases

## Projects

A series of relational databases have been prepared using SQLite and Microsoft SQL Server.


### SQLite Requirements:
 - Install SQLite3 onto OS
 - (If using VS Code) install SQLite3 Editor by yy0931 extension


### Microsoft SQL Server (MSSQL) Requirements:
 - Install SQL Server Management Studio (SSMS)
 - (If using VS Code) install SQLite3 Editor by yy0931 extension


## 1. TechNova Solutions (SQLite)

### Background

TechNova Solutions is a technology consulting firm that manages various projects for clients, has multiple departments, and employs a diverse workforce. You have been tasked with designing a relational database for TechNova Solutions to effectively manage employees, departments, and projects. The goal is to create, modify, and optimise the database structure while ensuring data integrity.


### Developing Database

An SQLite database was chosen for this project, as only simple read/ write operations were required for task completion. Two empty files were created in VS Code: TechNova_Solutions.db and TechNova_Solutions.sql. The first file stores the data, and the second file runs queries. The SQLite3 Editor extension was used to check if queries were executed successfully.

Inside the SQL file, the following problems were solved:
 - Creating various tables in a single database
 - Altering table structure
 - Dropping tables, or columns
 - Establishing indexes


### Creating Tables

1. Employees table: Create a table to store employee details, ensuring each employee has a unique identifier, first and last name, email address, hire date, and optional department information.
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

2. Departments table: Design a table to store department details, including a unique identifier and department name. Each department should have a manager, who is one of the employees.
```
CREATE TABLE Departments (
    Department_ID INTEGER    PRIMARY KEY AUTOINCREMENT,
    Department_Name TEXT,
    Manager_ID INTEGER,
    FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID)
);
```

3. Projects table: Develop a table to manage projects, where each project has a unique identifier, name, start date, and optional end date. Each project should be managed by an employee.
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

1. Add a column to the Employees table to store phone numbers.
```
ALTER TABLE Employees ADD COLUMN Phone_Number TEXT;
```

2. Make sure that every department has a name by including a NOT NULL constraint on the DepartmentName column.
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

3. Rename the HireDate column in the Employees table to StartDate.
```
ALTER TABLE Employees RENAME COLUMN Hire_Date TO Start_Date;
```

4. Remove the Department column from the Employees table, as it is no longer needed.
```
ALTER TABLE Employees DROP COLUMN Department;
```


### Dropping Tables

1. Drop the Departments table entirely from the database.
```
DROP TABLE IF EXISTS Departments;
```

2. Create a temporary table named TempProjects for testing purposes and then drop it.
```
CREATE TEMPORARY TABLE TempProjects (
    Temp_ID INTEGER  PRIMARY KEY,
    Temp_Name VARCHAR(50)
);

DROP TABLE TempProjects;
```

3. Write a script to drop the Employees table only if it exists.
```
DROP TABLE IF EXISTS Employees;
```


### Index

1. Create an index on the Email column in the Employees table to speed up email searches.
```
CREATE INDEX idx_email ON Employees(Email);
```

2. Create a composite index on the LastName and FirstName columns in the Employees table to improve full name searches.
```
CREATE INDEX idx_fullname ON Employees(Last_Name, First_Name);
```

3. Drop the index on the Email column if it is no longer needed.
```
DROP INDEX IF EXISTS idx_email;
```


## 2. AthleteZone (SQLite)

### Background

AthleteZone is a business that sells sports equipment online through its E-commerce website. You have been tasked with managing the online store's database by performing essential SQL operations. The project focuses on inserting, updating, and deleting records to ensure data consistency through transactions.


### Developing Database

An SQLite database was chosen for this project, as only simple read/ write operations were required for task completion. Two empty files were created in VS Code: AthleteZone.db and AthleteZone.sql. The first file stores the data, and the second file runs queries. The SQLite3 Editor extension was used to check if queries were executed successfully.

Inside the SQL file, the following problems were solved:
 - Creating various tables in a single database
 - Inserting new records into tables
 - Updating records with new information
 - Deleting records that are no longer needed


### Insert Statement

1. Customers Table: Create a table to store customer information, including a unique identifier for each customer, their first and last names, email address, and the date they joined the store.
```
CREATE TABLE Customers (
    CustomerID INTEGER  PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT      NOT NULL,
    LastName TEXT       NOT NULL,
    Email TEXT          UNIQUE NOT NULL,
    JoinDate DATE       NOT NULL
);
```

Insert records for at least three customers. Ensure that each customer has a unique email address.
```
INSERT INTO Customers (FirstName, LastName, Email, JoinDate)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '2024-01-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '2024-02-10'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '2024-03-05');
```

2. Products Table: Create a table to hold product details, including a unique product identifier, product name, price, and available stock quantity.
```
CREATE TABLE Products (
    ProductID INTEGER       PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT        NOT NULL,
    Price DECIMAL(10, 2)    NOT NULL,
    StockQuantity INTEGER   NOT NULL
);
```

Insert records for at least three different products. Make sure each product has a unique identifier and a reasonable stock quantity.
```
INSERT INTO Products (ProductName, Price, StockQuantity)
VALUES
    ('Laptop', 999.99, 50),
    ('Smartphone', 699.99, 100),
    ('Headphones', 199.99, 200);
```

3. Orders Table: Design a table to track customer orders. This table should include an order identifier, the customer's identifier (linking to the Customers table), the product's identifier (linking to the Products table), the order date, and the quantity ordered.
```
CREATE TABLE Orders (
    OrderID INTEGER     PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER,
    ProductID INTEGER,
    OrderDate DATE      NOT NULL,
    Quantity INTEGER    NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

Insert records for at least three orders, ensuring that each order correctly references existing customers and products.
```
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity)
VALUES
    (1, 1, '2024-04-01', 1), 
    (2, 2, '2024-04-02', 2),  
    (3, 3, '2024-04-03', 3); 
```


### Update Statement

1. Customers Table: One of the customers has updated their email address. Let's say John Doe's new email address is john.doe.new@example.com. Could you identify the customer and modify their record to reflect this change?
```
UPDATE Customers SET Email = 'john.doe.new@example.com' WHERE CustomerID = 1;
```

2. Products Table: The price of the "Laptop" product has increased to 1,099.99. Could you adjust the price in the Products table accordingly?
```
UPDATE Products SET Price = 1099.99 WHERE ProductName = 'Laptop';
```

3. Orders Table: A customer has requested a change in their order quantity. Let's say Jane Smith wants to change the quantity of her smartphone order from 2 to 1. Update the relevant order record to reflect the new quantity.
```
UPDATE Orders SET Quantity = 1 WHERE OrderID = 2;
```


### Delete Statement

First, disable the foreign key constraint to avoid errors.
```
PRAGMA foreign_keys = 0;
```

1. Delete a Customer Record: A customer has requested that their account be deleted. Let's say Alice Johnson has requested that her account be removed. Could you identify the customer and remove their record from the database?
```
DELETE FROM Customers WHERE CustomerID = 3;
```

2. Delete a Product Record: One of the products, "Headphones," is no longer available for sale and should be removed from the database. Could you remove this product from the Products table?
```
DELETE FROM Products WHERE ProductName = 'Headphones';
```

3. Delete an Order Record: An order has been canceled by the customer. Let's say the order with OrderID = 3, which was for Alice Johnson, needs to be deleted. Could you delete this order from the Orders table?
```
DELETE FROM Orders WHERE OrderID = 3;
```

Re-enable foreign key constraints to ensure database integrity moving forward.
```
PRAGMA foreign_keys = 1;
```


## 3. Greenfield Academy (MSSQL)

### Background

Greenfield Academy, a growing educational institution, has decided to modernise its student information system. The IT department is tasked with creating a new database called 'student_management' to store and manage information about students and teachers. As part of this initiative, they need to set up appropriate access controls to ensure data security and privacy.


### Developing Database

This project required a more sophisticated solution to allow users to have varying permissions. First, a connection to 'localhost' with the profile 'Greenfield Academy' was established within SSMS. Then, the database was developed within VS Code using the SQL file in the relevant folder.

Inside the SQL file, the following problems were solved:
 - Creating the necessary database structure
 - Setting up user accounts with varying levels of access
 - Implementing and managing database privileges
 - Creating and assigning roles for different types of users

These tasks will help Greenfield Academy maintain the confidentiality and integrity of its student and teacher data while allowing appropriate access to authorised personnel. The lessons will guide the database administrator through the process of granting privileges, revoking them when necessary, and using roles to manage user permissions efficiently.


### Grant Statement

1. Create a new database called student_management.
```
CREATE DATABASE student_management;
```

3. Create two tables in the database:
Students table: Stores information about students (id, name, age, grade).
```
CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    grade TEXT
);
```

Teachers table: Stores information about teachers (id, name, subject).
```
CREATE TABLE teachers (
    id INTEGER PRIMARY KEY,
    name TEXT,
    subject TEXT
);
```

3. Create a user named teacher_user without any initial privileges.
```
CREATE LOGIN teacher_user WITH PASSWORD = 'Password.123';
CREATE USER teacher_user FOR LOGIN teacher_user;
```

4. Write a query to grant SELECT and INSERT privileges to teacher_user on the students table.
```
GRANT SELECT, INSERT ON dbo.students TO teacher_user;
```

5. Verify that teacher_user can now select and insert records in the students table but cannot delete or update any records.
```
SELECT * FROM dbo.students;
INSERT INTO dbo.students (ID, name, age, grade) VALUES (1, 'John Doe', 16, '10th Grade');
DELETE FROM dbo.students WHERE id = 1;
UPDATE dbo.students SET grade = '11th Grade' WHERE id = 1;
```


### Revoke Statement

1. Use the same database student_management.
```
USE student_management;
```

2. Create another user called admin_user.
```
CREATE LOGIN admin_user WITH PASSWORD = 'Password.123';
CREATE USER admin_user FOR LOGIN admin_user;
```

3. Grant all privileges (SELECT, INSERT, UPDATE, DELETE) on both tables (students and teachers) to admin_user.
```
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.students TO admin_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.teachers TO admin_user;
```

4. Verify that admin_user can perform all operations.
```
SELECT * FROM students;
INSERT INTO dbo.students (ID, name, age, grade) VALUES (2, 'Jane Smith', 17, '11th Grade');
UPDATE students SET grade = '12th Grade' WHERE name = 'Jane Smith';
DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Jane Smith';
```

5. Write a query to revoke the DELETE privilege from admin_user on the students table.
```
REVOKE DELETE ON dbo.students FROM admin_user;
```

6. Verify that admin_user can no longer delete records from the students table but can still insert, update, and select records. SELECT * FROM students;
```
INSERT INTO students (ID, name, age, grade) VALUES (1, 'John Doe', 16, '10th Grade');
UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'John Doe';
DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'John Doe';
```


### Roles and Privileges

1. Create a new role called student_role and assign it SELECT privileges on the students table.
```
CREATE ROLE student_role;
GRANT SELECT ON dbo.students TO student_role;
```

2. Create a new user student_user and assign them the student_role.
```
CREATE LOGIN student_user WITH PASSWORD = 'Password.123';
CREATE USER student_user FOR LOGIN student_user;
ALTER ROLE student_role ADD MEMBER student_user;
```

3. Verify that student_user can only view the records in the students table but cannot make any changes.
```
SELECT * FROM dbo.students;
INSERT INTO students (ID, name, age, grade) VALUES (3, 'Test User', 18, '12th Grade');
UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
```

4. Modify the student_role to also include INSERT privileges on the students table.
```
GRANT INSERT ON dbo.students TO student_role;
```

5. Verify that student_user can now insert new records but still cannot delete or update them.
```
INSERT INTO students (ID, name, age, grade) VALUES (4, 'Test User', 18, '12th Grade');
UPDATE students SET grade = '11th Grade' WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
DELETE FROM students WHERE CAST(name AS VARCHAR(MAX)) = 'Test User';
```

















