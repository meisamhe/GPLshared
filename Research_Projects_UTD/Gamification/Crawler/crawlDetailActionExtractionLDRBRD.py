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
filePathRootAction = "C:\\Users\\mxh109420\\Desktop\\GMFC\\Actions\\"  # to save leadership board #individualCSDAtaLDrBrd.csv
filePathRootBadges = "C:\\Users\\mxh109420\\Desktop\\GMFC\\Badges\\"  # to save leadership board #individualCSDAtaLDrBrd.csv
interestingUsersFilePath = "C:\\Users\\mxh109420\\Desktop\\GMFC\\interestingUsers1.csv"  # interestingUsers
url = "http://stackexchange.com/leagues/1/week/stackoverflow/2015-02-09?sort=reputationchange&pagesize=50"
rootUrl = "http://stackexchange.com"

f = open(interestingUsersFilePath)
content = f.read().splitlines()

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
	url = curUserInfo[1] + '?tab=activity&sort=all&page=1'
	print('url is:%s'%url)
	# to keep track if the date is still greater than 
	missionFulfilled = False
	
	while (missionFulfilled == False):
		rawPage = urllib2.urlopen(url)	
		readItem = rawPage.read()
		time.sleep(0.3) # delays for 5 seconds
		print ('starting collecting data on user: %s\n'%(userName))
		
		#==============================
		# file of detail of action for each individual separately
		#===============================
		# read first line of the file
		fileNameActions = filePathRootAction + userName + 'Actions.csv'
		outIndvActions = open(fileNameActions,'w')
		outIndvActions.write('user,date,actionType\n')
		
		# read first line of the file
		fileNameBadges = filePathRootBadges + userName + 'Badges.csv'
		outIndvBadges = open(fileNameBadges,'w')
		outIndvBadges.write('user,date,BadgeType\n')
		
		#===================
		# collecting activity data
		#====================
		# accepted: <tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2015-01-04 18:57:45Z">Jan<br>4</div></div>[^<]*</td>
				#[^<]*<td>[^<]*<span class="answered-accepted" style="padding:3px; font-weight:bold;">accepted</span>
				#[^<]*</td>[^<]*<td class="" id="">
				#[^<]*<b><a href="/questions/27768901/is-it-possible-to-assign-css-properties-on-specific-zoom/27769101#27769101" class="answer-hyperlink timeline-answers">Is it possible to assign CSS properties on specific zoom?</a></b>
				#[^<]*</td>[^<]*</tr>
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=all&page=2'	
		#===============================================
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*<span class="answer[^"]*" style="[^"]*">[^<]*</span>'
		pattern = pattern + '[^<]*</td>[^<]*<td[^<]*>'
		pattern = pattern + '[^<]*<b><a href="/questions/[^"]*" class="[^"]*">[^<]*</a>[^<]*</b>[^<]*</td>[^<]*</tr>'
		acceptedDates=re.findall(pattern, readItem)
		
		first = True
		# save the acceptances
		if len(acceptedDates) != 0:
			for i in acceptedDates:
				outIndvActions.write('%s,%s,accepted\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if first == True:
					first = False
					minDate = dateDecom
				else:
					if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
						minDate = dateDecom
		
		#===============================================
		# post: <tr class="">[^<]*<td>[^<]*<div class="date" title="2015-02-11 01:56:22Z">20m</div>[^<]*</td>[^<]*<td>
				#[^<]*<span class="accept-answer-link">answered</span>[^<]*</td>
				#[^<]*<td class="async-load load-prepped" id="enable-load-body-28445311"><a class="load-body expander-arrow-small-hide" style=""></a>&nbsp;
				#[^<]*<b><a href="/questions/28444905/initialize-then-increment-the-rownumber-of-a-record-set-if/28445311#28445311" class="answer-hyperlink timeline-answers">initialize then increment the rownumber of a record set if</a></b>
				#[^<]*</td>[^<]*</tr>
		#===============================================
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*<span class="[^"]*">answered</span>[^<]*</td>'
		answerDates=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(answerDates) != 0:
			for i in answerDates:
				outIndvActions.write('%s,%s,poste-answered\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom

		# asked
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=posts'
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*<b>asked</b>[^<]*</td>'
		askedDates=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(askedDates) != 0:
			for i in askedDates:
				outIndvActions.write('%s,%s,post-asked\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom
		
		
		#===============================================		
		#badges: <tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2015-01-21 14:13:41Z">Jan<br>21</div></div>
					#[^<]*</td>[^<]*<td>[^<]*awarded</td>[^<]*<td class="" id="">
					#[^<]*<a href="/help/badges/26/popular-question?userid=2963652" title="bronze badge: Asked a question with 1,000 views" class="badge"><span class="badge3"></span>&nbsp;Popular Question</a>            </td>
					#[^<]*</tr>
					
				#<tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2015-01-23 03:09:15Z">Jan<br>23</div></div>
				#[^<]*</td>[^<]*<td>[^<]*awarded</td>[^<]*<td class="" id="">
				#<a href="/help/badges/296/html?userid=2963652" title="bronze badge: Earned at least 100 total score for at least 20 non-community wiki answers in the html tag" class="badge-tag"><span class="badge3"></span>&nbsp;html</a>            </td>
				#[^<]*</tr>
				
				#<tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2014-11-07 07:13:37Z">Nov<br>7</div></div>[^<]*</td>
				#[^<]*<td>[^a-zA-Z]*awarded</td>[^<]*<td class="" id="">
				#[^<]*<a href="/help/badges/13/yearling?userid=2963652" title="silver badge: Active member for a year, earning at least 200 reputation" class="badge"><span class="badge2"></span>&nbsp;Yearling</a>            </td>
				#[^<]*</tr>
				
				#<tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2014-10-20 15:07:33Z">Oct<br>20</div></div>[^<]*</td>
				#[^<]*<td>[^a-zA-Z]*awarded</td>[^<]*<td class="" id="">
				#[^<]*<a href="/help/badges/1298/marshal?userid=2963652" title="gold badge: Raised 500 helpful flags" class="badge"><span class="badge1"></span>&nbsp;Marshal</a>            </td>
				#[^<]*</tr>
				
		#===============================================
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=all&page=1'
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*[^a-zA-Z]*awarded</td>[^<]*<td[^>]*>[^<]*<a  href="[^"]*"[^t]*title="([^ ]*) badge:'
		#pattern = pattern + '[^<]*<a href="[^"]*"'
		badgesInfo=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(badgesInfo) != 0:
			for i in badgesInfo:
				outIndvActions.write('%s,%s,%s\n',%(userName,i[0],i[1]))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i[0])
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom

		#===============================================
		#comment: <tr class="">[^<]*<td> [^<]*<div class="date" title="2015-02-10 14:06:17Z">11h</div>[^<]*</td>
				# [^<]*<td>[^a-zA-Z]*comment</td>[^<]*<td class="" id="">
				#[^<]*<b><a href="/questions/28433648/sql-sum-different-rows#comment45197302_28433648" class="question-hyperlink timeline-answers">SQL - SUM different rows</a></b>
				#[^<]*<br>[^<]*<span class="comments">(1) Choose the correct database tag for the question.  (2) Add sample data as well as the desired results.</span>
				#[^<]*</td>[^<]*</tr>
		#===============================================		
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^a-zA-Z]*comment[^<]*</td>'
		commentDates=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(commentDates) != 0:
			for i in commentDates:
				outIndvActions.write('%s,%s,comment\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom
				
		#===============================================
		# revision: [^<]*<tr class="">[^<]*<td>[^<]*<div class="date" title="2015-02-10 22:49:41Z">3h</div>
				#[^<]*</td>[^<]*<td>[^<]*<span style="color:maroon;">revised</span>[^<]*</td>
				#[^<]*<td class="async-load load-prepped" id="enable-load-revision-7c4c1a36-af81-4ccb-b646-6eca484dc274"><a class="load-body expander-arrow-small-hide" style=""></a>&nbsp;
				#[^<]*<b><a href="/questions/28442921/sql-case-statement-for-no-data/28443310#28443310" class="answer-hyperlink timeline-answers">SQL CASE Statement for no data</a></b>
				#[^<]*<br>[^<]*<span class="revision-comment">Missed the success message.</span>[^<]*</td>[^<]*</tr>
		#===============================================
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=revisions'
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*<span style="[^"]*">revised</span>[^<]*</td>'
		reviseDates=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(reviseDates) != 0:
			for i in reviseDates:
				outIndvActions.write('%s,%s,revision\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom
				
		#===============================================
		# reviews: <tr class="">[^<]*<td>[^<]*<div class="date" title="2015-02-09 22:18:14Z">1d</div>[^<]*</td>[^<]*<td>[^a-zA-Z]*reviewed</td>
				#[^<]*<td class="" id="">[^<]*<a href="/review/suggested-edits/6997764" class="reviewed-action">Approve</a>
				#[^<]*<b><a href="/questions/28420457/how-to-combine-multiple-rows-into-one-row-when-using-sql-statement" class="question-hyperlink">How to combine multiple rows into one row when using SQL statement</a></b>
				#[^<]*</td>[^<]*</tr>
		#===============================================
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=reviews'
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=all'
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>[^<]*<td>'
		pattern = pattern + '[^r]*reviewed</td>'
		reviewDate=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(reviewDate) != 0:
			for i in reviewDate:
				outIndvActions.write('%s,%s,review\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom
					
		#===============================================		
		# suggestion: 	<tr class="">[^<]*<td>[^<]*<div class="date"><div class="date_brick" title="2015-01-04 18:54:37Z">Jan<br>4</div></div>[^<]*</td>
				#[^<]*<td>[^<]*<span title="suggested an edit to this post">suggested</span>[^<]*</td>[^<]*<td class="" id="">
				#[^<]*<a href="/review/suggested-edits/6646831">approved edit</a> on <a href="/questions/27768901/is-it-possible-to-assign-css-properties-on-specific-zoom/27769101#27769101" class="answer-hyperlink ">Is it possible to assign CSS properties on specific zoom?</a>            </td>
				#[^<]*</tr>
		#===============================================
		#url = 'http://stackoverflow.com/users/2963652/nicael?tab=activity&sort=all&page=2'
		pattern =  '<tr class="">[^<]*<td>[^<]*<div class="date"><div class="[^"]*" title="([^ ]*) [^"]*">[^<]*<br/>[^<]*</div></div>[^<]*</td>'
		pattern = pattern + '[^<]*<td>[^<]*<span title="[^"]*">suggested</span>[^<]*</td>'
		suggestionDate=re.findall(pattern, readItem)
		
		# save the acceptances
		if len(suggestionDate) != 0:
			for i in suggestionDate:
				outIndvActions.write('%s,%s,suggestion\n',%(userName,i))
				pattern = '([0-9]+)-([0-9]+)-([0-9]+)'
				dateDecom = re.findall(pattern,i)
				dateDecom = dateDecom[0]
				if float(dateDecom[0]) <= float(minDate[0]) && float(dateDecom[1]) <= float(minDate[1]) && float(dateDecom[2]) <= float(minDate[2]):
					minDate = dateDecom
		
		#=================================================
		# Next Page
		#=================================================
		pattern =  '<a href="([^"]*)" rel="next" title="[^"]*"> <span class="page-numbers next"> next</span>'
		nextPage=re.findall(pattern, readItem)
		
		#check whether the mission is complete
		if float(minDate[0]) <= 2014 && float(dateDecom[1]) <= 6 && float(dateDecom[2]) <= 22:
					missionFulfilled = True
		
		if len(nextPage)!=0 && missionFulfilled==False:
			url='http://stackoverflow.com'+nextPage[0]
	
	
	
	