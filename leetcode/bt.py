import requests
from bs4 import BeautifulSoup

for i in range(2426566, 2427508):
    url = 'http://www.tianxiabachang.cn/5_5864/' + str(i) + '.html'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
        }
    response = requests.get(url, headers=headers)
    response.encoding = 'gbk'
    #需要进行两次的格式转换，先变成gbk再变成utf-8，不然会报错
    response.encoding = 'utf-8'
    # 把响应的内容扔到BeautifulSoup里，生成BeautifulSoup对象，用来解析HTML
    soup = BeautifulSoup(response.text, 'lxml')
    # 找到 id="content"的标签，也就是小说文本内容
    contentsText = soup.find(id="content")
    # 找到title标签
    title = soup.title
    # 获取title的文本内容，也就是去掉<title>
    title = str(title.string)
    with open("天才相师.txt", 'a', encoding="utf-8") as file:
        file.write(contentsText.text)
        print(title + "完成！")
        file.close()