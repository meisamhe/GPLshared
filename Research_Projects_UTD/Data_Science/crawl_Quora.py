#! pip install google
from google import search
import urllib
from bs4 import BeautifulSoup
numberOfItems = 240 # for now only keep 800 questions in quora, but this is configurable (based on number of google results)
# def google_scrape(url):
#     thepage = urllib.urlopen(url)
#     soup = BeautifulSoup(thepage, "html.parser")
#     return soup.title.txt
import re
quora = []
i = 1
query = 'xab site:quora.com'
for url in search(query, stop=numberOfItems):
       # print(url)
        try:
            m = re.match(r"https://www.quora.com/(.+)", url)
            question = m.group(1)
            question = question.replace('-',' ')
            quora.append(question)
            time.sleep(5)
            #print str(i) + ". " + question
    #        a = google_scrape(url)
    #         print str(i) + ". " + a
            i += 1
            if (float(i)/50==i/50):
                print(i),
        except:
            pass

# write the scraped result into a file
import pickle

with open('quora.txt', 'wb') as fp:
    pickle.dump(quora, fp)
# redditFile = open('reddit.txt', 'w')
# for item in reddit:
#     redditFile.write("%s\n" % item.encode('utf-8'))
# redditFile.close()
# read the reddit file back
with open ('quora.txt', 'rb') as fp:
    quora = pickle.load(fp)
# sanity check
print(len(quora))
