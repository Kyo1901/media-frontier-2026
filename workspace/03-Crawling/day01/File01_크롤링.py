# File01_크롤링.py

# ctrl + shift + p

'''
터미널 환경에서 실행할 때
 clear: 터미널 화면 비우기

 PS 로 시작하는 것이 아닌 '>>>' 시작할 경우
 exit 로 종료

 패널 위치 
  - 패널 우클릭 -> Pannel Position -> Right
'''

import requests, bs4

# 서버에 페이지 요청하여 응답을 반환
r = requests.get('http://192.168.219.45:8000')

# 응답 코드
#  - 200: 정상
#  - 404: 페이지 없음
print(r.status_code)

if r.status_code == 200: 
    print(r.headers['Content-Type'])    # 파일 형식
    print(len(r.content))               # 파일 크기(byte)
    # print(r.text)                       # 파일 내용(본문)

    # 첫 기사 제목
    i = r.text.find('article/1.html')   # 파일 내에서 위치 찾기
    print(r.text[i: i+50])              # 일부 내용 잘라내기
    # → article/1.html">ì¬ì¼ ìì°ì ëê³  ê³µë°©</a>
    # → 한글이 깨진 상태로 읽어온다.
    # → 정상적인 파일을 가져왔지만
    #   표시할 때 인코딩 방식이 잘못 매칭된 경우다.

    # 현재 인코딩 방식
    print(f'현재 인코딩 방식: {r.encoding}')

    # 추측하고 있는 인코딩 방식
    print(f'추측 인코딩 방식: {r.apparent_encoding}')

    # 현재 인코딩 방식을 utf-8 로 설정
    r.encoding = 'utf-8'

    # 다시 읽어오기
    i = r.text.find('article/1.html')   # 파일 내에, 위치 찾기
    print(r.text[i: i+50])              # 다시 읽어오기

    # 파일을 바이트 형식으로 보관하고 있다.
    # → 사람이 보기 보단 프로그램이 보고 처리하기 위한 본문
    # print(r.content)    

    # 다섯 번째 기사의 제목을 읽어오기
    i = r.text.find('article/5.html')
    print(r.text[i:i+50])

    
    
