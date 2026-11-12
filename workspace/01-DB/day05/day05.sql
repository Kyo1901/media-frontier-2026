use newsdb;

# 기자별 댓글 참여율
#  댓글참여율 = 총댓글수/총조회수 * 100
#  (기자, 댓글참여율)

select	reporter,
		sum(comments) / sum(views) * 100 as `참여율`
from articles
group by reporter
order by `참여율` desc;
# 참여율의 차이가 5배 가까이 차이가 나기 때문에
# 각 기자별 섹션을 분석해보자
# → 이서연, 장예은, 조채원, 서지훈, 김준영

# 기자별 총 조회수, 건당 평균 조회수
select	reporter,
		sum(views) as `총조회수`,
        avg(views) as `건당평균`
from articles
group by reporter
order by `총조회수` desc 
limit 5; 
# 정다은, 김준영, 조도현, 이서연, 서수빈
        
# 결측값을 포함한 평균
#  coalesce(값, 기본값)
#   값이 없거나 null 인 경우 기본값으로 치환
select 
	avg(views) as `null 제외`,
    avg(coalesce(views, 0)) as `null 포함`
from articles;

# 섹션 x 등급별 건수
#  - 조회수에 따른 등급: 인기, 보통, 저조
select	section,
		case when views >= 10000 then '인기'
             when views >= 3000 then '보통'
             else '저조' 
		end as `등급`,
        count(*) as `건수`
from articles
group by section, `등급`  # 섹션별 등급을 그룹
order by section, `등급`; # 섹션을 오름차순, 동일한 섹션 내에서는 등급을 기준


# 기자들의 부서를 알기 위해 한 '김예은' 기자가 작성한 기사를 조회
select section, count(*) as `건수`
from articles
where reporter = '김예은'  # 기사 중 기자가 '김예은'인 기사만 조회
group by section
order by `건수` desc;
# → 사회(33), 정치(4), 경제(2), ...
# → 사회가 압도적으로 높기 때문에 '사회'를 담당하는 부서일 수 있다. - 예측
# → 실제 기자가 속한 부서는 '사회'가 아닐 수 있다.

# -------------------------------------------------------------------

# reporters.sql 파일 실행 후 reporters 테이블과 함께 실습

select * from articles; # 전체 조회

# reporter_id 가 모두 저장됐는지 확인
select 	count(*) as `건수`,
		count(reporter_id) as `삽입건수`,
from articles;
# 건수: 전체 기사 수
# 삽입 건수: 새로 삽입된 데이터의 수

select *
from reporters;


# 기사 제목, 섹션, 기자 번호
select title, section,reporter, reporter_id
from articles limit 5;

# articles
#  1 / 여아 예산안 ~ / 정치 / 18

# reporters
#  18 / 조채원 / 정치부 / 2024-04-11

# articles.reporter_id = reporters.id
#  1 / 여아 예산안 ~ / 정치 / 18 / 18 / 조채원 / 정치부 / 2024-04-11

select a.title, r.name, r.department
from articles a 
join reporters r on a.reporter_id = r.id;


# 부서가 '정치부'인 기자들이 작성한 기사들을 조회
select a.title, a.views, r.name 
from articles a 
join reporters r on a.reporter_id = r.id
where r.department = '정치부'
order by a.views desc
limit 5;







