# ============================================================
#  과제 — 무한 스크롤, 두 가지 방법으로
#
#  연습 사이트의 「최신 기사」 페이지는 처음에 20건만 보이고,
#  아래로 내릴 때마다 20건씩 더 나옵니다 (무한 스크롤).
#      http://localhost:8000/live/feed.html      ← 브라우저로 먼저 열어 내려 보세요
#      (첫 쪽 오른쪽 「안내」의 「최신 기사」를 눌러도 갑니다)
#
#  🔴 순서는 수업과 같습니다 — 방법 1(Network 탭)이 먼저, 방법 2(Playwright)는 그다음.
#  🔴 주소는 칠판에 적힌 것으로 바꾸세요.
#  실행:  VS Code 오른쪽 위 ▶
#  준비:  pip install playwright (Anaconda Prompt) — 4일차에 이미 했다면 그대로
#  만들어지는 파일: 이 파일과 같은 폴더의 feed_api.csv
# ============================================================

import os
import time

import pandas as pd
import requests
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

BASE = 'http://localhost:8000/'
FEED = BASE + 'live/feed.html'
UA = {'User-Agent': 'MediaFrontier-Class/1.0 (+homework)'}    # 🔴 브라우저인 척하지 않습니다


# ── [1] 그냥 받으면 ─────────────────────────────────────────
#  requests + BeautifulSoup 으로 FEED 를 받아 .card 를 세세요.
#
#  출력 형식:  [1] 0
#  🔴 화면에는 분명히 있는데 왜 0 입니까? (4일차 1차시의 그것)

print('[1]', ...)          # ← 고치세요


# ════════ 방법 1 — Network 탭에서 «다음 묶음» 요청을 찾는다 ════════
#
#  1. 브라우저로 FEED 를 열고 F12 → Network → Fetch/XHR
#  2. 아래로 스크롤하면서 새로 뜨는 요청의 이름을 보세요
#  3. 그 요청을 눌러 Response(응답)를 보세요 — 무엇이 들어 있습니까?  ______
#     🔴 특히 맨 아래 «next» 를 보세요. 다음에 받을 것이 무엇인지 서버가 알려 줍니다.


# ── [2] next 를 따라 끝까지 ─────────────────────────────────
#  찾은 첫 요청부터 시작해 next 를 따라가며 items 를 모두 모으세요.
#    · 주소:   BASE + 'live/' + 파일이름
#    · 받기:   requests.get(주소, headers=UA).json()   ← bs4 가 필요 없습니다
#    · 🔴 한 번 받을 때마다 time.sleep(1)
#    · 🔴 next 가 None 이면 멈춥니다 — 몇 묶음인지 미리 정하지 마세요 (3일차 while 과 같은 모양)
#
#  받은 묶음 수 · 모은 건수를 출력하세요.
#  출력 형식:  [2] 5 100

rows = []
# ← 여기에 while 문을 쓰세요

print('[2]', ...)          # ← 고치세요


# ── [3] 표로 만들어 CSV 로 ─────────────────────────────────
#  rows 를 DataFrame 으로 만들어 feed_api.csv 로 저장한 뒤, 다시 읽어서
#    · 행 수 · 조회수 결측 수 · 첫 제목
#  을 출력하세요. (3일차 [3]·[4] 와 같습니다)
#
#  출력 형식:  [3] 100 9 여야 외교 현안 놓고 공방
#  🔴 이번엔 clean_views 가 필요 없습니다. 왜일까요?  ______

print('[3]', ...)          # ← 고치세요


# ════════ 방법 2 — Playwright 로 진짜 끝까지 내린다 ════════

# ── [4] 바닥까지 스크롤 ─────────────────────────────────────
#  with sync_playwright() as p:
#      page = p.chromium.launch(channel='chrome').new_page()
#      page.goto(FEED)
#      page.wait_for_selector('.card')
#      ... 여기서 «카드 수가 더 안 늘 때까지» 스크롤을 반복합니다
#
#  · 아래로:      page.mouse.wheel(0, 20000)
#  · 🔴 기다리기: page.wait_for_timeout(1000)   — 새 묶음이 그려질 시간이자 쉬는 시간
#  · 카드 수:     page.locator('.card').count()
#  · 🔴 for _ in range(50) 처럼 «상한» 을 두세요 — 끝이 없는 사이트에서 영원히 돕니다
#  다 내린 뒤 제목 리스트:  page.locator('.card a').all_inner_texts()
#
#  출력 형식:  [4] 100
#  🔴 wait_for_timeout 을 빼고도 돌려 보세요. 몇 건에서 멈춥니까?  ______  왜입니까?  ______

titles = []
# ← 여기에 with 블록을 쓰세요

print('[4]', ...)          # ← 고치세요


# ── [5] 두 방법을 맞춰봅니다 ───────────────────────────────
#  [4] 의 제목 리스트와 [3] 에서 다시 읽은 표의 title 열(list(...))이 같은지 출력하세요.
#
#  출력 형식:  [5] True
#
#  🔴 마지막으로 — 두 방법에 걸린 시간을 time.time() 으로 재 보세요.
#     같은 결과를 얻는 데 어느 쪽이 더 무겁습니까? 그래서 무엇을 먼저 해야 합니까?  ______

print('[5]', ...)          # ← 고치세요
