# File01_BeautifulSoup.py

# 크롤링을 위한 라이브러리
import requests
from bs4 import BeautifulSoup

# 시스템 라이브러리
import sys


BASE = 'http://192.168.219.45:8000/'

# 서버에 페이지 요청하여 응답을 반환
r = requests.get(BASE)

if r.status_code != 200:
    print('응답을 받지 못했습니다.')
    sys.exit()

# 텍스트 형식으로 보관
# r.encoding='utf-8'
# print(r.text)

# 바이트 형식으로 보관
# print(r.content)

# soup 만들기
#  - 해석하기 위한 본문(r.content)
#  - 해석하기 위한 도구(html.parser)
soup = BeautifulSoup(r.content, 'html.parser')

# "CSS의 선택자"이용하여 탐색
#   soup.select(선택자) 
#     : 선택자에 해당하는 요소들을 리스트로 반환
#   soup.select_one(선택자) 
#     : 선택자에 해당하는 요소 하나를 반환

# class 속성이 'card' 인 요소를 탐색
cards = soup.select('.crad')
print('.card 의 수:', len(cards)) # .card 요소의 개수

# class 속성이 'cards' 인 요소를 탐색
cards = soup.select('.crads')
print('.cards 의 수:', len(cards)) # .card 요소의 개수
# → 선택자에 해당하는 요소가 없다면
#   빈 리스트로 반환

# class 속성이 'card' 인 요소 하나를 탐색
card = soup.select_one('.card')
print(card)

# class 속성이 'crad' 인 요소 하나를 탐색
card = soup.select_one('.crad')
print(card)
# → 선택자에 해당하는 요소가 없다면
#   None 으로 반환
# → card.get_text() 와 같은 명령어 수행시 오류가 발생


# a 요소의 개수
print(len(soup.select('a')))        # 29
print(len(soup.select('.card a')))  # 20
# → 요소를 탐색할 때 태그만 보는 것이 아닌
#   구조와 클래스를 보고 탐색을 해야한다.
# ----------------------------------------------------------

# 탐색한 요소에서 정보 가져오기
#  - 요소의 내부 문자 = 태그 사이에 작성된 텍스트
#  - 요소의 속성      = 태그에 설정된 속성 값

# 첫 번째 기사의 발생 시간
time_tag = soup.select_one('.card time')
print(time_tag)

# 태그 사이의 내부 문자를 반환
#  - strip 매개변수: 좌우 공백 제거 여부
time_text = time_tag.get_text(strip=True)
print(time_text)

# 태그에 설정된 속성을 반환
#  → tag[attr]      : 없으면 에러가 발생
#  → tag.get(attr)  : 없으면 None 을 반환 
time_attr = time_tag['datetime']
print(time_attr)

time_attr = time_tag.get('datetime')
print(time_attr)
# → datetime 에는 초단위까지 저장되어있다.


