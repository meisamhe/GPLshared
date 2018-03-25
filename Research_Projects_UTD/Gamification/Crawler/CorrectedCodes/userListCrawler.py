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


userListFilePath = "C:\\Users\\mxh109420\\Desktop\\GMFC\\userList.csv"  # path of to be outputted submission file


with open(userListFilePath, 'w') as outfile:
	outfile.write('URL,Name\n')
	for i in range(89819,100040):
		URL = 'http://stackoverflow.com/users?page=%s&tab=reputation&filter=week'%(i)
		rawPage = urllib2.urlopen(URL)
		readItem = rawPage.read()
		userList=re.findall('<div class="user-details">[^<]*<a href="([^"]*)">([^<]*)</a><br>', readItem)
		print ('item number is: %s, length is: %s'%(i,len(userList)))
		for j in userList:
			outfile.write('%s,%s\n' % (j[0], j[1]))
		time.sleep(0.2) # delays for 5 seconds