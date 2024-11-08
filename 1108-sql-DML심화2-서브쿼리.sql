#### 서브쿼리 ####

use school;


create table departments
as select * from dept_data;

create table employees
as select * from emp_data;

select * from employees;
select * from departments;

#### 단일 행 서브쿼리 ####
#### 서브쿼리의 조건검색 결과가 한 개 행인 경우
-- 서브쿼리 먼저 실행해보자.
select deptno -- 30
from departments
where dname = 'SALES';

-- 메인쿼리를 나중에 실행해보자.
select empno, ename, deptno
from employees
where deptno = (
	select deptno -- 30
	from departments
	where dname = 'SALES'
);

#### 다중 행 서브쿼리 ####
#### 서브쿼리의 조건검색 결과가 여러 개의 행인 경우
-- 데이터 준비
update departments
set loc = 1700
where deptno in (10, 30);

update departments
set loc = 1800
where deptno in (20, 40);

select * from departments;

-- 서브쿼리 먼저 해보자.
select deptno 
from departments 
where loc = 1700;

-- 메인쿼리
select empno, ename, deptno
from employees
where deptno in (
	select deptno 
	from departments 
	where loc = 1800
);


#### 다중 열 서브쿼리 ####
select empno, ename, deptno, job
from employees
where (deptno, job) in (
	select deptno, job
    from employees
    where empno = 7369
);

select * from employees;

-- 서브쿼리
-- --> empno가 7499인 사람의 job과 mgr을 찾아서
-- 메인쿼리
-- --> 같은 job과 mgr인 사람들을 찾아보세요.!
select job, mgr -- SALESMAN, 7698
from employees
where empno = 7499;

select empno, ename, job, mgr
from employees
where (job, mgr) in (
	select job, mgr -- SALESMAN, 7698
	from employees
	where empno = 7499
);

#### 다중행 서브쿼리(ANY) ####
SELECT empno, ename, sal
FROM employees
WHERE sal = ANY ( -- 하나의 조건결과값과 만족하면 되는경우!
    SELECT sal -- 3000, 2790, 2430, 800
    FROM employees
    WHERE deptno = 20
);

#### 다중행 서브쿼리(ALL) ####
SELECT empno, ename, sal
FROM employees
WHERE sal >= ALL ( -- 모든 조건을 다 만족해야하는 경우!
    SELECT sal -- 3000, 2790, 2430, 800
    FROM employees
    WHERE deptno = 20
);

SELECT empno, sal
FROM employees
WHERE sal >= ANY (
    SELECT sal
    FROM employees
    WHERE sal >= 2750
);

SELECT empno, sal
FROM employees
WHERE sal > ALL (
    SELECT AVG(sal) -- 2175
    FROM employees
    GROUP BY deptno
);

SELECT deptno, AVG(sal)
FROM employees
GROUP BY deptno;

-- any : or성격
-- all : and성격

#### 상관서브 쿼리 ####
select empno, ename 
from employees
where sal > (
	select avg(sal)
    from employees
);

#### 스칼라(값) 서브쿼리 ####
select empno, ename, (
	select dname 
    from departments
    where deptno = employees.deptno
) as deptname 
from employees;

-- 직원 테이블에서 직원의 직원이름, 직원job, 부서위치를 검색
select ename, job, (
	select loc
    from departments d
    where d.deptno = employees.deptno
) as 부서위치
from employees;

SELECT AVG(sal)
FROM employees e2;

SELECT ename
FROM employees
WHERE EXISTS (
    SELECT 1
    FROM departments
    WHERE departments.deptno = employees.deptno
    AND loc = 1700
);

select * from departments;

-- 1. 단일행 서브쿼리 --> ACCOUNTING부서의 deptno를 조회해서
-- 해당부서의 직원이름과 급여를 검색
-- (단일 행 서브쿼리)

-- 2. loc가 1800인 부서no를 검색해서 
--    해당 부서에 속한 직원들의 이름과 부서no를 검색
--    (다중 행 서브쿼리)

-- 3.특정 직원(empno=7499)의 deptno와 job가 같은 
--   다른 직원들의 ID와 이름을 조회하세요.(다중 열 서브쿼리)

select * from employees;

-- 4. 부서에서 deptno가 10이 있으면 
--    직원테이블에서 empno와 결과라는 컬럼을 만들어 "있음"으로 출력
select empno, "있음" as "결과" from employees
where exists (select 1 from departments where deptno = 10);

select empno, "있음" as "결과" from employees
where exists (select 1 from departments where deptno = 100);

