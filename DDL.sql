select @@hostname;

-- 이　창은　메모장처럼　사용됨
-- 스크립트를 1줄씩 실행하는것이 기본임(ctrl + enter)
-- 만약 더미데이터를 20개 입력한다!! (블럭설정 ctrl + shift + enter) 
use sakila; -- sakila 데이터베이스에 가서 사용할게 
select * from actor; -- actor 테이블에 모든 값을 가져와 

use world; -- wrold 데이터베이스에 가서 사용할게 
select * from city; -- city 테이블에 모든 값을 가져와

-- 데이터베이스 생성, 삭제
create database DoitSQL;
drop database doitsql;
-- 데이터베이스 생성 후 지정
create database doitsql;
use doitsql;
-- 테이블 생성, 삭제
create table doit_create_table(
col_1 int,
col_2 varchar(50),
col_3 datetime
);
drop table doit_create_table;
-- 테이블 생성 후 값 입력
create table doit_dml(
col_1 int,
col_2 varchar(50),
col_3 datetime
);
select * from doit_dml; -- 조회용
insert into doit_dml (col_1, col_2, col_3) values (1, 'DoItSQL', '2023-01-01');
insert into doit_dml(col_1) values ('문자 입력');
insert into doit_dml values (2, '열 이름 생략', '2023-01-02');
insert into doit_dml values(3, 'col_3 값 생략');
insert into doit_dml(col_1, col_2) values (3, 'col_3 값 생략');
insert into doit_dml(col_1, col_3, col_2) values (4, '2023-01-03', '열 순서 변경');
insert into doit_dml(col_1, col_2, col_3)
values (5, '데이터 입력5', '2023-01-03'), (6, '데이터 입력6', '2023-01-03'), (7, '데이터 입력7', '2023-03-01');

-- null 허용하지 않는 조건을 가진 테이블 테스트
create table doit_notnull(
col_1 int,
col_2 varchar(50) not null
);
insert into doit_notnull (col_1) values (1);
drop table doit_notnull;

-- update로 값 수정, where로 대상 지정
update doit_dml set col_2 = '데이터 수정'
where col_1 = 5;

-- 안전모드 해제(0), 활성화(1)
set SQL_SAFE_UPDATES=0;
set SQL_SAFE_UPDATES=1;
select * from doit_dml;

-- update로 하나가 아닌 다수의 값 변경 가능
update doit_dml set col_1 = col_1 + 10;

delete from doit_dml where col_1 =15;
delete from doit_dml;
select * from doit_dml;
-- 테이블 데이터 전체 빠르게 제거
truncate table doit_dml;
select * from doit_dml;

-- sql 기본 문법
use sakila;
select first_name from customer;
select first_name, last_name from customer;
select * from customer;

-- 컬럼 조회
show columns from sakila.customer;
-- where 조건 데이터 검색 비교 연산자 사용(숫자에만 권장, 문자열은 기준에 따라 달라질 수 있음)
select * from customer where first_name = 'MARIA';

select * from customer where address_id = 200;
select * from customer where address_id < 200;

select * from customer where first_name = 'MARIA';
select * from customer where first_name < 'MARIA';

select * from payment where payment_date = '2005-07-09 13:24:07';
select * from payment where payment_date < '2005-07-09';

-- 정확한 날짜형 데이터를 조건값으로 사용하려면 초까지 고려해야함
select* from payment where payment_date = '2005-07-08 07:33:56';

