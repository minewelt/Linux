import re
import requests
import time
import json

for i in range(0,226,25):
    url = 'https://movie.douban.com/top250?start=' + str(i) + '&filter='
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36'
    }

    response = requests.get(url, headers=headers)
    html = response.text

    result = re.findall('class="info".*?title.*?>(.*?)<',html, re.S)
    for results in result:
        with open('result.txt','a', encoding='utf-8') as f:
             f.write(json.dumps(results, ensure_ascii=False) + '\n')

        time.sleep(0.1)