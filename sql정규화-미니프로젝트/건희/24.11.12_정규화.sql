## SSG_DB/강의자료/NEW02-MySQL-4(정규화).pdf  p.36 ##
## 정영재 박헌우 신가연 김건희

create table 강좌정보 (
	강좌이름 varchar(50) not null primary key,
    강의실 varchar(50)
);

create table 학과정보 (
	학과 varchar(50) not null primary key,
    학과사무실 varchar(50)
);

CREATE TABLE 학생 (
    학생번호 int not null primary key,
    학생이름 VARCHAR(50) NOT NULL,
    주소 VARCHAR(50),
    학과 VARCHAR(50),
    foreign key (학과) references 학과정보(학과)
);
create table 성적정보 (
	학생번호 int not null,
    강좌이름 varchar(50) not null,
	성적 decimal(2, 1),
    primary key(학생번호, 강좌이름),
    foreign key (학생번호) references 학생(학생번호),
    foreign key (강좌이름) references 강좌정보(강좌이름)
);

-- 강좌정보 테이블에 데이터 삽입
INSERT INTO 강좌정보 (강좌이름, 강의실) VALUES
('프로그래밍 기초', '101호'),
('자료구조', '102호'),
('알고리즘', '103호');

-- 학과정보 테이블에 데이터 삽입
INSERT INTO 학과정보 (학과, 학과사무실) VALUES
('컴퓨터공학과', '201호'),
('전자공학과', '202호'),
('수학과', '203호');

-- 학생 테이블에 데이터 삽입
INSERT INTO 학생 (학생번호, 학생이름, 주소, 학과) VALUES
(1, '김철수', '서울시 강남구', '컴퓨터공학과'),
(2, '이영희', '서울시 서초구', '전자공학과'),
(3, '박민수', '서울시 관악구', '수학과');

-- 성적정보 테이블에 데이터 삽입
INSERT INTO 성적정보 (학생번호, 강좌이름, 성적) VALUES
(1, '프로그래밍 기초', 4.0),
(2, '자료구조', 3.5),
(3, '알고리즘', 3.0),
(1, '자료구조', 3.8),
(2, '알고리즘', 2.9);

-- 강좌정보 테이블에 샘플 데이터 삽입
INSERT INTO 강좌정보 (강좌이름, 강의실) VALUES
('데이터베이스', '104호');

-- 학과정보 테이블에 샘플 데이터 삽입
INSERT INTO 학과정보 (학과, 학과사무실) VALUES
('정보통신공학과', '204호');

-- 학생 테이블에 샘플 데이터 삽입
INSERT INTO 학생 (학생번호, 학생이름, 주소, 학과) VALUES
(4, '최지원', '서울시 동작구', '정보통신공학과');

-- 성적정보 테이블에 샘플 데이터 삽입
INSERT INTO 성적정보 (학생번호, 강좌이름, 성적) VALUES
(4, '데이터베이스', 3.7);

-- 학생이 성적정보에 참조되고 있는지 확인하고 학생 테이블에서 데이터를 삭제
DELETE FROM 학생 WHERE 학생번호 = 4; -- 이 경우, 성적정보 테이블에 학생번호=4가 있어 참조 무결성 오류가 발생합니다.

-- 성적정보의 참조를 먼저 삭제한 후 학생을 삭제
DELETE FROM 성적정보 WHERE 학생번호 = 4;
DELETE FROM 학생 WHERE 학생번호 = 4;

-- 학생번호를 참조하는 성적정보 테이블에서 데이터를 업데이트
UPDATE 성적정보 SET 학생번호 = 5 WHERE 학생번호 = 4; -- 학생번호=5가 학생 테이블에 존재하지 않으면 오류 발생

