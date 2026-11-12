-- ============================================================
--  3일차 실습 ① — 실전 집계
-- ============================================================


-- [1] 섹션별 총 조회수(SUM)를 높은 순으로 조회하세요.
--     건수 순위와 비교해 보세요. 순서가 같나요?
select	section,
		sum(views) as `총조회수`,
        count(*) as `건수`
from articles
group by section
order by `건수` desc;
# 총조회수 기준: 문화 < IT < 정치 < 사회 < 스포츠 < 경제
# 건수 기준   : 문화 < IT < 스포츠 < 경제 < 정치 < 사회



-- [2] 섹션별 댓글 참여율을 구해 높은 순으로 조회하세요.
--     참여율 = 총 댓글 수 / 총 조회수 × 100
--     힌트: SUM(comments) * 100.0 / SUM(views)
select	section,
		sum(comments) * 100 / sum(views) as `참여율`
from articles
group by section
order by `참여율` desc;



-- [3] 9월 평균 조회수가 유독 높은 이유를 찾아보세요.
--     9월 기사를 조회수 높은 순으로 5건만 보면 짐작이 갑니다.
# → 조회수가 이상하리 만큼 높은 443번 기사때문이다.
# → 해당 기사를 제외하면 다른 월별 평균과 비슷하다.


# 1. 월별 평균 조회수를 조회
select 	date_format(published_at, '%Y-%m') as `월`,
		count(*) as `건수`,
        round(avg(views)) as `평균조회수`
from articles
group by `월`
order by `월`;

# 2. 9월의 평균 조회수가 가장 높기 때문에
#    9월 기사들을 조회수가 높은 순으로 조회
select id, title, section, views
from articles
where published_at >= '2026-09-01' 
  and published_at <  '2026-10-01'
order by views desc
limit 5;

# 3. 443번 기사를 제외하고 월별 평균
select 	date_format(published_at, '%Y-%m') as `월`,
		count(*) as `건수`,
        round(avg(views)) as `평균조회수`
from articles
#where views < 500000
where id != 443
group by `월`
order by `월`;

-- ============================================================
--  더 해보기
-- ============================================================

-- [4] 조회수 등급별 건수를 구하세요.
--       10000 이상 = '인기' / 3000 이상 = '보통' / 나머지 = '저조'
--     힌트: CASE WHEN ... THEN ... ELSE ... END


-- [5] 기자별 총 조회수(SUM)로 상위 5명을 뽑아보세요.
--     건수 상위 5명과 얼마나 겹치나요?
select 	reporter,
		sum(views) as `총조회수`,
        count(*) as `건수`
from articles
group by reporter
#order by `총조회수` desc  # 정다은 > 김준영 > 조도현 > 이서연 > 서수빈
order by `건수` desc  	 # 조채원 > 김예은 > 이지민 > 이서연 > 조도현
limit 5;
# 이서연 기자와 조도현 기자가 두 기준 모두 상위권에 포함

-- [6] 더 해보기 — 섹션별 '인기'(조회수 1만 이상) 기사의 «비율»(%) 을 구하세요.
--     SUM(CASE ... THEN 1 ELSE 0 END) 로 인기 건수를 세고, 전체 건수로 나누면 됩니다.
--     건수 1위인 사회가 비율로도 1위인가요?
# 섹션
# 전체 건수
# 인기 건수
# 인기 비율

