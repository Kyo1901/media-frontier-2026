# File03_BS.py

import requests
from bs4 import BeautifulSoup

import sys, os

import time

os.system('cls')

BASE = 'http://192.168.219.45:8000/'

def soup_of(path=''):
    return BeautifulSoup(
            requests.get(BASE + path).content, 
            'html.parser'
        )

# 전체 페이지 순회
url = ''

# 다음 페이지가 없으면 종료
#  - 만약 중간에 프로그램을 종료시키거나
#    무한 루프인 경우 'ctrl + c' 를 통해 종료
page_num = 1
while url != None:
    print(f'{page_num}번 페이지')
    soup = soup_of(url)

    
    # btn = soup.select('.pager .btn')
    # nxt = None
    # for b in btn:
    #     if b.get_text() == '다음':
    #         nxt = b

    # 다음 버튼이 있으면 nxt 에 저장, 없으면 None 을 저장
    nxt = next(
        (b for b in soup.select('.pager .btn') if b.get_text() == '다음'), 
        None
    )

    url = nxt.get('href') if nxt else None
    page_num += 1
    # time.sleep(0.5) # 프로그램이 0.5초 대기(= 멈춘다)
    

# 숫자 데이터 가공
#  - 숫자 데이터가 없는 경우 0, '', '-' 등으로 다양하게 표현
#  - 숫자 데이터를 쉼표(,)를 포함하여 표시하는 경우가 많다.
#  → 데이터 분석 단계에서 처리하려면 사전에 숫자 데이터로 변환
#  → 숫자가 아닌 데이터인 경우 None 으로 처리
#  → 쉼표(,)가 포함된 숫자인 경우 쉼표(,)를 제거

def clean_views(text):
    if text in ['-', '']:
        return None
    
    return int(text.replace(',', ''))

num_str = '3,213' # = get_text() 로 받아온 데이터
# num = int(num_str)
# float( ) # → 소수점을 포함한 데이터로 반환

num = clean_views(num_str)
print(f'num = {num}')

