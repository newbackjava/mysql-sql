use shop4; -- DB선택
show tables; -- table목록 프린트

SELECT * FROM shop4.member2;
insert into member2
values ('apple', '1234', 'park', '011');
insert into member2
values ('ice', '1234', null, null);
insert into member2
values ('melon', bbs'1234', null, null);
insert into member2
values (null, '1234', null, null);

-- bbs에 1, 안녕, 오늘은 월요일,  apple
-- bbs에 2, 바이, null, ice
-- bbs에 3, 하하, null, banana
insert into bbs values ('1', '안녕', '오늘은 월요일',  'apple');
insert into bbs values ('2', '바이', null,  'ice');
insert into bbs values ('3', '하하', null,  'melon');


select * from bbs;
select * from member2;

insert into bbs
values (null, '점심', '가자', 'apple');

insert into reply values (null, 1, '좋아', 'apple');
insert into reply values (null, 1, '난 별로', 'ice');
select * from reply;

insert into reply values (null, 5, '난 별로', 'ice');

show tables;
desc member2; -- 테이블의 구조
select * from member2; -- 테이블의 내용

CREATE TABLE `member2` (
  `id` varchar(50) NOT NULL,
  `pw` varchar(45) NOT NULL,
  `name` varchar(45),
  `tel` varchar(45),
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `member3` (
  `id` varchar(50) NOT NULL,
  `pw` varchar(45) NOT NULL,
  `name` varchar(45),
  `tel` varchar(45),
  PRIMARY KEY (`id`)
);

CREATE TABLE `member4` (
  `id` varchar(50) PRIMARY KEY,
  `pw` varchar(45) NOT NULL,
  `name` varchar(45),
  `tel` varchar(45)
  ) ;
  
  CREATE TABLE `bbs2` (
  `no` int PRIMARY KEY AUTO_INCREMENT ,
  `title` varchar(45),
  `content` varchar(45),
  `writer` varchar(45),
  wdate datetime,
  KEY `fk_member_id_1_idx2` (`writer`),
  CONSTRAINT `fk_member_id_2` FOREIGN KEY (`writer`) REFERENCES `member2` (`id`)
); 
-- ddl(테이블 생성, pk설정)
create table reply2(
	id int primary key auto_increment,
    oriid int not null,
    content varchar(100),
    writer varchar(100)
);

create table bbs3(
	no int primary key auto_increment,
    title varchar(100),
    content varchar(200),
    writer varchar(100),
    foreign key create table bbs3(
	no int primary key auto_increment,
    title varchar(100),
    content varchar(200),
    writer varchar(100), 
    foreign key writer references member2(id)
);
);

desc bbs3;

create table reply3(
	no int primary key auto_increment,
    oriid int not null,
    content varchar(100),
    writer varchar(100),
	foreign key(oriid) references bbs(no),
    foreign key(writer) references member2(id)
);

drop table member4;

alter table 회원정보
add post varchar(100);

desc 회원정보;

alter table 회원정보
modify post varchar(10);

alter table 회원정보
drop post;



