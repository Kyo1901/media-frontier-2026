# File02_Robots.py

# robots.txt 파일을 읽어들이기 위한 표준 라이브러리
import urllib.robotparser as robotparser

import requests
from bs4 import BeautifulSoup

BASE = 'http://192.168.219.45:8000/'


# 파일 분석기 생성
rp = robotparser.RobotFileParser()

# 분석기에 분석할 파일 경로를 지정
rp.set_url(BASE + 'robots.txt')

# 지정된 경로에서 파일 읽어오기
rp.read()

UA = 'MediaFrontier-Class-Bot/1.0 (+https://--.md; email@example.com)'
DELAY = rp.crawl_delay(UA)
print(DELAY) # 지연 시간 = 1s

# 크롤링 가능한 페이지인지 검사
print(rp.can_fetch(UA, BASE + 'article/1.html'))
# = True = 크롤링 허용
print(rp.can_fetch(UA, BASE + 'admin/notice.html'))
# = False = 크롤링 미허용

print(requests.utils.default_user_agent())
r = requests.get(BASE, headers = { 'User-Agent': UA })