-- 논리연산자를 사용하여 다향한 조건으로 데이터 조회 가능
select * from customer where address_id between 5 and 10;
select * from payment where payment_date between '2005-06-17' and '2005-07-19';
-- and
select * from customer
where first_name between 'M' and 'O';
-- not
select * from customer
where first_name not between 'M' and 'O';
-- and
select * from city where city = 'Sunnyvale' and country_id = 103;
-- and
select * from payment
where payment_date >= '2005-06-01' and payment_date <= '2005-07-05';
-- or
select * from customer
where first_name = 'MARIA' or first_name = 'LINDA';
select * from customer
where first_name = 'MARIA' or first_name = 'LINDA' or first_name = 'NANCY';
-- in
select * from customer
where first_name IN ('MARIA','LINDA','NANCY');
-- or, and, in
select * from city
where (country_id = 103 or country_id = 86)
 and city in ('Cheju','Sunnyvale','Dallas');
 -- in으로 깔끔하게 정리 가능
 select * from city
 where country_id in (103, 86)
 and city in ('Cheju','Sunnyvale','Dallas');
 
 -- null에 관련된 조회
 select * from address;
 select * from address where address2 = NULL;
 
 select * from address where address2 is null;
 select * from address where address2 is not null;
 -- '' 공백 조회
 select * from address where address2 = '';
 -- order by 정렬 asc(오름차순), desc(내림차순)
 select * from customer order by first_name;
 select * from customer order by last_name;
 select * from customer order by store_id, first_name;
 select * from customer order by first_name asc;
 select * from customer order by first_name desc;
 select * from customer order by store_id desc, first_name asc;
 -- 상위 데이터 조회 limit (limit는 정렬기준 명확히 위해 order by와 함께)
 select * from customer order by store_id desc, first_name asc limit 10;
 select * from customer order by customer_id asc limit 100, 10;
 -- offset 특정구간 데이터 조회 (반드시 limit와 함께 사용) 
 select * from customer order by customer_id asc limit 10 offset 100; -- 100 이후 데이터 10개
 
 -- 와일드카드 문자열 조회
 -- A% : A로 시작하는 모든 문자열
 -- %A : A로 끝나는 모든 문자열
 -- %A% : A가 포함된 모든 문자열
 select * from customer where first_name like 'A%';
 select * from customer where first_name like 'AA%';
 select * from customer where first_name like '%A';
 select * from customer where first_name like '%RA';
 select * from customer where first_name like '%A%';
 -- not like 제외
 select * from customer where first_name not like 'A%';
 
 -- 특수문자를 포함한 데이터 조회 : escape
 -- 임의의 테이블 생성
 WITH cte (col_1) AS (
 select 'A%BC' union all
 select 'A_BC' union all
 select 'ABC'
 )
 select * from CTE;
 
 -- 특수 문자 %가 들어간 데이터 조회 -> 원하는 결과 안나옴
 -- % 기호는 검색할수 있는 값이 아니라 0개 이상의 문자를 의미하는 예약어
WITH cte (col_1) AS (
 select 'A%BC' union all
 select 'A_BC' union all
 select 'ABC'
 )
 select * from cte where col_1 like '%';
 
 -- A%BC 조회 할려면 escape 이용
WITH cte (col_1) AS (
 select 'A%BC' union all
 select 'A_BC' union all
 select 'ABC'
 )
 select * from cte where col_1 like '%#%%' escape '#';
 
 -- # 외에 &,!,/ 등 다른것도 가능하지만 해당 문자가 데이터에 쓰이지 않는것이여야함
WITH cte (col_1) AS (
 select 'A%BC' union all
 select 'A_BC' union all
 select 'ABC'
 )
 select * from cte where col_1 like '%!%%' escape '!';
 
 -- like와 _로 정해진 데이터 조회
 -- A_ : A로 시작 뒤의 글자는 상관없이 전체 길이 2개인 문자열
 -- _A : A로 끝 뒤의 글자는 상관없이 전체 길이 2개인 문자열
 -- _A_ : 세 글자로 된 문자열 중 가운데 글자만 A면 앞뒤는 상관없는 문자열
select * from customer where first_name like 'A_';
select * from customer where first_name like 'A__';
select * from customer where first_name like '__A';
select * from customer where first_name like 'A__A';
-- 전체길이 5
select * from customer where first_name like '_____';
-- _과 %로 문자열 조회
select * from customer where first_name like 'A_R%';
select * from customer where first_name like '__R%';
select * from customer where first_name like 'A%R_';

-- 정규표현식을 의미하는 regexp으로 다양한 방법으로 문자열 검색
-- 정규표현식은 특정한 패턴의 문자열을 표현하기 위해 사용한다.

-- k로 시작하거나 n으로 끝나는 데이터
select * from customer where first_name regexp '^K|N$';

-- k와 함께 l과n사이의 글자를 포함한 데이터
select * from customer where first_name regexp 'K[L-N]';

-- k와 함께 l과n사이 글자를 포함하지 않는 데이터
select * from customer where first_name regexp 'K[^L-N]';

-- s로 시작하는 문자열 데이터 중에 a뒤에 l과 n사이의 글자가 있는 데이터
select * from customer where first_name like 'S%' and first_name regexp 'A[L-N]';

-- 총 7글자, a뒤에 l과n사이 글자가 있고, 마지막 글자는 o인 문자열 데이터
select * from customer where first_name like '_______'
and first_name regexp 'A[L-N]'
and first_name regexp 'o$';


-- group by절과 having절
-- 데이터를 그룹화 시킬 때 group by -> 집계함수와 함께 사용하는 경우가 많음
-- 데이터 그룹을 필터링할 때 having
-- 그룹화 하면 중복된 데이터를 제외하고 보여준다.
-- select [열] from [테이블] where [열] = [조건값] group by [열] having [열] = [조건값]
select special_features from film group by special_features;
select rating from film group by rating;

