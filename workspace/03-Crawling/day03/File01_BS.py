# File01_BS.py

import requests
from bs4 import BeautifulSoup

# 시스템(System)과 OS 라이브러리
import sys, os

# 화면 지우기
#  - windows: cls
#  - linux, max: clear
os.system('cls')


# 기본 경로 = 메인
BASE = 'http://192.168.219.45:8000/'

def soup_of(path=''):
    # r = requests.get(BASE + path)
    # return BeautifulSoup(r.content, 'html.parser')
    return BeautifulSoup(
            requests.get(BASE + path).content, 
            'html.parser'
        )

soup = soup_of()
# = http://192.168.219.45:8000/

# 기사 카드 내의 a 태그를 탐색
a = soup.select_one('.card a')
print(a.get('href'))

# a 태그에 연결된 페이지를 크롤링
detail = soup_of( a.get('href') )
# = http://192.168.219.45:8000/article/1.html

# 기사 상세 페이지 내에서 기사 제목과 댓글 수
title = detail.select_one('.article h1').get_text(strip=True)
comment_count = detail.select_one('.comments').get_text(strip=True)

print(f'제목: {title}')
print(f'댓글 수: {comment_count}')


# IT 섹션의 첫 번째 기사의 제목과 기사 본문 내용을 출력
a = soup.select_one('.card:nth-child(5) a')
print(a.get('href'))

detail = soup_of(a.get('href'))

title = detail.select_one('.article h1').get_text(strip=True)

# 마지막 p 태그는 버튼이기 때문에 제외
content_list = detail.select('.article p:not(:last-child)')
print(content_list) # p 태그가 여러개가 묶인 리스트

contents = []
for p in content_list:
    contents.append(p.get_text(strip=True))
# → p 태그 내의 내부 문자들을 리스트에 따로 저장

# 리스트에 저장된 내부 문자들을 하나의 문자열로 연결
content = '\n'.join(contents)
print(content)






