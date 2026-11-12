-- ============================================================
--  5일차 실습 ① — 서브쿼리 기본 (값 하나)
-- ============================================================


-- [1] 평균보다 댓글이 많은 기사를 조회하세요. (제목 · 댓글수, 댓글 많은 순 10건)
--     힌트: WHERE comments > (SELECT AVG(comments) FROM articles)
select title, comments
from articles
where comments > (select avg(comments) from articles)
order by comments desc
limit 10;


-- [2] 조회수가 가장 많은 기사 1건을 조회하세요. (제목 · 조회수)
--     🔴 ORDER BY ... LIMIT 1 말고, MAX() 를 서브쿼리로 써서 풀어보세요.
select title, views
from articles
where views = (select max(views) from articles);
# → 최대 조회수가 동일한 기사가 만약 2건 이상이라면 모두 표시가 되어야한다.


-- [3] 기사 목록에 「전체 평균 조회수」를 열로 붙여 조회하세요.
--     (제목 · 조회수 · 전체평균, id 순 5건)
--     모든 줄에 같은 값이 붙습니다.
select title, views, (select avg(views) from articles) as `전체평균`
from articles
order by id
limit 5;



-- ============================================================
--  반드시 실행할 것 — 오류를 눈으로 직접 볼 것
-- ============================================================

-- [4] 아래 쿼리는 오류가 납니다. 실행해서 메시지를 확인하고,
--     왜 안 되는지 주석으로 적어보세요. (2일차 실행 순서를 떠올려 보세요)

SELECT title, views
FROM   articles
WHERE  views > AVG(views);

-- 이유:
