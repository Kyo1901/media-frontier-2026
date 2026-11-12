# 기자별 생산성
SELECT   reporter,
         COUNT(*)          AS 건수,
         ROUND(AVG(views)) AS 평균조회수,
         COUNT(*) * ROUND(AVG(views)) AS 총조회수
FROM     articles
GROUP BY reporter
ORDER BY 평균조회수 DESC
LIMIT    5;

# 월별 집계
select 	date_format(published_at, '%Y-%m') as `월`,
		count(*) as `건수`,
        round(avg(views)) as `평균조회수`
from articles
group by `월`
order by `월`;
# 4월: 82건, 평균조회수=6319
# 9월: 73건, 평균조회수=14939
#  → 왜 9월이 높으냐?
#     능력이 좋은 기자, 인기 많은 섹션

# ----------------------------------------------
# 조건을 통해 값을 만들어 낼 수 있다.
#  	case when 조건 then 값
#   	 when 조건 then 값
#        ...
#        else 값 
#	end 

# 조회수가 10,000 이상이면 등급이 "인기"
# 조회수가 10,000미만 3,000 이상이면 등급이 "보통"
# 그 외인 경우 등급이 "저조"
select 	*,
		case 
			when views >= 10000 then '인기'
			when views >= 3000 then '보통'
			else '저조' 
        end as `등급`
from articles;

select 	*,
		case 
			when views >= 3000 then '보통'
			when views >= 10000 then '인기'
			else '저조' 
        end as `등급`
from articles
where views is not null;
# 첫번째 조건을 검사한 뒤 조건을 만족하면 해당 값으로 "확정"
#  = 두번째 조건을 검사조차 하지 않는다. 
# → 조회수가 10,000 이상인 기사는 3,000이상이기 때문에 '보통'으로 확정

# 조회수 등급별(인기, 보통, 저조) 건수를 조회
#  (등급, 건수)
# → 등급별로 개수 집계를 구하기 위해 등급별로 그룹을 지정
#    = '인기' 그룹 -> 해당 그룹의 기사 몇 건
#	 = '보통' 그룹 -> 해당 그룹의 기사 몇 건
#    = '저조' 그룹 -> 해당 그룹의 기사 몇 건
select case
		when views >= 10000 then '인기'
        when views >= 3000 then '보통'
        else '저조' end 
		as `등급`,
        count(*) as `건수`
from articles
where views is not null
group by `등급`;
		

# 섹션별 건수를 조회
select	section,
		count(*) as `전체`
from articles
group by section;

# 섹션별 인기 기사 건수를 조회
#  인기: 조회수가 10,000 이상인 기사
select	section,
		count(*) as `전체`,
        sum(views)
from articles
group by section;

select 	views,
		case 
			when views >= 10000 then 1
			else 0
		end as '인기여부'
from articles;

select	section,
		count(*) as `전체`,
        sum(case when views >= 10000 then 1 else 0 end) as `인기`
from articles
group by section
order by `인기` desc;




