use newsdb;

# sections 테이블을 생성
create table sections ( 
	# ID 기본키, 자동으로 번호 부여
	id		int auto_increment primary key,
    # 섹션 이름, 20자 이내, 중복 없이 값이 무조건 있어야한다.
    name	varchar(20) not null unique
);

# 섹션 6개 저장
insert into sections(name)
values ('정치'), ('경제'), ('사회'), ('문화'), ('스포츠'), ('IT');

# sections 테이블 조회
select * from sections;

create table articles_v2 (
	# 기사 테이블의 기본키
	id			int auto_increment primary key,
    # 기사 제목, 200자 이내, 값 필수
    title		varchar(200) not null,
    # 섹션 ID, sections 테이블의 번호, 값 필수
    section_id 	int not null,
    # 기자 ID, reporters 테이블의 번호, 값 필수
    reporter_id int not null,
    # 게시 시간, 날짜 + 시간, 값 필수
    published_at datetime not null,
    # 조회수,	 0 이상의 정수
	views		int check (views >= 0),
    # 댓글수, 값 필수, 기본 값: 0
    comments	int not null default 0,
    # 외래키 section_id 가 sections 테이블의 id 를 참조
    foreign key (section_id) references sections(id),
    # 외래키 reporter_id 가 reporters 테이블의 id 를 참조
    foreign key (reporter_id) references reporters(id)
);


# insert into ~ values ~  : 값을 직접 지정하여 저장
# insert into ~ select ~  : 조회된 데이터를 저장

# 저장할 데이터를 먼저 조회
select 
	a.title, 
    s.id, 	# sections 테이블의 id
    a.reporter_id, 
    a.published_at, 
    a.views, 
    a.comments
from articles a
join sections s on a.section = s.name
order by a.id;

# 조회한 데이터를 articles_v2에 그대로 저장
insert into articles_v2
	(title, section_id, reporter_id, published_at, views, comments)
select 
	a.title, 
    s.id, 	# sections 테이블의 id
    a.reporter_id, 
    a.published_at, 
    a.views, 
    a.comments
from articles a
join sections s on a.section = s.name
order by a.id;

select * from articles_v2;

# 기사에 대한 정보를 조회
#  - 제목, 섹션, 기자, 조회수

select title, section, reporter, views
from articles;
# → 데이터 저장, 수정, 삭제될 시 이상 현상 발생할 수 있다.

select 	title as `제목`, 
		s.name as `섹션`, 
        r.name as `기자`, 
        views as `조회수`
from articles_v2 a
join reporters r on a.reporter_id = r.id
join sections s on a.section_id = s.id
order by a.id;



