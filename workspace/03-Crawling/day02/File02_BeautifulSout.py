# File02_BeautifulSoup.py

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


soup = BeautifulSoup(r.content, 'html.parser')

# 첫 번째 기사의 정보를 하나의 묶음으로 관리 
#  → dict 를 이용하여 카드 하나의 정보를 보관
c = soup.select_one('.card')

c_info = { 
    # key: value
    'title':        c.select_one('a').get_text(strip=True),
    'section':      c.select_one('.badge').get_text(strip=True),
    'reporter':     c.select_one('.reporter').get_text(strip=True),
    'published_at': c.select_one('time').get('datetime'),
    'detail_path':  c.select_one('a').get('href')
}

# print(c_info)

# for key in c_info:
#     print(f'{key}: {c_info[key]}')

for key, value in c_info.items():
    print(f'{key}: {value}')
print()


# 기사 20건의 제목
card_list = []

# 기사 20건 순회
for c in soup.select('.card'):
    # 기사 하위 정보를 dict 로 보관
    c_dict = {
        'title':        c.select_one('a').get_text(strip=True),

        # 제목 외 추가 정보
        'section':      c.select_one('.badge').get_text(strip=True),
        'reporter':     c.select_one('.reporter').get_text(strip=True),
        'published_at': c.select_one('time').get('datetime'),
        'detail_path':  c.select_one('a').get('href')
    }
    # 기사 정보를 담은 dict를 list 에 보관
    card_list.append(c_dict)


# 기사 정보 출력
num = 1
for card in card_list:
    print(f'{num}번 기사')
    for key, value in card.items():
        print(f'{key}: {value}')
    print()
    num += 1


# num 변수 대신 enumerate 함수로 번호와 card 를 반환
for num, card in enumerate(card_list, start=1):
    print(f'{num}번 기사')
    for key, value in card.items():
        print(f'{key}: {value}')
    print()
    

