# ============================================================
#  실습 ② — 선택자로 원하는 것만 뽑는다
#
#  🔴 어제 문자열로 억지로 뽑던 것을 오늘 제대로 합니다.
#  🔴 주소는 칠판에 적힌 것으로 바꾸세요.
#  🔴 오늘은 **한 쪽**만 다룹니다. 여러 쪽 도는 것은 내일입니다.
#
#  실행:  VS Code 오른쪽 위 ▶  (또는 터미널에서 python practice.py)
# ============================================================

import requests
from bs4 import BeautifulSoup


BASE = "http://localhost:8000/"


def soup_of(path=""):
    """주소를 받아 수프로 만들어 돌려줍니다. 그대로 쓰세요.
    🔴 .text 가 아니라 .content 를 넘기는 것에 주목하세요 — 어제의 그것입니다."""
    return BeautifulSoup(requests.get(BASE + path).content, "html.parser")


soup = soup_of()


# ── [1] 어제 아팠던 것을 한 줄로 ────────────────────────
#  첫 기사 제목을 출력하세요. select_one 과 get_text 를 씁니다.
#
#  출력 형식:  [1] 여야 예산안 놓고 공방
#  🔴 어제 index() 두 번 쓰던 그것입니다. 몇 줄이 됐습니까?

# 제목은 .card 내의 a 요소에 있기 때문에 a 요소까지 탐색
print("[1]", soup.select_one('.card a').get_text(strip=True))


# ── [2] 태그만으로는 안 됩니다 ──────────────────────────────
#  두 개를 세어 출력하세요.
#    · 페이지의 <a> 전체     soup.select("a")
#    · 카드 안의 <a> 만      soup.select(".card a")
#
#  출력 형식:  [2] 29 20
#  🔴 왜 다릅니까? 차이나는 것들은 무엇입니까? (힌트: 메뉴·사이드·「다음」)

print("[2]", 
    len(soup.select('a')),        # 29 = 카드 + 메뉴, 사이트, 다음 버튼
    len(soup.select('.card a'))   # 20
    )          


# ── [3] 제목과 링크 ─────────────────────────────────────────
#  첫 카드의 <a> 하나를 골라서, **링크와 제목**을 함께 출력하세요.
#    · 글자는   .get_text(strip=True)
#    · 속성은   태그["href"]      ← 대괄호입니다
#
#  출력 형식:  [3] article/1.html 여야 예산안 놓고 공방

link_tag = soup.select_one(".card a")
print("[3]",
    link_tag.get('href'),           # href 속성 값을 반환
    link_tag.get_text(strip=True)   # 내부 문자를 반환
    ) 


# ── [4] 카드 하나를 dict 로 ─────────────────────────────────
#  첫 카드(li.card) 하나에서 아래 넷을 뽑아 dict 로 만드세요.
#    title         .card a 의 글자
#    section       .badge 의 글자
#    reporter      .reporter 의 글자
#    published_at  🔴 <time> 의 **datetime 속성**
#
#  출력 형식:  [4] 정치 조채원 2026-04-01 10:30:26
#
#  🔴 발행 시각을 get_text() 로 꺼내면 «2026-04-01 10:30» 이 나옵니다.
#     초가 없습니다. 속성에서 꺼내야 합니다 — 어제 개발자도구로 본 그것입니다.

c = soup.select_one('.card')
c_info = {
    'title':        c.select_one('a').get_text(strip=True),
    'section':      c.select_one('.badge').get_text(strip=True),
    'reporter':     c.select_one('.reporter').get_text(strip=True),
    'published_at': c.select_one('time').get('datetime')
}
print("[4]",
    c_info['section'],
    c_info['reporter'],
    c_info['published_at']
)         


