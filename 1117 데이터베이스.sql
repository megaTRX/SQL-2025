# world에서, country에는 있는 국가인데, city에는 없는 국가의
# 국가코드(code), 국가명(name), 국가인구(population) 를 select 하세요.

desc country;
desc city;

select CO.code 국가코드, CO.name 국가명, CO.population 인구
from country CO
left outer join city CI 
on CO.code = CI.countrycode
where CI.countrycode is NULL
order by CO.code;

select * from member;