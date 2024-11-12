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

-- 테이블 삭제 후 비교 테스트 다시 시작
drop table customers2;
drop table orders2;


##### 정규화 #####
use school;
CREATE TABLE Students (
    학생번호 INT NOT NULL,
    학생이름 VARCHAR(50) NOT NULL,
    주소 VARCHAR(50),
    학과 VARCHAR(50),
    학과사무실 VARCHAR(50),
    강좌이름 VARCHAR(50) NOT NULL,
    강의실 VARCHAR(50),
    성적 DECIMAL(2, 1)
);

INSERT INTO Students (학생번호, 학생이름, 주소, 학과, 학과사무실, 강좌이름, 강의실, 성적) VALUES
(501, '박지성', '맨체스터', '컴퓨터과', '공학관101', '데이터베이스', '공학관110', 3.5),
(401, '김연아', '서울', '체육학과', '체육관101', '데이터베이스', '공학관110', 4.0),
(402, '장미란', '강원도', '체육학과', '체육관101', '스포츠경영학', '체육관103', 3.5),
(502, '주신수', '플리블랜드', '컴퓨터과', '공학관101', '자료구조', '공학관111', 4.0),
(501, '박지성', '맨체스터', '컴퓨터과', '공학관101', '자료구조', '공학관111', 3.5);

select * from Students;

-- 삽입 이상 : 강좌이름이 not null이기 때문에 강좌이름을 넣지 않으면 insert되지 않음.
INSERT INTO Students (학생번호, 학생이름, 주소, 학과) VALUES (503, '홍길동', '부산', '컴퓨터과');
INSERT INTO Students (학생번호, 학생이름, 주소, 학과, 강좌이름) VALUES (503, '홍길동', '부산', '컴퓨터과', '');

-- 삭제 이상 : 스포츠경영학이 폐강되어서 강좌이름을 삭제하면 학생정보, 학과정보도 연쇄적으로 삭제됨.
DELETE FROM Students WHERE 강좌이름 = '스포츠경영학';	

-- 수정 이상 : 자료구조를 듣는 박지성학생이 학과를 체육학과로 변경하려고 함. 정보불일치 현상(일관성X)
update Students set 학과 = '체육학과' where 강좌이름 = '자료구조' and 학생이름 = '박지성';
select 학생번호, 학생이름, 주소, 학과 from Students where 학생이름 = '박지성';
