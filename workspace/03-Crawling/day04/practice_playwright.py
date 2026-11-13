# ============================================================
#  실습 ⑤ — Playwright: 진짜 브라우저로 받는다
#
#  🔴 준비 (한 번만) — 시작 메뉴 → Anaconda Prompt 에서
#        python -m pip install playwright
#     브라우저는 따로 안 받습니다. PC 에 깔린 «크롬»을 씁니다 (아래 channel='chrome').
#
#  🔴 주소는 칠판에 적힌 것으로 바꾸세요. 연습 사이트를 씁니다.
#  실행:  VS Code 오른쪽 위 ▶
#
#  ⑤-1 [1]~[4] 는 3차시, ⑤-2 [5]~[8] 은 4차시에 합니다.
#  🔴 모든 문항이 아래 «with 블록 안»에 들어갑니다. 들여쓰기를 지키세요.
# ============================================================

import os
import time
import requests
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

BASE = 'http://localhost:8000/'
URL = BASE + 'live/popular.html'

with sync_playwright() as p:
    browser = p.chromium.launch(channel='chrome')   # 깔린 크롬. 창을 보고 싶으면 headless=False 를 더하세요
    page = browser.new_page()


    # ════════ 실습 ⑤-1 (3차시) — JS 가 그린 페이지 ════════

    # ── [1] 0 과 10 ──────────────────────────────────────────
    #  같은 URL 을
    #    · requests + BeautifulSoup 으로 받아 .card 를 세고
    #    · page.goto(URL) → page.wait_for_selector('.card') → page.locator('.card').count()
    #  로도 세서 둘 다 출력하세요.
    #
    #  출력 형식:  [1] 0 10

    page.goto(URL) # 페이지 이동
    page.wait_for_selector('.card')  # .card 가 그려질 때 까지 대기
    card_count = page.locator('.card').count() # 그려진 .card 의 개수 

    print('[1]', card_count)


    # ── [2] 1위 제목 ─────────────────────────────────────────
    #  첫 카드 안의 <a> 글자를 꺼내세요.
    #    page.locator('.card').first.locator('a').inner_text()
    #  🔴 locator 는 bs4 의 select, inner_text() 는 get_text() 와 같은 자리입니다.
    #
    #  출력 형식:  [2] 반도체 정책 발표에 업계 촉각

    first = page.locator('.card').first.locator('a').inner_text()
    print('[2]', first)
    
    

    # ── [3] 열 개 전부 ───────────────────────────────────────
    #  모든 카드의 제목을 리스트로 만드세요.
    #    page.locator('.card a').all_inner_texts()
    #  개수와 «마지막» 제목을 출력하세요.
    #
    #  출력 형식:  [3] 10 국가대표 결승 진출

    titles = page.locator('.card a').all_inner_texts()
    print('[3]', len(titles), titles[-1])          # ← 고치세요


    # ── [4] JSON 과 맞춰 보기 ────────────────────────────────
    #  1차시에 Network 탭에서 찾은 live/popular.json 을 requests 로 받아
    #  그 제목 리스트가 [3] 의 리스트와 «같은지» 출력하세요.
    #
    #  출력 형식:  [4] True
    #  🔴 같다면 — 왜 1차시에 JSON 을 먼저 봤을까요? [1] 과 [4] 가 걸린 시간을 느껴 보세요.

    print('[4]', ...)          # ← 고치세요

    
    # ════════ 실습 ⑤-2 (4차시) — 누르고 넘어간다 ════════

    # ── [5] 「다음」을 누른다 ────────────────────────────────
    #  page.goto(BASE) 로 목록 첫 쪽에 간 뒤 「다음」을 «누르세요».
    #    page.get_by_text('다음').click()
    #  넘어간 쪽의 주소 끝과, 첫 카드 링크의 href 를 출력하세요.
    #    · 주소 끝      page.url.split('/')[-1]
    #    · 링크의 href  page.locator('.card a').first.get_attribute('href')
    #
    #  출력 형식:  [5] page-2.html article/21.html
    #  🔴 제목으로 확인하지 마세요 — 2쪽 첫 기사 제목이 1쪽 첫 기사와 우연히 같습니다.
    page.goto(BASE)
    page.get_by_text('다음').click() # 다음 글자를 글릭
    page.wait_for_selector('.card')
    url_end = page.url.split('/')[-1]
    a_href = page.locator('.card a').first.get_attribute('href')

    print('[5]', url_end, a_href)          # ← 고치세요


    # ── [6] 기사로 들어간다 ──────────────────────────────────
    #  [5] 의 첫 카드 링크를 «누르고» 상세 페이지의 제목(.article h1)과 댓글 수(.comments)를 출력하세요.
    #  (2일차 [9] 의 선택자 그대로입니다)
    #
    #  출력 형식:  [6] 여야 예산안 놓고 공방 357

    print('[6]', ...)          # ← 고치세요


    # ── ★ [7] 사진을 찍는다 ─────────────────────────────────
    #  지금 화면을 page.screenshot(path='상세.png') 로 저장하고,
    #  그 파일이 생겼는지 os.path.exists('상세.png') 로 출력하세요.
    #
    #  출력 형식:  [7] True

    print('[7]', ...)          # ← 고치세요


    # ── ★ [8] 쉬면서 세 쪽 ──────────────────────────────────
    #  첫 쪽부터 「다음」을 세 번 누르며 쪽마다 첫 제목을 모으세요.
    #  🔴 누르기 전에 page.wait_for_timeout(1000) — 1초 쉽니다 (2차시 예절의 그 간격).
    #  모은 개수와, 걸린 시간이 3초 이상인지 출력하세요.
    #
    #  출력 형식:  [8] 3 True

    print('[8]', ...)          # ← 고치세요


    browser.close()
