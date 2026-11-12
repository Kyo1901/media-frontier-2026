-- ============================================================
--  4일차 실습 ③ — 종합 (JOIN + GROUP BY)
-- ============================================================


-- [1] 부서별 건수 · 평균 조회수 · 평균 댓글 수를 함께 조회하세요.
--     평균 조회수 높은 순으로.
select	r.department,
		count(*) as `건수`,
        avg(a.views) as `평균조회수`,
        avg(a.comments) as `평균댓글수`
from articles a 
join reporters r on a.reporter_id = r.id
group by r.department
order by `평균조회수` desc;
        



-- [2] 2024년 1월 1일 이후 입사한 기자의 이름 · 입사일 · 기사 수를
--     입사일 순으로 조회하세요.
--     🔴 기사가 0건인 사람도 포함해야 합니다.
select	r.name, r.hired_at, count(a.id) as `건수`
from reporters r
left join articles a on a.reporter_id = r.id
where r.hired_at >= '2024-01-01'
group by r.id
order by r.hired_at;




-- [3] 부서별로 「담당 밖 기사」가 몇 건인지 조회하세요.
--     담당 밖 = 기사의 section 이 그 기자의 department 와 다른 것
--     힌트: REPLACE(r.department, '부', '') 로 '정치부' → '정치'
select r.department, count(a.id) as `건수`
from articles a
join reporters r on a.reporter_id = r.id
where a.section != REPLACE(r.department, '부', '')
group by r.department
order by `건수` desc;




-- [4] 기사를 가장 많이 쓴 기자 상위 5명을 부서와 함께 조회하세요.


-- [5] ★ 더 해보기 — 같은 부서의 동료 짝을 셀프 조인으로 구하세요.
--     reporters 에 별칭을 두 개(r1 · r2) 붙이면 같은 표를 서로 다른 표처럼 붙일 수 있습니다.
--     ① ON 에 「부서가 같다」만 넣었을 때 몇 줄입니까?
--     ② r1.id <> r2.id 를 더하면? ③ r1.id < r2.id 로 바꾸면?
--     숫자가 왜 줄어드는지 주석으로 적으세요.
