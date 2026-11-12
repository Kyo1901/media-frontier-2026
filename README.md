# 미디어 프론티어 2026 — 수업 중 작성한 코드

[미디어 프론티어] 데이터 분석을 통한 고객경험 설계과정에서 **수업 시간에 강사가 함께 친 코드**를 모아 둔 저장소입니다.

- 📘 강의 자료(슬라이드 · 실습 파일 · 가이드): https://kyo1901.github.io/media-frontier-lecture/
- 💻 수업 중 작성한 코드: 이 저장소

> 강의 자료의 실습 파일(`practice.py` 등)은 **문제**이고, 여기 있는 것은 **수업 시간에 같이 쳐 본 코드**입니다.
> 실습 정답과 다를 수 있습니다 — 설명하면서 고치거나 일부러 틀려 본 코드도 들어 있습니다.

## 폴더 구조

```
workspace/
  01-DB/          MySQL — dayNN/ 아래에 그날 친 SQL
  02-HTML_CSS/    HTML · CSS — dayNN/ 아래에 그날 만든 파일
  03-Crawling/    Python 크롤링 — dayNN/
data/
  articles.sql    실습 데이터 (기사 500건)
  reporters.sql   실습 데이터 (기자)
```

## 받는 법

처음 한 번:

```
git clone https://github.com/Kyo1901/media-frontier-2026.git
```

그다음부터는 매일:

```
git pull
```

Git 이 어렵다면 초록색 **Code → Download ZIP** 으로 받아도 됩니다.

## 실행 방법

| 과목 | 어떻게 |
| --- | --- |
| DB | MySQL Workbench 에서 `data/articles.sql` 을 먼저 실행한 뒤 각 날짜의 `.sql` |
| HTML/CSS | `.html` 파일을 브라우저로 열기 (VS Code 의 Live Server 권장) |
| 크롤링 | VS Code 에서 인터프리터를 `anaconda3` 로 고르고 오른쪽 위 ▶ 실행 · 연습 사이트를 띄운 상태여야 합니다 |

## 주의

- **크롤링 연습 사이트는 이 저장소에 없습니다.** 수업에서 강사 PC 에 띄운 주소를 쓰세요.
- 크롤링으로 모은 데이터는 **수업 안에서만** 씁니다. 다른 곳에 올리지 마세요.
- 내 PC 에서 고쳐 본 파일은 `git pull` 할 때 충돌이 날 수 있습니다 —
  내 코드는 **다른 폴더에 복사해 두고** 이 저장소는 받기만 하세요.

## 진행 현황

| 과목 | 기간 | 상태 |
| --- | --- | --- |
| DB (MySQL) | 10/19 ~ | ✅ 완료 |
| HTML/CSS | 11/02 ~ 11/09 | ✅ 완료 |
| 크롤링 (Python) | 11/10 ~ 11/13 | 🔄 진행 중 |
| 미니프로젝트 | 11/16 ~ | |
