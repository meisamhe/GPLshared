#=============================================
# Collecting detail data of each user's result
#===============================================
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt
import urllib2
import re
import time
# path to save the URLs
userListFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\Gamification\\UserListData\\userList.csv"  # path of to be outputted submission file

# read first line of the file
with open(userListFilePath) as f:
	reader = csv.reader(f)
	header = next(reader)   #gets the first line
	firstLine = next(reader)   #gets the first line
  

url = "http://stackoverflow.com"+firstLine[0]


# task remains:
# to read from the userList.csv file and save the into the related files: in the with format to not lose anything


#===================================================================================================================
#		extract data from summary page, or main page
#===================================================================================================================
# test now on the following:
url="http://stackoverflow.com/users/548225/anubhava"
rawPage = urllib2.urlopen(url)	
readItem = rawPage.read()

#-------------------------
#extract the related items
#-------------------------

# website
pattern = '<tr>[^<]*<th>bio</th>[^<]*<td>website</td>[^<]*<td><a href="[^"]*" rel="[^"]*" class="url">([^<]*)</a></td>[^<]*</tr>'			
websiteAddr=re.findall(pattern, readItem)
print ('user website is: %s'%(websiteAddr[0]))

#location
pattern = '<tr>[^<]*<th></th>[^<]*<td>location</td>[^<]*<td class="label adr">([^<]*)</td>[^<]*</tr>'
location=re.findall(pattern, readItem)
print ('location is: %s'%(location[0]))

#age
url = "http://stackoverflow.com/users/215945/mark-rajcok?tab=activity"
rawPage1 = urllib2.urlopen(url)	
readItem1 = rawPage1.read()
pattern = '<tr>[^<]*<th></th>[^<]*<td>age</td>[^<]*<td>([^<]*)</td>[^<]*</tr>'
age=re.findall(pattern, readItem1)
print ('age is: %s'%(age[0]))
					
#tenure
pattern = '<tr>[^<]*<th>visits</th>[^<]*<td>member for</td>[^<]*<td class="cool" title="[^"]*">([^<]*)</td>[^<]*</tr>'
tenure=re.findall(pattern, readItem)
print ('tenure is: %s'%(tenure[0]))

#seen
pattern ='<tr>[^<]*<th></th>[^<]*<td>seen</td>[^<]*<td class="[^"]*" title="[^"]*">[^<]*<span title="[^"]*" class="relativetime">([^<]*)</span>[^<]*</td>[^<]*</tr>'
seen=re.findall(pattern, readItem)
print ('seen is: %s'%(seen[0]))

#profile views					
pattern = '<tbody class="user-profile-stats">[^<]*<tr>[^<]*<th>stats</th>[^<]*<td>profile views</td>[^<]*<td>([^<]*)</td>[^<]*</tr>'
profileViews=re.findall(pattern, readItem)
print ('profileViews is: %s'%(profileViews[0]))	
							
# reputation
pattern = '<div class="reputation">[^<]*<span>[^<]*<a[^<]*>([^<]*)</a>'
reputation=re.findall(pattern, readItem)
print ('reputation is: %s'%(reputation[0]))	
				
# Gold badges
pattern = '<span title="[^g]*gold badges"><span class="badge1"></span><span class="badgecount">([^<]*)</span></span>'
goldBadges=re.findall(pattern, readItem)
print ('reputation is: %s'%(goldBadges[0]))	

# Silver badges
pattern = '<span title="[^s]*silver badges"><span class="badge2"></span><span class="badgecount">([^<]*)</span></span>'
silverBadges=re.findall(pattern, readItem)
print ('reputation is: %s'%(silverBadges[0]))	

#Bronz Badges
pattern = '<span title="[^b]*bronze badges"><span class="badge3"></span><span class="badgecount">([^<]*)</span></span>'
bronzBadges=re.findall(pattern, readItem)
print ('reputation is: %s'%(bronzBadges[0]))

#===================================================================================================================
#		extract data from answers page
#===================================================================================================================
# test now on the following:
rootUrl = "http://stackoverflow.com"
currentUser = "/users/548225/anubhava"
url = rootUrl + currentUser
tailUrl = "?tab=answers&sort=votes" 
urlVote = url + tailUrl
pattern1 ='<a href="[^"]*" rel="next" title="go to page ([^"]*)">'
pattern2='<div class="answer-summary"><div onclick="[^"]*" class="[^"]*" title="[^"]*">[^0-9-]*([-0-9]*)[^<]*</div><div class="answer-link">'+ '<a href="[^"]*" class="answer-hyperlink ">[^<]*</a></div>[^<]*<span title="[^"]*" class="relativetime">([^<]*)</span></div>'