-- 2개 이상의 열을 기준으로 그룹화
-- select 문 뒤에 열을 입력한 순서에 따라 출력되는 열의 순서도 달라짐
select special_features, rating from film group by special_features, rating;
select rating, special_features from film group by special_features, rating;
 
 -- count로 그룹화한 열의 데이터 개수 세기 | count(*)은 모든 행의 개수를 세겠다는 의미 as는 별칭을 의미
 select special_features, count(*) as cnt from film group by special_features;
 
 -- 2개 열의 데이터 그룹에 속한 데이터 개수 세기
 select special_features, rating, count(*) as cnt from film
 group by special_features, rating order by special_features, rating, cnt desc;
 
 -- select 문과 group by 절의 열 이름을 달리할 경우 오류 발생
 select special_features, rating, count(*) as cnt from film group by rating;
 
 -- having 절로 그룹화한 데이터 필터링하기
 -- having은 where과 비슷하지만 where절은 테이블에 있는 열에 대해 적용
 -- having은 select문으로 조회한 열이나 group by절에 그룹화한 열에만 필터링 적용
 
 -- rating 열에서 g인 데이터만 필터링
 select special_features, rating from film
 group by special_features, rating
 having rating ='G';
 
 -- count함수도 함게 사용 가능
 select special_features, count(*) as cnt from film
 group by special_features
 having cnt > 70;
 
 -- 그룹화 하지 않은 열을 필터링할 경우 오류
 select special_features, count(*) as cnt from film
 group by special_features
 having rating = 'G';
 
 -- 오류 수정
 select special_features, rating, count(*) as cnt from film
 group by special_features, rating
 having rating = 'R' and cnt > 8;
 
 -- group by는 중복 데이터 제거를 한다고 했지만 group by를 사용하지 않고 중복 제거를 원한다면
 -- dictinct 사용 (지정한 열의 중복 데이터 제거)
 -- select distinct [열] from [테이블]
 
 -- 두 열의 데이터 중복 제거
 select distinct special_features, rating from film;
 
 -- 비교를 위한 group by
 select special_features, rating from film
 group by special_features, rating;
 
 -- 결과가 같다고 같은 역할은 아님
 -- distinct는 중복만 제거지 그룹화 하거나 이를 이용해 계산 작업이 안됨
 -- 계산이 필요하면 group by절 사용
 
 -- distinct문에 count함수 사용할 경우 오류 발생
 select distinct special_features, rating, count(*) as cnt from film;
 
 -- 테이블 생성 및 조작
 create database if not exists dotisql;
 use doitsql;
 -- auto_increment 1씩 또는 사용자가 정의한 값 만큼 자동으로 입력
 create table doit_increment (
 col_1 int auto_increment primary key,
 col_2 varchar(50),
 col_3 int);
 
 insert into doit_increment (col_2, col_3) values ('1 자동 입력',1);
 insert into doit_increment (col_2, col_3) values ('2 자동 입력',2);
 
 select * from doit_increment;
 
 -- 자동입력되는 값과 동일한 값 입력 -> 문제 없음
 insert into doit_increment (col_1, col_2, col_3) values (3,'3자동 입력',3);
 select * from doit_increment;

-- 자동입력되는 값보다 큰 값 입력 -> 문제없음
insert into doit_increment (col_1, col_2, col_3) values (5,'4 건너뛰고 5 자동입력',5);
select * from doit_increment;
 
 -- 다시 auto_increment 적용된 1열 제외하고 값 입력
 insert into doit_increment (col_2, col_3) values ('어디까지 입력되었을까?',0);
 select * from doit_increment; -- 5 다음 값인 6 자동 입력
 -- auto_increment가 적용된 열의 마지막 데이터 조회
 select last_insert_id();
 
 -- auto_increment 시작값 변경
 alter table doit_increment auto_increment = 100;
 insert into doit_increment (col_2, col_3) values ('시작값이 변경되었을까?',0);
 select * from doit_increment;
 
 -- auto_increment 증가값 변경
 set @@auto_increment_increment = 5;
 insert into doit_increment (col_2, col_3) values ('5씩 증가 할까? (1)',0);
 insert into doit_increment (col_2, col_3) values ('5씩 증가 할까? (2)',0);
 select * from doit_increment;	-- 첫 데이터는 1이 증가, 이후 데이터부터 5씩 증가
 
 -- 조회 결과를 다른 테이블에 입력 (입력하려는 테이블과 조회한 열의 데이터 유형이 동일해야함)
 create table doit_insert_select_from(
 col_1 int,
 col_2 varchar(10)
 );
 
 create table doit_insert_select_to(
 col_1 int,
 col_2 varchar(10)
 );
 
 insert into doit_insert_select_from values (1, 'Do');
 insert into doit_insert_select_from values (2, 'It');
 insert into doit_insert_select_from values (3, 'MySQL'); # 첫번째 테이블에 데이터 입력
 
 insert into doit_insert_select_to
 select * from doit_insert_select_from; # 첫번째 테이블의 데이터를 조회해 두번째 테이블의 입력
 
 select * from doit_insert_select_to; # 두번째 테이블 조회
 
 -- 새 테이블에 조회 결과 입력
 create table doit_select_new AS (select * from doit_insert_select_from);
 select * from doit_select_new;
 
 -- 외래키 :  테이블 간에 관계를 구성할 때 참조하는 열
 -- 부모 테이블과 자식 테이블 생성
 create table doit_parent (col_1 int primary key);
 create table doit_child (col_1 int);
 
 alter table doit_child
 add foreign key (col_1) references doit_parent(col_1);
