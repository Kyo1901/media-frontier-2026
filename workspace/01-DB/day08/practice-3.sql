-- ============================================================
--  6일차 실습 ③ — 제약을 직접 걸어 본다
-- ============================================================
--
--  이 실습의 목적은 「만드는 것」이 아니라 **막히는 것을 눈으로 보는 것**입니다.
--  오류가 나면 성공입니다. 오류 번호와 문구를 주석으로 적어두세요.

# 기존 sections 테이블 삭제
drop table sections;

-- [1] sections 표를 만드세요.
--     · id   — 자동으로 붙는 번호, 기본키
--     · name — 20자 이내 글자, 비어 있으면 안 되고, 중복되면 안 된다
create table sections (
	id		int auto_increment primary key,
    name	varchar(20) not null unique
);

-- [2] 6개 섹션을 한 번의 INSERT 로 넣으세요.
--     정치 · 경제 · 사회 · 문화 · 스포츠 · IT
insert into sections(name)
values ('정치'), ('경제'), ('사회'), ('문화'), ('스포츠'), ('IT');



-- [3] 🔴 '정치' 를 한 번 더 넣어 보세요. 막혀야 합니다.
--     오류 번호와 문구를 아래에 적으세요.
--     오류: Error Code: 1062. Duplicate entry '정치' for key 'sections.name'
insert into sections(name)
values ('정치');



-- [4] 🔴 name 을 비운 채 넣어 보세요. 이것도 막혀야 합니다.
--     오류: Error Code: 1048. Column 'name' cannot be null
insert into sections(name)
values (NULL);



-- ★ [5] 여유가 되면 — 조회수 연습표를 만드세요. 이름은 view_log 로 합니다.
--     (1~4 를 못 끝냈으면 여기는 건너뛰어도 됩니다)
--     · id     — 자동 번호, 기본키
--     · cnt    — 정수, 비어 있으면 안 됨, 안 적으면 0
--     · 🔴 음수가 들어가지 못하게 CHECK 를 거세요
create table view_log (
	id	int auto_increment primary key,
    cnt int not null default 0 check (cnt >= 0)
);

-- [6] cnt 를 안 적고 한 줄 넣어 보세요. 0 이 들어가는지 확인하세요.
insert into view_log(id)
values (1);
select * from view_log;


-- [7] 🔴 cnt 에 -1 을 넣어 보세요. 막혀야 합니다.
--     오류: Error Code: 3819. Check constraint 'view_log_chk_1' is violated.
insert into view_log(cnt) values (-1);

drop table sections;
drop table view_log;

-- ★ 다 한 사람에게
--    UNIQUE 와 PRIMARY KEY 는 무엇이 다릅니까?
--    sections 에 UNIQUE 를 하나 더 걸 수 있을까요? 기본키는요?
