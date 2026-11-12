-- ============================================================
--  4일차 실습 ① — JOIN 기본
-- ============================================================
--
--  🔴 시작 전에 reporters.sql 을 실행했는지 확인하세요.
--     SELECT COUNT(*) FROM reporters;   → 19 가 나와야 합니다.
use newsdb;
SELECT COUNT(*) FROM reporters;
 
-- [1] 기사 제목 · 기자 이름 · 부서를 함께 조회하세요. (기사 id 순으로 10건)
--     힌트: FROM articles a JOIN reporters r ON a.reporter_id = r.id
select a.title, r.name, r.department
from articles a 
join reporters r on a.reporter_id = r.id
# order by a.id → 기본이 articles 의 id 오름차순
limit 10;


-- [2] 사회부 기자가 쓴 기사는 몇 건인가요?
--     그중 조회수 상위 5건의 제목과 기자명도 함께 뽑아보세요.
select count(*) as `사회부건수`
from articles a
join reporters r on a.reporter_id = r.id
where r.department = '사회부';
# = 118건 

select count(*) as `사회건수`
from articles
where section = '사회';
# = 121건
# → 소속(부서)와 섹션은 별개로 다뤄야한다.

select a.title, a.views, r.name
from articles a
join reporters r on a.reporter_id = r.id
where r.department = '사회부'
order by a.views desc
limit 5;


-- [3] 조회수가 10,000 이상인 기사의 제목 · 조회수 · 기자 · 부서를
--     조회수 높은 순으로 상위 10건만 조회하세요.
select a.title, a.views, r.name, r.department
from articles a
join reporters r on a.reporter_id = r.id
where a.views >= 10000
order by a.views desc
limit 10;



-- ============================================================
--  반드시 실행할 것 — 오류를 눈으로 직접 볼 것
-- ============================================================

-- [4] 아래 쿼리는 오류가 납니다. 실행해서 메시지를 확인하고,
--     왜 안 되는지 주석으로 적어보세요.

SELECT   id, title, name
FROM     articles a
JOIN     reporters r ON a.reporter_id = r.id;

-- 이유:
