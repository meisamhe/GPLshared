#Consumer Affairs
import requests
from lxml import html
page_order = range(0,5) # for now it is set to 10, but this is configurable
consumerAffairs = []
#curPage = 1
url = 'https://www.consumeraffairs.com/finance/x.html'
for curPage in page_order:
    completeURL = url + ("?page=%s" % (curPage))
    print('current URL is: %s'%completeURL)
    try:
        htmlText = requests.get(completeURL).text
        tree = html.fromstring(htmlText)
        reviews = tree.xpath("//*[contains(@id, 'review')]/div/div/div/p//text()")
        #//*[@id="review-2338008"]/div[2]/div[2]/div/p[1]
        #//*[@id="review-2312985"]/div[2]/div[2]/div/p
        length = len(reviews)
        #print(reviews)
        print('len of reviews is:%s'%(length))
        for element in reviews:
            try:
                consumerAffairs.append(str(element))
            except:
                pass
        length = len(consumerAffairs)
        print('len of yelpCorpus is:%s'%(length))
    except:
        pass

print(len(consumerAffairs))
type(consumerAffairs)
consumerAffairs[1]

# write the scraped result into a file
import pickle

with open('consumerAffairs.txt', 'wb') as fp:
    pickle.dump(consumerAffairs, fp)
	
# read the reddit file back
with open ('consumerAffairs.txt', 'rb') as fp:
    consumerAffairs = pickle.load(fp)
# sanity check
print(len(consumerAffairs))

