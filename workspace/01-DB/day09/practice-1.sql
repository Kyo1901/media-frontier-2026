-- ============================================================
--  7일차 실습 ① — 종합 설계. 댓글 표를 설계한다 · 대댓글
-- ============================================================
--
--  🔴 정답이 하나가 아닙니다. **왜 그렇게 정했는지** 주석으로 적으세요.
--     채점은 "제약을 많이 걸었는가"가 아니라 "판단에 근거가 있는가"로 합니다.
--
--  먼저 6일차에 만든 sections 와 오늘 1차시에 만든 articles_v2 가 있어야 합니다.


-- [1] 댓글 표 comments_tbl 을 설계해 만드세요.
--     담아야 할 것: 어느 기사에 달렸는지 · 작성자 이름 · 내용 · 작성 시각
--
--     스스로 정할 것:
--       · 각 열의 타입은?              (내용은 길이를 알 수 있습니까?)
--       · 비어도 되는 열은 어느 것?
--       · 기본값을 줄 열이 있습니까?
--       · 기사를 가리키는 열에 외래키를 겁니까?
--
--     ▶ 정한 이유를 각 줄 옆에 주석으로 적으세요.
drop table comments_tbl; 	# 테이블 삭제

create table comments_tbl ( 
	id			int auto_increment primary key,
    # 어느 기사에 달렸는지 → 기사를 식별하기 위한 수단 = articles_v2 의 id 컬럼
    article_id 	int	not null,
    # 작성자 이름
    author	    varchar(20)	not null,
    # 내용
    body		varchar(500) not null,
    # 작성 시각
    created_at	datetime not null,
    foreign key (article_id) references articles_v2(id)
);

-- [2] 정상 댓글 두 건을 넣으세요. (articles_v2 에 있는 기사에)
insert into comments_tbl(article_id, author, body, created_at)
values (1, '홍길동', '잘 읽었습니다.', '2026-11-02 11:21:02'),
	  (1, '김민수', '다음 기사도 기대합니다.', '2026-11-04 12:11:22');

select * from comments_tbl;

-- [3] 🔴 잘못된 값 세 가지를 넣어 보고, 전부 막히는지 확인하세요.
--     ① 없는 기사 번호를 가리키는 댓글
--     ② 작성자 이름이 비어 있는 댓글
--     ③ 자기가 건 제약을 어기는 값 하나 (직접 고르세요)
--
--     막히지 않은 것이 있다면 — 제약이 실제로 안 걸린 것입니다. 정의를 다시 보세요.

insert into comments_tbl(article_id, author, body, created_at)
values (1999, '홍길동', '잘 읽었습니다.', '2026-11-02 11:21:02');
# → 없는 기사이기 때문에 등록이 되지 않는다.
# Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`newsdb`.`comments_tbl`, CONSTRAINT `comments_tbl_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles_v2` (`id`))

insert into comments_tbl(article_id, author, body, created_at)
values (1, null, '잘 읽었습니다.', '2026-11-02 11:21:02');
# → 작성자는 필수이기 때문에 빈 값이 될 수 없다.
# Error Code: 1048. Column 'author' cannot be null

insert into comments_tbl(article_id, author, body, created_at)
values (1, '이영희', null, '2026-11-02 11:21:02');
# → 내용도 필수이기 때문에 빈 값이 될 수 없다.
# Error Code: 1048. Column 'body' cannot be null



-- [4] 기사 제목과 댓글 내용을 함께 조회하세요.
--     articles_v2 와 comments_tbl 을 이어서, 댓글이 달린 기사만 나오게.
# 기사와 해당 기사에 달린 댓글을 출력
select a.id, a.title, c.author, c.body
from articles a
inner join comments_tbl c on a.id = c.article_id; # 댓글이 없는 기사는 조회 X 
# left join comments_tbl c on a.id = c.article_id;    # 댓글이 없는 기사도 조회


