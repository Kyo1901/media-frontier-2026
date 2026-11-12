use newsdb;

select * from articles;
select * from reporters;

select a.title, r.name, a.views, a.comments
from articles a
inner join reporters r on a.reporter_id = r.id;


select r.name, r.department, count(a.id) `건수`
from reporters r
left join articles a on a.reporter_id = r.id
group by r.id
order by `건수` desc;
# ---------------------------------------------------

# 서브쿼리
#  - 쿼리 내의 작은 쿼리

# 조회수가 평균조회수보다 높은 기사
select title, views
from articles
where views > avg(views);
# → 오류 발생
#    ERROR 1111 (HY000): Invalid use of group function

# 조회수가 평균조회수보다 높은 기사
#  - 평균조회수
select avg(views) from articles;

select title, views
from articles
where views > (select avg(views) from articles)
order by views;


# 정치부 기자가 작성한 기사

# 기존: join
select a.title, a.section
from articles a
join reporters r on a.reporter_id = r.id
where r.department = '정치부';

# 오늘: 서브쿼리
select title, section
from articles
where reporter_id in (select id from reporters where department='정치부');


# 한 건도 작성하지 않은 기자
#  - 기사를 작성한 기자의 id 를 구하고
#  - 해당 id 에 포함되지 않은 기자를 조회
select name, department
from reporters
where id not in (select distinct reporter_id from articles);

# ----------------------------------------------------------

# UNION
#  - 두 쿼리문의 결과를 이어 붙이는 구문
#  - 열의 개수가 동일해야야 이어붙일 수 있다.

# 섹션이 'IT'인 기사를 작성한 기자
select distinct reporter from articles where section = 'IT';

# 섹션이 '문화'인 기사를 작성한 기자
select distinct reporter from articles where section = '문화';
# → 'IT' 기사를 쓴 기자=8명, '문화' 기사를 쓴 기자=10명
# → 두 쿼리에 모두 포함되는 기자: 김예은, 오수빈, 이지민, 장예은, 정다은

# UNION ALL
#  - 두 쿼리문의 결과를 그대로 이어서 붙인다. 
#  → 중복된 데이터가 있을 수 있다.
select distinct reporter from articles where section = 'IT'
union all
select distinct reporter from articles where section = '문화';

# UNION
#  - 두 쿼리문의 결과를 이어 붙인다.
#  → 중복된 데이터는 지운다.
select distinct reporter from articles where section = 'IT'
union
select distinct reporter from articles where section = '문화';


# INTERSECT
#  - 두 쿼리문에 동일한 값만을 조회
#  - 중복된 값은 지운다.
select reporter from articles where section = 'IT'
intersect
select reporter from articles where section = '문화';

# EXCEPT
#  - 첫 번째 쿼리에서 두 번째 쿼리를 제외한 값만을 조회
select reporter from articles where section = 'IT'
EXCEPT
select reporter from articles where section = '문화';

# ----------------------------------------------------------


# 부서별 평균
select r.department, avg(a.views) as `부서평균`
from articles a
join reporters r on a.reporter_id = r.id
group by r.department;


# 부서별 평균의 평균
select avg(`부서평균`) as `평균의평균`
from (select r.department, avg(a.views) as `부서평균`
      from articles a
      join reporters r on a.reporter_id = r.id
      group by r.department) as t



