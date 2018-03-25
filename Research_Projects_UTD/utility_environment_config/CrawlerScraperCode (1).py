# Python Code to Extract the location of the hotel from google
# Written by: Meisam Hejazi Nia
# Feb/18/2016
#=============================================

#import os
#os.system('cls')

#===============================================
# include libraries
#===============================================
from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt
import urllib2
import re
import time
import os

#check  current working directory
#os.getcwd()
#change the current working directory to new one
#os.chdir("new_working_directory")


#-------------------------------------------------------------
# Define functions
#-------------------------------------------------------------
#set difference (list difference) function useful for amenities
def diff(a, b):
        b = set(b)
        return [aa for aa in a if aa not in b]


#*************************************************************
# Test whether I can recognize the path on a simple example
#*************************************************************
# set the path to read a sample file and match the string
#first example: "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Vila Gale Ericeira hotel - Google Search.html"
# second example:  "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Lion Pub with Rooms - Google Search.html"
# negative example:"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Americas Best Value Inn V2058 - Google Search.html"
# test the combination with download them all

sampleFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Lion Pub with Rooms - Google Search.html"

#"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Mayan+Inn.htm"
#
#"C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\GoogleExtraction\\Mayan+Inn.htm"
sampleFile = open(sampleFilePath)
content = sampleFile.read()

#Match the string of address
#<span class="_xdb">Address: </span><span class="_Xbe">Navegantes, Estr. da Fonte Boa dos Nabos, 2659-501 Ericeira, Portugal</span>
#<span class="_xdb">Address: </span><span class="_Xbe">Bridge St, Belper DE56 1AX, United Kingdom</span>
addressTemp = re.findall('<span class="_xdb">Address: </span><span class="_Xbe">([^<]*)</span>', content)
starTemp = re.findall('<div class="_mr _Wfc vk_gy"><span>([^<]*)</span></div>',content)
reviewTemp = re.findall('<div><span style="margin-right:5px" class="rtng" aria-hidden="true">([^<]*)</span><g-review-stars>',content)
amenityTemp = re.findall('<span class="_Wzg">([^<]*)</span>',content)

#unavilable amenities
amenityUnavailableTemp = re.findall('<span class="_bRg"><span class="_Czg _Xzg"></span></span><span class="_Wzg">([^<]*)</span>',content)

#available amenities
amenityAvailableTemp = diff(amenityTemp,amenityUnavailableTemp)


# for description use xpath 
#installing within the program:  which did not work in my case
#from setuptools.command import easy_install
# easy_install.main( ["html"] )

from lxml import html
import requests
tree = html.fromstring(content)

description = tree.xpath('//*[@id="rhs_block"]/div/div[1]/div/div[1]/ol/div[5]/div//span/text()')

# if exists: len(addressTemp)=1
# if does not exist: len(addressTemp) = 0
#*************************************************************

#Changed plan: create the list of URL
# put them on the google document
# run download them all


#*************************************************************
# Check reading the Hotel input file
#*************************************************************
# input file of the hotel names
hotelNameFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\SHS_PropDetails _Data.txt"
hotelNameFile = open(hotelNameFilePath,'r')
hotelNames = hotelNameFile.readlines()


#output file of the hotel names
outputURLFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\HotelNamesURL.html"
outputURL = open(outputURLFilePath,'w')

#test to break down and extract hotel name..............Done

#create header of the html file
outputURL.write('<!DOCTYPE html>\n<html>\n<body><h1>File Created by Meisam Hejazi Nia</h1>\n<p>on 02/18/2016</p>\n')

#drop the header and start from the next line
for hotelItem in range(1,len(hotelNames)): 
	curHotelData= hotelNames[hotelItem]
	curHotelName=re.split(r'\t+', curHotelData)[0]
	#URL pattern to fetch
	#"https://www.google.com/#q=Vila+Gale+Ericeira+hotel"
	#https://www.google.com/#q=Americas+Best+Value+Inn+V2058+hotel
	#https://www.google.com/#q=Fairmont+hotel
	#preparation: replace every space with '+'
	curHotelName=curHotelName.replace(' ', '+')
	hotelURL="https://www.google.com/#q="+curHotelName+"+Hotel"
	#rawPage = urllib2.urlopen(hotelURL)
	#readItem = rawPage.read()
	#addressTemp = re.findall('<span class="_xdb">Address: </span><span class="_Xbe">([^<]*)</span>', readItem)
	#outputURL.write('%s\n'%(hotelURL))
	outputURL.write('<p><a href="%s">Link Number %s</a></p>'%(hotelURL,str(hotelItem)))
	#outputURL.write('<p>%s</p>\n'%(hotelURL))

# write footer of the html file
outputURL.write('</body>\n</html>\n')
outputURL.close()


#==========================================================================================================================================================================

#=================================
# important imacro code that worked
#==================================
VERSION BUILD=8961227 RECORDER=FX
SET !EXTRACT_TEST_POPUP NO
TAB T=1
URL GOTO=file:///C:/Users/sg0224373/Desktop/SabreTasks/HotelProject/HotelSHSAllProperties/HotelNamesURL.html
SET !EXTRACT NULL
TAG POS=1 TYPE=A ATTR=TXT:Link<SP>Number<SP>{{!LOOP}} EXTRACT=TXT
SET !VAR2 {{!EXTRACT}}
TAG POS=1 TYPE=A ATTR=TXT:Link<SP>Number<SP>{{!LOOP}}
WAIT SECONDS=2
SAVEAS TYPE=CPL FOLDER=C:\Users\sg0224373\Desktop\SabreTasks\HotelProject\HotelSHSAllProperties\downloadThemAllExtraction FILE={{!LOOP}}_{{!VAR2}}
BACK
#================================

