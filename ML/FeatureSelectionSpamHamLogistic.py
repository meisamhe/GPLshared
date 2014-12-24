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
# Second 25 Point
# -------------- MCAP Logistic Regression with L2 Regularization-------------------
#------------------------Main Algorithm -------------------------------
# 1. Recieve the folder for training and folder for test
#arg1 = sys.argv[1]
#arg2 = sys.argv[2]
#rootpath = arg1
#testRootpath = arg2

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
Hamvector = []
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
    Hamvector.insert(len(Hamvector),temp)
HamFilecontent = TextOfAllDocs
#-----------------------------------------------------------------------------
#    Read the Spam file
#-----------------------------------------------------------------------------
mypath = rootpath + "\\spam"
onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]
#onlyfiles[1]
TextOfAllDocs = ""
totalSpams = len(onlyfiles)
Spamvector = []
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
    Spamvector.insert(len(Spamvector),temp)
SpamFilecontent = TextOfAllDocs

# 2. Read all the files and for each write the frequency of each keyword (+1 for Laplase correction) => use Parse function
# 3. Create a vector of Y of spam or ham for all the documents => stack all Y and X (Spam: 1, Ham: 0)

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
hamdocList = Hamvector
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
spamdocList = Spamvector
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

# solution: one pass and create complete vector and in the second pass just create frequency, and stack Y's
# also for test just check frequency of each keyword

wordList = FreqTableSpam.keys()
Xvector = []
Yvector = []
# Create vector of variables for Ham
for hamelement in Hamvector:
    hamterms = re.split('\W+',hamelement)
    hamtermsfreq = {}
    # Create the hash table of items
    for token in hamterms:
        if token in hamtermsfreq:
            hamtermsfreq[token] = hamtermsfreq[token] + 1
        else:
            hamtermsfreq[token] = 1
    Xvectortemp = {}
    for item in FreqTableSpam:
        if item in hamtermsfreq:
            Xvectortemp[item] = hamtermsfreq[item] + 1
        else:
            Xvectortemp[item] =  1
    Xvector.insert(len(Xvector),Xvectortemp)
    Yvector.insert(len(Yvector),0)

# create vector of variables for SPAM
for Spamelement in Spamvector:
    spamterms = re.split('\W+',Spamelement)
    spamtermsfreq = {}
    # Create the hash table of items
    for token in spamterms:
        if token in spamtermsfreq:
            spamtermsfreq[token] = spamtermsfreq[token] + 1
        else:
            spamtermsfreq[token] = 1
    Xvectortemp = {}
    for item in FreqTableSpam:
        if item in spamtermsfreq:
            Xvectortemp[item] = spamtermsfreq[item] + 1
        else:
            Xvectortemp[item] =  1
    Xvector.insert(len(Xvector),Xvectortemp)
    Yvector.insert(len(Yvector),1)

# 4. Print lamda, eta, convergance rate, and print that it is started => experiment different values of lamda
# weight of regularization
lamda = 0.001
# weight of move in gradient ascent
eta   = 0.1
# convergence rate
convrate = 0.1
# 5. Initialize weights to some random function, print weights
import random
# an extra one for w0
weightvector=[random.uniform(-1,1) for _ in xrange(len(FreqTableSpam)+1)]

print "---------------------------Starting Multinomial Logistic Model for Ham/Spam Classification ---------------------------------"
print "lambda is:",lamda
print "eta is:", eta
print "convergence rate is:",convrate
print "starting value is:", weightvector
# 6. Until Conversion value (dwi is close to zero) => which first parinted do the following
converged = 0
#print 'length of Xvector is:',len(Xvector)
#print 'the first element is:',Xvector[0]
#print 'the second element is:',Xvector[1]
while converged != 1:
#    6.1. wieghtedsum = w0+sum(wi.Xi)
    Probvector = []
    weightedsum = weightvector[0]
    for line in range(0,len(Xvector),1):
        currline = Xvector[line]
        #print 'current line is',currline
        for item in range(0,len(weightvector)-1,1):
           # print item
            weightedsum = weightvector[item+1]*currline[wordList[item]]
#    6.2. if weightedsum > log(maxnumber) => weightedsum = log(maxnumber), if weightesum<log(minnumber) => weightedsum= log(minnumber)
        if weightedsum> math.log(1e308):
            weightedsum = 1e308
        elif weightedsum< -math.log(1e308):
             weightedsum = -math.log(1e308)
        #    6.3. P(Yl=1|Xl,w)=1/(1+exp(weightedsum))
        Probvector.insert(len(Probvector),float(1)/(1+math.exp(weightedsum)))
    #    6.4. dwi = 0

 #    6.5. For each weight i: dwi = dwi + X(i,l)(Y(l)-P(l)) - wi * lamda
    dw = []
    maxdw = 0
    for i in range(0,len(weightvector),1):
        dwi = 0
        for line in range(0,len(Xvector),1):
            currline = Xvector[line]
            dwi = dwi + currline[wordList[line]]*(Yvector[line]-Probvector[line]) - weightvector[line]*lamda
        dw.insert(len(dw),dwi)
        # for dwi convergence test
        if abs(maxdw) < abs(dwi):
            maxdw = abs(dwi)
        # update weights
        #    6.6. wi = wi + eta*dwi, print updated value of w(i): Gradient ascent
        weightvector[i] = weightvector[i] + eta * dwi
        print "new weight of weight vector i=",i," is: ",weightvector[i]," the value of eta*maxdw is:",eta*maxdw
    if abs(eta*maxdw) < abs(convrate):
        converged = 1
# 7. Print the convergence reached
print "Good News! Convergence is reached...."
# 8. After you found weights run on the test sample: weightedsum lower than zero => spam
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
    tokenizeditem = re.split('\W+',temp)
    currentDatavectorX = {}
    for token in tokenizeditem:
        if token in wordList:
            if token in currentDatavectorX:
                currentDatavectorX[token] = currentDatavectorX[token] + 1
            else:
                currentDatavectorX[token] = 1
    for token in wordList:
        if token in currentDatavectorX:
            currentDatavectorX[token] = currentDatavectorX[token] + 1
        else:
            currentDatavectorX[token] = 1
    currweightedmean = 0
    indx = -1
    for token in currentDatavectorX:
        indx = indx + 1
        currweightedmean = currweightedmean + currentDatavectorX[token] * weightvector[indx]
    if currweightedmean < 0:
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
    tokenizeditem = re.split('\W+',temp)
    currentDatavectorX = {}
    for token in tokenizeditem:
        if token in wordList:
            if token in currentDatavectorX:
                currentDatavectorX[token] = currentDatavectorX[token] + 1
            else:
                currentDatavectorX[token] = 1
    for token in wordList:
        if token in currentDatavectorX:
            currentDatavectorX[token] = currentDatavectorX[token] + 1
        else:
            currentDatavectorX[token] = 1
    currweightedmean = 0
    indx = -1
    for token in currentDatavectorX:
        indx = indx + 1
        currweightedmean = currweightedmean + currentDatavectorX[token] * weightvector[indx]
    if currweightedmean > 0:
        correctlyClassified = correctlyClassified +1

# 9. Report accuracy on the test set : Correctly classified divided by total size
print (' the result of the Naive Bayes algorithm is as follows: ')
precision = float(correctlyClassified)/TotalSizeOfClassification
print(precision)

