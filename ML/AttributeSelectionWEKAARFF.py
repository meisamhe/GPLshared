__author__ = 'MeisamHe'


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

#rootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset1\\hw2_train\\train"   #first dataset
#rootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset2\\enron1_train\\enron1\\train"  # second dataset
rootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset3\\enron4_train\\enron4\\train" #third dataset

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

# solution: one pass and create complete vector and in the second pass just create frequency, and stack Y's
# also for test just check frequency of each keyword

wordList = FreqTableSpam.keys()
print 'word list includes:',wordList
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
eta = 0.1
# weight of move in gradient ascent
niterations   = 10
iteration = 0
# convergence rate
convrate = 0.05
# 5. Initialize weights to some random function, print weights
import random
# an extra one for w0
weightvector=[random.uniform(-1,1) for _ in xrange(len(FreqTableSpam)+1)]
# perceptron output
perceptronOutput = 0

print "---------------------------Starting Multinomial Perceptron for Ham/Spam Classification ---------------------------------"
print "eta is:",eta
print "number of iterations is:", niterations
print "convergence rate is:",convrate
print "starting value is:", weightvector
# 6. Until Conversion value (dwi is close to zero) => which first parinted do the following
converged = 0
#print 'length of Xvector is:',len(Xvector)
#print 'the first element is:',Xvector[0]
#print 'the second element is:',Xvector[1]
# while (converged != 1) and (iteration<niterations):
# #    6.1. wieghtedsum = w0+sum(wi.Xi)
#     iteration = iteration + 1
#     Probvector = []
#     weightedsum = weightvector[0]
#     maxdw = 0
#     for line in range(0,len(Xvector),1):
#         currline = Xvector[line]
#         #print 'current line is',currline
#         for item in range(0,len(weightvector)-1,1):
#            # print item
#             weightedsum = weightedsum + weightvector[item+1]*currline[wordList[item]]
# #    6.2. if weightedsum > log(maxnumber) => weightedsum = log(maxnumber), if weightesum<log(minnumber) => weightedsum= log(minnumber)
#         if weightedsum> 0:
#             perceptronOutput  = 1
#         else:
#             perceptronOutput  = 0
#         #    w(i) = w(i) + dwi
#         # dwi = eta*(t-o)x(i)
#         weightvector[0] = weightvector[0] + eta* (Yvector[line]- perceptronOutput)
#         if abs(maxdw) < abs(eta* (Yvector[line]- perceptronOutput)):
#                 maxdw = abs(eta* (Yvector[line]- perceptronOutput))
#         for item in range(0,len(weightvector)-1,1):
#            # print item
#             weightvector[item+1] = weightvector[item+1] + eta* (Yvector[line]- perceptronOutput)
#             if abs(maxdw) < abs(eta* (Yvector[line]- perceptronOutput)):
#                 maxdw = abs(eta* (Yvector[line]- perceptronOutput))
#    # for i in range(0,len(weightvector),1):
#    #     print "new weight of weight vector i=",i," is: ",weightvector[i]," the value of maxdwo is:",maxdw
#     i = 100
#     print "another iteration is done, iteration number is", iteration
#     print "sample weight is weight of weight vector i=",i," is: ",weightvector[i]," the value of maxdwo is:",maxdw
#    # print "Yvector for i=", i,"is: ",Yvector[i]
#    # print "perceptron output is:",perceptronOutput
#
#     if abs(eta*maxdw) < abs(convrate):
#         converged = 1
# Print out ARFF File (write trainingset)
arffFile = open("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\DatasetARFF.arff","w")
arffFile.write("@relation HamSpamDataset\n")
arffFile.write("\n")
indx = 0
for token in wordList:
    arffFile.write("@attribute ")
    if (len(token)==0):
        token = 'something%s'%indx
        indx = indx+1
    arffFile.write(token)
    arffFile.write(" numeric\n")

arffFile.write("@attribute categ {0,1}\n@data\n")
for line in range(0,len(Xvector),1):
    currline = Xvector[line]
    tempstring = ""
    #arffFile.write('startline')
    #arffFile.write(str( (len(currline))))
    for item in range(0,len(weightvector)-1,1):
        #print "\ncurrent item to write is:",currline[wordList[item]],"\n"
        tempstring= tempstring + str(currline[wordList[item]])
        tempstring= tempstring + ","
    tempstring=tempstring+ str(Yvector[line])
    #arffFile.write('len of the Y vector is:')
    #arffFile.write(str(len(tempstring)))
    arffFile.write(tempstring)
    #print(tempstring)
    arffFile.write("\n")
arffFile.close()

#import weka.core.jvm as jvm
#jvm.start(class_path = ['C:/Python27/jars/python-weka-wrapper.jar','C:/Python27/jars/weka.jar'])

# from weka.core.classes import Random
# from weka.core.converters import Loader
# from weka.filters import Filter
# from weka.classifiers import Classifier, Evaluation

