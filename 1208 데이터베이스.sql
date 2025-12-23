show index from member;
create index apple on member(addr);
show table status like 'member';
analyze table member;

create unique index idx_member_mem_name on member (mem_name);

select * from member where mem_name='여자친구';

# 5장 view 뷰 - 보안 

create table aaa as (select a, b, c, from member);  -- 데이터 중복, 향후 데이터 일관성 없어짐.
create view aaa as (select a, b, c, from member);  -- 가상테이블(뷰) 향후 데이터 일관성 없어짐.