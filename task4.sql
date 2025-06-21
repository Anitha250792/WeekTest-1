SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS CartItems;
DROP TABLE IF EXISTS Carts;
DROP TABLE IF EXISTS Customers;

SET FOREIGN_KEY_CHECKS = 1;


-- 2. Create tables

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE Carts (
    cart_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    created_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE CartItems (
    cart_item_id INT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    cart_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id)
);

-- 3. Insert sample customers
INSERT INTO Customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- 4. Insert sample carts
INSERT INTO Carts VALUES
(101, 1, '2025-06-15'),
(102, 2, '2025-06-15'),
(103, 3, '2025-06-16'),
(104, 1, '2025-06-16');

-- 5. Insert cart items (groceries)
INSERT INTO CartItems VALUES
(1, 101, 'Milk', 2),
(2, 101, 'Bread', 1),
(3, 102, 'Eggs', 12),
(4, 103, 'Apples', 6),
(5, 103, 'Bananas', 5),
(6, 104, 'Orange Juice', 1);

-- 6. Insert orders (checkout carts)
-- Only carts 101 and 103 were checked out
INSERT INTO Orders VALUES
(1001, 101, '2025-06-15'),
(1002, 103, '2025-06-16');

-- 7. Cart Abandonment Rate Report (daily)
SELECT
    c.created_date AS cart_date,
    COUNT(c.cart_id) AS total_carts,
    COUNT(o.order_id) AS checked_out_carts,
    COUNT(c.cart_id) - COUNT(o.order_id) AS abandoned_carts,
    ROUND(100.0 * (COUNT(c.cart_id) - COUNT(o.order_id)) / COUNT(c.cart_id), 2) AS abandonment_rate_percent
FROM
    Carts c
    LEFT JOIN Orders o ON c.cart_id = o.cart_id
GROUP BY
    c.created_date
ORDER BY
    c.created_date;