# references : 참조 관계를 생성하는 명령문

-- 자식 테이블에 데이터 입력 시 부모 테이블에 해당 데이터가 없는 경우 -> 오류
-- 해결방안 : 부모 테이블에 데이터를 먼저 입력
insert into doit_child values(1);
 
 -- 부모 테이블에 데이터 입력 후 자식 테이블 데이터 입력
 insert into doit_parent values (1);
 insert into doit_child values(1);
 
 select * from doit_parent;
 select * from doit_child;
 
 -- 부모 테이블에서만 데이터 삭제할 경우 -> 오류
 -- 해결방안 : 자식 테이블 데이터 먼저 삭제 후 부모데이터 삭제
 delete from doit_parent where col_1 = 1;
 
 -- 자식 테이블 데이터 삭제 후 부모 테이블 데이터 삭제
 delete from doit_child where col_1 =1;
 delete from doit_parent where col_1 =1;
 
 -- 외래키로 연결되어 있는 테이블 삭제하기
 -- 부모테이블 삭제할 경우 -> 오류
 -- 해결방안 : 자식 테이블-> 부모 테이블 순서로 삭제
 -- 다른 해결방안 : 제약조건을 제거
 drop table doit_parent;
 
 -- 하위 테이블 삭제 후 상위 테이블 삭제
 drop table doit_child;
 drop table doit_parent;
 
 -- 외래키 제약 조건 확인
 create table doit_parent (col_1 int primary key);
 create table doit_child (col_1 int);
 alter table doit_child add foreign key(col_1) references doit_parent(col_1);
 show create table doit_child; 
 
 -- 제약 조건 제거 후 상위 테이블 삭제
 alter table doit_child
 drop constraint doit_child_ibfk_1;
 
 drop table doit_parent;
 
 -- 일시적으로 외래키 설정 가능(set)
 -- 이미 입력된 데이터는 외래키 체크를 하지 않음
 -- 외래키는 데이터 무결성 유지를 위해 사용되는데 off->on 상태로 돌아갔을때
 -- 현재까지 입력된 데이터에 대한 무결성 검사를 하지 않음
 set foreign_key_checks=0; # 비활성
 set foreign_key_checks=1; # 활성
 
 -- MySQL의 데이터 유형
 -- 정수형
 -- 음수와 양수 동시에 저장 가능 auto_increment 적용 열에는 음수 저장x
 -- int(4byte),bigint(8byte)
 -- 실수형
 -- float(4~8byte), double(8byte)
 create table doit_float (col_1 float);
 insert into doit_float values (0.7);
 
 select * from doit_float where col_1 = 0.7;
 -- float타입은 부동소수점 숫자를 저장하기 때문에 정확한 값이 아닌 근사치 저장
 -- 0.7과 정확히 일치하는 값이 없기 때문에 빈 결과 반환
 -- 소수점이 고정되어아 하는 숫자라면 float, double 사용불가
 -- deciaml(5~17byte), numeric(5~17byte)을 사용 (전체 자릿수와 소수 자릿수가 고정)
 
 -- 형 변환
 -- 암시적, 명시적으로 자료형을 변환
 -- 암시적 형 변환 : 자료형을 직접 변경하지 않아도 실행환경에서 자동으로 자료형을 변경
 -- 명시적 형 변환 : cast, convert등의 함수를 사용하여 사용자가 자료형 직접 변경
 
 -- 10/3 = 3.3333
 -- 정수10,3을 나눴지만 실수 3.3333이 출력
 -- 우선순위 형 변환 정책에 따라 암시적 형 변환된 것
 
 -- 문자형 , mysql의 경우 바이트가 아닌 문자 개수를 의미 -> char(5), varchar(5)
 -- 문자열 데이터의 길이가 항상 고정이라면 char
 -- varchar(1~65535byte) : 글자 길이를 예측 할 수 없지만 최대 글자 수를 예측 가능
 -- char(1~255byte) : 2~3바이트 범위 내 예측하기 어려운 경우에는 넉넉한 char로 설정하는것이 좋다.
 
 -- 문자열 데이터의 길이와 크기 확인
 create table doit_char_varchar(
 col_1 char(5),
 col2 varchar(5)
 );
 
 insert into doit_char_varchar values ('12345','12345');
 insert into doit_char_varchar values ('ABCDE','ABCDE');
 insert into doit_char_varchar values ('가나다라마','가나다라마');
 insert into doit_char_varchar values ('hello','안녕하세요');
 insert into doit_char_varchar values ('安寧安寧安','安寧安寧安');
 
 select
 col_1, char_length(col_1) as char_length, length(col_1) as char_byte,
 col2, char_length(col2) as char_length, length(col2) as char_byte
 from doit_char_varchar;
 -- 숫자와 영어는 한 글자당 1바이트, 한글과 한문은 글자당 3바이트
 -- MySQL에서는 유니코드 utf-8은 3바이트, utf-16은 2바이트 
 -- 최근에는 다양한 이모티콘 표현 등을 위해 utf8mb4라는 형식을 기본으로 사용하기도 함

 -- mysql은 하나의 행에서 text, blob형식을 제외한 열 전체크기가 64kb 초과 불가
 -- 생성 성공
 create table doit_table_byte(
 col_1 varchar(16383)
 );
 -- 생성 실패
 create table doit_table_byte(
 col_1 varchar(16383),
 col_2 varchar(10)
 );
 
 -- 문자 집합
 -- 입력에 따라 다양한 크기(바이트 단위)로 저장 -> 인코딩에 따른 특징
 -- DB인코딩은 문자 데이터를 컴퓨터가 이해하는 이진수로 변환하여 저장하는 규칙
 -- 한글은 EUC-KR 또는 utf8mb4
 -- 일본어는 CP932 또는 utf8mb4
 show character set;
 
 -- 콜레이션
 -- 문자열 데이터가 담긴 열의 비교나 정렬 순서를 위한 규칙
 create table doit_collation(
 col_latin1_GENERAL_CI VARCHAR(10) COLLATE LATIN1_GENERAL_CI,
 col_latin1_GENERAL_CS VARCHAR(10) COLLATE LATIN1_GENERAL_Cs,
 col_latin1_bin VARCHAR(10) COLLATE LATIN1_bin,
 col_latin7_GENERAL_CI VARCHAR(10) COLLATE LATIN7_GENERAL_CI
 );
 insert into doit_collation values ('a', 'a', 'a', 'a');
 insert into doit_collation values ('b', 'b', 'b', 'b');
 insert into doit_collation values ('A', 'A', 'A', 'A');
 insert into doit_collation values ('B', 'B', 'B', 'B');
 insert into doit_collation values ('*', '*', '*', '*');
 insert into doit_collation values ('_', '_', '_', '_');
 insert into doit_collation values ('!', '!', '!', '!');
 insert into doit_collation values ('1', '1', '1', '1');
 insert into doit_collation values ('2', '2', '2', '2');
 # 대소문자 구분하지 않고 정렬
 select col_latin1_general_ci from doit_collation order by col_latin1_general_ci; 
 #대문자A 와 소문자a는 모두 대문자B와 소문자b보다 먼저 정렬, 같은 알파벳에선 대문자가 소문자보다 먼저 정렬
 select col_latin1_general_cs from doit_collation order by col_latin1_general_cs; 
 # 대문자 먼저 정렬, 소문자 정렬 그리고 특수 문자가 알파벳 사이에서 정렬
 select col_latin1_bin from doit_collation order by col_latin1_bin;
 # 특수 문자는 항상 알파벳 보다 먼저
 select col_latin7_general_ci from doit_collation order by col_latin7_general_ci;

