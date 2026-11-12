-- ============================================================
--  4일차 실습 ② — LEFT JOIN
-- ============================================================


-- [1] 모든 기자의 이름 · 부서 · 기사 수를 조회하세요.
--     🔴 기사가 0건인 기자도 반드시 나와야 합니다.
--     힌트: reporters 를 왼쪽에 두고 LEFT JOIN
select r.name, r.department, count(a.id)
from reporters r
left join articles a on a.reporter_id = r.id
group by r.id;



-- [2] 기사를 한 건도 쓰지 않은 기자만 조회하세요.
--     힌트: [1]에 HAVING 을 붙이거나, WHERE a.id IS NULL
select r.name, r.department
from reporters r 
left join articles a on a.reporter_id = r.id
# where a.id is null;
group by r.id having count(a.id) = 0;





-- ============================================================
--  반드시 실행할 것 — 두 결과를 비교할 것
-- ============================================================

-- [3] LEFT JOIN 의 전체 줄 수를 세어보세요.
--     articles 가 500건인데 왜 500이 아닐까요?

SELECT COUNT(*) FROM reporters r
LEFT JOIN articles a ON a.reporter_id = r.id;

-- 몇 줄인가요? 501
-- 왜 그런가요? r.id 가 19 인 기자까지 포함 


-- [4] COUNT(*) 와 COUNT(a.id) 를 나란히 놓고 실행해,
--     한서윤 기자의 값이 어떻게 다른지 확인하세요.

SELECT   r.name,
         COUNT(*)    AS 별표,
         COUNT(a.id) AS 열
FROM     reporters r
LEFT JOIN articles a ON a.reporter_id = r.id
WHERE    r.name = '한서윤'
GROUP BY r.id;

-- 왜 다른가:


-- [5] 더 해보기 (선택) — 아래 쿼리는 ON 이 빠져 있습니다.
--     실행하기 전에 몇 줄이 나올지 먼저 적고, 실행해서 확인하세요.
--     그 숫자는 어디서 나왔을까요?  (힌트: 기자 수 × 기사 수)

SELECT COUNT(*)
FROM   reporters r
JOIN   articles  a;

-- 예상: ____ 줄   실제: ____ 줄