#=================================
#improvement of imacro code (!VAR1 the last element that has been saved)
#============================
VERSION BUILD=8961227 RECORDER=FX
SET !EXTRACT_TEST_POPUP NO
TAB T=1
URL GOTO=file:///C:/Users/sg0224373/Desktop/SabreTasks/HotelProject/HotelSHSAllProperties/HotelNamesURL.html
SET !EXTRACT NULL
SET !VAR1 {{!LOOP}}
ADD !VAR1 50
TAG POS=1 TYPE=A ATTR=TXT:Link<SP>Number<SP>{{!VAR1}} EXTRACT=TXT
SET !VAR2 {{!EXTRACT}}
TAG POS=1 TYPE=A ATTR=TXT:Link<SP>Number<SP>{{!VAR1}}
WAIT SECONDS=2
SAVEAS TYPE=CPL FOLDER=C:\Users\sg0224373\Desktop\SabreTasks\HotelProject\HotelSHSAllProperties\downloadThemAllExtraction FILE={{!VAR1}}_{{!VAR2}}
BACK
#==================================

#==========================================================================================================================================================================
#scraper to collect the data of the hotel locations

# input file of the hotel names
hotelNameFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\SHS_PropDetails _Data.txt"
hotelNameFile = open(hotelNameFilePath,'r')
hotelNames = hotelNameFile.readlines()

#output file
#output file of the hotel names
outputHotelAddressPath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\HotelAddress.csv"
outputHotelFile = open(outputHotelAddressPath,'w')

#create header of the html file
#===================================
#take out other relevant information
curHotelData= hotelNames[0]
curHotelName=re.split(r'\t+', curHotelData)
outputHotelFile.write('%s,%s,%s,Hotel.Address\n'%(curHotelName[0],curHotelName[1],curHotelName[2].rstrip()))

# test a sample
#path: C:\Users\sg0224373\Desktop\SabreTasks\HotelProject\HotelSHSAllProperties\downloadThemAllExtraction
googleFilePath = "C:\\Users\\sg0224373\\Desktop\\SabreTasks\\HotelProject\\HotelSHSAllProperties\\downloadThemAllExtraction\\"
#cur_i = 1000

sumNA=0

for cur_i in range(1,1001): 
	# file name format:
	#1000_Link Number 1000
	googleFileName="%s_Link Number %s.htm"%(cur_i,cur_i)
	#create the appropriate file name and path
	googleFileCompletePath = googleFilePath+googleFileName
	sampleFile = open(googleFileCompletePath,'r')
	content = sampleFile.read()
	#Match the string of address
	#<span class="_xdb">Address: </span><span class="_Xbe">Navegantes, Estr. da Fonte Boa dos Nabos, 2659-501 Ericeira, Portugal</span>
	#<span class="_xdb">Address: </span><span class="_Xbe">Bridge St, Belper DE56 1AX, United Kingdom</span>
	addressTemp = re.findall('<span class="_xdb">Address: </span><span class="_Xbe">([^<]*)</span>', content)
	if len(addressTemp)==0:
		addressTemp=['NA']
		sumNA = sumNA + 1
	#take out other relevant information
	curHotelData= hotelNames[cur_i]
	curHotelName=re.split(r'\t+', curHotelData)
	outputHotelFile.write('%s,%s,%s,%s\n'%(curHotelName[0],curHotelName[1],curHotelName[2].rstrip(),addressTemp[0].replace(',', ';')))
	print('%s\n.............Done'%cur_i)

outputHotelFile.close()
print('number of NAs are:%s'%sumNA)
























#================
# back to quick imacro
#=================
VERSION BUILD=8961227 RECORDER=FX
FILTER Type=IMAGES STATUS=OFF
TAB T=1
URL GOTO=file:///C:/Users/sg0224373/Desktop/SabreTasks/HotelProject/HotelSHSAllProperties/HotelNamesURL.html
TAG POS=1 TYPE=A ATTR=TXT:Link<SP>Number<SP>{{!LOOP}}
WAIT SECONDS=1
SAVEAS TYPE=CPL FOLDER=C:\Users\sg0224373\Desktop\SabreTasks\HotelProject\HotelSHSAllProperties\downloadThemAllExtraction FILE=+_{{!NOW:yyyymmdd_hhnnss}}




#ran for 13,622 hotels

#===================================================
# Draft codes and not used
#===================================================
#add word hotel to it if the actual did not found anything
hotelURL="https://www.google.com/#q="+curHotelName+"+hotel"		
		
# set the path for reading the hotel names

# set the path for saving the output (hotel with location or NA if the location is not found)

#pip install setuptools-20.1.1-py2.py3-none-any.whl

#C:\Program Files (x86)\Google\google_appengine\

#from google.appengine.api import urlfetch
# !!! problem in the proxy, it seems there is problem with the newtork
# The same problem exists in R
#library(XML)
# Read and parse HTML file
#doc.html = htmlTreeParse('http://apiolaza.net/babel.html',           useInternal = TRUE)
# source: http://www.r-bloggers.com/reading-html-pages-in-r-for-text-processing/

#resorting to downloadThemAll




pip install google_api_python_client-1.4.2-py2.py3-none-any.whl

import urllib2

url = "http://www.google.com/"
try:
  result = urllib2.urlopen(url)
  doSomethingWithResult(result)
except urllib2.URLError, e:
  print(e)


