use newsdb;

# 간단한 메모를 저장할 테이블 생성
create table memo (
	id		int auto_increment primary key,
    body	varchar(100),
    likes	int
);


# memo 테이블에 데이터 삽입(저장)
insert into memo (body, likes)
values ('첫 메모', 3);

# 여러 데이터 동시 삽입
insert into memo (body, likes)
values ('두 번째', 0), ('세 번째', 5);

# memo 테이블 조회
select * from memo;

# 테이블 내의 데이터 수정
select * from memo where id = 2; # 데이터 조회
update memo set likes = 10 where id = 2;

# 데이터 삭제
select * from memo where id = 3;
delete from memo where id = 3;

# 테이블 삭제
drop table memo;
# ------------------------------------------------
# DDL: Data Definition Language(데이터 정의어)
#  - CREATE : 테이블 생성
#  - ALTER  : 테이블 수정 = 구조 변경
#  - DROP   : 테이블 삭제
#  - TRUNCATE : 테이블 초기화
#  - RENAME : 테이블 이름 변경
# DML: Data Maniqulation Language(데이터 조작어)
#  - SELECT : 데이터 조회
#  - INSERT : 데이터 삽입
#  - UPDATE : 데이터 수정
#  - DELETE : 데이터 삭제
# DCL: Data Control Language(데이터 제어어)
#  - GRANT  : 권한 부여
#  - REVOKE : 권한 회수
# TCL: Transaction Control Language(트랜젝션 제어어)
#  - COMMIT	: 트랜젝션 변경사항 저장
#  - ROLLBACK : 트랜젝션 변경사항 취소, 이전 복구
#  - SAVEPOINT : 트랜섹션 내에 되돌림 지정 설정
#  - START TRANSACTION : 트랜젝션 시작
# -----------------------------------------------

# 테이블 정보 조회
desc articles;
show create table articles;



# sections 테이블 생성
#  - 섹션은 무조건 테이블에 저장되어야하며, 중복이 되어선 안된다.
create table sections (
	id		int auto_increment primary key,
    name	varchar(20) not null unique
);


# sections 테이블에 섹션 추가
insert into sections(name)
values ('정치'), ('경제'), ('사회'), ('문화'), ('스포츠'), ('IT');

select * from sections order by id;
# --------------------------------------------------------------------


# 외래키(Foreign key)
#  - 다른 테이블의 기본 키

select id, reporter_id from articles where id = 1;
# (1, 18)

update articles set reporter_id = 9999 where id = 1;
select id, reporter_id from articles where id = 1;
# reporter_id 를 통해 reporters 테이블에서 기자 정보를 조회를 해야하는데
# 잘못된 값이 들어온 순간 기자 정보를 조회할 수 없다.

update articles set reporter_id = 18 where id = 1;
alter table articles
	add constraint fk_articles_reporters
    foreign key (reporter_id) references reporters(id)
    on delete restrict;   # 기사가 남아있기 때문에 가지를 제거할 수 없다.(기본)
	#on delete cascade;    # 기자가 작성한 기사도 제거된다.
    #on delete set null;    # 기자 번호(reporter_id) 를 null 로 치환
    
update articles set reporter_id = 9999 where id = 1;
# 오류: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`newsdb`.`articles`, CONSTRAINT `fk_articles_reporters` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`))



