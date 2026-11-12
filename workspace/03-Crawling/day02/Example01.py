# Example01.py

# 크롤링을 위한 라이브러리
import requests
from bs4 import BeautifulSoup

# 시스템 라이브러리
import sys


BASE = 'http://192.168.219.45:8000'

# 서버에 페이지 요청하여 응답을 반환
r = requests.get(BASE)

if r.status_code != 200:
    print('응답을 받지 못했습니다.')
    sys.exit()

# 첫 번째 기사의 섹션, 제목, 기자, 상세 페이지 링크를 출력

# 1. 요청한 페이지에서 원하는 정보를 뽑기 위해 수프를 생성
soup = BeautifulSoup(r.content, 'html.parser')

# 2. 첫 번째 기사를 탐색
#     → select(...)
#     → select_one(...)
first_card = soup.select_one('.card')

# 3. 첫 번째 기사의 하위 태그를 탐색
first_card_section = soup.select_one('.card .badge')
first_card_title = soup.select_one('.card a')
first_card_reporter = soup.select_one('.card .reporter')

# 4. 기사의 정보 출력
print(f'섹션: {first_card_section.get_text()}')
print(f'제목: {first_card_title.get_text()}')
print(f'기자: {first_card_reporter.get_text()}')
print(f'링크: {first_card_title.get('href')}')


# 3-2. 첫 번째 기사의 하위 태그를 탐색
#       - 첫 번째 기사(.card)의 하위 태그를 탐색
first_card_section = first_card.select_one('.badge')
first_card_title = first_card.select_one('a')
first_card_reporter = first_card.select_one('.reporter')

# 4-2. 기사의 정보 출력
print(f'섹션: {first_card_section.get_text()}')
print(f'제목: {first_card_title.get_text()}')
print(f'기자: {first_card_reporter.get_text()}')
print(f'링크: {first_card_title.get('href')}')
