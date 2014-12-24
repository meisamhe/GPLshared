__author__ = 'MeisamHe'

#----------------------------------------------------------------------
# Extra credit: smoothing or feature selection method to improve accuracy
#--------------------------------------------------------
# 1. Report the accuracy of method => Mutual Information, X^2, Frequency
# 2. Why the method work and why not?
# Accuracy: : Correctly classified divided by total size


# Expected Mutual infomation A(t,c)
# how much information the presence/absence of a term contributes to making the correct classification decision on c
# couple (t,c) = ({0,1},{0,1}) term and class of document
# N1. = N10+N11
# N=N00+N01+N10+N11
# I(U;C)=N11/N*log(N*N11/N1./N.1)+N01/N*log(N*N01/N0./N.1)+N10/N*log(N*N10/N1./N.0)+N00/N*log(N*N00/N0./N.0)
# V: Vocabulary vector
# L = []
# for each t(term) in Vocab vector V:
#      A(t,c) = I(U;C): Feature utility expected mutual information
#      Append(L,<A(t,c),t>)
# return Features with Largest Value (L,k)
# select only 100, as according to figure 13.8 it has the largest accuracy

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
hamdocList = []
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
    hamdocList.insert(len(hamdocList),temp)
HamFilecontent = TextOfAllDocs
#-----------------------------------------------------------------------------
#    Read the Spam file
#-----------------------------------------------------------------------------
mypath = rootpath + "\\spam"
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalSpams = len(onlyfiles)
spamdocList = []
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
    spamdocList.insert(len(spamdocList),temp)
SpamFilecontent = TextOfAllDocs

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


#---------------------------------------------------------------------------------------------------------------------
# Feature Selection Portion
#---------------------------------------------------------------------------------------------------------------------
# My algorithm:
# L = {}
# For each unique feature (keyword) do:
#        calculate N00, N01, N10, N11
#        calculate N.0,N.0,N1.,N.1
#        N1. = N10+N11
#        N=N00+N01+N10+N11
#        Calculte I(U;C)=N11/N*log(N*N11/N1./N.1)+N01/N*log(N*N01/N0./N.1)+N10/N*log(N*N10/N1./N.0)+N00/N*log(N*N00/N0./N.0)
#        A(t,c) = I(U;C)
#        L[feature] = A(t,c)
# for 1 to 100:
#      selectedFeature[i] = max of remaining features content
# use the selected feature as the basis for later computations
L = {}
import math
# started N00, N10, N11, N01 with 1 to avoid 0 problem
# to be efficient I should only pass once
# count N00
N10={}
for doc in hamdocList:
    docword = re.split('\W+',doc)
    uniquedocword = []
    for feature in docword:
        if feature not in uniquedocword:
            uniquedocword.insert(len(uniquedocword),feature)
    for feature in uniquedocword:
        if feature in N10:
            N10[feature] = N10[feature] + 1
        else:
            N10[feature]= 1
N11={}
for doc in spamdocList:
    docword = re.split('\W+',doc)
    uniquedocword = []
    for feature in docword:
        if feature not in uniquedocword:
            uniquedocword.insert(len(uniquedocword),feature)
    for feature in uniquedocword:
        if feature in N11:
            N11[feature] = N11[feature] + 1
        else:
            N11[feature] = 1

# correct for terms not in the other list
for term in N10:
    N10[term] = N10[term] + 1
    if term not in N11:
        N11[term] = 1
    else:
        N11[term] = N11[term] + 1
for term in N11:
    if term not in N10:
        N10[term]=1
    else:
        N11[term] = N11[term] + 1
N00={}
for feature in N10:
    N00[feature] = totalHams + 2 - N10[feature]
N01={}
for feature in N11:
    N01[feature] = totalSpams + 2 - N11[feature]

for feature in N01:
    if N00[feature] == 0:
        N00[feature] = 1
    if N10[feature] == 0:
        N10[feature] = 1
    if N01[feature] == 0:
        N01[feature] = 1
    if N11[feature] == 0:
        N11[feature] = 1
    N=N00[feature]+N01[feature]+N10[feature]+N11[feature]
    N1d = N10[feature]+N11[feature]
    N0d = N01[feature]+ N00[feature]
    Nd1 = N01[feature] + N11[feature]
    Nd0 = N00[feature] + N10[feature]
    f1 = math.log(float(N)*N11[feature]/N1d/Nd1)
   # print 'N01 is:',N01[feature]
   # print 'N0d is:',N0d
   # print 'N00[feature] is:', N00[feature]
    #print 'Nd1 is:', Nd1
    f2 = math.log(float(N)*N01[feature]/N0d/Nd1)
    f3 = math.log(float(N)*N10[feature]/N1d/Nd0)
    f4 = math.log(float(N)*N00[feature]/N0d/Nd0)
    I=N11[feature]/N*f1+N01[feature]/N*f2+N10[feature]/N*f3+N00[feature]/N*f4
    L[feature] = I

selectedFeatures = []
# only work with 100 features as the maximum erformance algorithm based on 13.8
for i in range(1,500,1):
    maxfeature = -1
    for feature in N01:
        if feature not in selectedFeatures and feature!="" and feature in FreqTableHam:
            if maxfeature == -1:
                maxfeature = feature
            elif L[feature] > L[maxfeature]:
                maxfeature = feature
    selectedFeatures.insert(len(selectedFeatures),maxfeature)
tempFreqTableHam = {}
tempFreqTableSpam = {}
print "list of feature is",selectedFeatures
for feature in selectedFeatures:
    print "feature is:", feature
    tempFreqTableHam[feature] = FreqTableHam[feature]
    tempFreqTableSpam[feature]= FreqTableSpam[feature]
FreqTableHam  = tempFreqTableHam
FreqTableSpam = tempFreqTableSpam
print(len(FreqTableHam))
print(len(FreqTableSpam))

#--------------------------------------------------------------------------------------------------------------------
#    End of Feature Selection portion
#--------------------------------------------------------------------------------------------------------------------
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