-- 날짜형 및 시간형
create table date_table(
justdate DATE,
justtime TIME,
justdatetime DATETIME,
justtimestamp TIMESTAMP);

insert into date_table values(now(), now(), now(), now());
# now()는 날짜 함수로 현재 날짜와 시간을 가져옴
select * from date_table;


-- 문자열 함수
-- concat 함수 : 문자열과 문자열을 연결하는 함수
-- select concat('I ', 'Love ', 'MySQL') AS col_1;

use sakila;
select concat(first_name, ', ', last_name) AS customer_name from customer;

-- concat_ws 함수 : 구분자 미리 정의해서 자동 적용
select concat_ws(', ',first_name, last_name, email) as customer_name from customer;

-- 인수로 null을 입력할 경우 결과는 모두 null, null은 어떠한 문자열과 결합하더라도 결과가 null
select concat(null, first_name, last_name) as customer_name from customer;

-- concat_ws 인자로 null이 있는 경우 : 구분 인수 뒤에 null은 무시하고 null을 제외한 결합 문자 출력
select concat_ws(', ', first_name, null, last_name) as customer_name from customer;

-- 데이터 형 변환 함수 - cast, convert-> convert 함수는 cast 함수와 달리 문자열 집합을 다른 문자열 집합으로 변환
-- 문자열을 부호 없는 정수형으로 변경
select
4 / '2',
4 /2,
4 / cast('2' as unsigned); # 부호 없는 정수형으로 변경

