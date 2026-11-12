# Example01.py


import requests
from bs4 import BeautifulSoup

import sys, os

os.system('cls')

BASE = 'http://192.168.219.45:8000/'

def soup_of(path=''):
    return BeautifulSoup(
            requests.get(BASE + path).content, 
            'html.parser'
        )

# 문화 섹션의 기사 5개의 제목
soup = soup_of()

# 각 섹션별 페이지로 이동하는 a 태그 리스트
nav_site = soup.select('.site-nav a')

sites = dict()
for a in nav_site:
    # 섹션 별 하위 링크
    #  문화: ~ .html
    #  정치: ~ .html
    #  사회: ~ .html
    sites[a.get_text(strip=True)] = a.get('href')

print(sites['문화'])


# 문화 섹션 페이지를 요청
section = '문화'
section_page = soup_of(sites[section])

title_list = section_page.select('.card a')[:5]

for a in title_list:
    print(a.get_text(strip=True))

    detail = soup_of(a.get('href'))
    # ... 

'''
BeautifulSoup(requests.get(BASE + a.get('href')), 'html.parser')
# → 다른 페이지를 요청할 때마다 해당 구문을 반복하여 작성
# → 달라지는 부분은 Base 하위 링크이기 때문에 함수화

def soup_of(path=''):
    return BeautifulSoup(requests.get(BASE + path), 'html.parser')
'''