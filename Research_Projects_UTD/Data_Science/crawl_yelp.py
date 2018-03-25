import time
from google import search
import urllib
from bs4 import BeautifulSoup
numberOfItems = 30
import re
yelpSites = []
i = 1
query = 'x yelp'
for url in search(query, stop=numberOfItems):
        #print(url)
        time.sleep(5)
        urlHttp = url.replace('https','http')
        yelpSites.append(urlHttp)
        i += 1
print(len(yelpSites))
30
import requests
from lxml import html
yelpCorpus = []
page_order = range(0,10) # here I assumed that there are at most 10 pages of review per location, but this can be configured
for url in yelpSites:
    time.sleep(5)
    for curPage in page_order:
        completeURL = url + ("?start=%s" % (20*curPage))
        print('current URL is: %s'%completeURL)
        try:
            htmlText = requests.get(completeURL).text
            tree = html.fromstring(htmlText)
            reviews = tree.xpath(' //*[@id="super-container"]/div/div/div[1]/div[5]/div[1]/div[2]/ul/li/div/div/div/p//text()')
            time.sleep(2)
            length = len(reviews)
            print('len of reviews is:%s'%(length))
            yelpCorpus = yelpCorpus + reviews
            length = len(yelpCorpus)
            print('len of yelpCorpus is:%s'%(length))
        except:
            pass
#//*[@id="super-container"]/div/div/div[1]/div[4]/div[1]/div[2]/ul/li[3]/div/div[2]
#//*[@id="super-container"]/div/div/div[1]/div[4]/div[1]/div[2]/ul/li[4]/div/div[2]/div[1]/p
#print(title)
# import re
# rating_pattern = re.compile(r'\d.\d star rating">')
# for rating in re.findall(rating_pattern, htmlText):
#     print(rating)

len(yelpCorpus)
1844
yelpCorpus[0]
for i in range(0,len(yelpCorpus)):
    try:
        yelpCorpus[i] = str(yelpCorpus[i])
    except:
        yelpCorpus[i]=""
# write the scraped result into a file
import pickle

with open('yelpCorpus.txt', 'wb') as fp:
    pickle.dump(yelpCorpus, fp)
# read the reddit file back
with open ('yelpCorpus.txt', 'rb') as fp:
    yelpCorpus = pickle.load(fp)
# sanity check
print(len(yelpCorpus))
1844
yelpCorpus[5]