# run attribute selection first to not grow out of memory by Logistic Regression
import os
#java -cp "C:/Python27/jars/weka.jar" weka.filters.AttributeSelectionFilter -S weka.attributeSelection.Ranker -N 500 -E "weka.attributeSelection.InfoGainAttributeEval" -i "C:\Users\MeisamHe\Desktop\BackupToRestoreComputerApril15\MachineLearning\HW\HW3\DatasetARFF.arff" -o "C:\Users\MeisamHe\Desktop\BackupToRestoreComputerApril15\MachineLearning\HW\HW3\FeatureSelectedDatasetARFF.arff" -c last

#java weka.filters.AttributeSelectionFilter -S "weka.attributeSelection.Ranker -N 5" -E "weka.attributeSelection.InfoGainAttributeEval" -i vowel.arff -o fs_vowel.arff -c last

filter = 'weka.filters.supervised.attribute.AttributeSelection'
# keep only 500 features
ranker = "weka.attributeSelection.Ranker -N 500"
evaluation = "weka.attributeSelection.InfoGainAttributeEval"
numiter = -1
Wekapath = "C:/Python27/jars/weka.jar"
inputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\DatasetARFF.arff"
outputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\FeatureSelectedDatasetARFF.arff"
modelFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\modelFile.wkm"
#trainingOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\trainingOutput.txt"
featureSelectionCommand = 'java -cp "%s" %s -S "%s" -E "%s" -i "%s" -o "%s" -c last'% (Wekapath, filter, ranker,evaluation,inputFile,outputFile)
#trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
print featureSelectionCommand
os.system(featureSelectionCommand)


# loader = Loader()
# data = loader.load_file("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\DatasetARFF.arff")
classifier = 'weka.classifiers.functions.Logistic'
#classifier = 'weka.classifiers.bayes.NaiveBayesUpdateable'
numiter = 500
Wekapath = "C:/Python27/jars/weka.jar"
inputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\FeatureSelectedDatasetARFF.arff"
modelFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\modelFile.wkm"
trainingOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\trainingOutput.txt"
trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
#trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
print trainingCommand
os.system(trainingCommand)


# update list of features that have been selected
f = open(inputFile,'r')
temp = f.read()
import re
result = re.findall('@attribute ([0-9\w]*) numeric', temp)
print ('result is:')
print (result)
wordList = result
print ('1. size of the wordList is:')
print(len(wordList))
# 7. Print the convergence reached
print "Good News! Convergence is reached...."
# 8. After you found weights run on the test sample: weightedsum lower than zero => spam
#testRootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset1\\hw2_test\\test"   #first dataset
#testRootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset2\\enron1_test\\enron1\\test"  # second dataset
testRootpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Dataset3\\enron4\\test" #third dataset

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
arffFile = open("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\TestDatasetARFF.arff","w")
arffFile.write("@relation TestHamSpamDataset\n")
arffFile.write("\n")
indx = 0
for token in wordList:
    arffFile.write("@attribute ")
    if (len(token)==0):
        token = 'something%s'%indx
        indx = indx+1
    arffFile.write(token)
    arffFile.write(" numeric\n")

arffFile.write("@attribute categ {0,1}\n@data\n")

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
    tempstring = ""
    for item in range(0,len(wordList),1):
        #print "\ncurrent item to write is:",currline[wordList[item]],"\n"
        tempstring= tempstring + str(currentDatavectorX[wordList[item]])
        tempstring= tempstring + ","
    tempstring=tempstring+ '0'
    #arffFile.write('len of the Y vector is:')
    #arffFile.write(str(len(tempstring)))
    arffFile.write(tempstring)
    #print(tempstring)
    arffFile.write("\n")

    # currweightedmean = 0
    # indx = -1
    # for token in currentDatavectorX:
    #     indx = indx + 1
    #     currweightedmean = currweightedmean + currentDatavectorX[token] * weightvector[indx]
    # if currweightedmean < 0:
    #     correctlyClassified = correctlyClassified +1

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
    tempstring = ""
    for item in range(0,len(wordList),1):
        #print "\ncurrent item to write is:",currline[wordList[item]],"\n"
        tempstring= tempstring + str(currentDatavectorX[wordList[item]])
        tempstring= tempstring + ","
    tempstring=tempstring+ '1'
    #arffFile.write('len of the Y vector is:')
    #arffFile.write(str(len(tempstring)))
    arffFile.write(tempstring)
    #print(tempstring)
    arffFile.write("\n")

arffFile.close()
    # currweightedmean = 0
    # indx = -1
    # for token in currentDatavectorX:
    #     indx = indx + 1
    #     currweightedmean = currweightedmean + currentDatavectorX[token] * weightvector[indx]
    # if currweightedmean > 0:
    #     correctlyClassified = correctlyClassified +1
testInputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\TestDatasetARFF.arff"
testOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\testOutput.txt"
testCommand = 'java -cp "%s" %s -l "%s" -T "%s" > "%s"'% (Wekapath, classifier,modelFile,testInputFile,testOutput)
print testCommand
os.system(testCommand)

print ('2. size of the wordList is:')
print(len(wordList))

# 9. Report accuracy on the test set : Correctly classified divided by total size
# print (' the result of the Naive Bayes algorithm is as follows: ')
# precision = float(correctlyClassified)/TotalSizeOfClassification
# print(1-precision)

