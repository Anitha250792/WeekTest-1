-- DROP DATABASE IF EXISTS if needed
DROP DATABASE IF EXISTS GroceryStoreDB;
CREATE DATABASE GroceryStoreDB;
USE GroceryStoreDB;

-- Create Tables
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Categories
INSERT INTO Categories VALUES
(1, 'Fruits'),
(2, 'Vegetables'),
(3, 'Dairy');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Apple', 1, 3.00),
(102, 'Banana', 1, 1.50),
(103, 'Carrot', 2, 2.00),
(104, 'Broccoli', 2, 2.50),
(105, 'Milk', 3, 4.00),
(106, 'Cheese', 3, 5.00);

-- Insert Orders
INSERT INTO Orders VALUES
(201, '2025-06-20'),
(202, '2025-06-21');

-- Insert OrderDetails
INSERT INTO OrderDetails VALUES
(301, 201, 101, 2, 6.00),   -- 2 Apples
(302, 201, 103, 3, 6.00),   -- 3 Carrots
(303, 201, 105, 1, 4.00),   -- 1 Milk
(304, 202, 102, 4, 6.00),   -- 4 Bananas
(305, 202, 104, 2, 5.00),   -- 2 Broccoli
(306, 202, 106, 1, 5.00);   -- 1 Cheese

-- Final Query: Average Order Value by Category
SELECT 
    c.category_name,
    ROUND(AVG(od.subtotal), 2) AS average_order_value
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name;
