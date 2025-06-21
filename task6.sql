-- Step 1: Create the Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Step 2: Create the Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- Step 3: Create the OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Step 4: Insert Sample Data into Products
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 80000),
(2, 'Mouse', 500),
(3, 'Keyboard', 1000),
(4, 'Monitor', 12000);

-- Step 5: Insert Sample Data into Orders (covering all 4 quarters)
INSERT INTO Orders (order_id, order_date) VALUES
(101, '2024-01-15'),  -- Q1
(102, '2024-04-10'),  -- Q2
(103, '2024-07-05'),  -- Q3
(104, '2024-10-20');  -- Q4

-- Step 6: Insert Sample Data into OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity) VALUES
(1001, 101, 1, 2),  -- Laptop x2
(1002, 102, 2, 10), -- Mouse x10
(1003, 103, 3, 5),  -- Keyboard x5
(1004, 104, 4, 1);  -- Monitor x1

-- Step 7: Final Query to Show Revenue Per Quarter with Details
SELECT 
    QUARTER(o.order_date) AS Quarter,
    o.order_id,
    o.order_date,
    p.product_id,
    p.product_name,
    p.price,
    od.quantity,
    (p.price * od.quantity) AS revenue
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.order_id = od.order_id
JOIN 
    Products p ON od.product_id = p.product_id
ORDER BY 
    Quarter;
