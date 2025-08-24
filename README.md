# SQL Databases

## Projects

A series of relational databases have been prepared using SQLite and Microsoft SQL Server.


### SQLite Requirements:
 - Install SQLite3 onto OS
 - (If using VS Code) install SQLite3 Editor by yy0931 extension


## 1. TechNova Solutions (SQLite)

### Background

TechNova Solutions is a technology consulting firm that manages various projects for clients, has multiple departments, and employs a diverse workforce. You have been tasked with designing a relational database for TechNova Solutions to effectively manage employees, departments, and projects. The goal is to create, modify, and optimise the database structure while ensuring data integrity.


### Developing Database

Two empty files were created in VS Code: TechNova_Solutions.db and TechNova_Solutions.sql. The first file stores the data, and the second file runs queries. The SQLite3 Editor extension was used to check if queries were executed successfully.

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


## 2. AthleteZone

### Background

AthleteZone is a business that sells sports equipment online through its E-commerce website. You have been tasked with managing the online store's database by performing essential SQL operations. The project focuses on inserting, updating, and deleting records to ensure data consistency through transactions.


### Insert Statement

Customers Table: Create a table to store customer information, including a unique identifier for each customer, their first and last names, email address, and the date they joined the store.
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

Products Table: Create a table to hold product details, including a unique product identifier, product name, price, and available stock quantity.
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

Orders Table: Design a table to track customer orders. This table should include an order identifier, the customer's identifier (linking to the Customers table), the product's identifier (linking to the Products table), the order date, and the quantity ordered.
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

Customers Table: One of the customers has updated their email address. Let's say John Doe's new email address is john.doe.new@example.com. Identify the customer and modify their record to reflect this change.
```
UPDATE Customers SET Email = 'john.doe.new@example.com' WHERE CustomerID = 1;
```

Products Table: The price of the "Laptop" product has increased to 1,099.99. Adjust the price in the `Products` table accordingly.
```
UPDATE Products SET Price = 1099.99 WHERE ProductName = 'Laptop';
```

Orders Table: A customer has requested a change in their order quantity. Let's say Jane Smith wants to change the quantity of her smartphone order from 2 to 1. Update the relevant order record to reflect the new quantity.
```
UPDATE Orders SET Quantity = 1 WHERE OrderID = 2;
```


### Delete Statement

First, disable the foreign key constraint to avoid errors.
```
PRAGMA foreign_keys = 0;
```

Delete a Customer Record: A customer has requested that their account be deleted. Let's say Alice Johnson has asked for her account to be removed. Identify the customer and remove their record from the database.
```
DELETE FROM Customers WHERE CustomerID = 3;
```

Delete a Product Record: One of the products, "Headphones," is no longer available for sale and should be removed from the database. Remove this product from the `Products` table.
```
DELETE FROM Products WHERE ProductName = 'Headphones';
```

Delete an Order Record: An order has been canceled by the customer. Let's say the order with OrderID = 3, which was for Alice Johnson, needs to be deleted. Delete this order from the `Orders` table.
```
DELETE FROM Orders WHERE OrderID = 3;
```

Re-enable foreign key constraints to ensure database integrity moving forward.
```
PRAGMA foreign_keys = 1;
```

