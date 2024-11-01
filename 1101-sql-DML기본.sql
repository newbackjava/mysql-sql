use shop;
create table member (
    id varchar2(10),
    pw varchar2(10),
    name varchar2(10),
    tel varchar2(10)
);

insert into member values ('100', '100', 'park', '011');
insert into member values ('200', '200', 'park', '011');
insert into member values ('300', '300', 'park', '011');
update member set tel = '999' where id = '100';
update member set name = 'kim' where id = '200';
delete from member where id = '300';
select * from member;
select * from member where id = '100';
select name, tel from member where id = '100';
