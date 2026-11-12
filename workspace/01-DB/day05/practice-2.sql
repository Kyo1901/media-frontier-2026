-- ============================================================
--  3일차 실습 ④ — 종합
-- ============================================================


-- [1] 7월 이후(published_at >= '2026-07-01') 기사 중,
--     평균 댓글 수가 50 이상인 섹션을 평균댓글 높은 순으로 조회하세요.
--     (섹션 · 건수 · 평균댓글)
select 	section, 
		count(*) as `건수`,
        avg(comments) as `평균댓글`
from articles
where published_at >= '2026-07-01'
group by section
having `평균댓글` >= 50
order by `평균댓글` desc;

-- [2] 등급(인기 10000↑ · 보통 3000↑ · 저조)별로 평균 조회수와
--     평균 댓글 수를 함께 조회하세요.
select	case when views >= 10000 then '인기'
			 when views >= 3000 then '보통'
             else '저조' end as `등급`,
		avg(views) as `평균조회수`,
        avg(comments) as `평균댓글수`
from articles
group by `등급`;


-- [3] COALESCE 처리 전후로 섹션별 평균 조회수의 차이가 가장 큰 섹션을 찾으세요.
--     힌트: AVG(views) - AVG(COALESCE(views, 0)) 를 열로 계산해 정렬하세요.
--      → 결측 비율: 결측값이 얼마만큼 있느냐
select 	section,
		avg(views) - avg(coalesce(views, 0)) as `차이`
from articles
group by section
order by `차이` desc 
limit 1;
