/* select 1번, 2번, 3번(집계), 4번(집계) 일 때 
group by 옆에 오는 것은 1번, 2번입니다. ==> 이게 표준
그런데 MySQL에서는 위와 같은 경우 1번, 2번이 오직 primary key에 종속되는 경우
group by 옆에 PK 컬럼 적어도 됩니다. ==> 표준은 아님.
그래서 확인문제 4장 8번 경우
group by p_id 써도 되긴 하는데,
1번, 2번이 p_id에 종속되기 때문에 가능합니다.

따라서 제가 추천드리는 건 , group by 옆에 집계 빼고 group by 1번, 2번 이렇게 넣어주시는 걸 추천드립니다. */

/* select P.p_name 상품명, P.price 단가, sum(O.amount) 주문수량합, sum(P.price*O.amount) 주문금액합
여기에서 P, O는 테이블 alias, 상품명 단가 등은 컬럼 alias입니다.

제가 월요일에 말씀드리기를
테이블 alias는 전체에서 쓸 수 있고, 컬럼 alias는 group by부터 사용할 수 있다고 말씀드렸습니다.
(즉, 컬럼 alias는 where 절에서는 못쓴다는 의미)

그런데 컬럼alias를 group by부터 사용할 수 있다는 건 MySQL기준입니다.
표준SQL 및 다른 DBMS에서는 컬럼 alias는 order by에만 사용 가능

우리는 MySQL만 사용하므로
group by P.p_name, P.price (O) ==>  얘는 표준
group by 상품명, 단가 (O) ==> 얘는 MySQL only(실무자들 위해서 플러스알파 기능 넣은 것) 

시험, 과제 등에서 얼마든지 사용 가능.

하지만, 만약 표준SQL 관련 시험을 보신다면, group by 상품명, 단가(x) 입니다. */

/*
select 
from
where
group by
having
order by

컴퓨터가 일할 떄는 from부터 봅니다. 일단 어느테이블에 가야할 지 생각해야 하기 때문에
그래서 컴퓨터가 일하는 순서는
from
where
group by
having

select <----- select 순서가 요기. 이런 이유로 select에서 정의된 컬럼 alias는 order by밖에 못사용하게 됨

order by

*/

/* select P.p_name 상품명, P.price 단가, sum(O.amount) 주문수량합, sum(P.price*O.amount) 주문금액합 ==== 1번


select P.p_name 상품명, P.price 단가, sum(O.amount) 주문수량합, P.price * sum(O.amount) 주문금액합 ====== 2번

group by 하려면 집계아닌 파트, 집계파트가 명확해야함
그래야 group by 옆에 집계아닌 파트를 적을 수 있음


그런데 2번처럼 하면 마지막에 집계아닌 * 집계파트 이렇게 이상하게 콜라보레이션 되어버림 */

select * from member;
select * from member order by height;

# 확인문제 10번 (1)
select mem_name, height
from member
where height = (select max(height) from member) # heihgt = 168
 or
 height = (select min(height) from member);		# height = 160
 
 # 키가 168, 160인 회원이 많다면, 모두 select됨, 지금은 키 중복 없어서 하나씩만 나옴
 
 # 확인문제 10번 (2)
select mem_name, height
from member
where height = (select max(height) from member)
union all
select mem_name, height
from member
where height = (select min(height) from member)

# 그런데 두 select문의 결과가 같을 떄는? --> 중복없이 한 번만 나옵니다. (자동으로 중복 제외)
# 중복제외 싫으면 union 대신 union all을 사용하면 됩니다. (union all하면 중복데이터도 같이 나오게 됩니다.)

select * from country;
select * from countrylanguage;
select * from city;

# quiz 11
select CI.Name 도시이름,
CO.Name 나라이름,
CI.Population 도시인구 
from city CI
inner join country CO on
CI.CountryCode = CO.Code
where CI.Population >= 9000000
order by 도시인구 desc;

# quiz 12
select CO.Name 나라이름, 
CL.CountryCode Code,
count() 공식언어수
from country CO on
CO.Code = CL.CountryCode
group by CO.name
having 공식언어수 >= 3
order by 공식언어수 desc;


