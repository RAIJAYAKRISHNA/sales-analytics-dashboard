--Creation of SalesAnalytics Database
CREATE DATABASE SalesAnalytics;

GO

USE SalesAnalytics;

GO

--Creation of Customer Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

--Creation of Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

--Creation of Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Inserting data into customer table
INSERT INTO Customers VALUES
(1,'Rahul','Hyderabad'),
(2,'Priya','Chennai'),
(3,'Arjun','Bangalore'),
(4,'Sneha','Mumbai'),
(5,'Kiran','Delhi'),
(6,'Anjali','Pune'),
(7,'Ravi','Hyderabad'),
(8,'Meena','Chennai');

--Inserting data into products table
INSERT INTO Products VALUES
(101,'Laptop','Electronics',55000),
(102,'Mouse','Electronics',800),
(103,'Keyboard','Electronics',1500),
(104,'Monitor','Electronics',12000),
(105,'Chair','Furniture',5000),
(106,'Table','Furniture',8000),
(107,'Bookshelf','Furniture',6000),
(108,'Printer','Electronics',10000);

--Inserting data into orders table
INSERT INTO Orders VALUES
(1001,1,101,'2025-01-05',1),
(1002,2,102,'2025-01-08',2),
(1003,3,105,'2025-01-10',1),
(1004,4,104,'2025-01-12',1),
(1005,5,106,'2025-01-15',2),
(1006,6,103,'2025-01-18',3),
(1007,7,108,'2025-01-20',1),
(1008,8,105,'2025-01-22',2),
(1009,1,104,'2025-02-02',1),
(1010,2,101,'2025-02-05',1),
(1011,3,102,'2025-02-08',4),
(1012,4,106,'2025-02-10',1),
(1013,5,103,'2025-02-12',2),
(1014,6,107,'2025-02-15',1),
(1015,7,101,'2025-02-18',1),
(1016,8,108,'2025-02-20',1),
(1017,1,105,'2025-03-02',1),
(1018,2,106,'2025-03-05',1),
(1019,3,101,'2025-03-08',1),
(1020,4,102,'2025-03-10',5);

--Total Sales Query
SELECT
	SUM(p.Price * o.Quantity) AS TotalSales
FROM dbo.Orders o
JOIN dbo.Products p
	ON o.ProductID = p.ProductID

-- Category Sales Query

SELECT
	p.Category,
	SUM(p.Price * o.Quantity) AS TotalSales
FROM Orders o
JOIN Products p
	ON o.ProductID = p.ProductID
GROUP BY p.Category;

-- Top Customers Query

SELECT
	c.CustomerName,
	SUM(p.Price * o.Quantity) AS TotalSpent
FROM Orders o
JOIN Customers c
	ON o.CustomerID = c.CustomerID
JOIN Products p
	ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;

-- Monthly Sales Query

SELECT
	DATENAME(MONTH, OrderDate) AS MonthName,
	SUM(p.Price * o.Quantity) AS Sales
FROM Orders o
JOIN Products p
	ON o.ProductID = p.ProductID
GROUP BY DATENAME(MONTH, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);