-- cast 함수로 날짜형을 숫자형으로 변환
select cast(now() as signed); # now() 현재 날짜 시간 출력 함수
#			열이 아닌 함수를 직접 넣을 수 있음

-- cast 함수로 숫자형을 날짜형으로 변환
select cast(20230819 as date);

-- cast 함수로 숫자형을 문자열로 변환
select cast(20230819 as char);

-- convert 함수로 날짜형을 숫자형으로 변환
select convert(now(), signed);

-- convert 함수로 숫자형을 날짜형으로 변환
select convert(20230819, date);

-- char로 데이터 길이 지정 길이보다 길면 자르고 출력
select convert(20230819, char(5));

-- 오버플로 발생 예
select 9223372036854775807 + 1;

-- cast 함수로 오버플로 방지
select cast(9223372036854775807 as unsigned) + 1;

-- convert함수로 오버플로 방지
select convert (9223372036854775807, unsigned) +1;

-- null 치환을 위한 ifnull(열, 대체할 값) 함수와 coalesce(열1, 열2,...)함수
create table doit_null(
col_1 int,
col_2 varchar(10),
col_3 varchar(10),
col_4 varchar(10),
col_5 varchar(10)
);
insert into doit_null values(1, null, 'col_3', 'col_4', 'col_5');
insert into doit_null values(2, null, 'col_3', 'col_4', 'col_5');
insert into doit_null values(2, null, null, null, 'col_5');
insert into doit_null values(3, null, null, null, null);

select * from doit_null;
-- ifnull 함수로 col_2열의 null 대체
select col_1, ifnull(col_2,'') as col_2, col_3, col_4, col_5
from doit_null where col_1 = 1;
-- ifnull 함수로 col_3열의 null 대체
select col_1, ifnull(col_2, col_3) as col_2, col_3, col_4, col_5
from doit_null where col_1 = 1;

-- coalesce 함수로 null을 다른 데이터로 대체: 마지막 인자에 데이터가 있는 경우
select col_1, coalesce(col_2, col_3, col_4, col_5)
from doit_null where col_1 = 2;
-- 마지막 인자까지도 null이 이쓴ㄴ 경우 null을 반환
select col_1, coalesce(col_2, col_3, col_4, col_5)
from doit_null where col_1 = 3;

-- 소문자 혹은 대문자 변경 함수 : LOWER, UPPER
-- lower함수로 소문자를, upper함수로 대문자로
select 'Do it! SQL', LOWER('Do it! SQL'), UPPER('Do it! SQL');
select email, lower(email), upper(email) from customer;

-- 공백 제거 함수 ltrim, rtrim, trim
select '      Do it! MySQL', LTRIM('      Do it! MySQL');
select'Do it! MySQL		',rtrim('Do it! MYSQL		');
select'		Do it! MySQL		',trim('	Do it! MySQL		');
-- trim은 단어 앞뒤 특정 문자 제거 기능도 있음
select trim(both '#' from '#	do it! mySQL	#'); 
# both는 왼쪽과 오른쪽의 접두사 제거하는 명령문
# both 자리에 leading을 입력하면 왼쪽 문자, trailing을 입력하면 오른쪽 문자가 제거됨

-- 문자열 크기 또는 개수를 반환하는 함수 -> length(바이트 크기), char_length(문자열 개수)
select length('Do it! MySQL'),length('두잇 마이에스큐엘');
select length('A'),length('강'),length('漢'),length('◁'),length(' ');

select char_length('Do it! MySQL'), char_length('두잇 마이에스큐엘');

-- length와 char_length함수에 열 이름 전달
select first_name, length(first_name), char_length(first_name) from customer;

