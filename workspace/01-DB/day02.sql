# 새 파일: ctrl + t
# 커서가 위치한 쿼리 실행 : ctrl + enter

# newsdb 데이터베이스를 사용
use newsdb;

# articles 테이블 전체(*) 조회
select * 		# 모든 열을 선택
from articles;  # article 테이블로부터

# aritlces 테이블에서 title 과 section 을 조회 
select title, section
from articles;

# articles 테이블에서 기사 제목과 조회 수를 조회
#  → 다른 별칭(alias) 부여하기 위해 as 키워드를 사용
select title as `제목`, views as `조회 수`
from articles;

# 각 기사의 댓글 비율을 조회
#  = 댓글수 / 조회수 * 100
select 	title,
		views,
        comments,
        comments / views * 100 as `댓글 비율`
from articles;


# articles 테이블에서 기사 섹션 종류 조회
#  → 섹션을 중복 없이 조회
select distinct section
from articles;


# articles 테이블에서 기사 10건만 조회
#  → limit 키워드로 조회할 데이터 수를 제한한다.
select title, views
from articles
limit 10;

# 조회수가 가장 높은 기사 10건을 조회
#  → order by: 정렬(오름차순:asc, 내림차순:desc)
select title, views
from articles
order by views desc
limit 10;


# 조회수가 가장 낮은 기사 10건을 조회
select title, views
from articles
order by views is null, views asc
limit 10;

# -----------------------------------------------

# 스포츠 기사만 조회
#  section 이 '스포츠'인 경우
select title, section, views
from articles
where section = '스포츠';

# 조회수가 10000 이상인 기사만 조회
#  - 초과: 크다. 			a > b
#  - 이상: 크거나 같다.		a >= b
#  - 미만: 작다.			a < b
#  - 이하: 작거나 같다.		a <= b
select title, section, views
from articles
where views >= 10000;

# 정치를 제외한 기사만 조회
#  - 데이터가 일치하지 않는지 검사하는 연산자 : <>, !=
select title, section, views
from articles
#where section <> '정치';
where section != '정치';


# IT 와 문화 기사만 조회
#  = 섹션이 IT "이거나" 문화인 경우
#  → 둘 중 하나라도 해당하는 경우에는 OR 연산자를 사용
select title, section, views
from articles
# where section = 'IT' or '문화'; → 정상처리 X
where section = 'IT' or section = '문화';


# 조회수가 10000 이상인 사회 기사만 조회
#  = 조회수가 10000 이상"이면서" 섹션이 '사회'인 경우
#  → 둘 다 해당하는 경우 AND 연산자
select title, section, views
from articles
where views >= 10000 and section = '사회';


# 정치 기사이거나 조회수가 10000 초과인 경제 기사를 조회
#  조건1 : 섹션이 '정치'인 경우
#  조건2 : 조회수가 10000 초과이면서 섹션이 '경제'인 경우
# 	조건2-1: 조회수가 10000 초과인 경우
#   조건2-2: 섹션이 '경제'인 경우
select 	title, section, views
from 	articles
where 	section = '정치' or views > 10000 and section = '경제'
order by section;

# 섹션이 '정치' 또는 '경제' 이면서 조회수가 1만 초과인 경우
#  → 조회수가 1만 초과인 정치 기사
#  → 조회수가 1만 초과인 경제 기사
#  → 여러 연산(또는 조건)을 다룰 때는 우선 순위를 신경써야한다.
#    → 우선 순위를 명시할 때는 소괄호를 이용한다.
select 	title, section, views
from 	articles
where 	(section = '정치' or section = '경제') 
and 	views > 10000
order by section;


# 범위 검사
#  - 비교 연산자로 검사할 경우 
#    표현식이 길어지고 가독성이 점점 떨어지게 된다.
#  - between 연산자 통해 범위를 검사

# 조회수가 5000 이상 10000 이하인 기사 조회
select title, section, views
from articles
where views between 5000 and 10000;
# where views >= 5000 and views <= 10000;

# 섹션이 정치, 경제, IT 기사 조회
select title, section, views
from articles
where section in ('정치', '경제', 'IT');
# where section = '정치' or section = '경제' or section = 'IT';



# 부분 일치
#  like 연산자와 '%', '_' 문자를 사용
#  '%' : 임의의 글자들(0글자 이상)
#  '_' : 한 글자
select title
from articles
where title like '%정책%'; # ~~정책~~ 인 기사

select title
from articles
where title like '반도체%'; # 반도체~~~ 인 기사

select title
from articles
where title like '%발표'; # ~~발표 인 기사


# NULL 검사
#  - NULL : "아무 값도 없음" 을 의미
#  - IS NULL 과 IS NOT NULL 을 통해 NULL 과 비교

select count(*) from articles; # = 500

select count(*) from articles where views >= 5000; 
# = 184

select count(*) from articles where views < 5000; 
# = 291

# 조회수가 NULL 인 기사
select title, views 
from articles
where views is null;

# 조회수가 NULL 이 아닌 기사
#  = 조회수가 있는 기사
select title, views
from articles
where views is not null;


# 날짜 조건
#  - 2026-09-01 ~ 2026-09-30 까지의 기사
#  - 날짜 범위는 다음날 미만으로 조건을 작성
select title, published_at
from articles
where published_at >= '2026-09-01'
  and published_at < '2026-10-01';
# where published_at between '2026-09-01' and '2026-09-30 00:00:00';
# 30일 00:00:01 ~ 23:59:59 인 기사는 포함되지 않는다.


