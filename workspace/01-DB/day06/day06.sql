use newsdb;

select * from articles;
select * from reporters;

# articles 테이블과 reporters 테이블의 정보를 합치기
# = Join
# → 어떤 테이블들을 가지고 합칠 것인지
# → 무엇을 기준으로 합칠 것인지
select * 
from articles 
join reporters on articles.reporter_id = reporters.id;

# 조회할 컬럼을 지정할 때도 테이블이름과 함께 지정하면
# 이후 충돌을 방지할 수 있다.
select articles.title, reporters.name, reporters.department
from articles 
join reporters on articles.reporter_id = reporters.id;

# 테이블의 이름을 그대로 쓸 경우 쿼리문이 길어지기 때문에
# 테이블에도 별칭을 부여
select a.title, r.name, r.department
from articles a
join reporters r on a.reporter_id = r.id;
# ------------------------------------------------------------

select r.name, count(*) as `건수`
from reporters r
join articles a on a.reporter_id = r.id
group by r.id;
# → Join 은 양쪽 모두 해당하는 행만 남긴다.
#   = inner join

# Left Join
#  - 왼쪽 테이블의 모든 행을 두고 Join
select r.name, count(a.id) as `건수`
from reporters r
left join articles a on a.reporter_id = r.id
group by r.id;
# → count(*) = 모든 행의 개수를 구하기 때문에 NULL 로 채워진 행도 포함
# → 기자가 작성한 기사의 개수를 구하기 위해 count(a.id) 로 작성


# cross join
#  - on 절을 작성하지 않은 경우에 발생
select count(*)
from reporters r join articles a;
# 9500개의 행이 생성


# self join
select 	r1.name as `기자`,
		r2.name as `동료`,
        r1.department as `부서`
from reporters r1
join reporters r2 on r1.department = r2.department
				  and r1.id < r2.id
order by `기자`;

# ---------------------------------------------------------

# 부서별 집계
select 	r.department,
		count(*) as `건수`,
		avg(a.views) as `평균조회수`
from articles a
join reporters r on a.reporter_id = r.id
group by r.department
order by `평균조회수` desc;

# 섹션별 집계
select section, avg(views) as `평균조회수`
from articles
group by section
order by `평균조회수` desc;

# 부서별 집계와 섹션별 집계에서 '문화부'와 '문화' 섹션의 차이가 6배정도 난다.
# → 원인을 찾아보자

# 문화부인 기자들이 작성한 기사들의 섹션을 파악
select 	r.name, 
		a.section, 
        count(*) as `건수`, 
        max(a.views) as `최대조회수`
from articles a
join reporters r on a.reporter_id = r.id
where r.department = '문화부'
group by r.name, a.section
order by `최대조회수` desc;
# 정다은 기자의 '경제' 섹션의 기사가 51만조회수를 가지고 있다.
#  → 문화 기사와 문화부 기자가 작성한 기사는 다르다.







