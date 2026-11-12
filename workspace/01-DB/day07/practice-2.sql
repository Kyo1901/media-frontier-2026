-- ============================================================
--  5일차 실습 ② — IN 서브쿼리 (여러 값) · 집합 연산자
-- ============================================================


-- [1] 사회부 기자가 쓴 기사가 몇 건인지 IN 서브쿼리로 구하세요.
--     힌트: WHERE reporter_id IN (SELECT id FROM reporters WHERE ...)
select count(*) as `사회부건수`
from articles
where reporter_id in (select id 
                      from reporters 
                      where department = '사회부');

-- [2] 같은 것을 JOIN 으로 구하세요. 결과가 같은가요?
--     🔴 두 쿼리를 나란히 실행해 숫자를 비교해 보세요.
select count(*) as `사회부건수`
from articles a
join reporters r on a.reporter_id = r.id
where r.department= '사회부';



-- [3] '정치' 와 '경제' 기사를 **둘 다** 쓴 기자를 INTERSECT 로 구하세요.
--     그다음 같은 답을 IN 서브쿼리로도 구해 보세요. 몇 명인가요?
select reporter from articles where section = '정치'
intersect
select reporter from articles where section = '경제';


select distinct reporter
from articles
where section = '정치'
  and reporter in (select distinct reporter
					from articles
					where section = '경제');
         


-- [4] 기사를 쓴 적이 있는 기자의 이름만 조회하세요. (가나다순)
--     힌트: WHERE id IN (SELECT DISTINCT reporter_id FROM articles)




-- ============================================================
--  생각해보기
-- ============================================================

-- [5] [1]과 [2]는 결과가 같습니다. 그렇다면 기사 제목과 함께
--     "기자 이름"까지 보여주려면 둘 중 무엇을 써야 할까요? 왜 그런가요?


-- [6] 더 해보기 (선택) — '정치' 기사는 썼지만 '경제' 기사는 **안 쓴** 기자를
--     EXCEPT 로 구하세요. NOT IN 으로 바꿔도 같은 답이 나오나요?
