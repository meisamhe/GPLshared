#pip install scrapy
# cat > myspider.py <<EOF

from scrapy import Spider, Item, Field

class Post(Item):
    title = Field()

class BlogSpider(Spider):
    name, start_urls = 'blogspider', ['http://stackoverflow.com/users?page=1&tab=reputation&filter=week']

    def parse(self, response):
        return response.xpath('//*[@id="user-browser"]/table/tbody/tr[1]/td[1]/div/div[2]/a')

#EOF
# scrapy runspider myspider.py

#=====================================
# an  alternative approach
#========================================
# pip install ftp://xmlsoft.org/libxml2/python/libxml2-python-2.6.9.tar.gz
# https://pypi.python.org/pypi/lxml/3.4.1
# https://pypi.python.org/pypi/lxml/3.4.1#downloads
# lxml is wrapper around libxml2
#import lxml
start_urls = 'http://stackoverflow.com/users?page=1&tab=reputation&filter=week'
import urllib2
rawPage = urllib2.urlopen(start_urls)
readItem = rawPage.read()
#import libxml2
import re
output = re.findall('<div class="user-details">[^<]*<a', readItem)
userList=re.findall('<div class="user-details">[^<]*<a href="([^"]*)">([^<]*)</a><br>', readItem)

#NextLink = re.findall('<div class="user-details">[^<]*<a href="([^"]*)">([^<]*)</a><br>', readItem)
#http://stackoverflow.com/users?page=3&tab=reputation&filter=week

import time
time.sleep(2) # delays for 5 seconds


#=============================================
# integration
#===============================================
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt
import urllib2
import re
import time
# path to save the URLs
userListFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\Gamification\\UserListData\\userList.csv"  # path of to be outputted submission file


with open(userListFilePath, 'w') as outfile:
	outfile.write('URL,Name\n')
	for i in range(1,100040):
		URL = 'http://stackoverflow.com/users?page=%s&tab=reputation&filter=week'%(i)
		rawPage = urllib2.urlopen(URL)
		readItem = rawPage.read()
		userList=re.findall('<div class="user-details">[^<]*<a href="([^"]*)">([^<]*)</a><br>', readItem)
		print ('item number is: %s, length is: %s'%(i,len(userList)))
		for j in userList:
			outfile.write('%s,%s\n' % (j[1], j[2]))
		time.sleep(1) # delays for 5 seconds

#=============================================
# check the number of processors on the system
#==========================================
import multiprocessing

multiprocessing.cpu_count()