-- position함수로 특정 문자까지의 크기 반환
select 'DO it!! SQL', POSITION('!' in 'Do it!! MySQL');

-- 탐색 문자가 없는 경우 0 반환, null인 경우 null반환
select 'Do it!! SQL', POSITION('#' In 'Do it!! MySQL');

-- 지정한 길이만큼 문자열을 반환하는 함수 -left,right
select 'Do it! MySQL', left('Do it! MySQL', 2), right('Do it! MySQL',2);

-- 지정한 범위의 문자열 반환하는 함수 - substring
select 'Do it! MySQL', substring('Do it! MySQL',4,2);

-- substring함수에 열 이름 전달
select first_name, substring(first_name, 2, 3) from customer;

-- substring과 position함수 조합
select substring('abc@email.com', 1, position('@'in 'abc@email.com')-1);

-- 특정 문자를 다른 문자로 대체하는 함수 -replace
select first_name, replace(first_name, 'A', 'C')
from customer where first_name like 'A%';

-- 문자를 반복하는 함수 - repeat
select repeat('0',10);

-- repeat와 replace 함수 조합
select first_name, replace(first_name, 'A', repeat('C',10))
from customer where first_name like '%A%';

-- 공백 문자를 생성하는 함수 - space
select concat(first_name, space(10), last_name) from customer;

-- 문자열을 역순으로 출력하는 함수 - reverse
select 'Do it! MySQL', reverse('Do it! MySQL');

-- reverse 함수와 다른 여러 함수 조합
with ip_list(ip)
as (
	select '192.168.0.1' union all
    select '10.6.100.99' union all
    select '8.8.8.8' union all
    select '192.200.212.113'
)
select ip, substring(ip, 1, char_length(ip) - position('.' in reverse(ip)))
from ip_list;

-- 문자열을 비교하는 함수 - strcmp 동일할 경우 0, 다를 경우 -1
select strcmp('Do it! MySQL','Do it! MySQL');
select strcmp('Do it! MySQL','Do it! MySQL!');

-- 날짜 함수
select current_date(), current_time(), current_timestamp(), now();
select current_date(), current_time(3), current_timestamp(3), now(3); # 밀리초나 마이크로초까지 가능

-- UTC (Coordinated Universal Time) 세계 표준 시간 관련 함수
select current_timestamp(3), UTC_DATE(), UTC_time(3), UTC_timestamp(3);

-- 날짜를 더하거나 빼는 함수 -date_add, date_sub
select now(), date_add(now(), interval 1 year); # interval 시간 간격을 의미
select now(), date_add(now(), interval -1 year); # 빼고 싶으면 음수

-- 날짜를 빼고 싶을 떄 date_sub 사용해도 가능 단 이때 양수 입력해야함 음수는 오히려 더함
select now(), date_sub(now(), interval 1 year), date_sub(now(), interval -1 year);

