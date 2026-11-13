# File01_BS.py

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

soup = soup_of('live/popular.html')
print(soup.select('.card')) 
# = []
# → .card 가 하나도 없음.

# 뉴스 기사 정보가 json 파일로 전달됨을 확인하고
# json 파일을 요청하여 받아오기
data = requests.get(BASE + 'live/popular.json').json()
print(len(data), data[0]['title'])

for d in data:
    print(d['title'])

