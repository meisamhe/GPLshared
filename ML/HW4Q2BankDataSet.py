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
dataset = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\bank\\refinedBank.csv"   # third dataset
f = open(dataset,'r')
temp = f.read()

import re
result = re.findall('([0-9-a-zA-Z ,.]*)\n', temp)
header = re.split(',',result.pop(0))

listdict = []
indx = 0
for line in result:
    indx = indx + 1
    curLine  = re.split(',',line)
    for i in range(0,6,1):
        if indx == 1:
            listdict.insert(len(listdict), {})
        if listdict[i].has_key(curLine[i]):
            listdict[i][curLine[i]] = listdict[i][curLine[i]] +1
        else:
            listdict[i][curLine[i]] = 1
x = []
y = []
rowindx = 0
for line in result:
    curLine  = re.split(',',line)
    x.insert(len(x),[])
    for i in range(0,6,1):
        for j in range(len(listdict[i])):
            if curLine[i]==listdict[i].keys()[j]:
                x[rowindx].insert(len(x[rowindx]),1)
            else:
                x[rowindx].insert(len(x[rowindx]),0)
    for i in range(6,len(curLine)-1,1):
        x[rowindx].insert(len(x[rowindx]),curLine[i])
    rowindx = rowindx + 1
    y.insert(len(y),curLine[len(curLine)-1])


arffFilepath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\BankData.arff"
arffFile = open(arffFilepath,"w")
arffFile.write("@relation BankData\n")
arffFile.write("\n")
indx = 0

for i in range(0,6,1):
        for j in range(len(listdict[i])):
            arffFile.write("@attribute ")
            if (len(listdict[i].keys()[j])==0):
                key = '%ssomething%s'%(header[i],indx)
                indx = indx+1
            else:
                key = '%s%s'%(header[i],listdict[i].keys()[j])
            arffFile.write(key)
            arffFile.write(" numeric\n")

for i in range(6,len(curLine)-1,1):
        arffFile.write("@attribute ")
        key =header[i]
        arffFile.write(key)
        arffFile.write(" numeric\n")

arffFile.write("@attribute %s {0,1}\n@data\n"%header[len(curLine)-1])

for i in range(len(result)):
        for j in range(len(x[i])):
            arffFile.write('%s,'%x[i][j])
        arffFile.write('%s\n'%y[i])
arffFile.close()
