use school;
create table test(
		id int primary key,
        name varchar(100),
        index name_idx (name)
);
desc test;

-- 데이터베이스 생성
CREATE DATABASE company;
USE company;

-- departments 테이블 생성
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location_id INT
);

-- employees 테이블 생성
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    job_id VARCHAR(20),
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

show tables;

-- departments 테이블에 데이터 삽입
INSERT INTO departments (department_id, department_name, location_id) VALUES
(1, 'Sales', 1700),
(2, 'Engineering', 1800),
(3, 'HR', 1700),
(4, 'Finance', 1900);

-- employees 테이블에 데이터 삽입
INSERT INTO employees (employee_id, first_name, last_name, department_id, job_id, salary) VALUES
(101, 'John', 'Doe', 1, 'Salesman', 60000),
(102, 'Jane', 'Smith', 2, 'Engineer', 80000),
(103, 'Sam', 'Brown', 1, 'Salesman', 62000),
(104, 'Sue', 'Wilson', 3, 'HR Specialist', 55000),
(105, 'Jim', 'Taylor', 2, 'Engineer', 78000),
(106, 'Amy', 'Adams', 4, 'Accountant', 70000);

## fk가 설정되어있는 경우
## 1. 테이블 생성 : fk가 없는 테이블부터(dept --> emp)
## 2. 데이터 삽입 : fk가 없는 테이블부터(dept --> emp)
## 3. 데이터 삭제 : fk가 있는 테이블부터(emp  --> dept)

select * from departments;
select * from employees;

select count(*) from departments;
select count(*) from employees;

#### 집합
select department_id from departments
union -- 중복허용X, 오름차순
select employee_id from employees;

select department_id from departments
union all -- 중복허용O
select employee_id from employees;


select * from departments;

-- dept table에서 컬럼은 location_id
-- dept_id가 2이하인 검색결과와
-- dept_id가 3인 검색결과를
-- 합해보세요.
select location_id
from departments
where department_id <= '2'
union all
select location_id
from departments
where department_id = '3';

select location_id
from departments
where department_id <= '2'
union
select location_id
from departments
where department_id = '3';

#### 조인
use shop;
SELECT * FROM bbs;

update bbs 
set writer = 'ice'
where no in (101, 103, 105, 107);

create table member(
	id varchar(250) primary key,
    pw varchar(250),
    name varchar(250),
    tel varchar(250)
);
desc member;

insert into member
values
('ice', '1234', 'ice', '5555'),
('apple', '1234', 'apple', '7777');

select * from member;

alter table bbs
add
foreign key(writer) references member(id);

desc bbs;

select no, title, writer, tel
from bbs, member
where bbs.writer = member.id;

select bbs.no, bbs.title, bbs.writer, member.tel
from bbs, member
where bbs.writer = member.id;

select no, b.title, b.writer, m.tel
from bbs b, member m
where b.writer = m.id
order by b.no;

use school;
select e.empno, e.ename, e.job, d.dname, d.deptno
from emp e, dept  d
where e.deptno = d.deptno
order by empno;




