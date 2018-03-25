#=============================================
# Collecting detail data of each user's result
# do 32 manually
#===============================================
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt
import urllib2
import re
import time
# path to save the URLs
leadershipBoardFilePath = "C:\\Users\\mxh109420\\Desktop\\GMFC\\leadershipBoard.csv"  # to save leadership board
interestingUsersFilePath = "C:\\Users\\mxh109420\\Desktop\\GMFC\\interestingUsers.csv"  # interestingUsers
url = "http://stackexchange.com/leagues/1/week/stackoverflow/2014-06-22?sort=reputationchange&pagesize=50"
rootUrl = "http://stackexchange.com"

# set initial variables
initial = 1
urlHash = {}
nextPageExists = True
numPages = 2000

# read first line of the file
outLdrshpBrd = open(leadershipBoardFilePath,'w')
outLdrshpBrd.write('date,userID,rank,rankChange,totalReputation,weekReputation\n')
interestingUsers = open(interestingUsersFilePath,'w')
interestingUsers.write('userID,URL\n')

# test url's
#url = "http://stackexchange.com/leagues/1/week/stackoverflow/2014-06-22"
#url = "http://stackexchange.com/leagues/1/week/stackoverflow/2015-02-02"
pattern = 'http://stackexchange.com/leagues/1/week/stackoverflow/(.*)\?.*'
date=re.findall(pattern, url)
print ('starting collecting data on date: %s\n'%date)
date = date[0]

rawPage = urllib2.urlopen(url)	
readItem = rawPage.read()
# read next page
pattern = '<a href="([^"]*)" class="viewnewer">next week[^<]*</a>'
websiteAddr=re.findall(pattern, readItem)
#if len(websiteAddr)!=0:
#	nextPageurl = rootUrl + websiteAddr[0] + '?sort=reputationchange&pagesize=50'
#else:
#	nextPageExists = False
#	break;
#into the loop to collect 500 pages data
for i in range(1,numPages,1):
	rawPage = urllib2.urlopen(url)	
	readItem = rawPage.read()
	time.sleep(0.3) # delays for 5 seconds
	print ('starting collecting data on page,date: %s,%s\n'%(date,i))
	# read next userPage
	#<a href="/leagues/1/week/stackoverflow/2015-02-01?sort=reputationchange&amp;page=2" title="go to page 2" rel="next"><span class="page-numbers next"> next</span></a>
	pattern='<a href="([^"]*)" title="[^"]*" rel="next"><span class="page-numbers next"> next</span></a>'
	websiteAddr=re.findall(pattern, readItem)
	nextPageUserUrl = rootUrl + websiteAddr[0]
	
	#<h2><a href="http://stackoverflow.com/users/1144035/gordon-linoff">Gordon Linoff</a></h2>		
	# read url page		
	pattern='<h2><a href="([^"]*)">([^<]*)</a></h2>'
	websiteAddr=re.findall(pattern, readItem)
	
	# collect (rank, rankChange, totalReputation, weekReputation)
	#rank
	pattern = '<div class="statsWrapper">[^<]*<div class="statsBox statsBoxWide">[^<]*<span class="number">#([^<]*)</span> week rank[^<]*</div>'
	#rankChange
	pattern = pattern + '[^<]*<div class="statsBox statsBoxWide">[^<]*<span class="[^"]*">([^<]*)</span> change[^<]*</div>'
	#total reputation
	pattern = pattern + '[^<]*<div class="statsBox statsBoxWider">[^<]*<span class="number">([^<]*)</span> total reputation[^<]*</div>'
	#week Reputation
	pattern = pattern + '[^<]*<div class="statsBox statsBoxWider">[^<]*<span class="number">([^<]*)</span> week reputation[^<]*</div>[^<]*</div>'
	
	ldrBrdInfo=re.findall(pattern, readItem)
	
	# in a for loop go over items that exist in the dictionary (i.e. entered after the first round)
	if initial <= numPages:
		initial += 1
		N = min(len(ldrBrdInfo),len(websiteAddr)-1)
		#print('length of lists are:%s,%s\n'%(len(ldrBrdInfo),len(websiteAddr)))
		for i in range(0,N,1):
				#outLdrshpBrd.write('date,userID,rank,rankChange,totalReputation,weekReputation\n')
				# i+1, because the first one is for stackoverflow itself
				outLdrshpBrd.write('%s,%s,'%(date,websiteAddr[i+1][1]))
				outLdrshpBrd.write('%s,%s,%s,%s\n'%(ldrBrdInfo[i][0],ldrBrdInfo[i][1],ldrBrdInfo[i][2],ldrBrdInfo[i][3]))
				# keep the URL, and build the list of valid users
				urlHash[websiteAddr[i+1][1]] = websiteAddr[i+1][0]
				# write the hash of users
				interestingUsers.write('%s,%s\n'%(websiteAddr[i+1][1],websiteAddr[i+1][0]))
	else:
		N = min(len(ldrBrdInfo),len(websiteAddr)-1)
		for i in range(0,N,1):
				#outLdrshpBrd.write('date,userID,rank,rankChange,totalReputation,weekReputation\n')
				# i+1, because the first one is for stackoverflow itself
				# filter to not write the items that I already don't need based on the origin (this also creates some delay so that the crawler be polite)
				if websiteAddr[i+1][1] in urlHash:
					outLdrshpBrd.write('%s,%s,'%(date,websiteAddr[i+1][1]))
					outLdrshpBrd.write('%s,%s,%s,%s\n'%(ldrBrdInfo[i][0],ldrBrdInfo[i][1],ldrBrdInfo[i][2],ldrBrdInfo[i][3]))
	# go to the next page
	url = nextPageUserUrl
# set the url for the next loop to the next page Url
url = nextPageurl


#outfile.write('URL,Name\n')
	
