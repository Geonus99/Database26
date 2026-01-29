# LMS에 대한 테이블을 생성 하고 더미데이터 입력(CRUD)

SHOW DATABASES; # LMS만 보인다.

USE LMS; # LMS 데이터베이스를 사용하겠다.

create table members ( # members테이블 생성
# 필드명 타입 옵션
id int auto_increment primary key,
# 정수 자동번호생성기check	기본키 (다른 테이블과 연결용)
uid varchar(50) not null unique,
#	가변문자(50자) 공백비허용 유일한값
password varchar(255) not null,
name varchar(50) not null,
role enum('admin','manager','user') default 'user',
#	 열거타입(괄호안에 글자만 허용)			기본값 user
active boolean default true,
#	   불린타입   기본값  ture
create_at datetime default current_timestamp
#  생성일   날짜시간타입     기본값 시스템시간
);

# 더미데이터 입력
insert into members (uid, password, name, role, active) values ('kkw','1234','김기원','admin',true);
insert into members (uid, password, name, role, active) values ('lhj','5678','임효정','manager',true);
insert into members (uid, password, name, role, active) values ('kdg','1111','김도균','user',true);
insert into members (uid, password, name, active) values ('ksb','2222','김수빈',true);
insert into members (uid, password, name) values ('kjy','3333','김지영');
insert into members (uid, password, name, active) values ('agw', '4444', '안건우', false);

# 더미데이터 출력
select * from members; # 전체 출력

# 로그인 할 때
select * from members where uid='kkw' and password='1234' and active = true;

# 더미데이터 수정
update members set password = '1111' where uid = 'kkw';

# 회원 삭제 , 활성화, 비활성화
delete from members where uid = 'kkw';
update members set active = false where uid = 'kkw';
update members set active = true where uid = 'kkw';