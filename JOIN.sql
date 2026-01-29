-- JOIN 테이블 2개 이상을 조인
-- inner join의 기본 형식 (조건에 맞는 데이터만 조회하므로 null이 발생하지 않음)
/* select [열]
   from [테이블1]
		inner join [테이블 2] on [테이블 1.열] = [테이블 2.열]
   where [검색 조건]
*/
# inner join 적용 예
/* select
		[고객.고객 번호], [고객.고객 이름], [주문.주문 번호], [주문.고객 번호], [주문.주문 날짜]
	from [고객]
		inner join [주문] on [고객.고객 번호] = [주문.고객 번호]
*/
-- 내부 조인한 테이블에서 조건에 맞는 데이터 조회
select a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id
as a_address_id, # a.address_id, b.address_id라고 각 테이블 별칭 붙여 조회 구분하기 쉽게 as 사용해 별칭 붙임
	b.address_id as b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
from customer as a
	inner join address as b on a.address_id = b.address_id
where a.first_name = 'ROSA';
# on과 where 절의 차이
# 데이터 필터링한다는 점에서 비슷하지만 완전히 다름
# on은 조인할 떄 조인 조건을 위해 사용
# where은 조건에 맞는 데이터(값)를 가져오기 위해 사용
# join시 열 이름이 유일해야 한다

-- inner join에 조인 조건 2개 이상 사용하기
select
	a.customer_id, a.first_name, a.last_name,
	b.address_id, b.address, b.district, b.postal_code
from customer as a
	inner join address as b on a.address_id = b.address_id and a.create_date = b.last_update
where a.first_name = 'ROSA';
# 열 이름이 같을 필요는 없고 데이터 유형이 같아야 함
# 데이터의 상관관계가 없어도 조인이 가능

-- inner join으로 테이블 3개 이상 조인
select
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code,
    c.city_id, c.city
from customer as a
	inner join address as b on a.address_id = b.address_id
    inner join city as c on b.city_id = c.city_id
where a.first_name = 'ROSA';

-- outer join 외부 조인
-- 열의 일치 여부를 고려하지 않고 한 쪽 테이블과 다른 쪽 테이블에 조인할 때 사용
/* select
		[열]
	from [테이블 1]
		[left | right | full] outer join [테이블 2] on [테이블 1.열] = [테이블 2.열]
	where [검색 조건]
*/
-- left outer join
select 
	a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	left outer join store as b on a.address_id = b.address_id;
# address 테이블을 기준으로 외부 조인 store 테이블에 없는 address_id의 경우 null 출력

-- left outer join으로 조회한 결과에서 null만 조회
select
	a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	left outer join store as b on a.address_id = b.address_id
where b.address_id is null;

-- right outer join
select 
	a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	right outer join store as b on a.address_id = b.address_id;
    
-- right outer join으로 조회한 결과에서 null만 조회
select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id
where a.address_id is null;

-- full outer join
select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	left outer join address as b on a.address_id = b.address_id
	  # mysql에서는 full outer join을 지원하지 않아
union # letf outer join과 right outer join의 결과를 합쳐 구현함
	  # 이때 합치는 명령어로 union 사용
select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id;
    
-- full outer join 으로 조회한 결과에서 null만 조회
select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	left outer join address as b on a.address_id = b.address_id
where b.address_id is null

union 

select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id
where a.address_id is null;

-- 교차조인 = 카르테시안곱 : 각 테이블의 모든 경우의 수를 조합한 데이터
/* select [열]
   from [테이블 1]
		cross join [테이블 2]
	where [검색 조건]
*/
# 교차 조인에 from 절에는 조인 조건이 없는데
# 한 테이블에서 모든 행을 조인하므로 조건이 필요 없음

-- cross join 위한 샘플 데이터 생성
use sakila;
create table doit_cross1(num int);
create table doit_cross2(name varchar(10));
insert into doit_cross1 values (1), (2), (3);
insert into doit_cross2 values ('Do'), ('It'), ('SQL');

-- cross join을 적용한 쿼리
select
	a.num, b.name
from doit_cross1 as a
	cross join doit_cross2 as b
order by a.num;

-- where 절을 사용한 cross join
select
	a.num, b.name
from doit_cross1 as a
	cross join doit_cross2 as b
where a.num = 1;

-- self join : 동일한 테이블을 사용하는 특수한 조인(자기 자신과 조인한다는거)
# 반드시 테이블 별칭을 사용해줘야 함
select a.customer_id as a_customer_id, b.customer_id as b_customer_id
from customer as a
	inner join customer as b on a.customer_id = b.customer_id;
select 
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount as prof_it_amount
from payment as a
	left outer join payment as b on a.payment_id = b.payment_id -1;
    
-- 서브쿼리
# 1. 서브 쿼리는 반드시 소괄호로 감싸 사용
# 2. 서브 쿼리는 주 쿼리를 실행하기 전에 1번만 실행된다.
# 3. 비교 연산자와 함께 서브 쿼리르 사용하는 경우
# 	서브 쿼리를 연산자 오른쪽에 기술해야 한다.
# 4. 서브 쿼리 내부에는 정렬 구문인 order by절을 사용할 수 없다.