urlVoteExists = True
while (urlVoteExists==True):
	rawPage = urllib2.urlopen(urlVote)	
	readItem = rawPage.read()
	# check whether there is a next page and save the page number of it exists
		nextPage=re.findall(pattern1, readItem)
	if (len(nextPage)!=0):
		nextPage = nextPage[0]
		nextUrl = url + tailUrl+'&page=%s'%(nextPage)
	else:
		urlVoteExists = False
	print ('nextPage is: %s'%(nextPage))
	#collect vote and date couple in the current page
	voteDate=re.findall(pattern2, readItem)
	print ('voteDate couple are: %s'%(voteDate))
	# for the next loop
	urlVote = nextUrl
	time.sleep(0.2) # delays for 5 seconds

#===================================================================================================================
#		extract data from Question page
#===================================================================================================================
# test now on the following:
rootUrl = "http://stackoverflow.com"
currentUser = "/users/548225/anubhava"
url = rootUrl + currentUser
tailUrl = "?tab=questions&sort=votes" 
urlVote = url + tailUrl

patternNext = '<a href="[^"]*" rel="next" title="go to page ([^"]*)">'

# tuple includes: (votes, answers,views, date)
# favorite removed because it is high possibility that it comes with 0, and sparse data has no information

#votes #
pattern = '[^<]*<div class="question-counts cp">[^<]*<div class="votes">[^<]*<div class="mini-counts">([^<]*)</div>[^<]*<div>votes</div>[^<]*</div>'

#answers
pattern = pattern + '[^<]*<div class="status answered[^>]*>[^<]*<div class="mini-counts">([^<]*)</div>[^<]*<div>answer[^<]*</div>[^<]*</div>'

#views
patternViews =  '[^<]*<div class="views">[^<]*<div class="mini-counts[^>]*>(<[^>]*>)*([0-9k]+)<*[^0-9k>]*>*</div>[^<]*<div[^>]*>views</div>[^<]*</div>'

#date
datePattern = '<div class="started">[^<]*<a href="[^<]*" class="started-link"><span title="[^"]*" class="relativetime">([^<]*)</span></a>'

urlVoteExists = True
while (urlVoteExists==True):
	rawPage = urllib2.urlopen(urlVote)	
	readItem = rawPage.read()
	# check whether there is a next page and save the page number of it exists
	nextPage=re.findall(patternNext, readItem)
	if (len(nextPage)!=0):
		nextPage = nextPage[0]
		nextUrl = url + tailUrl+'&page=%s'%(nextPage)
	else:
		urlVoteExists = False
	print ('nextPage is: %s'%(nextPage))

	#collect question info current page
	questionInfo =re.findall(pattern, readItem)
	#print ('Question info k-uple are: %s'%(questionInfo))

	#collect date info
	dateInfo     = re.findall(datePattern, readItem)
	#print ('Date Info info are: %s'%(dateInfo))

	#collect view info
	viewInfo =re.findall(patternViews, readItem)
	viewInfoTemp = list()
	for i in range(0,len(viewInfo),1):
		viewInfoTemp.append([questionInfo[i][0],questionInfo[i][1],viewInfo[i][1],dateInfo[i]])
	print ('full question info k-uple are: %s'%(viewInfoTemp))

	# the output is now in: view InfoTemp

	# for the next loop
	urlVote = nextUrl
	time.sleep(0.2) # delays for 5 seconds





#===================================================================================================================	
with open(userListFilePath, 'w') as outfile:
	outfile.write('URL,Name\n')
	for i in range(15127,100040):
		URL = 'http://stackoverflow.com/users?page=%s&tab=reputation&filter=week'%(i)
		rawPage = urllib2.urlopen(URL)
		readItem = rawPage.read()
		userList=re.findall('<div class="user-details">[^<]*<a href="([^"]*)">([^<]*)</a><br>', readItem)
		print ('item number is: %s, length is: %s'%(i,len(userList)))
		for j in userList:
			outfile.write('%s,%s\n' % (j[0], j[1]))
		time.sleep(0.2) # delays for 5 seconds