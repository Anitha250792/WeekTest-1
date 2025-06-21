-- Drop tables if exist (for clean rerun)
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- 1. Create Customers table with region and city columns
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    city VARCHAR(50)
);

-- 2. Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- 3. Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 4. Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample customers from four different cities and regions
INSERT INTO Customers (customer_name, region, city) VALUES
('Anitha', 'North', 'Chennai'),
('Saravanan', 'North', 'Madurai'),
('Nila', 'South', 'Tiruchy'),
('Niranjan', 'South', 'Tanjavore');

-- Insert sample products
INSERT INTO Products (product_name, price) VALUES
('Product A', 100.00),
('Product B', 200.00),
('Product C', 150.00);

-- Insert sample orders
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2025-01-10'),
(2, '2025-01-12'),
(3, '2025-01-13'),
(4, '2025-01-14');

-- Insert sample order details (order items with quantities)
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2), -- Alice ordered 2 of Product A
(1, 2, 1), -- Alice ordered 1 of Product B
(2, 2, 3), -- Bob ordered 3 of Product B
(3, 3, 1), -- Charlie ordered 1 of Product C
(4, 1, 5); -- Diana ordered 5 of Product A

-- Query: Calculate total sales amount by region and city
SELECT 
    c.region,
    c.city,
    SUM(od.quantity * p.price) AS total_sales_amount
FROM 
    Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
GROUP BY 
    c.region,
    c.city
ORDER BY 
    c.region,
    c.city;
