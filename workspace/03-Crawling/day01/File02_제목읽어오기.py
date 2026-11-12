# File02_제목읽어오기.py

# HTTP 요청 라이브러리를 불러오기
import requests

# 시스템 명령어 처리하기 위한 라이브러리
import sys

# 서버 경로
BASE = 'http://192.168.219.45:8000'

# 페이지 요청
r = requests.get(BASE)

# 요청 실패한 경우 프로그램 종료
if r.status_code != 200: 
    print('연결을 실패했습니다.')   
    sys.exit() # 프로그램 종료


print('연결을 성공했습니다.')

# 인코딩 설정
r.encoding = 'utf-8'

# 카드의 개수를 구해보자
#  - HTML 구조를 통해 원하는 영역이 몇개 있는지 파악
card_count = r.text.count('<li class="card">')
print(f'card 의 개수: {card_count}')
print(r.text)

section_end = 0
for i in range(1, card_count + 1):
    print(f'{i}번 기사')

    
    tag = f'<a href="article/{i}.html">'

    # 제목 시작 위치 = 태그 시작 위치 + 태그의 문자 길이
    title_start = r.text.find(tag) + len(tag)

    # 제목의 끝 위치
    #  = a 태그의 끝태그 앞까지
    title_end = r.text.find('</a>', title_start)

    # [start: end] : start <= i < end
    # [start: start + n] : start 에서부터 n 개를 잘라낸다.
    title = r.text[title_start:title_end]

    # 섹션 읽어오기
    tag = '<span class="badge">'

    # 이전 섹션의 끝태그 이후에 있는 .badge 를 탐색
    section_start = r.text.find(tag, section_end) + len(tag)
    section_end = r.text.find('</span>', section_start)

    section = r.text[section_start:section_end]

    print(f'섹션: {section}, 제목: {title}')
    print()

print('-' * 30)


from bs4 import BeautifulSoup

soup = BeautifulSoup(r.content, 'html.parser')

# .card 요소 내의 a 요소를 탐색
print(soup.select_one('.card a').get_text())



