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