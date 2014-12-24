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
currentDatasetName = "FeatureSelectedDatasetARFF"
    #"DresssSales"
    #"BankData"
dataset = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\%s.arff"%currentDatasetName   # third dataset
newDatasetPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\tenfold\\"
f = open(dataset,'r')
temp = f.read()

import re
header = re.findall('(@relation[a-z A-Z -@{}0-9,.\n]*@data\n)',temp)
result = re.findall('@data\n([-0-9 ,.\n]*)', temp)
data = re.split('\n',result[0])

randPermutation = np.random.permutation(len(data)-1)

#-----------------------Create data for 10-fold cross validation--------------------------------------
datalen = len(data)-1
foldsize = datalen/10
tempData = []
for i in range(1,11,1):
    validData = []
    tempData = data
    topoplist = []
    for j in range(foldsize*(i-1),foldsize*i,1):
        topoplist.insert(len(topoplist),randPermutation[j])
    topoplist.sort()
    for j in range(len(topoplist)-1,-1,-1):
        if (topoplist[j]<len(tempData)):
            validData.insert(len(validData),tempData.pop(topoplist[j]))
    validFile = newDatasetPath+"valid"+currentDatasetName+"%s"%i+".arff"
    trainFile = newDatasetPath+"train"+currentDatasetName+"%s"%i+".arff"
    f = open(trainFile,"w")
    f.write(header[0])
    for j in range(len(tempData)):
        f.write('%s\n'%tempData[j])
    f.close()
    f = open(validFile,"w")
    f.write(header[0])
    for j in range(len(validData)):
        f.write('%s\n'%validData[j])
    f.close()

