# 주석(Comments)
# 명령어 실행하는 방법
#  1. 번개 아이콘     : 파일 내의 모든 명령어를 한 번에 수행
#  2. ctrl + enter  : 커서가 위치한 명령어만 수행 

# https://kyo1901.github.io/media-frontier-lecture/
# https://naver.me/GfrGpDt2
create database newsdb character set utf8mb4;

use newsdb;

# 전체 조회
select * from articles;

# 총 데이터 수
select count(*) from articles;

# 조회수만 출력 
select views from articles;

# 기사 제목, 조회수를 출력
select title, views 
from articles;

# 기사 제목과 조회수를 한글 명칭으로 출력
#  - 한 단어인 경우 따옴표 없이 작성
#  - 두 단어 이상인 경우 백틱(``)으로 묶어서 작성
#     → 백틱or따옴표: 물결(~) 키를 누르면 나오는 문자
# as(alias) : 별칭을 지정하는 키워드
select title as `기사 제목`,
	   views as `조회 수`
from articles;


# 제목, 조회수, 댓글수를 출력
select title as `제목`,
       views as `조회 수`,
       comments as `댓글 수`
from articles;

# 제목, 조회수, 댓글수, 댓글 비율를 출력
#  → 댓글비율 = 댓글수/조회수 * 100
#  → 나누기(/)의 결과값은 항상 소수(네자리)로 계산
#  → 정수값을 원할 경우 'div' 연산자로 연산
#  → 소수점 자리를 줄이려면 round(..., 1)
select title as `제목`,
       views as `조회 수`,
       comments as `댓글 수`,
       # comments * 100 / views  as `댓글 비율` # 소수점 네자리
       comments * 100 div views  as `댓글 비율` # 정수
from articles;

# 섹션의 종류 출력
#  → 각 섹션을 중복 없이 출력
select distinct section 
from articles;

# 정렬(오름차순, 내림차순)
#  - desc : 내림차순
#  - asc  : 오름차순(기본)
# 조회수 내림차순으로 출력
select title, views
from articles
order by views desc;


