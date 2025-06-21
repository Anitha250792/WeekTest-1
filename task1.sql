-- DROP and CREATE DATABASE
DROP DATABASE IF EXISTS GroceryStoreDB;
CREATE DATABASE GroceryStoreDB;
USE GroceryStoreDB;

-- STEP 1: Create Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- STEP 2: Insert Sample Data

-- Customers
INSERT INTO Customers (customer_id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'Diana', 'diana@example.com');

-- Products
INSERT INTO Products (product_id, name, price) VALUES
(101, 'Rice', 50.00),
(102, 'Milk', 30.00),
(103, 'Bread', 25.00),
(104, 'Eggs', 6.00),
(105, 'Apples', 100.00);

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2024-06-10'),
(1002, 2, '2024-06-11'),
(1003, 1, '2024-06-12'),
(1004, 3, '2024-06-13'),
(1005, 4, '2024-06-14');

-- Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1001, 101, 2), -- Alice bought 2 Rice
(1001, 102, 1), -- Alice bought 1 Milk
(1002, 103, 4), -- Bob bought 4 Bread
(1003, 104, 10),-- Alice bought 10 Eggs
(1003, 105, 1), -- Alice bought 1 Apples
(1004, 101, 1), -- Charlie bought 1 Rice
(1004, 103, 2), -- Charlie bought 2 Bread
(1005, 102, 3), -- Diana bought 3 Milk
(1005, 104, 5); -- Diana bought 5 Eggs

-- STEP 3: Customer Purchase History Report
SELECT 
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    p.name AS product_name,
    od.quantity,
    (od.quantity * p.price) AS total_price
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
ORDER BY c.name, o.order_date;

