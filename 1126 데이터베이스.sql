select * from city;
select * from country;
select * from countrylanguage;

select name 도시,
	format(population,0) 인구수 # format을 넣는 순간 문자 크기비교가 되어버림
from city
where countrycode = 'kor'
order by Population desc # 컬럼 alias인 인구수를 사용하면, 숫자비교 아닌 문자비교가 됩니다. 주의!!
limit 5;

# 확인문제 14번
select CO.name 나라, count(*) 도시수
	from country CO inner join city CI
    on CO.code = CI.CountryCode
group by 나라  # 표준SQL은 order by부터, mysql은 group by부터 컬럼 alias 사용 가능
order by 도시수 desc
limit 10;

# 확인문제 15번 (1)
select code 국가코드, name 국가명
	from country
    where code not in (select distinct countrycode from city);
    
# 확인문제 15번 (2)
select CO.code 국가코드, CO.name 국가명
 from country CO left outer join city CI 
 on CO.code = CI.countrycode
 where CI.CountryCode is null
 order by CO.code;
 
 # 확인문제 16번
 create table pay2 (select customer_id, amount, payment_date from sakila.payment limit 5000);
 select count(*) from pay2;
 
 # 확인문제 17번
 desc pay2; -- smallint unsigned, decimal(5, 2), datetime
 desc sakila.payment; -- 원본과 컬럼 타입 동일
 
 # 확인문제 18번
 select min(payment_date), max(payment_date) from pay2; 
 
 # 확인문제 19번
insert into pay2 values(1, 7.777, '10:10:10');

# 확인문제 20번
delete from pay2 where year(payment_date) not in (2005, 2006);
 
 # 확인문제 21번
 select date_format(payment_date, '%Y-%m') 년월, -- left(payment_date, 7) 년월 이렇게 해도 됩니다.
		count(*) 건수,
        sum(amount) 합
	from pay2
group by 년월 with rollup;
# order by 년월;
# 롤업이 있으므로 order by 하면 최종합 행이 맨 위로 올라감.
# 물론 내리는 방법도 있긴 한데, 이번 학기에 이것까지는 하지 않겠습니다. 

# 확인문제 22번
select P.customer_id 아이디,
concat(C.first_name, ' ' ,C.last_name) 이름,
 count(*) 건수, 
 sum(P.amount) 합
from pay2 P inner join sakila.customer C
  on P.customer_id = C.customer_id
group by 아이디
order by 아이디;

select * from sakila.customer limit 5;

# 확인문제 23번
use sakila;

SELECT first_name, COUNT(*) AS 수
FROM customer
GROUP BY first_name
HAVING COUNT(*) >= 2
ORDER BY first_name; 

# 확인문제 24번 (1) 서브쿼리 (O), 조인 (X)
SELECT CONCAT(first_name, ' ', last_name) AS '동명이인'
FROM customer
WHERE first_name IN (
    -- 이름이 2번 이상 등장하는 first_name만 추출하는 서브쿼리
    SELECT first_name
    FROM customer
    GROUP BY first_name
    HAVING COUNT(*) >= 2
)
ORDER BY first_name;

# 확인문제 24번 (2) 서브쿼리 (X), 조인 (O)
SELECT DISTINCT CONCAT(c1.first_name, ' ', c1.last_name) AS '동명이인'
FROM customer c1
INNER JOIN customer c2 
    ON c1.first_name = c2.first_name 
    AND c1.customer_id <> c2.customer_id
ORDER BY 1;




