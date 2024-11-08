#### in, any, all 비교 ####

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

##### on delete no action test #####
set @@autocommit = 0;
CREATE TABLE customers2(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders2(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers2(customer_id)
    on delete no action
);

INSERT INTO customers2(customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

INSERT INTO orders2(order_id, customer_id, order_amount) VALUES
(1, 1, 100.00),
(2, 2, 250.00),
(3, 1, 150.00),
(4, 3, 300.00),
(5, 4, 80.00);

delete from customers2 where customer_id = 1;
delete from orders2 where customer_id = 1;
select * from customers2;
select * from orders2;

drop table customers2;
drop table orders2;
rollback;
commit;

#######################
-- 자동 커밋을 해제하여 수동 트랜잭션을 사용
SET @@autocommit = 0;

-- 부모 테이블: customers2
CREATE TABLE customers2 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- 자식 테이블: orders2 (ON DELETE NO ACTION 설정)
CREATE TABLE orders2 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers2(customer_id) 
    ON DELETE NO ACTION
);

-- 데이터 삽입
INSERT INTO customers2 (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO orders2 (order_id, customer_id, order_amount) VALUES
(1, 1, 100.00),
(2, 2, 200.00),
(3, 1, 150.00);

-- 트랜잭션 시작
BEGIN;

-- Step 1: 부모 테이블에서 customer_id = 1 삭제 시도 --> 못지움.
DELETE FROM customers2 WHERE customer_id = 1;

-- Step 2: 자식 테이블에서 customer_id = 1 삭제
DELETE FROM orders2 WHERE customer_id = 1;

-- 결과 확인
SELECT * FROM customers2;
SELECT * FROM orders2;

-- 트랜잭션 롤백
rollback;

drop table customers2;
drop table orders2;



