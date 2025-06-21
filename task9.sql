-- STEP 1: Create Tables
DROP TABLE IF EXISTS Promotions;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY,
    discount_percent DECIMAL(5,2),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
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

-- STEP 2: Insert Sample Data

-- Products (Electronic Items)
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Smartphone', 20000),
(2, 'Laptop', 60000),
(3, 'Bluetooth Speaker', 3000),
(4, 'Smartwatch', 7000),
(5, 'Tablet', 25000);

-- Promotions (discount on some products)
INSERT INTO Promotions (promotion_id, discount_percent, product_id) VALUES
(1, 10.00, 1),  -- Smartphone
(2, 15.00, 3),  -- Bluetooth Speaker
(3, 5.00, 4);   -- Smartwatch

-- Orders
INSERT INTO Orders (order_id, order_date) VALUES
(101, '2025-06-01'),
(102, '2025-06-03'),
(103, '2025-06-05'),
(104, '2025-06-06'),
(105, '2025-06-07');

-- Order Details (Sales Data)
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity) VALUES
(1, 101, 1, 2),  -- Smartphone (with discount)
(2, 101, 2, 1),  -- Laptop (no discount)
(3, 102, 3, 5),  -- Bluetooth Speaker (with discount)
(4, 102, 4, 1),  -- Smartwatch (with discount)
(5, 103, 2, 2),  -- Laptop (no discount)
(6, 104, 5, 1),  -- Tablet (no discount)
(7, 105, 1, 1);  -- Smartphone (with discount)

-- STEP 3: Compare Sales with and without Discounts

SELECT
    CASE 
        WHEN p.promotion_id IS NOT NULL THEN 'With Discount'
        ELSE 'Without Discount'
    END AS discount_status,
    pr.product_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.quantity * pr.price) AS gross_sales_amount
FROM OrderDetails od
JOIN Products pr ON od.product_id = pr.product_id
LEFT JOIN Promotions p ON od.product_id = p.product_id
GROUP BY discount_status, pr.product_name
ORDER BY discount_status, total_units_sold DESC;
