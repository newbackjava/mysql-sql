use school;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_amount) VALUES
(1, 1, 100.00),
(2, 2, 250.00),
(3, 1, 150.00),
(4, 3, 300.00),
(5, 4, 80.00);

SELECT customer_name, customer_id
FROM customers
WHERE customer_id = ANY (
    SELECT customer_id
    FROM orders
    WHERE order_amount >= 200
);

 SELECT customer_id
    FROM orders
    WHERE order_amount >= 200;

SELECT customer_name, customer_id
FROM customers
WHERE customer_id >= ALL (
    SELECT customer_id  -- 1, 2, 3
    FROM orders
    WHERE order_amount >= 100
);


SELECT customer_id
    FROM orders
    WHERE order_amount >= 100;

SELECT customer_name, customer_id
FROM customers;


SELECT customer_name, customer_id
FROM customers
WHERE customer_id >= ALL (
    SELECT customer_id  -- 1, 2, 3
    FROM orders
    WHERE order_amount >= 100
);

SELECT customer_name, customer_id
FROM customers
WHERE customer_id IN (
    SELECT customer_id  -- 1, 3
    FROM orders
    WHERE order_amount = 150 or order_amount = 300
);


