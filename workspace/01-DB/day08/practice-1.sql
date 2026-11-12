-- ============================================================
--  6일차 실습 ① — 넣기 · 고치기 · 지우기
-- ============================================================
--
--  「내가 스크랩한 기사」 표를 만들어 직접 넣고 · 고치고 · 지웁니다.
--  🔴 articles · reporters · sections 는 건드리지 마세요. 이 연습표에서만 합니다.
--     마지막 [9] 에서 표를 지우므로 망가뜨려도 괜찮습니다.
--  🔴 한 문장 칠 때마다 SELECT 로 확인하세요. 그게 오늘의 습관입니다.


-- [1] scraps 표를 만드세요.
--     · id    — 자동으로 붙는 번호, 기본키
--     · title — 기사 제목, 100자 이내 글자
--     · memo  — 내 메모, 200자 이내 글자
--     · score — 내가 매긴 점수, 정수
create table scraps(
	id		int auto_increment primary key, 
    title	varchar(100), 
    memo	varchar(200), 
    score 	int 
);


-- [2] 스크랩 세 건을 넣으세요.
--     첫 번째는 한 줄짜리 INSERT 로, 나머지 두 개는 INSERT 하나에 «여러 줄»로 넣습니다.
--
--       제목                           메모               점수
--       여야 예산안 놓고 공방            정치 1번 기사        4
--       반도체 정책 발표에 업계 촉각      경제 — 다시 읽기     2
--       미술관 전시 개막                 주말에 가 보기       3
insert into scraps(title, memo, score)
values ('여야 예산안 놓고 공방', '정치 1번 기사', 4);

insert into scraps(title, memo, score)
values 	('반도체 정책 발표에 업계 촉각', '경제 - 다시 읽기', 2),
		('미술관 전시 개막', '주말에 가 보기', 3);


-- [3] 표 전체를 조회하세요. 몇 줄입니까? id 는 몇 번부터 붙었습니까?
select * from scraps;



-- [4] 이번에는 «제목만» 적어서 한 건 넣으세요.  제목: 수도권 조사 결과 공개
--     그다음 그 줄을 조회하세요. memo 와 score 에는 무엇이 들어 있습니까?
insert into scraps (title) values ('수도권 조사 결과 공개');
select * from scraps where id = 4;



-- [5] 2번 스크랩의 점수를 5 로 고치세요.
--     🔴 고치기 «전에» 같은 WHERE 로 SELECT 부터
--          — 고칠 줄이 정말 한 줄인지 보세요.
--     고친 뒤에 다시 조회해 확인하세요.
select * from scraps where id = 2;
update scraps set score = 5 where id = 2;



-- [6] 점수가 3 이하인 스크랩을 지우세요.
--     ① 먼저 SELECT 로 지울 대상을 확인하세요. 몇 건입니까? id 는 몇 번입니까?
--     ② 확인한 id 로 DELETE 하세요.
--     🔴 Workbench 에서 WHERE score <= 3 으로 바로 지우면 1175 오류가 납니다 —
--        안전장치가 «키(id)가 아닌 열로 지우는 것»을 막기 때문입니다. 그래서 ①→② 순서입니다.
select * from scraps where score <= 3;
delete from scraps where id = 3;

select * from scraps;



-- [7] 남은 줄 수를 세세요. 몇 줄입니까?
--     [4] 에서 넣은 4번은 점수가 없는데 왜 [6] 에서 안 지워졌을까요? 주석으로 적으세요.
select count(*) as `남은수` from scraps;



-- [8] ★ 더 해보기 — WHERE 를 빼고 UPDATE 하면 어떻게 될까요?
--     아래 두 줄을 실행해 보세요. (첫 줄은 Workbench 라면 이미 켜져 있는 안전장치입니다)

SET SQL_SAFE_UPDATES = 1;
UPDATE scraps SET score = 0;
select * from scraps;

--     오류 번호와 뜻을 적으세요. 안전장치가 없었다면 몇 줄이 바뀌었을까요?




-- [9] 다 썼으면 표를 지우세요. 그리고 정말 없어졌는지 확인하세요.
--     힌트: SHOW TABLES LIKE 'scraps';


