# ============================================================
#  실습 ④ — 긁기 «전»에 확인하는 법
#
#  🔴 오늘은 더 많이 긁는 날이 아닙니다.
#     ① 안 뽑히는 페이지를 만났을 때 어떻게 하는지
#     ② 남의 서버를 어떻게 대하는지
#     미니프로젝트에서 데이터를 직접 보태려면 이 둘이 곧바로 필요합니다.
#
#  🔴 주소는 칠판에 적힌 것으로 바꾸세요.
#  실행:  VS Code 오른쪽 위 ▶  (또는 python practice.py) · [5] 에서 3초쯤 멈춥니다 — 정상입니다
# ============================================================

import time
import urllib.robotparser as robotparser
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup

BASE = 'http://192.168.219.45:8000/'

# 🔴 헤더는 latin-1 로만 나갑니다. 한글을 넣으면 UnicodeEncodeError 가 납니다.
UA = 'MediaFrontier-Class/1.0 (+class practice)'


# ── [1] 안 보이는 페이지 ─────────────────────────────────────
#  브라우저로 live/popular.html 을 열면 기사 10건이 보입니다.
#  그런데 requests 로 받으면?
#
#    · .card 가 몇 개인지 세세요
#    · 받아온 글자 안에 'fetch(' 가 있는지 보세요
#
#  출력 형식:  [1] 0 True

pop_url = urljoin(BASE, 'live/popular.html') # BASE + 'live~'
r = requests.get(pop_url)
soup = BeautifulSoup(r.content, 'html.parser')

cards = soup.select('.card')

# fetch 를 통해 json 파일을 읽어들이는지 검사
has_fetch = 'fetch(' in r.text

print('[1]', len(cards), has_fetch)
# = 0   → .card 가 없음
# = True → 어디선가 파일을 읽어오고 있음


# ── [2] 그러면 그 «어디»를 직접 받습니다 ───────────────────────
#  🔴 먼저 브라우저에서 F12 → Network 탭 → 새로고침.
#     목록에 popular.json 이 보입니다. 그 주소를 직접 받으세요.
#
#    · requests 로 받아 .json() 으로 파이썬 자료로 바꿉니다
#    · 몇 건인지, 1위의 조회수와 제목이 무엇인지
#
#  출력 형식:  [2] 10 517185 반도체 정책 발표에 업계 촉각

data = requests.get(urljoin(BASE, 'live/popular.json')).json()
top = data[0]
print('[2]', len(data), top['views'], top['title'])

# ── [3] robots.txt 를 코드로 읽습니다 ─────────────────────────
#  urllib.robotparser 는 표준 라이브러리입니다 — 설치할 것이 없습니다.
#
#    rp = robotparser.RobotFileParser()
#    rp.set_url( robots.txt 주소 )
#    rp.read()
#
#    · rp.crawl_delay('*')           몇 초 쉬라고 하는가
#    · rp.can_fetch(UA, 주소)        긁어도 되는가
#      → article/1.html 과 admin/notice.html 을 각각 물어보세요
#
#  출력 형식:  [3] 1 True False

rp = robotparser.RobotFileParser()
rp.set_url(urljoin(BASE, 'robots.txt'))
rp.read()

DELAY = rp.crawl_delay(UA)
ok_article = rp.can_fetch(UA, urljoin(BASE, 'article/1.html'))
ok_admin = rp.can_fetch(UA, urljoin(BASE, 'admin/notice.html'))
print('[3]',DELAY, ok_admin, ok_article)

# ── [4] 🔴 막았는데 열립니다 ──────────────────────────────────
#  [3] 에서 admin/notice.html 은 False 였습니다.
#  그런데 requests 로 그냥 받아 보세요. 상태 코드가 몇입니까?
#
#  출력 형식:  [4] False 200
#
#  🔴 이 두 값의 차이가 오늘 2차시 전체입니다. 잠깐 멈추고 생각해 보세요.

r_admin = requests.get(urljoin(BASE, 'admin/notice.html'))

print('[4]', ok_admin, r_admin.status_code)


# ── [5] 간격을 지키면 얼마나 걸립니까 ─────────────────────────
#    · article/1 · 2 · 3 을 받되 한 번마다 [3] 의 crawl_delay 만큼 쉬세요
#    · 걸린 시간이 (3 × 간격) 이상인지 확인하세요
#      (시작 전에 t0 = time.time(), 끝나고 time.time() - t0)
#    · 그 속도로 500건을 받으면 «몇 분»입니까?  round(..., 1)
#
#  출력 형식:  [5] True 8.3

# ← 여기


# ── [6] 내가 누구인지 밝힙니다 ────────────────────────────────
#    · requests.utils.default_user_agent() 가 무엇인지 보세요
#    · headers={'User-Agent': UA} 로 보낸 뒤
#      r.request.headers['User-Agent'] 로 실제 나간 값을 확인하세요
#
#  출력 형식:  [6] True MediaFrontier-Class/1.0 (+class practice)

# ← 여기


# ── ★[7] 사전 점검기 — 🔴 월요일 미니프로젝트에서 쓸 물건입니다 ──────────────────
#  주소 하나를 받아 세 가지를 알려주는 함수를 만드세요.
#
#    def check_target(url):
#        ① robots 가 허용하는가        → '허용' / '🔴금지'
#           🔴 **그 주소의** robots.txt 를 새로 읽으세요.
#              위 [3] 의 rp 를 그대로 쓰면 안 됩니다 — can_fetch 는 호스트를
#              «안 보고» 경로만 봅니다. 연습 사이트의 규칙이 남의 사이트에
#              적용되어 후보가 전부 「허용」으로 나옵니다.
#              urljoin(url, '/robots.txt') 로 새 RobotFileParser 를 만드세요
#        ② 목록이 HTML 에 있는가        → '정적' / '동적'   (.card 로 판단)
#        ③ 「다음」 링크가 있는가        → '다음있음' / '다음없음'
#
#  BASE 와 pop_url 에 각각 돌려보세요.
#
#  출력 형식:  [7] 허용 정적 다음있음 | 허용 동적 다음없음
#
#  🔴 4차시에 팀 주제에 보탤 대상을 고를 때 이 함수를 그대로 씁니다.
#     «동적»이 나오면 [2] 처럼 Network 탭부터 여세요.

# ← 여기
