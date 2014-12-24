__author__ = 'MeisamHe'

#=================================Start with the first data set farm ads=======================================================
import csv
import sys
import math
import random
import numpy as np

#-----------------------------------------------------------------------------
#    Read the Ham file
#-----------------------------------------------------------------------------
dataset = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\farm-data\\farm-ads"   # second dataset
f = open(dataset,'r')
temp = f.read()

import re
result = re.findall('(-*1) ([0-1-a-zA-Z ]*)\n', temp)
y = []
x = []
dict = {}
# create doc word matrix
for i in range(len(result)):
    docContent = result[i][1]
    wordList = re.split('\W+',docContent)
    for term in wordList:
        if dict.has_key(term):
            dict[term] = dict[term]+1
        else:
            dict[term]= 1

wordList = dict.keys()

for term in wordList:
    if dict[term]<3 :
        wordList.remove(term)

dictdoc = {}
for i in range(len(result)):
    if int(result[i][0])== 1:
        ytemp = 1
    elif int(result[i][0])== -1:
        ytemp = 0
    y.insert(len(y),ytemp)
    docContent = result[i][1]
    docwordList = re.split('\W+',docContent)
    dictdoc.clear()
    for term in docwordList:
        if dictdoc.has_key(term):
            dictdoc[term] = dictdoc[term]+1
        else:
            dictdoc[term]= 1
    currx = len(x)
    x.insert(len(x),[])
    for j in range(len(wordList)):
        if dictdoc.has_key(wordList[j]):
            x[currx].insert(len(x[currx]), dictdoc[wordList[j]])
        else:
             x[currx].insert(len(x[currx]),0)
arffFilepath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\farmads1.arff"
arffFile = open(arffFilepath,"w")
arffFile.write("@relation FarmAds\n")
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

for i in range(len(result)):
    if (len(x[i])==len(wordList)):
        for j in range(len(x[i])):
            arffFile.write('%s,'%x[i][j])
        arffFile.write('%s\n'%y[i])
arffFile.close()

# keep only 500 features
import os
ranker = "weka.attributeSelection.Ranker -N 500"
evaluation = "weka.attributeSelection.InfoGainAttributeEval"
filter = 'weka.filters.supervised.attribute.AttributeSelection'
numiter = -1
Wekapath = "C:/Python27/jars/weka.jar"
inputFile = arffFilepath
outputFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\FeatureSelectedDatasetARFF.arff"
featureSelectionCommand = 'java -Xmx2G -cp "%s" %s -S "%s" -E "%s" -i "%s" -o "%s" -c last'% (Wekapath, filter, ranker,evaluation,inputFile,outputFile)
print featureSelectionCommand
os.system(featureSelectionCommand)