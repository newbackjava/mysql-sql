* 사이트 선정
아고다(숙소)

* 테이블로 저장할 대상
- 엔티티 : 회원, 숙소, 예약정보
- 엔티티 관계 추측 : 회원(member_no) - 예약정보(member_no), 숙소(room_no) - 예약정보(room_no)

** 회원(member)
member_no : int, primary key, auto increment
member_name : varchar(45), not null
member_id : varchar(45), not null, unique
member_pw : varchar(45), not null
member_gender : tinyint
member_age : int, not null
member_tel : varchar(45), not null

** 숙소(room)
room_no : int, primary key, auto increment
room_name : varchar(45), not null
building_name : varchar(45), not null
region : varchar(45), not null
restriction : bool, not null
price : int, not null

** 예약정보(reservation)
reserve_no : int, primary key, auto increament
member_no : int, 외래키 설정하기
room_no : int, 외래키 설정하기
reserve_start_date : date, not null
reserve_end_date : date, not null
reserve_persons : int