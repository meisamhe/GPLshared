__author__ = 'MeisamHe'
#----------------------------------------------------------------------
# Third 25 Point
#------------------------------------------------------------------------
#---------- Imrpove NB and LR by throughing away (filter out) stop words: "the", "of" and "for"----------
# 1. Put stop words in the vector, and remove them from the hash table
# read the stop words from stopwords folder
#arg1 = sys.argv[1]
#arg2 = sys.argv[2]
#arg3 = sys.argv[3]
#rootpath = arg1
#testRootpath = arg2
#stopwordPath = arg3

import re

stopwordPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW2\\stopwords.txt"
f = open(stopwordPath,'r')
temp = f.read()
stopwordList= re.split('\W+',temp)
dictionary = {}
for word in stopwordList:
    dictionary[word]=""
#tesstring = "meisam, I have heard that formerly you own seeking asking tends, is that true?"

#for word, initial in dictionary.items():
#    tesstring=tesstring.lower()
#    tesstring = tesstring.replace(" "+word.lower()+" ", " "+initial+" ")

#print tesstring

import csv
import sys
import math
import random
#----------------------------------------------------------------------
# First 25 Point
# ---------------------------Naive Bayes-------------------------------

#------------------------Main Algorithm -------------------------------
# 1. Recieve the folder for training and folder for test
#arg1 = sys.argv[1]
#arg2 = sys.argv[2]
#rootpath = arg1
#testRootpath = arg2

# 2. Read number of files in the folder of Ham/SPAM and create prior probability
# 3. Read all files and for each class concatenate all together into a sring

rootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW2\\hw2_train\\train"

#-----------------------------------------------------------------------------
#    Read the Ham file
#-----------------------------------------------------------------------------
mypath = rootpath + "\\ham"
from os import listdir
from os.path import isfile, join
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalHams = len(onlyfiles)
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
HamFilecontent = TextOfAllDocs
for word, initial in dictionary.items():
    HamFilecontent=HamFilecontent.lower()
    HamFilecontent = HamFilecontent.replace(" "+word.lower()+" ", " "+initial+" ")
#-----------------------------------------------------------------------------
#    Read the Spam file
#-----------------------------------------------------------------------------
mypath = rootpath + "\\spam"
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalSpams = len(onlyfiles)
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
SpamFilecontent = TextOfAllDocs
for word, initial in dictionary.items():
    SpamFilecontent=SpamFilecontent.lower()
    SpamFilecontent = SpamFilecontent.replace(" "+word.lower()+" ", " "+initial+" ")
#-----------------------------------
#   Prior
#-----------------------------------
Hamprior = float(totalHams)/(totalHams + totalSpams)
print(totalHams)
Spamprior = 1- Hamprior

# 4. run Function Parse, recieve an string and return hash table of all the terms within and their frequency
import re
tokenizedSpam = re.split('\W+',SpamFilecontent)
tokenizedHam  = re.split('\W+',HamFilecontent)

FreqTableSpam = {}
for token in range(0,len(tokenizedSpam),1):
    if tokenizedSpam[token] in FreqTableSpam:
        FreqTableSpam [tokenizedSpam[token]] = FreqTableSpam [tokenizedSpam[token]] + 1
    else:
        FreqTableSpam [tokenizedSpam[token]] = 1

FreqTableHam = {}
for token in range(0,len(tokenizedHam),1):
    if tokenizedHam[token] in FreqTableHam:
        FreqTableHam [tokenizedHam[token]] = FreqTableHam [tokenizedHam[token]] + 1
    else:
        FreqTableHam [tokenizedHam[token]] = 1
    if not tokenizedHam[token] in FreqTableSpam:
        FreqTableSpam[tokenizedHam[token]] = 0

# look back to create the same zero element for tokens of Spam
for token in range(0,len(tokenizedSpam),1):
    if not tokenizedSpam[token] in FreqTableHam:
        FreqTableHam[tokenizedSpam[token]] = 0
print 'the frequency of table Ham is:'
print(len(FreqTableHam))
print(len(FreqTableSpam))

# 5. run Function Train MultinomialNB(C,D): Addone-Laplase smoothing [Log Scale]
# first for Spam class
condprobSpam = {}
totalSpamKeywords = 0
for keys in FreqTableSpam:
   totalSpamKeywords = totalSpamKeywords + FreqTableSpam[keys]+1
for keys in FreqTableSpam:
    condprobSpam[keys] = float(FreqTableSpam[keys]+1)/totalSpamKeywords
# second for Ham class
condprobHam = {}
totalHamKeywords = 0
for keys in FreqTableSpam:
   totalHamKeywords = totalHamKeywords + FreqTableHam[keys]+1
for keys in FreqTableSpam:
    condprobHam[keys] = float(FreqTableHam[keys]+1)/totalHamKeywords

# 6. run Function Apply MultinomialNBD(C,V<prior,condprob,d): Addone-Laplase smoothing[Log Scale]
testRootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW2\\hw2_test\\test"

correctlyClassified = 0
TotalSizeOfClassification = 0

#-----------------------------------------------------------------------------
#    Read the Ham file
#-----------------------------------------------------------------------------
mypath = testRootpath + "\\ham"
print(mypath)
from os import listdir
from os.path import isfile, join
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalHams = len(onlyfiles)
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TotalSizeOfClassification = TotalSizeOfClassification +1
    scoreHam = math.log(Hamprior)
    scoreSpam = math.log(Spamprior)
    # parse read item
    tokenizeditem = re.split('\W+',temp)
    #update score for Spam
    for item in tokenizeditem:
        if item in condprobSpam:
            scoreSpam = scoreSpam + math.log(condprobSpam[item])
    #update score for Ham
    for item in tokenizeditem:
        if item in condprobHam:
            scoreHam = scoreHam + math.log(condprobHam[item])
    if scoreHam > scoreSpam:
        correctlyClassified = correctlyClassified +1

#-----------------------------------------------------------------------------
#    Read the Spam file
#-----------------------------------------------------------------------------
mypath = testRootpath + "\\spam"
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalSpams = len(onlyfiles)
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TotalSizeOfClassification = TotalSizeOfClassification +1
    scoreHam = math.log(Hamprior)
    scoreSpam = math.log(Spamprior)
    # parse read item
    tokenizeditem = re.split('\W+',temp)
    #update score for Spam
    for item in tokenizeditem:
        if item in condprobSpam:
            scoreSpam = scoreSpam + math.log(condprobSpam[item])
    #update score for Ham
    for item in tokenizeditem:
        if item in condprobHam:
            scoreHam = scoreHam + math.log(condprobHam[item])
    if scoreHam < scoreSpam:
        correctlyClassified = correctlyClassified +1

# 7. Print the results => report accuracy: Correctly classified divided by total size
print (' the result of the Naive Bayes algorithm is as follows: ')
precision = float(correctlyClassified)/TotalSizeOfClassification
print(precision)


# 2. Run NB and report accuracy
# 3. Report accuracy
# 4. Compare accuracy: Correctly classified divided by total size
# 5. Why accuracy improved

