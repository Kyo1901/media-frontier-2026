-- ============================================================
--  2일차 실습 ① — WHERE · NULL
-- ============================================================


-- [1] 조회수(views)가 30000 이상인 기사를 조회하세요.
--     제목 · 섹션 · 조회수
select title, section, views
from articles
where views >= 30000;


-- [2] 섹션이 '정치' 또는 '사회'이면서, 댓글이 100개 이상인 기사를 조회하세요.
--     ⚠️ 괄호에 주의하세요. AND가 OR보다 먼저 계산됩니다.
select title, section, comments
from articles
where section in ('정치', '사회')
  and comments >= 100;



-- [3] 제목에 "발표"가 들어간 기사를 조회하세요.
select title
from articles
where title like '%발표%'; # ~발표~ 



-- [4] 조회수가 집계되지 않은(NULL) 기사가 몇 건인지 세어보세요.
--     힌트: COUNT(*) 와 IS NULL
select COUNT(*) as `null 건수`
from articles
where views IS NULL;



-- [5] 2026년 9월에 발행된 '사회' 기사를 조회수 높은 순으로 조회하세요.
--     ⚠️ 9월 30일 기사가 빠지지 않도록 주의하세요. 몇 건이 나오나요?
select title, section, published_at, views
from articles
where section = '사회'
  and published_at >= '2026-09-01' 
  and published_at < '2026-10-01'
  and view is not null
order by views desc;

-- ============================================================
--  생각해보기
-- ============================================================

-- [6] 아래 두 쿼리의 결과를 더하면 500이 될까요?
--     실행해서 확인하고, 이유를 주석으로 적어보세요.

SELECT COUNT(*) FROM articles WHERE views > 5000;
SELECT COUNT(*) FROM articles WHERE views <= 5000;

-- 답:



-- [7] 댓글이 5건 미만인 기사를 조회수와 함께 조회하세요.
--     어떤 섹션이 많은가요? 왜 그럴까요?
