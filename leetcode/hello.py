import urllib.request
import urllib.parse
import json

while True:
	content = input("请输入待翻译的内容(输入0退出程序):")
	if content == "0": break
	url = 'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule'

	data = {}
	data['i'] = content
	data['from'] = 'AUTO'
	data['to'] =  'AUTO'
	data['smartresult'] = 'dict'
	data['client'] = 'fanyideskweb'
	data['salt'] = '15780286531233'
	data['sign'] = 'fea785927e5dc89ee5d05f9b5d4035b3'
	data['ts'] = '1578028653123'
	data['bv'] = '42160534cfa82a6884077598362bbc9d'
	data['doctype'] = 'json'
	data['version'] = '2.1'
	data['keyfrom'] = 'fanyi.web'
	data['action'] = 'FY_BY_REALTlME'

	data = urllib.parse.urlencode(data).encode('utf-8')

	response = urllib.request.urlopen(url, data) #新增了data参数.
	html = response.read().decode('utf-8')
	result = json.loads(html)
	print(result["translateResult"][0][0]["tgt"])