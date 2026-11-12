-- ============================================================
--  2일차 실습 ② — 집계 함수 · GROUP BY
-- ============================================================


# count() : 개수 -> 데이터의 수(행의 수)
# sum()   : 합계 -> 각 행의 데이터 합계
# max()   : 최대 -> 각 행 중에서 큰 값


-- [1] 기사가 가장 많은 섹션 3개를 조회하세요. (섹션 · 건수)
# → 섹션별 기사 건수 = 섹션 별로 그룹
select section, COUNT(*) as `건수`
from articles
group by section
order by `건수` desc
limit 3;



-- [2] 섹션별 평균 댓글 수를 높은 순으로 조회하세요.
--     힌트: ROUND() 로 소수점을 정리하면 읽기 좋습니다.
select	section, 
		round(avg(comments), 2) as `평균댓글` # 소수 둘째자리
from articles
group by section
order by `평균댓글` desc;

-- [3] 기자별 기사 수를 많은 순으로 상위 10명 조회하세요.
select reporter, count(*) as `건수`
from articles
group by reporter
order by `건수` desc
limit 10;

-- [4] 월별 기사 수를 조회하세요.
--     힌트: DATE_FORMAT(published_at, '%Y-%m') 이
--          '2026-04' 형태를 만듭니다.
--     날짜를 원하는 형식의 문자열로 바꾸는 MySQL 함수입니다.
select 	date_format(published_at, '%Y-%m') as `월`, 
		count(*) as `건수`
from articles
group by `월`
order by `월`;



-- ============================================================
--  더 해보기
-- ============================================================

-- [5] 섹션이 몇 종류인지, 기자가 몇 명인지 한 번에 조회하세요.
--     힌트: COUNT(DISTINCT ...)
select	count(distinct section) as `섹션 종류`,
		count(distinct reporter) as `기자 수`
from articles;



-- [6] 섹션별로 COUNT(*) 와 COUNT(views) 를 나란히 조회하세요.
--     두 값이 다른 섹션이 있나요? 왜 다를까요?
select	section,
		count(*) as `전체`,
        count(views) as `실데이터 수`,
        count(*) - count(views) as `누락 수`
from articles
group by section;


# 지금까지 배운 SQL 절

# select : 조회하기 데이터 종류 → 기존 테이블의 컬럼, 집계, 연산
# from	 : 조회할 테이블
# where	 : 각 행(줄)마다 조건을 검사
# group by : 특정 컬럼을 그룹으로 지정
# order by : 특정 컬럼을 기준으로 정렬
# limit    : 제한된 수만 조회

# SQL 절 실행 순서: 
#  from → where → group by → select → order by → limit








