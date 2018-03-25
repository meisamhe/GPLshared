__author__ = 'MeisamHe'

import sys, os, re

# use PyEnchant as a strong spell checking library
import enchant

# create english dictionary
d = enchant.Dict("en_US")

from stemming.porter2 import stem

#==========================================================================
# read the file of description of auction and category of the auction
#==========================================================================
# to clear screen: os.system("clear") or os.system("cls")

AuctionCategoryFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\CleanedData\\AuctionCategories.txt"
AuctionTitlesFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\CleanedData\\AuctionTitles.txt"
OutputFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\CleanedData\\AuctionDocWordMatrix.txt"
OutputIDLinePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\CleanedData\\mapAuctionIDLineNumber.txt"

#=====================================================================
#  Create ARFF File for Feature Selection
#=====================================================================

forFeatureSelectionARFFPath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\Projects\\RegretInAuction\\CleanedData\\DocTerm4FeatureSelection.arff"
arffFile = open(forFeatureSelectionARFFPath, 'w')


AuctionCategoryFile = open(AuctionCategoryFilePath, 'r')
AuctionTitlesFile= open(AuctionTitlesFilePath, 'r')
OutputFile = open(OutputFilePath, 'w')
OutputIDLine = open(OutputIDLinePath, 'w')

AuctionCategoryData = AuctionCategoryFile.read()
AuctionTitlesData = AuctionTitlesFile.read()

stopwordPath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW2\\stopwords.txt"
stopwordFile = open(stopwordPath,'r')

stopwordData = stopwordFile.read()
stopwordList= re.split('\W+',stopwordData)

#==========================================================
# select each line of the input file separately
#==========================================================
#word = re.findall('(^\n*)\n',AuctionTitlesData)
AuctionTitleList = re.findall('(..+)\n',AuctionTitlesData)
AuctionCategoryList = re.findall('(..+)\n',AuctionCategoryData)

AuctionDataList = {}
AuctionwordDictionary={}

for auction in AuctionCategoryList:
    #auction = AuctionCategoryList[0]
    #print(auction)
    auction = re.sub('[\b\t]', ' ', auction)
    auctionWords = re.split('\W+',auction)
    tempList = []
    for word in auctionWords[1:(len(auctionWords))]:
        if (word not in stopwordData) and (d.check(word)== True): #make sure it is in the dictionary and it is not stop word
            tempList.append(stem(word))
            if (stem(word) in AuctionwordDictionary):
                AuctionwordDictionary[stem(word)] = AuctionwordDictionary[stem(word)] +1
            else:
                AuctionwordDictionary[stem(word)] = 1
    AuctionDataList[auctionWords[0]]=tempList
    #print(AuctionDataList)

AuctionDataTitleList = {}
for auction in AuctionTitleList:
    #auction = AuctionTitleList[0]
    #print(auction)
    auction = re.sub('[\b\t]', ' ', auction)
    auctionWords = re.split('\W+',auction)
    tempList = []
    for word in auctionWords[1:(len(auctionWords))]:
        if (word not in stopwordData) and (d.check(word)== True): #make sure it is in the dictionary and it is not stop word
            tempList.append(stem(word))
            if (stem(word) in AuctionwordDictionary):
                AuctionwordDictionary[stem(word)] = AuctionwordDictionary[stem(word)] +1
            else:
                AuctionwordDictionary[stem(word)] = 1
        AuctionDataTitleList[auctionWords[0]]=tempList
        if (auctionWords[0] in AuctionDataList):
            AuctionDataList[auctionWords[0]] = AuctionDataList[auctionWords[0]]+tempList
        else:
            AuctionDataList[auctionWords[0]] = tempList
        #print(AuctionDataList)

#=======================================================================
#          Filter dictionary and remove infrequent words
#=======================================================================
filterdAuctionWordDictionary = {}

for word in AuctionwordDictionary.keys():
    if ( AuctionwordDictionary[word] > 3):
        filterdAuctionWordDictionary[word] = AuctionwordDictionary[word]

AuctionwordDictionary = filterdAuctionWordDictionary

indx = 0
termNumberMap = {}
for term in AuctionwordDictionary.keys():
    termNumberMap[term] = indx
    indx = indx + 1


curLindID = 0

attributeList = termNumberMap.keys()
arffFile.write("@relation auctionDocTerm\n\n")
arffFile.write("\n")
counter = 0
for token in attributeList:
    arffFile.write("@attribute A")
    token = re.sub(' ', '', token)
    if (len(token)==0):
        token = 'something%s'%counter
    counter = counter+1
    arffFile.write(token)
    arffFile.write('%s'%counter)
    arffFile.write(" numeric\n")
arffFile.write("\n@data\n")


for auctionID in AuctionDataList.keys():
    # auctionID = AuctionDataList.keys()[0]
    # print(auctionID)
    curLindID = curLindID + 1
    words = AuctionDataList[auctionID]
    wordVector = [0] * (len(attributeList))  #create a vector of zeros for currend auction (= document)
    for word in words:
        if (word in termNumberMap.keys()):
           wordVector[termNumberMap[word]] = wordVector[termNumberMap[word]]+1
    # first put the name of the auction in
    OutputFile.write(auctionID)
    arffFile.write('%s'% wordVector[0])
    for i in range(0,indx,1):
        OutputFile.write(',%s'% wordVector[i])
        if (i!=0):
            arffFile.write(',%s'% wordVector[i])
    OutputFile.write('\n')
    OutputIDLine.write('%s,%s\n'%(auctionID,curLindID))
    arffFile.write('\n')

arffFile.close()