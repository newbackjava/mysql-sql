use shop2;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT
);

INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES
(1, 'John', 'Doe', 1),
(2, 'Jane', 'Smith', 2),
(3, 'Mike', 'Johnson', 1);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Marketing');

select * from departments;
select * from employees;

#### inner join
select 
	e.employee_id, e.first_name, e.last_name,
    d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

#### 뷰(view) --> emp_details
create view emp_details as
select 
	e.employee_id, e.first_name, e.last_name,
    d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

select * from emp_details; 
select count(*) from emp_details; 

#### 데이터 추가
INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES
(4, 'John', 'Doe', 1),
(5, 'Jane', 'Smith', 2),
(6, 'Mike', 'Johnson', 1);

select * from emp_details; 
select count(*) from emp_details; -- 6개로 업데이트됨.

#### 진짜 테이블복사와 view비교!
create table emp_details2 as
select 
	e.employee_id, e.first_name, e.last_name,
    d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

select * from emp_details2; 
select count(*) from emp_details2; -- 6개

INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES
(7, 'John', 'Doe', 1),
(8, 'Jane', 'Smith', 2),
(9, 'Mike', 'Johnson', 1);

select * from emp_details2; 
select count(*) from emp_details2; -- 6개로 변동이 없음.