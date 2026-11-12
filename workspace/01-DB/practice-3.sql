-- ============================================================
--  2일차 실습 ③ — HAVING · 실행 순서
-- ============================================================

use newsdb;

select section, count(*)	# 섹션, 각섹션별 건수
from articles				# articles 테이블을 로드
where views >= 5000			# 각 기사마다 조회수가 5000이상인지 검사
							# 5000이상인 기사들만 선택
group by section 			# 섹션 별로 그룹을 지정
having count(*) >= 40;		# 각 그룹마다 40건 이상인지 검사
							# 40건 이상인 그룹만 선택


-- [1] 평균 조회수가 5,000 이상인 섹션을 조회하세요.
--     (섹션 · 건수 · 평균 조회수)
select	section, 
		count(*) as `건수`, 
        avg(views) as `평균조회수`
from articles
group by section
having `평균조회수` >= 5000;



-- [2] 기사를 30건 이상 쓴 기자를 조회하세요.
--     (기자명 · 건수 · 평균 조회수), 건수 많은 순(내림차순, desc)
--     평균 조회수는 소수점 둘째자리까지 출력
select 	reporter,
		count(*) as `건수`,
        round(avg(views), 2) as `평균조회수`
from articles
group by reporter
having `건수` >= 30
order by `건수` desc;
        


-- [3] 2026년 9월에 발행된 기사만으로 섹션별 건수를 구하되,
--     15건 이상인 섹션만 조회하세요.
--     ⚠️ WHERE 와 HAVING 을 각각 어디에 써야 할까요?
select 	section, count(*) as `건수`
from 	articles
where	published_at >= '2026-09-01'
  and 	published_at <  '2026-10-01'
group by section
having `건수` >= 15;
# where  : 각 기사별로 검사 = 각 행마다 검사
# having : 각 섹션별로 검사 = 각 그룹마다 검사


-- ============================================================
--  반드시 실행할 것 — 오류를 눈으로 직접 볼 것
-- ============================================================

-- [4] 아래 쿼리는 오류가 납니다. 실행해서 메시지를 확인하고,
--     왜 안 되는지 주석으로 적어보세요.

SELECT   section, COUNT(*)
FROM     articles
WHERE    COUNT(*) >= 60
GROUP BY section;

-- 이유:


-- [5] 아래 쿼리도 오류입니다. 이유가 [4]와 같을까요, 다를까요?

SELECT   section, title, COUNT(*)
FROM     articles
GROUP BY section;

-- 이유:


-- [6] 아래 두 쿼리는 비슷해 보이지만 결과가 완전히 다릅니다.
--     각각 몇 개 섹션이 나오는지 확인하고, 왜 그런지 적어보세요.
--     (힌트: MIN(views) 는 "그 그룹에서 가장 작은 조회수" 입니다)

SELECT section, COUNT(*) FROM articles
WHERE views >= 5000 GROUP BY section;

SELECT section, COUNT(*) FROM articles
GROUP BY section HAVING MIN(views) >= 5000;

-- 첫 번째 결과:      개 섹션
-- 두 번째 결과:      개 섹션
-- 왜 다른가:
