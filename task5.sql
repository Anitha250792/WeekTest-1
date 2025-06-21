-- Drop the table if it already exists (optional)
DROP TABLE IF EXISTS Products;

-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT NOT NULL
);

-- Insert some electronic products with stock quantity and reorder levels
INSERT INTO Products (product_name, stock_quantity, reorder_level) VALUES
('Smartphone', 15, 10),
('Laptop', 8, 5),
('Bluetooth Speaker', 3, 5),
('Wireless Mouse', 12, 7),
('USB Charger', 4, 6),
('Smartwatch', 20, 15);

-- Query to list products below reorder level with an alert message
SELECT 
    product_id,
    product_name,
    stock_quantity,
    reorder_level,
    CASE 
        WHEN stock_quantity < reorder_level THEN '*** ALERT: Stock Low ***'
        ELSE 'Stock OK'
    END AS stock_status
FROM Products
WHERE stock_quantity < reorder_level;
