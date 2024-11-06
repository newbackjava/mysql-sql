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

#### 집계/그룹함수 ####
select count(empno) from emp;

select count(empno), sum(sal), avg(sal), max(sal), min(sal)
from emp;

select deptno, avg(sal), max(sal), min(sal)
from emp
group by deptno;

select deptno, avg(sal), max(sal), min(sal)
from emp
group by deptno
order by deptno desc;

-- job을 기준으로 그룹으로 묶어서 월급평균, 월급최대를 구해보세요.
-- 정렬은 job의 오름차순으로!
-- 출력은 job, 평균, 최대 순으로!
select job, avg(sal), max(sal)
from emp
group by job
order by job asc; -- asc는 생략 가능

SELECT job, count(SAL), sum(SAL), round(AVG(sal)), 
       MIN(SAL), MAX(SAL)
FROM EMP
GROUP BY JOB
HAVING COUNT(SAL) >= 4
ORDER BY JOB DESC;

SELECT job, count(SAL), sum(SAL), round(AVG(sal)), 
       MIN(SAL), MAX(SAL)
FROM EMP
GROUP BY JOB
HAVING max(sal) > 2500
ORDER BY JOB DESC;

SELECT job, count(SAL), sum(SAL), round(AVG(sal)), 
       MIN(SAL), MAX(SAL)
FROM EMP
GROUP BY JOB
HAVING job in ('MANAGER','CLERK')
ORDER BY JOB DESC;

SELECT job, count(SAL), sum(SAL), round(AVG(sal)), 
       MIN(SAL), MAX(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB DESC;

SELECT job, count(SAL) as c, sum(SAL) as s, round(AVG(sal)) as r, 
       MIN(SAL), MAX(SAL)
FROM EMP
where job in ('MANAGER', 'CLERK', 'SALESMAN')
GROUP BY job
HAVING c > 3

ORDER BY JOB DESC;

select a, b, 
	(
		select id from m 
		where name = 'p'
	) as c
from m;

#### 대용량 데이터 ####
CREATE DATABASE moviedb;

USE moviedb;
CREATE TABLE movietbl
(
    movie_id INT,
    movie_title VARCHAR(30),
    movie_director VARCHAR(20),
    movie_star VARCHAR(20),
    movie_script LONGTEXT,
    movie_film LONGBLOB
) DEFAULT CHARSET=utf8mb4;

select * from movietbl;

INSERT INTO movietbl VALUES ( 1, '쉰들러 리스트', '스필버그', '리암 니슨',
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/math.txt'), 
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/img1.jpg')
);

SELECT * FROM movietbl;

SELECT movie_script FROM movietbl WHERE movie_id=1
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/math_out.txt'
LINES TERMINATED BY '\n';

SELECT movie_film FROM movietbl WHERE movie_id=3
INTO DUMPFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/img1_out.jpg';


CREATE TABLE movietbl2
(
    movie_id INT,
    movie_title VARCHAR(30),
    movie_director VARCHAR(20),
    movie_star VARCHAR(20),
    movie_script text,
    movie_film text
) DEFAULT CHARSET=utf8mb4;

INSERT INTO movietbl2 VALUES ( 1, '쉰들러 리스트', '스필버그', '리암 니슨',
	'https://drive.google.com/file/d/1KWwP3F0cOW2DEn6ENXjzX3JBXd41zB8p/view',
    'https://drive.google.com/file/d/1utHCRUzrCwelEs2GZTXMaAiJioI8-6DO/view?usp=drive_link'
);

select * from movietbl2;

#### 문제풀이(심화) ####
CREATE TABLE Youth (
    YouthID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    City VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Activities (
    ActivityID INT AUTO_INCREMENT PRIMARY KEY,
    ActivityName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE YouthActivities (
    YouthActivityID INT AUTO_INCREMENT PRIMARY KEY,
    YouthID INT NOT NULL,
    ActivityID INT NOT NULL,
    ParticipationDate DATE NOT NULL,
    FOREIGN KEY (YouthID) REFERENCES Youth(YouthID),
    FOREIGN KEY (ActivityID) REFERENCES Activities(ActivityID)
);

INSERT INTO Youth (Name, BirthDate, Gender, City, Phone, Email) VALUES
('kimchulsoo', '2003-05-21', 'Male', '서울', '010-1234-5678', 'chulsoo@example.com'),
('leeyounghi', '2004-07-30', 'Female', '부산', '010-8765-4321', 'younghi@example.com'),
('parkgimin', '2005-02-15', 'Other', '대구', '010-1357-2468', 'jimin@example.com'),
('choiyoori', '2002-10-11', 'Female', '인천', '010-2468-1357', 'yuri@example.com'),
('jangmiho', '2001-12-25', 'Male', '광주', '010-5678-1234', 'minho@example.com');

INSERT INTO Activities (ActivityName, Description) VALUES
('socker', '팀 스포츠의 하나로, 11명이 한 팀을 이루어 공을 차서 상대방의 골대에 넣는 게임'),
('music', '다양한 악기와 목소리를 사용하여 조화로운 소리를 만드는 예술 활동'),
('volunteering', '지역 사회 봉사를 통해 사회에 기여하는 활동'),
('programming', '컴퓨터 소프트웨어를 개발하는 과정'),
('art', '그림, 조각 등 시각적 예술을 통해 창의적 표현을 하는 활동');

INSERT INTO YouthActivities (YouthID, ActivityID, ParticipationDate) VALUES
(1, 1, '2024-01-20'),
(2, 2, '2024-02-15'),
(3, 3, '2024-03-10'),
(4, 4, '2024-04-05'),
(5, 5, '2024-05-01');


SELECT Name, CHAR_LENGTH(Name) AS NameLength FROM Youth;
SELECT UPPER(ActivityName) AS UppercaseActivityName FROM Activities;
SELECT Email, SUBSTRING_INDEX(Email, '@', -1) AS EmailDomain FROM Youth;
SELECT CONCAT(UPPER(LEFT(Name, 1)), SUBSTRING(Name, 2)) AS ProperName FROM Youth;
SELECT Description, LOCATE('활동', Description) AS Position FROM Activities;
SELECT YouthID, COUNT(*) AS NumberOfActivities 
FROM YouthActivities 
GROUP BY YouthID;
SELECT ActivityID, COUNT(*) AS ParticipationCount 
FROM YouthActivities 
GROUP BY ActivityID;

SELECT Name, DATEDIFF(CURDATE(), BirthDate) AS DaysSinceBirth 
FROM Youth;
SELECT MAX(ParticipationDate) AS MostRecentParticipation 
FROM YouthActivities;
SELECT 
	YEAR(ParticipationDate) AS Year, 
	MONTH(ParticipationDate) AS Month, 
	COUNT(*) AS ParticipationCount
FROM YouthActivities
GROUP BY Year, Month;

SELECT Name, 
	CASE 
		WHEN Gender = 'Male' THEN '안녕하세요,  반가워요!'
		WHEN Gender = 'Female' THEN '안녕하세요, 즐거운 월요일!'
		ELSE '안녕하세요!' 
	END AS Greeting
FROM Youth;
SELECT ActivityID, COUNT(DISTINCT YouthID) AS ParticipantCount 
FROM YouthActivities 
GROUP BY ActivityID;
SELECT ActivityID, MIN(ParticipationDate) AS FirstParticipation
FROM YouthActivities 
GROUP BY ActivityID;

delete from YouthActivities;
delete from Activities;
delete from Youth;



