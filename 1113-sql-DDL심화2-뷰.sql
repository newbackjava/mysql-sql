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


#### 뷰에서의 작업이 원본테이블에 영향을 미친다.
#### 단일테이블로 생성된 뷰만 가능하다.
#### 가상테이블인 view이 작업이 실제테이블에 반영된다.!

create view emp_eng as
select 	employee_id, first_name, last_name
from employees
where department_id = '1';

select * from employees;
select * from departments;
select * from emp_eng;

-- 뷰작업
-- update
update emp_eng 
set last_name = 'www'
where employee_id = 1;

select * from emp_eng;
select * from employees;

-- insert
insert into emp_eng values (10, 'jung', 'lim');
select * from employees;
select * from emp_eng;

-- delete
delete from emp_eng
where employee_id = 9;
select * from employees;
select * from emp_eng;

#### 뷰 문제풀이
## 문제1
-- 학생 정보 테이블 생성
CREATE TABLE students (
    s_id INT PRIMARY KEY,
    s_addr VARCHAR(50),
    s_tel VARCHAR(10),
    tour_id VARCHAR(10)
);

-- 투어 정보 테이블 생성
CREATE TABLE tours (
    t_id VARCHAR(10) PRIMARY KEY,
    t_location VARCHAR(50),
    t_car VARCHAR(50)
);

-- 학생 정보 데이터 삽입
INSERT INTO students (s_id, s_addr, s_tel, tour_id) VALUES 
(1, '강남구', '011', 't1'),
(2, '영등포구', '012', 't2'),
(3, '강남구', '013', 't1'),
(4, '영등포구', '014', 't2');

-- 투어 정보 데이터 삽입
INSERT INTO tours (t_id, t_location, t_car) VALUES
('t1', '부산', 'ktx'),
('t2', '제주도', '비행기');

create table t1_table as
	select t_id, t_location, t_car
	from tours
    where t_id = 't1';
    
select * from t1_table;

## 문제2
create view young_view
as
	select s_id, s_addr, t_location, t_car
    from students s 
    join tours t
    on s.tour_id = t.t_id
    where s.s_addr = '영등포구';

-- drop view young_view;
select * from young_view;
    
## 문제3
create view t1_view 
as 
		select  s_id, s_addr, s_tel, tour_id
        from students
        where tour_id = 't1';
        
select * from t1_view;

insert into t1_view values (5, '강남구', '015', 't1');
select * from students;

delete from t1_view 
where s_id = 5;
select * from t1_view;
select * from students;

update t1_view
set s_tel = '333'
where s_id = 3;
select * from students;



