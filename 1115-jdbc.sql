use shop2;
CREATE TABLE `member` (
  `id` varchar(250) NOT NULL,
  `pw` varchar(250) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `tel` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

SELECT * FROM shop2.member;

select * from member 
where id  = 'ice';

select * from dept;

-- id, pw가 동일해야 로그인성공!
-- 1. id를 주고 검색을 해서 pw를 찾아온후 
--    자바에서 pw가 동일한지 체크 --> 입력pw 1234 == db검색pw 1234
--    로그인 성공
select pw from member where id = 'ice'; -- > db처리
-- 입력pw 1234 == db검색pw 1234 --> 자바처리 권장X

-- 2. id, pw둘다 넣어서 db에서 검색해서 id가 있으면 로그인 성공
select id from member where id = 'ice' and pw = '1234';
-- db에서 처리할 수 있으면 다 처리해서 자바로 결과만 받아오는 것이 좋음.

-- 3. id, pw둘다 넣어서 db에서 검색해서 몇 개있는지 세어서 1이면 로그인 성공
select count(id) from member where id = 'ice' and pw = '1234';
select 1 from member where id = 'ice' and pw = '12345'; -- 1 X
select 1 from member where id = 'ice' and pw = '1234'; -- 1 O



