# 사용할 데이터베이스를 지정
use newsdb;

# articles 테이블 전체 조회
select * 
from articles;

# articles 테이블 내에서 조회수(views)가 10,000 이상인 기사만 조회
#  10,000 이상 = 10,000 보다 크거나 같다.
#   → '>=' 연산자를 사용
select * 
from articles
where views >= 10000;



# 댓글이 100개 이상인 IT 기사를 조회
#  1. 댓글이 100개 이상
#  2. 섹션이 'IT'
#  → 두 조건을 동시에 만족 = AND 연산자
select *
from articles
where comments >= 100 and section = 'IT';
# --------------------------------------------------

# 집계 함수
#  - 개수, 합계, 평균, 최대/최소 값

# 전체 데이터 개수(행의 수)
select count(*)
from articles;
# = 500

# 특정 열의 데이터 개수
select count(views)   # `조회수`의 개수
from articles;
# = 475 (NULL 을 제외한 개수)

# 섹션의 종류 개수
#  → 중복을 제거한 상태에서 섹션(distinct section)의 개수를 집계
select count(distinct section) as `섹션의 개수`
from articles;

# 기자(reporter)의 인원 수
select count(distinct reporter) as `기자 인원 수`
from articles;

# 합계(SUM), 평균(AVG)

# 총 조회수, 평균 조회수를 조회
select sum(views) as `총 조회수`, avg(views) as `평균 조회수`
from articles;


# 최대값(MAX), 최소값(MIN)

# 최대 조회수, 최소 조회수를 조회
select 	max(views) as `최대 조회수`, 
		min(views) as `최소 조회수`
from articles;


# 댓글의 합계, 평균, 최소, 최대를 조회
# --------------------------------------------


# GROUP BY 절
#  - 그룹 단위로 집계하기 위한 수단 

# 섹션 별 기사 개수를 조회
#  → 섹션의 종류를 그룹 단위로 묶어서 개수를 집계
select section, count(*) as `건수`
from articles
group by section
order by `건수`;


# 각 섹션 별 건수, 평균 조회수, 최대 조회수를 조회
select	section,
		count(*) as `건수`,
        avg(views) as `평균 조회수`,
        max(views) as `최대 조회수`
from articles
group by section;

# GROUP BY 사용시 주의
#  - 그룹 대상이 아닌 열을 작성할 경우 오류가 발생
#  → select 에는 그룹 기준과 집계 함수만 작성
select section, count(*) as `건수`
from articles
group by section;



# 각 기자별 기사 건수를 내림차순(DESC)으로 조회
select reporter, count(*) as `건수`
from articles
group by reporter
order by `건수` desc;


# 각 기자별 기사 건수와 총 조회수를 조회
#  - 총 조회수를 기준으로 내림차순으로 정렬
select 	reporter as `기자`, 
		count(*) as `건수`, 
		sum(views) as `총 조회수`
from articles
group by reporter
order by `총 조회수` desc;

# `~`(백틱)   : 칼럼(열), 테이블, 데이터베이스 이름을 지정 = 변수
# '~'(따옴표) : 문자열 데이터


# 여러 그룹으로 묶기
#  각 섹션별 기자를 그룹
select section, reporter, count(*)
from articles
group by section, reporter
order by section, reporter;


select reporter, section, count(*)
from articles
group by reporter, section
order by reporter, section;


# 각 섹션 별 조회수가 10,000 이상인 기사 건수를 조회
#  - 조회수가 10,000 이상인 기사들만 집계에 포함
select section, count(*) as `건수`
from articles
where views >= 10000
group by section;

# -----------------------------------------------------

# HAVING 절
#  - 그룹이 묶인 뒤 검사하기 위한 구문

# 60건이 넘는 섹션만 조회
select section, count(*) as `건수`
from articles
group by section
having count(*) >= 60;
# = 각 섹션별 건수가 60 이상인 섹션만 조회
# → 조건을 만족하는 그룹만 남긴다.


# 7월 이후 기사가 40건 이상인 섹션을 조회
select section, count(*) as `건수`, avg(views) as `평균`
from articles
where published_at >= '2026-07-01'
group by section
having `건수` >= 40
order by `평균` desc;




