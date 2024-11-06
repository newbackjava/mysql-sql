use school;
show tables;
create table dept
as select * from dept_data;
select * from dept;

create table emp
as select * from emp_data;
select * from emp;

SELECT YEAR(CURDATE());
SELECT YEAR(now());

SELECT HOUR(CURTIME());
update emp
set comm = null
where comm = "";

SELECT DATE(NOW());


#### 문자함수 ####
select * from emp; -- 전체 검색
select lower(ename) from emp; -- ename을 소문자로 해서 검색
select length(ename) from emp; -- ename 글자수(바이트수)
select substr(ename, 2) from emp; -- ename의 2번째글자부터 끝까지 추출
select substr(ename, 1, 2) from emp; -- ename의 1번째글자부터 2개 추출
select substr(ename, -2) from emp; -- ename의 -2번째글자부터 끝까지 추출
select replace(ename, 'L', 'N') from emp; -- ename에서 L을 찾아 N으로 모두 대체

select concat('번호는 ', empno, ' 이름은 ', ename) as 문자열결합 from emp; -- 다 붙여서 검색
select trim(' hong '); -- 공백제거
select trim('W' from 'WILL') as w제거;

#### 숫자/날짜/자료형 변환 함수 ####
select round(1234.567, 1); -- 소숫점 1번째까지 반올림하세요.
select round(1234.567, 0); -- 정수 1의자리까지 반올림하세요.
select round(1234.567, -1); -- 정수 2의자리까지 반올림하세요.
select truncate(1234.567, 1); -- 소숫점 1의자리까지 남기고 잘라라.
select adddate('2024-09-23', interval 6 month); -- 6개월 이후 날짜
select timestampdiff(DAY, '2024-09-23', now()); -- 일 차이
select now(); -- 날짜 출력
select date_format(now(), '%Y년 %m%d %H%i%s'); -- 포맷팅 날짜 출력
select year(now());
select hour(now());
select date(now());
select time(now());
select curdate() as 날짜, curtime() as 시간, sysdate() as 날짜시간;

#### null 처리 ####
update emp
set comm = 0
where comm is null;

select comm from emp
where comm is null;

select count(comm) from emp
where comm = 0; -- 10명

select empno, ename, job, sal, 
	case job
		when 'MANAGER' then sal * 1.1
        when 'SALESMAN' then sal * 1.05
        when 'ANALYST' then sal
        else sal * 1.03
	end as upsal
from emp;

select empno, ename, comm, 
	-- 처리후에 마지막에 comm_text라는 컬럼에 값을 넣어줘.
    case
		when comm is null then '해당사항없음'
        when comm = 0 then '수당없음'
        when comm > 0 then concat('수당: ', comm)
	end as comm_text
from emp;



SELECT EMPNO, ENAME, JOB, SAL,
    IF(JOB = 'MANAGER', SAL * 1.1,
        IF(JOB = 'SALESMAN', SAL * 1.05,
            IF(JOB = 'ANALYST', SAL, SAL * 1.03)
        )
    ) AS U_SAL
FROM EMP;