-- 단일 행 서브 쿼리 적용
select * from customer
where customer_id = (select customer_id from customer where first_name = 'ROSA');

-- 잘못된 단일 행 서브 쿼리 적용 시 오류 발생 예
select * from customer
where customer_id = (select customer_id from customer where first_name in('ROSA','ANA'));
# 서브 쿼리 결괏값이 1행이 아니어서 오류
# where 절에 사용한 서브 쿼리가 여러 행을 반환하면 비교 연산자 규칙에 어긋남
# 2건 이상이면 비교 연산자가 아닌 다중 행 연산자 사용

-- in을 활용한 다중 행 서브 쿼리 적용 1
select * from customer
where first_name in ('ROSA', 'ANA');
-- in을 활용한 다중 행 서브 쿼리 적용 2
select * from customer
where customer_id in (select customer_id from customer where first_name in('ROSA', 'ANA'));

-- 테이블 3개를 조인하는 쿼리
select
	a.film_id, a.title
from film as a
	inner join film_category as b on a.film_id = b.film_id
    inner join category as c on b.category_id = c.category_id
where c.name = 'Action';
-- in을 활용한 서브 쿼리 적용
select
	film_id, title
from film
where film_id in (
	select a.film_id
    from film_category as a
		inner join category as b on a.category_id = b.category_id
	where b.name = 'Action');
# 같은 결과를 반환함 쿼리문 작성 방법에는 하나의 정답이 있는 것이 아님.

-- not in을 활용한 서브 쿼리 적용
# 다른 테이블의 값과 일치하지 않는 행을 찾을 수 있다.
select
	film_id, title
from film
where film_id not in (
	select a.film_id
    from film_category as a
		inner join category as b on a.category_id = b.category_id
	where b.name = 'Action');
    
-- =any를 활용한 서브 쿼리 적용
# 서브쿼리 결과에서 값이 하나라도 만족하는 조건
select * from customer
where customer_id = any (select customer_id from customer where first_name in
('ROSA','ANA'));

-- <any를 활용한 서브 쿼리 적용
select * from customer
where customer_id < any (select customer_id from customer where first_name in
('ROSA','ANA'));
-- >any를 활용한 서브 쿼리 적용
select * from customer
where customer_id > any (select customer_id from customer where first_name in
('ROSA','ANA'));

-- exists를 활용한 서브 쿼리 적용 : 결괏값이 1행이라도 있으면 True아니면 False
select * from customer
where exists(select customer_id from customer where first_name in ('ROSA', 'ANA')); # True

select * from customer
where exists(select customer_id from customer where first_name in ('KANG')); # False

-- not exists는 exists와 반대로 동작
select * from customer
where not exists(select customer_id from customer where first_name in ('KANG'));

-- all을 활용한 서브 쿼리 적용 : 서브 쿼리의 결괏값 모두를 만족하는 조건을 주 쿼리에서 검색하여 결과를 반환
select * from customer
where customer_id = all (select customer_id from customer where first_name in
('ROSA', 'ANA'));
# where customer_id = 112 and customer_id = 181 조건과 같음

-- from 절에 서브 쿼리 사용하기
# from 절에 사용한 서브 쿼리 결과는 테이블처럼 사용되어 다른 테이블과 다시 조인할 수 있다
# 즉, 쿼리를 논리적으로 격리할 수 있다.
/* select
		[열]
   from [테이블] as a
		inner join (select [열] from [테이블] where [열] = [값]) as b on [a.열] = [b.열]
	where [열] = [값]
*/
# 이때 from절에 사용하는 서브 쿼리는 인라인 뷰 라고 한다

-- 테이블 조인
select
	a.film_id, a.title, a.special_features, c.name
from film as a
	inner join film_category as b on a.film_id = b.film_id
    inner join category as c on b.category_id = c.category_id
where a.film_id > 10 and a.film_id < 20;

-- from절에 서브 쿼리 적용
select
	a.film_id, a.title, a.special_features, x.name
from film as a
	inner join (
    select
		b.film_id, c.name
	from film_category as b
		inner join category as c on b.category_id = c.category_id
	where b.film_id > 10 and b.film_id < 20) as x on a.film_id = x.film_id;
    
-- select 절에 서브 쿼리(스칼라 서브 쿼리) 사용하기
/* select
		[열], (select <집계 함수> [열] from [테이블 2]
        where [테이블 2.열] = [테이블 1.열]) as a
	from [테이블 1]
    where [조건]
*/
-- 테이블 조인
select
	a.film_id, a.title, a.special_features, c.name
from film as a
	inner join film_category as b on a.film_id = b.film_id
    inner join category as c on b.category_id = c.category_id
where a.film_id > 10 and a.film_id < 20;

-- select 절에 서브 쿼리 적용
select
	a.film_id, a.title, a.special_features, (select c.name from film_category as
    b inner join category as c on b.category_id = c.category_id where a.film_id=
    b.film_id) as name
from film as a
where a.film_id > 10 and a.film_id < 20;
-- with  cte_customer (customer_id, first_name, email)
-- as
-- (
-- 	select customer_id, first_name, email from customer where customer_id >= 10
--     and customer_id <=15
--     intersect
--     select customer_id, first_name, email from customer where customer_id >= 12
--     and customer_id <= 20
-- )
