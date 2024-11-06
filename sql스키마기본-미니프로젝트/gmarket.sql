사이트 선정
G마켓

테이블로 저장할 대상(3개 이상)

엔티티 추측 : 상품, 회원, 장바구니, 포인트, 리뷰, 쿠폰, 할인, 
엔티티 관계 추측 : 주문하다, 주문내역, 포인트적립, 리뷰작성, 할인조건, 

테이블의 스키마 정의 : 컬럼수 한 테이블당 5개 이상)
엔티티, 관계 → 테이블명, 컬럼명, 제약조건 정의
제약조건(데이터타입 + pk ,fk, unique 등등)
pk는 2개 이상, autoincrement기능 2개 이상, fk는 한 개 이상)
DDL로 테이블을 생성
각 테이블 당 레코드 2개 이상씩 넣어서 유효성 검증
DML은 insert은 여러개, update, delete는 각 1개 이상, select는 3개 이상

create schema g_market;

use g_market;

create table product(
	product_code int unique,
    product_id int auto_increment primary key,
    product_name varchar(50),
    product_price int,
    product_sale int
);

insert product(product_code, product_name, product_price, product_sale)
values(100, "베베숲 프라임 아기물티슈", 29850, 53);
insert product(product_code, product_name, product_price, product_sale)
values(200, "하림 무항생제 닭", 7190, 31);
insert product(product_code, product_name, product_price, product_sale)
values(300, "유한락스 욕실청소용", 9900, 14);

create table users(
    user_id varchar(50) primary key,
    user_pw varchar(50) not null,
    user_name varchar(50) not null,
    user_addr varchar(100) not null,
    user_tel varchar(50) not null,
    user_year int,
    user_rank int not null
);
insert users(user_id, user_pw, user_name, user_addr, user_tel, user_year, user_rank)
values("abc", "ABC", "Kim", "삼성동", "010", 1999, 2);
insert users(user_id, user_pw, user_name, user_addr, user_tel, user_year, user_rank)
values("def", "DEF", "Park", "대치동", "011", 1998, 1);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_user_id VARCHAR(50),
    cart_product_id int,
    cart_product_name VARCHAR(50),
    cart_count INT,
    cart_sum INT,
    cart_price INT,
    FOREIGN KEY (cart_user_id)
        REFERENCES users (user_id),
    FOREIGN KEY (cart_product_id)
        REFERENCES product (product_code)
);

insert cart(cart_user_id, cart_product_name, cart_product_id, cart_price)
values("abc", "베베숲 프라임 아기물티슈", 100, 29850);
insert cart(cart_user_id, cart_product_name, cart_product_id, cart_price)
values("abc", "하림 무항생제 닭", 200, 7190);
insert cart(cart_user_id, cart_product_name, cart_product_id, cart_price)
values("def", "유한락스 욕실청소용", 300, 9900);

select * from cart;