-- ============================================================
--  3일차 실습 ③ — 하나의 테이블로는 부족한 순간
-- ============================================================


-- [1] 기자별로 몇 개의 서로 다른 섹션에 기사를 썼는지 조회하세요.
--     (기자명 · 섹션수 · 건수), 섹션수가 많은 순으로.
--     힌트: COUNT(DISTINCT section)
select	reporter, 
		count(distinct section) as `섹션수`,
        count(*) as `건수`
from articles
group by reporter
order by `섹션수` desc;



-- [2] 섹션이 1개뿐인 기자가 있는지 확인하세요. 몇 명인가요?
--     힌트: 위 쿼리에 HAVING COUNT(DISTINCT section) = 1 을 붙이면 됩니다.

-- where  : 각 기사별로 조건을 검사
-- having : 각 그룹별로 조건을 검사
select reporter
from articles
group by reporter
having count(distinct section) = 1;
# → 잘못된 쿼리는 아니기 때문에 섹션 수가 1인 기자가 없다는 결론


-- [3] '조채원' 기자가 쓴 기사를 섹션별로 몇 건씩 썼는지 조회해,
--     어떤 섹션이 "주력"으로 보이는지 확인하세요.

# 1. 전체 기사들 중 '조채원' 기자가 작성한 기사들을 뽑고
# 2. 기사들을 섹션 별로 그룹으로 나눈다.
select section, count(*) as `건수`
from articles
where reporter = '조채원'
group by section
order by `건수` desc;



-- ============================================================
--  생각해보기 (SQL이 아닙니다)
-- ============================================================

-- [4] [2]의 결과를 보면, articles 테이블만으로 기자의 "소속 부서"를
--     확신할 수 있나요? 왜 그런가요? 한두 문장으로 적어보세요.
