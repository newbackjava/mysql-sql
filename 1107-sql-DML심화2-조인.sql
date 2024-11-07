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
where e.deptno = d.deptno and empno > 7400
order by empno;


select e.empno, e.ename, e.job, d.dname, d.deptno
from emp e
join dept d
    on e.deptno = d.deptno
where empno > 7400
order by empno;


select e.empno, e.ename, e.job, d.dname, d.deptno
from emp e
join dept d
on e.deptno = d.deptno -- 조인 기준 조건 on뒤에 써줌!
where empno > 7400 -- 부가적인 조건
order by empno;

-- use shop;
-- 1. 
-- member의 id와 bbs의 writer는 데이터타입과 도메인이 동일
-- 이것을 기준으로 내부조인(inner join)해보세요.
-- 조인 결과는 다음 순서대로 나와야함.
-- member의 id, name, bbs의 no, title, content
-- ==> 2가지 방법으로 조인해보세요.!
-- ==> bbs에 글을 쓰지 않은 사람은 결과에 나타나지 않음.
-- 2. 위 1번에 bbs no가 105보다 큰 것만 내부조인해서 출력
-- 3. 2번까지 한 결과에 bbs의 title로 내림차순 정렬

use shop;
select m.id, m.name, b.no, b.title, b.content
from member m, bbs b
where m.id = b.writer; 

select m.id, m.name, b.no, b.title, b.content
from member m
join bbs b
on m.id = b.writer;

select m.id, m.name, b.no, b.title, b.content
from member m
join bbs b
on m.id = b.writer
where b.no > 105;

select m.id, m.name, b.no, b.title, b.content
from member m
join bbs b
on m.id = b.writer
where b.no > 105
order by b.title desc;

#### outerjoin(외부조인, 아우터조인)
select b.*, m.name
from bbs b
left join member m
on b.writer = m.id;

select b.no, m.*
from bbs b
right join member m
on b.writer = m.id;