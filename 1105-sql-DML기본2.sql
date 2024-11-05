use shop;
select * from product3;
select * from bbs;

create database school;
use school;
SELECT * FROM dept_data;


## 나는 주석 ########################
-- 나도 주석
##### 1. 서브쿼리이용 테이블 복사
create table dept2
as select * from dept_data; -- 서브쿼리

desc dept2; ## 스키마 출력
select * from dept2; ## 인스턴스 출력

##### 2. DDL + csv 
CREATE TABLE `dept3` (
  `DEPTNO` int,
  `DNAME` text,
  `LOC` text
); 

select * from dept3;

##############################
use shop;

select * from member;

create table member3
as select * from member;

select * from member3;

insert into member3 
values (3, 3, 3, 3, '2024-11-05');

insert into member3 
values (4, 4, 4, 4, now());

insert into member3 
values (5, 5, 5, 5, now());

insert into member3 
values (6, 6, 6, 6, now(), '삼성');

insert into member3 
values (7, 7, 7, 7, now(), null); 
-- not null이므로 X

insert into 
member3(idmember, pwmember, name, tel, team)
values (7, 7, 7, 7, now()); 

select * from member3;

CREATE TABLE example1 (
    id INT AUTO_INCREMENT,
    name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

desc example1;

INSERT INTO example1 (name, created_at, updated_at) 
VALUES ('John Doe', '2022-07-01 12:34:56', '2022-07-01 12:34:56');



INSERT INTO example1(name) VALUES ('Jane Smith');

update example1
set name = '홍길동2'
where id = 2;

select * from example1;

insert into 
member3(idmember, pwmember, name, tel, team, location)
values (8, 8, 8, 8, now(), '부산'); 

insert into 
member3(idmember, pwmember, name, tel, team, location)
values (9, 9, 9, 9, now(), '대구'); 

select * from member3;


create table productOrder(
	id varchar(100) primary key,
    title varchar(100) not null,
    price int,
    buydate date,
    addr varchar(200) not null default 'home'
);

insert into productOrder values 
(100, 'hat', 1000, now(), 'office');

select * from productOrder;

insert into productOrder values 
(2, 'mouse', 2000, now(), null);

insert into productOrder(id, title, price, buydate) 
values (2, 'mouse', 2000, now());

insert into productOrder(id, title, buydate) 
values (300, 'pen', now());

update productOrder
set id = 200
where title = 'mouse';

########################################
use school;
create table dept 
as select * from dept_data;

create table emp 
as select * from emp_data;

create table salgrade 
as select * from salgrade_data;

############ select
select * from emp;
select DEPTNO from emp;
select distinct DEPTNO from emp;
select ename, sal * 12 as 연봉 from emp;

select * from emp
order by sal; 
-- sal컬럼을 기준으로 오름차순 정렬(asc생략)
select * from emp
order by sal desc; -- sal컬럼을 기준으로 오름차순 정렬