-- ============================================================
--  대댓글 — 댓글에 다는 답글
-- ============================================================
--  답글도 «댓글»입니다. 표를 새로 만들지 않고, comments_tbl 에
--  「어느 댓글에 단 답글인가」를 가리키는 열 하나를 더합니다.
--  그 열은 «같은 표»의 id 를 가리킵니다 — 표가 자기 자신을 가리키는 외래키입니다.
--  🔴 답글은 2번 기사에 답니다. 1번 기사의 댓글은 오늘 3·4차시에 씁니다 — 건드리지 마세요.


-- [5] comments_tbl 에 parent_id 열을 추가하세요. 원댓글이면 비워 둡니다(NULL).
--     그다음 parent_id 가 comments_tbl 의 id 를 가리키도록 외래키를 거세요.
--     힌트: 6일차 39번 「붙여 봅시다」 — ALTER TABLE … ADD CONSTRAINT … FOREIGN KEY … REFERENCES …

# parent_id 컬럼 추가
#  → 대댓글을 작성할 경우의 상위 댓글 id 
#  → 원댓글은 상위 댓글이 없기 때문에 null 이 추가되도록 설정
alter table comments_tbl add column parent_id int null;
desc comments_tbl;

# 컬럼의 외래키 제약 조건 설정
#  - 자기 참조 외래키
alter table comments_tbl
add constraint fk_comments_parent
foreign key (parent_id) references comments_tbl(id);


-- [6] 2번 기사에 원댓글 하나를 다세요 (parent_id 는 적지 않습니다).
--     그 원댓글의 id 를 SELECT 로 확인하세요. 🔴 몇 번일지 미리 짐작하지 마세요 —
--     [3] 에서 실패한 INSERT 가 번호를 먹었을 수 있습니다 (6일차 37번).
--     그다음 그 원댓글에 답글 두 개를 다세요 (parent_id 에 확인한 번호).
insert into comments_tbl(article_id, author, body, created_at)
values (2, '박민수', '근거 자료가 필요합니다.', '2026-10-27 14:00:00');

insert into comments_tbl(article_id, author,  body, created_at, parent_id)
select 2, '김성문', '저도 궁금합니다.', '2026-10-17 15:00:00', id
from comments_tbl where article_id = 2 and author = '박민수';

insert into comments_tbl(article_id, author,  body, created_at, parent_id)
select 2, '하준민', '기사 하단에 출처가 있습니다.', '2026-10-17 15:25:00', id
from comments_tbl where article_id = 2 and author = '박민수';

select * from comments_tbl;

-- [7] 답글과, 그 답글이 달린 원댓글을 «한 줄에» 나란히 조회하세요.
--     (답글 작성자 · 답글 내용 · 원댓글 작성자 · 원댓글 내용)
--     힌트: 같은 표에 별칭을 두 개 붙입니다 — 4일차 30~32번 「셀프 조인」.
--     몇 줄이 나와야 맞습니까?

# 2번 기사의 모든 댓글(원댓글 + 대댓글)
select * from comments_tbl where article_id = 2;

# 2번 기사의 원 댓글
select * from comments_tbl where article_id = 2 and parent_id is null;

# 댓글과 답글을 한 번에 조회 = 셀프 조인(self join)
select c.author as `답글작성자`, c.body as `답글`,
	   p.author as `원댓글작성자`, p.body as `원댓글`
from comments_tbl c
join comments_tbl p on c.parent_id = p.id;


-- [8] 🔴 막히는지 확인하세요. 오류 번호를 적으세요.
--     ① 없는 댓글(99999번)에 다는 답글
--     ② 답글이 달린 원댓글을 DELETE
--     둘 다 6일차에 본 오류입니다. 각각 무엇을 지켜 준 것입니까?




-- ★ 다 한 사람에게
--    articles_v2 에는 이미 comments 라는 「댓글 수」 열이 있습니다.
--    이제 댓글 표까지 생겼으니 그 열은 필요 없어진 걸까요?
--    지우는 쪽과 남기는 쪽, 각각의 이유를 적어보세요.
--    (2차시 정규화에서 이 이야기를 이어갑니다)
