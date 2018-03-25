#=============================================
# Collecting detail data of each user's result
# do 32 manually
# read from the file and only take information from each differently
#===============================================
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt
import urllib2
import re
import time
# path to save the URLs
individualCSData = "C:\\Users\\mxh109420\\Desktop\\GMFC\\individualCSDAtaLDrBrd.csv"  # to save leadership board
interestingUsersFilePath = "C:\\Users\\mxh109420\\Desktop\\GMFC\\interestingUsers1.csv"  # interestingUsers
url = "http://stackexchange.com/leagues/1/week/stackoverflow/2015-02-09?sort=reputationchange&pagesize=50"
rootUrl = "http://stackexchange.com"

f = open(interestingUsersFilePath)
content = f.read().splitlines()


# read first line of the file
outIndvCS = open(individualCSData,'w')
outIndvCS.write('user,website,location,age,tenure,seen,profViews,reputation,GoldBadges,SilveBadges,BronzBadges\n')

rawPage = urllib2.urlopen(url)	
readItem = rawPage.read()

numUsers = len(content)
#into the loop to collect 500 pages data
for i in range(0,numUsers,1):
	curUserInfo = content[i]
	pattern = '([^,]*),([^,]*)'
	curUserInfo = re.findall(pattern, curUserInfo)
	curUserInfo=curUserInfo[0]
	userName = curUserInfo[0]
	url = curUserInfo[1]
	print('url is:%s'%url)
	rawPage = urllib2.urlopen(url)	
	readItem = rawPage.read()
	time.sleep(0.3) # delays for 5 seconds
	print ('starting collecting data on user: %s\n'%(userName))
	
	#===================
	# collecting detail data
	#====================
	# website
	pattern = '<tr>[^<]*<th>bio</th>[^<]*<td>website</td>[^<]*<td><a href="[^"]*" rel="[^"]*" class="url">([^<]*)</a></td>[^<]*</tr>'			
	websiteAddr=re.findall(pattern, readItem)
	#print ('user website is: %s'%(websiteAddr[0]))
	if len(websiteAddr) == 0:
		websiteAddr = ""
	else:
		websiteAddr=websiteAddr[0]

	#location
	pattern = '<tr>[^<]*<th></th>[^<]*<td>location</td>[^<]*<td class="label adr">([^<]*)</td>[^<]*</tr>'
	location=re.findall(pattern, readItem)
	#print ('location is: %s'%(location[0]))
	if len(location) == 0:
		location = ""
	else:
		location=location[0]

	#age
	pattern = '<tr>[^<]*<th></th>[^<]*<td>age</td>[^<]*<td>([^<]*)</td>[^<]*</tr>'
	age=re.findall(pattern, readItem)
	#print ('age is: %s'%(age[0]))
	if len(age) == 0:
		age = ""
	else:
		age=age[0]
						
	#tenure
	pattern = '<tr>[^<]*<th>visits</th>[^<]*<td>member for</td>[^<]*<td class="cool" title="[^"]*">([^<]*)</td>[^<]*</tr>'
	tenure=re.findall(pattern, readItem)
	#print ('tenure is: %s'%(tenure[0]))
	if len(tenure) == 0:
		tenure = ""
	else:
		tenure=tenure[0]

	#seen
	pattern ='<tr>[^<]*<th></th>[^<]*<td>seen</td>[^<]*<td class="[^"]*" title="[^"]*">[^<]*<span title="[^"]*" class="relativetime">([^<]*)</span>[^<]*</td>[^<]*</tr>'
	seen=re.findall(pattern, readItem)
	#print ('seen is: %s'%(seen[0]))
	if len(seen) == 0:
		seen = ""
	else:
		seen=seen[0]

	#profile views					
	pattern = '<tbody class="user-profile-stats">[^<]*<tr>[^<]*<th>stats</th>[^<]*<td>profile views</td>[^<]*<td>([^<]*)</td>[^<]*</tr>'
	profileViews=re.findall(pattern, readItem)
	#print ('profileViews is: %s'%(profileViews[0]))	
	if len(profileViews) == 0:
		profileViews = ""
	else:
		profileViews=profileViews[0]
								
	# reputation
	pattern = '<div class="reputation">[^<]*<span>[^<]*<a[^<]*>([^<]*)</a>'
	reputation=re.findall(pattern, readItem)
	#print ('reputation is: %s'%(reputation[0]))
	if len(reputation) == 0:
		reputation = ""
	else:
		reputation=reputation[0]	
					
	# Gold badges
	pattern = '<span title="[^g]*gold badges"><span class="badge1"></span><span class="badgecount">([^<]*)</span></span>'
	goldBadges=re.findall(pattern, readItem)
	#print ('reputation is: %s'%(goldBadges[0]))	
	if len(goldBadges) == 0:
		goldBadges = ""
	else:
		goldBadges=goldBadges[0]

	# Silver badges
	pattern = '<span title="[^s]*silver badges"><span class="badge2"></span><span class="badgecount">([^<]*)</span></span>'
	silverBadges=re.findall(pattern, readItem)
	#print ('reputation is: %s'%(silverBadges[0]))	
	if len(silverBadges) == 0:
		silverBadges = ""
	else:
		silverBadges=silverBadges[0]

	#Bronz Badges
	pattern = '<span title="[^b]*bronze badges"><span class="badge3"></span><span class="badgecount">([^<]*)</span></span>'
	bronzBadges=re.findall(pattern, readItem)
	#print ('reputation is: %s'%(bronzBadges[0]))
	if len(bronzBadges) == 0:
		bronzBadges = ""
	else:
		bronzBadges=bronzBadges[0]
	
	outIndvCS.write('%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n'%(userName,websiteAddr,location,age,tenure,seen,profileViews,reputation,goldBadges,silverBadges,bronzBadges))
	
	
