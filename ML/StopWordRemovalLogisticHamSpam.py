import re
import csv
import sys
import math
import random

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
Spamvector = []
for filenumber in range(0,len(onlyfiles),1):
    f = open(mypath+"\\"+onlyfiles[filenumber],'r')
    temp = f.read()
    TextOfAllDocs=TextOfAllDocs+ temp
    Spamvector.insert(len(Spamvector),temp)
SpamFilecontent = TextOfAllDocs
for word, initial in dictionary.items():
    SpamFilecontent=SpamFilecontent.lower()
    SpamFilecontent = SpamFilecontent.replace(" "+word.lower()+" ", " "+initial+" ")

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
        if token in FreqTableSpam:
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
        if token in FreqTableSpam:
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
lamda = 0.1
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
        print "new weight of weight vector i=",i," is: ",weightvector[i], "the dwi is:",dwi
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