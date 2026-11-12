-- 기자 명단 — 4일차 JOIN 실습용
-- 생성: node generate-reporters.js   (articles.sql 에서 역산 — 매번 같은 결과)
--
-- 🔴 articles.sql 을 먼저 실행한 뒤에 이 파일을 실행하십시오.

SET NAMES utf8mb4;
DROP TABLE IF EXISTS reporters;

CREATE TABLE reporters (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    hired_at   DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO reporters (name, department, hired_at) VALUES
('강도현', '문화부', '2024-03-07'),
('강현우', '문화부', '2021-05-01'),
('권민준', 'IT부', '2021-03-03'),
('김예은', '사회부', '2022-08-12'),
('김준영', '스포츠부', '2024-01-22'),
('김지훈', '경제부', '2024-10-06'),
('서수빈', '경제부', '2021-10-09'),
('서준영', 'IT부', '2023-08-02'),
('서지훈', '스포츠부', '2023-05-15'),
('오수빈', 'IT부', '2024-07-24'),
('이서연', '정치부', '2021-02-25'),
('이지민', '사회부', '2022-03-27'),
('장예은', '정치부', '2020-04-22'),
('장지민', '경제부', '2025-09-15'),
('장태윤', '스포츠부', '2022-06-02'),
('정다은', '문화부', '2019-11-28'),
('조도현', '사회부', '2019-11-27'),
('조채원', '정치부', '2024-04-11'),
('한서윤', '사회부', '2026-09-01');

-- articles 에 외래키 열을 붙이고 이름으로 채운다 (3일차 도해가 실제 스키마가 되는 지점)
ALTER TABLE articles ADD COLUMN reporter_id INT;

-- 🔴 MySQL Workbench 는 Safe Updates 가 기본 ON 이라, 키 열을 쓰지 않는 WHERE 없는
--    UPDATE 를 막는다 (Error Code: 1175). 이 세션에서만 꺼 두고 아래 UPDATE 를 돌린다.
--    환경설정에서 끄는 방법도 있지만 그쪽은 재접속까지 해야 해서 수업 중에는 이 편이 빠르다.
SET SQL_SAFE_UPDATES = 0;

UPDATE articles SET reporter_id = (
    SELECT id FROM reporters WHERE reporters.name = articles.reporter
);

SET SQL_SAFE_UPDATES = 1;   -- 원래대로 돌려놓는다

CREATE INDEX idx_articles_reporter_id ON articles(reporter_id);