# ── [5] 스무 개 전부 ────────────────────────────────────────
#  [4] 를 반복문으로 돌려 이 쪽의 카드를 전부 dict 리스트로 만드세요.
#  그리고 개수 · 첫 섹션 · 마지막 섹션을 출력하세요.
#
#  출력 형식:  [5] 20 정치 정치
#  🔴 여기까지가 오늘의 목표입니다.

cards = soup.select('.card')
card_list = []
for c in cards:
    card_list.append({
        'title':    c.select_one('a').get_text(strip=True),
        'section': c.select_one('.badge').get_text(strip=True)
    })

print("[5]", 
    len(card_list), 
    card_list[0]['section'],    # 첫 번째 기사의 섹션
    card_list[-1]['section'],   # 마지막 기사의 섹션
)        


# ── ★ [6] 없는 것을 고르면 어떻게 됩니까 ────────────────────
#  일부러 없는 클래스(.nope)를 골라 보세요.
#    · select_one(".nope") 는 무엇을 돌려줍니까?
#    · select(".nope") 의 길이는?
#
#  출력 형식:  [6] None 0
#
#  🔴 오류가 안 납니다. 그런데 여기에 .get_text() 를 붙이면 그때 터집니다.
#     한 줄 더 써서 직접 터뜨려 보세요. 무슨 오류입니까?  ______________

print("[6]", ...)          # ← 고치세요


# ── ★★ [7] 선택자는 그 페이지 구조에 붙습니다 ───────────────
#  상세 페이지(article/1.html)를 받아서
#    · li.card 가 몇 개인지
#    · .article h1 의 글자
#  를 출력하세요.
#
#  출력 형식:  [7] 0 여야 예산안 놓고 공방
#  🔴 같은 사이트인데 0개입니다. 왜입니까?

print("[7]", ...)          # ← 고치세요


# ── ★★ [8] 조회수가 없는 기사 ───────────────────────────────
#  3쪽(page-3.html)에서 .views 의 글자가 "-" 인 카드가 몇 개입니까?
#
#  출력 형식:  [8] 2
#  🔴 1·2쪽에는 없습니다. int("-") 를 하면 어떻게 됩니까? 내일 이걸 처리합니다.

print("[8]", ...)          # ← 고치세요


# ============================================================
#  실습 ②-2 (4차시) — 링크를 따라 상세 페이지로
#
#  🔴 [5] 를 못 끝냈으면 [5] 부터 끝내고 오세요. ★ 는 건너뛰어도 됩니다.
#  🔴 목록에서 쓰던 선택자(li.card)는 상세 페이지에 없습니다. 상세는 구조가 다릅니다.
# ============================================================


# ── [9] 상세 페이지 하나를 dict 로 ──────────────────────────
#  상세 페이지(article/1.html)를 받아서 아래 넷을 dict 로 만드세요.
#    title         .article h1 의 글자
#    reporter      .reporter 의 글자
#    published_at  🔴 <time> 의 datetime 속성 — 목록과 같습니다
#    comments      .comments 의 글자    ← 🔴 목록에는 없고 상세에만 있습니다
#
#  출력 형식:  [9] 여야 예산안 놓고 공방 조채원 2026-04-01 10:30:26 129

print("[9]", ...)          # ← 고치세요


# ── [10] 링크를 따라가서 맞춰 보기 ──────────────────────────
#  첫 쪽의 «마지막» 카드에서
#    ① 링크(href)를 꺼내고
#    ② soup_of(링크) 로 그 상세 페이지를 받은 뒤
#    ③ 목록의 제목 == 상세의 제목 인지,
#       목록의 발행시각(속성) == 상세의 발행시각(속성) 인지 비교하고
#    ④ 상세에만 있는 댓글 수를 출력하세요.
#
#  출력 형식:  [10] article/20.html True True 230
#  🔴 주소를 "article/20.html" 로 직접 쓰지 말고 카드에서 꺼내세요.
#     그래야 내일 스무 개·오백 개로 늘릴 수 있습니다.

print("[10]", ...)         # ← 고치세요
