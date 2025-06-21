-- 1. Drop tables if exist to avoid errors on rerun
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;

-- 2. Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- 3. Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);

-- 4. Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 5. Insert sample data into Products
INSERT INTO Products VALUES
(1, 'Smartphone', 'Electronics'),
(2, 'Laptop', 'Electronics'),
(3, 'Headphones', 'Electronics'),
(4, 'Refrigerator', 'Home Appliances'),
(5, 'Microwave', 'Home Appliances');

-- 6. Insert sample data into Orders
INSERT INTO Orders VALUES
(101, '2025-05-15'),
(102, '2025-05-20'),
(103, '2025-06-01'),
(104, '2025-06-15'),
(105, '2025-07-05');

-- 7. Insert sample data into OrderDetails
INSERT INTO OrderDetails VALUES
(1, 101, 1, 10),  -- Smartphone, May
(2, 101, 2, 5),   -- Laptop, May
(3, 102, 3, 15),  -- Headphones, May
(4, 103, 2, 20),  -- Laptop, June
(5, 103, 4, 8),   -- Refrigerator, June
(6, 104, 3, 7),   -- Headphones, June
(7, 105, 1, 12),  -- Smartphone, July
(8, 105, 5, 10);  -- Microwave, July

-- 8. Query: Top selling products per month
WITH MonthlyProductSales AS (
    SELECT 
        DATE_FORMAT(O.order_date, '%Y-%m') AS YearMonth,
        P.product_id,
        P.product_name,
        SUM(OD.quantity) AS Total_Quantity_Sold
    FROM 
        OrderDetails OD
    JOIN 
        Orders O ON OD.order_id = O.order_id
    JOIN 
        Products P ON OD.product_id = P.product_id
    GROUP BY 
        YearMonth, P.product_id, P.product_name
)
SELECT 
    YearMonth,
    product_name,
    Total_Quantity_Sold
FROM (
    SELECT 
        *,
        RANK() OVER (PARTITION BY YearMonth ORDER BY Total_Quantity_Sold DESC) AS `rank`
    FROM 
        MonthlyProductSales
) ranked
WHERE `rank` = 1
ORDER BY YearMonth;
