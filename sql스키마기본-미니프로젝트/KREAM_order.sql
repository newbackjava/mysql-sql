create table users(
	user_id int primary key auto_increment,
    user_pw varchar(30) not null,
    name varchar(30) not null,
    tel varchar(30) not null,
    address varchar(30) not null
);

insert into users
values (null, '1234', 'hong', '010-1234-5678', 'SEOUL'),
	   (null, '5678', 'park', '010-5678-9123', 'SEOUL');
       

create table shoes(
	size int not null,
    product_number int primary key auto_increment not null,
    brand varchar(30) not null,
    price int not null,
    drop1 date not null
);

insert into shoes
values (280, null, 'nike', 150000, now()),
		(270, null, 'new_balance', 150000, now());

create table orderr(
	ord_id int primary key auto_increment,
    ord_pw varchar(30) not null,
    ord_number varchar(30) not null,
    ord_tel varchar(30) not null,
    ord_address varchar(30) not null
);

insert into orderr
values (null, '1234', '23456', '1234', 'seoul'),
	   (null, '1234', '23456', '1234', 'seoul');
select * from users;
select * from shoes;
select * from orderr;