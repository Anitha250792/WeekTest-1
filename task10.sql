-- Drop and recreate database for a clean start
DROP DATABASE IF EXISTS ReturnRefundDB;
CREATE DATABASE ReturnRefundDB;
USE ReturnRefundDB;

-- Step 1: Create Tables
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
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
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    order_detail_id INT,
    return_date DATE,
    refund_amount DECIMAL(10, 2),
    FOREIGN KEY (order_detail_id) REFERENCES OrderDetails(order_detail_id)
);

-- Step 2: Insert Sample Categories
INSERT INTO Categories VALUES
(1, 'Laptops'),
(2, 'Smartphones'),
(3, 'Headphones');

-- Step 3: Insert Sample Products
INSERT INTO Products VALUES
(101, 'Dell Inspiron', 1),
(102, 'MacBook Air', 1),
(201, 'iPhone 14', 2),
(202, 'Samsung Galaxy S22', 2),
(301, 'Sony WH-1000XM4', 3),
(302, 'Boat Rockerz 450', 3);

-- Step 4: Insert Orders
INSERT INTO Orders VALUES
(1001, '2024-01-10'),
(1002, '2024-01-15'),
(1003, '2024-01-20'),
(1004, '2024-01-25'),
(1005, '2024-01-30');

-- Step 5: Insert Order Details
INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),  -- Dell
(2, 1001, 201, 1),  -- iPhone
(3, 1002, 102, 1),  -- MacBook
(4, 1002, 301, 2),  -- Sony Headphones
(5, 1003, 202, 1),  -- Samsung
(6, 1004, 302, 1),  -- Boat
(7, 1005, 301, 1);  -- Sony

-- Step 6: Insert Returns (some items returned)
INSERT INTO Returns VALUES
(1, 2, '2024-01-18', 899.99),  -- iPhone
(2, 4, '2024-01-22', 150.00),  -- Sony Headphones (1st unit)
(3, 6, '2024-01-31', 25.00);   -- Boat

-- Step 7: Query - Return Rate by Product
SELECT 
    p.product_name,
    COUNT(r.return_id) AS returns,
    COUNT(od.order_detail_id) AS total_orders,
    ROUND((COUNT(r.return_id) / COUNT(od.order_detail_id)) * 100, 2) AS return_rate_percent
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
LEFT JOIN Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY p.product_name;

-- Step 8: Query - Return Rate by Category
SELECT 
    c.category_name,
    COUNT(r.return_id) AS returns,
    COUNT(od.order_detail_id) AS total_orders,
    ROUND((COUNT(r.return_id) / COUNT(od.order_detail_id)) * 100, 2) AS return_rate_percent
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN OrderDetails od ON p.product_id = od.product_id
LEFT JOIN Returns r ON od.order_detail_id = r.order_detail_id
GROUP BY c.category_name;
