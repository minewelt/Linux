from wordcloud import WordCloud
import jieba

string = '''


The core values of Chinese socialism

Patriotic, dedicated, honest and friendly

Prosperity, democracy, civilization and harmony

Legal system of freedom, equality and justice

The core values of Chinese socialism

'''
cut = jieba.cut(string)
cut_string = ' '.join(cut)

wc = WordCloud(
  font_path = 'Garuda-Bold.ttf', #如果string 的内容是中文就要添加font_path参数的内容。
  background_color ='white',   #背景色为白色
  width = 1000,            #宽度为1000
  height = 800,             #高度为800
  )


wc.generate_from_text(cut_string)
wc.to_file('社会主义.jpg')   #保存图片，其格式为.png(可以根据需求变换格式)