-- 날짜간 차이를 구하는 함수 - datediff, timestampdiff
select datediff('2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

-- timestampdiff 함수로 날짜 간의 개월 수 차 반환
select timestampdiff(month, '2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

-- 지정한 날짜의 요일을 반환하는 함수 - dayname
select dayname('2023-08-20');

-- 날짜에서 연,월,주,일을 값으로 가져오는 함수 - year,month,week,day
select
	year('2023-08-20'),
    month('2023-08-20'),
    week('2023-08-20'),
    day('2023-08-20');
    
-- 날짜 형식을 변환하는 함수 - date_format, get_format
select date_format('2023-08-20 20:23:01', '%m/%d/%y');
select date_format('2023-08-20 20:23:01', '%y/%m/%d');
select date_format('2023-08-20 20:23:01', '%y./%m/.%d');
select date_format('2023-08-20 20:23:01', '%h./%i./%s');

select get_format(date, 'USA') as usa,
get_format(date, 'JIS') as JIS,
get_format(date, 'EUR') as EUR,
get_format(date, 'ISO') as ISO,
get_format(date, 'INTERNAL') as INTERNAL;

-- date_format과 get_format 함수 조합
select date_format(now(), get_format(date, 'USA')) as usa,
date_format(now(), get_format(date, 'JIS')) as JIS,
date_format(now(), get_format(date, 'EUR')) as EUR,
date_format(now(), get_format(date, 'ISO')) as ISO,
date_format(now(), get_format(date, 'INTERNAL')) as INTERNAL;

-- 집계 함수 : 데이터를 그룹화(group by)해 계산할 떄 자주 사용
-- 조건에 맞는 데이터 개수를 세는 함수 -count
select count(*) from customer;
select store_id, count(*) as cnt from customer group by store_id;

-- count함수와 group by문 조합 : 열2개 활용
select store_id, active, count(*) as cnt from customer group by store_id, active;

-- count 함수 주의점 : 전체 열이 아닌 특정 열만 지정하여 집계할 떄
-- 해당 열에 있는 null값은 제외한다.
select count(*) as all_cnt,
count(address2) as ex_null from address;

-- count 함수와 distinct : 중복된 값 제외한 데이터 개수 집계
select count(*), count(store_id), count(distinct store_id) from customer;

-- 데이터의 합을 구하는 함수 -sum
select sum(amount) from payment;
select customer_id, sum(amount) from payment group by customer_id;

-- 암시적 형 변환으로 오버플로 없이 합산 결과를 반환
create table doit_overflow(
col_1 int,
col_2 int,
col_3 int
);
insert into doit_overflow values(1000000000,1000000000,1000000000);
insert into doit_overflow values(1000000000,1000000000,1000000000);
insert into doit_overflow values(1000000000,1000000000,1000000000);
select sum(col_1) from doit_overflow;

-- 데이터의 평균을 구하는 함수 - avg
select avg(amount) from payment;
select customer_id, avg(amount) from payment group by customer_id;

-- 최솟값 또는 최댓값을 구하는 함수 - min, max
select min(amount), max(amount) from payment;
select customer_id, min(amount), max(amount) from payment group by customer_id;

-- 부분합과 총합을 구하는 함수 - rollup
select customer_id, staff_id, sum(amount)
from payment
group by customer_id, staff_id with rollup;

-- 데이터의 표준편차를 구하는 함수 -- stdev, stddev_samp
select stddev(amount), stddev_samp(amount) from payment;

-- 수학함수
-- 절댓값을 구하는 함수 -abs
select ABS(-1.0), abs(0.0), abs(1.0);
select a.amount - b.amount as amount, abs(a.amount - b.amount) as abs_amount
from payment as a 
	inner join payment as b on a.payment_id = b.payment_id-1;
-- 암시적 형 변환으로 오버플로 없이 절댓값을 반환
select abs(-2147483648);

-- 양수 또는 음수 여부를 판단하는 함수 - sign
select sign(-256), SIGN(0), SIGN(256);

select a.amount - b.amount as amount, sign(a.amount - b.amount) as abs_amount
from payment as a
	inner join payment as b on a.payment_id = b.payment_id-1;
    
-- 천장값과 바닥값을 구하는 함수 - ceiling, floor
select ceiling(2.4), ceiling(-2.4), ceiling(0.0);
select floor(2.4), floor(-2.4), floor(0.0);
-- 반올림을 반환하는 함수 -round(숫자, 자릿수)
select round(99.9994, 3), round(99.9995, 3); # 셋째자리 반올림
select round(234.4545, 2), round(234.4545, -2); # 소수와 정수 따로 반올림
select round(748.58, -1);
select round(748.58, -2);
select round(748.58, -4);

-- log 함수의 기본 형식 - log(로그 계산할 숫자 또는 식, 밑)
-- log함수로 로그 10을 계산
select log(10);
select log(10,5);
-- e의 n 제곱값을 구하는 함수 -exp(지수 계산할 숫자 또는 식)
select exp(1.0);
select exp(10);
select exp(log(20)), log(exp(20)); # log함수와 exp함수로 결과 확인
# 같아야 하지만 실수 변환에서 반올림의 처리 때문에 미세하게 다름 같다고 보면 됨

-- 거듭제곱값을 구하는 함수 -power(숫자 또는 수식, 지수)
select power(2,3), power(2,10), power(2.0, 3);

-- 제곱근을 구하는 함수 -sqrt(숫자 또는 수식)
select sqrt(1.00), sqrt(10.00);

-- 난수를 구하는 함수 -rand(인자)
select rand(100), rand(), rand();

-- 인수가 없는 rand 함수로 난수 계산
DELIMITER $$
create procedure rnd()
begin
declare counter int;
SET counter =1;

WHILE counter < 5 Do
	SELECT RNAD() Random_Number;
    SET counter = counter + 1;
END WHILE;
END $$
DELIMITER ;
call rnd();

-- 삼각 함수 -cos, sin, tan, atan
-- cos(숫자 또는 식) 다른 삼각 함수도 마찬가지 형식
-- 함수 계산
select cos(14.78);
select sin(45.175643);
select tan(pi()/2), tan(.45);

select atan(45.87) as atanCalc1,
	atan(-181.01) as atanCalc2,
    atan(0) as atanCalc3,
    atan(0.1472738) as atanCalc4,
    atan(197.1099392) as atanCalc5;
    
    