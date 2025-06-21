-- Step 0: Drop dependent tables first
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- Step 1: Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

-- Step 2: Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- (Optional) Step 3: Create OrderDetails table if needed
-- You can ignore this part if you're not using OrderDetails here.
-- CREATE TABLE OrderDetails (
--     order_detail_id INT PRIMARY KEY,
--     order_id INT,
--     product_name VARCHAR(100),
--     quantity INT,
--     FOREIGN KEY (order_id) REFERENCES Orders(order_id)
-- );

-- Step 4: Insert sample customers
INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- Step 5: Insert sample orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(101, 1, '2025-06-01'),
(102, 1, '2025-06-10'),
(103, 2, '2025-06-05'),
(104, 3, '2025-06-02'),
(105, 3, '2025-06-07'),
(106, 3, '2025-06-15');

-- Step 6: Query repeat customers
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.customer_name
HAVING 
    COUNT(o.order_id) > 1;
