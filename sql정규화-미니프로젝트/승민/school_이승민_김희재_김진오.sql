create database school2;

use school2;

-- ==============================
-- 테이블 생성
-- ==============================

-- 1. subjects 테이블 생성
CREATE TABLE subjects (
    subject_name VARCHAR(250) PRIMARY KEY,  -- 과목명 (기본 키)
    office VARCHAR(250) NOT NULL            -- 사무실 위치 (NOT NULL)
);

-- 2. students 테이블 생성
CREATE TABLE students (
    student_idx INT PRIMARY KEY AUTO_INCREMENT,  -- 학생 인덱스 (기본 키, 자동 증가)
    student_name VARCHAR(250) NOT NULL,          -- 학생 이름 (NOT NULL)
    address VARCHAR(250),                        -- 주소
    subject_name VARCHAR(250) NOT NULL,          -- 전공 과목명 (NOT NULL)
    FOREIGN KEY (subject_name) REFERENCES subjects(subject_name)  -- 외래 키 (subjects 테이블 참조)
);

-- 3. lecture_info 테이블 생성
CREATE TABLE lecture_info (
    lecture_name VARCHAR(250) PRIMARY KEY,  -- 강의명 (기본 키)
    room VARCHAR(250) NOT NULL              -- 강의실 위치 (NOT NULL)
);

-- 4. grade_info 테이블 생성
CREATE TABLE grade_info (
    student_idx INT NOT NULL,                  -- 학생 인덱스 (NOT NULL)
    lecture_name VARCHAR(250) NOT NULL,        -- 강의명 (NOT NULL)
    grade INT,                                 -- 성적
    PRIMARY KEY (student_idx, lecture_name),   -- 복합 기본 키 (학생 인덱스, 강의명)
    FOREIGN KEY (student_idx) REFERENCES students(student_idx),        -- 외래 키 (students 테이블 참조)
    FOREIGN KEY (lecture_name) REFERENCES lecture_info(lecture_name)   -- 외래 키 (lecture_info 테이블 참조)
);

-- ==============================
-- 데이터 삽입
-- ==============================

-- 1. subjects 테이블에 데이터 삽입
INSERT INTO subjects (subject_name, office) VALUES
('데이터베이스', '공학관 101호'),
('과학', '과학관 202호'),
('예술', '예술관 303호');

-- 2. students 테이블에 데이터 삽입
INSERT INTO students (student_name, address, subject_name) VALUES
('김아름', '서울시 강남구', '데이터베이스'),
('이민호', '부산시 해운대구', '과학'),
('박철수', '인천시 연수구', '데이터베이스'),
('최영희', '대구시 수성구', '예술');

-- 3. lecture_info 테이블에 데이터 삽입
INSERT INTO lecture_info (lecture_name, room) VALUES
('미적분학', '강의실 A'),
('물리학', '강의실 B'),
('예술사', '강의실 C');

-- 4. grade_info 테이블에 데이터 삽입
INSERT INTO grade_info (student_idx, lecture_name, grade) VALUES
(1, '미적분학', 95),
(2, '물리학', 88),
(3, '미적분학', 76),
(4, '예술사', 90),
(1, '물리학', 82),
(2, '미적분학', 91);

-- ==============================
-- 데이터 조회 (SELECT 쿼리)
-- ==============================

-- 1. 학생 정보와 전공 과목의 사무실 위치를 조회합니다.
SELECT s.student_idx, s.student_name, s.address, sub.office
FROM students s
JOIN subjects sub ON s.subject_name = sub.subject_name;

-- 2. 학생별 수강 강의와 성적을 조회합니다.
SELECT s.student_idx, s.student_name, l.lecture_name, g.grade
FROM students s
JOIN grade_info g ON s.student_idx = g.student_idx
JOIN lecture_info l ON g.lecture_name = l.lecture_name;

-- 3. 학생의 전공 사무실, 수강 강의, 성적 정보를 조회합니다.
SELECT s.student_idx, s.student_name, sub.office AS major_office, l.lecture_name, g.grade
FROM students s
JOIN subjects sub ON s.subject_name = sub.subject_name
JOIN grade_info g ON s.student_idx = g.student_idx
JOIN lecture_info l ON g.lecture_name = l.lecture_name;

-- 4. '미적분학' 강의를 수강한 학생들의 정보와 성적을 조회합니다.
SELECT s.student_idx, s.student_name, g.grade
FROM students s
JOIN grade_info g ON s.student_idx = g.student_idx
WHERE g.lecture_name = '미적분학';

-- 5. 성적이 90점 이상인 학생들의 정보와 해당 강의명을 조회합니다.
SELECT s.student_idx, s.student_name, l.lecture_name, g.grade
FROM students s
JOIN grade_info g ON s.student_idx = g.student_idx
JOIN lecture_info l ON g.lecture_name = l.lecture_name
WHERE g.grade >= 90;

-- 6. 학생별 평균 성적을 계산하여 조회합니다.
SELECT s.student_idx, s.student_name, AVG(g.grade) AS average_grade
FROM students s
JOIN grade_info g ON s.student_idx = g.student_idx
GROUP BY s.student_idx, s.student_name;

-- 7. 강의별 평균 성적을 계산하여 조회합니다.
SELECT l.lecture_name, AVG(g.grade) AS average_grade
FROM lecture_info l
JOIN grade_info g ON l.lecture_name = g.lecture_name
GROUP BY l.lecture_name;

-- 8. 전공별 학생 수를 계산하여 조회합니다.
SELECT sub.subject_name, sub.office, COUNT(s.student_idx) AS student_count
FROM subjects sub
LEFT JOIN students s ON sub.subject_name = s.subject_name
GROUP BY sub.subject_name, sub.office;

-- 9. 학생의 전공 사무실, 수강 강의, 강의실, 성적 정보를 조회합니다.
SELECT s.student_name, sub.office AS major_office, l.lecture_name, l.room AS lecture_room, g.grade
FROM students s
JOIN subjects sub ON s.subject_name = sub.subject_name
JOIN grade_info g ON s.student_idx = g.student_idx
JOIN lecture_info l ON g.lecture_name = l.lecture_name;

-- 10. 학생의 상세 정보를 모두 조회합니다.
SELECT s.student_idx, s.student_name, s.address, sub.office AS major_office, l.lecture_name, l.room AS lecture_room, g.grade
FROM students s
LEFT JOIN subjects sub ON s.subject_name = sub.subject_name
LEFT JOIN grade_info g ON s.student_idx = g.student_idx
LEFT JOIN lecture_info l ON g.lecture_name = l.lecture_name;

-- ==============================
-- 데이터 삭제 및 갱신
-- ==============================

-- 학생의 성적 정보를 모두 삭제합니다.
DELETE FROM grade_info WHERE student_idx = 1;

-- 학생 정보를 삭제합니다.
DELETE FROM students WHERE student_idx = 1;

-- '물리학' 강의의 강의실 정보를 변경합니다.
UPDATE lecture_info SET room = '강의실 D' WHERE lecture_name = '물리학';

