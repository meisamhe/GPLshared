__author__ = 'MeisamHe'

import csv
import sys
import math
import random
import numpy as np
import os

#-----------------------------------------------------------------------------
#    Read the Ham file
#-----------------------------------------------------------------------------
RGBHUEARFFpath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\RGBHUEARFFs\\"
clusterSummarypath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\clusteringSummary\\"

postfix =  "pn.arff"
            #".arff"
            #"pn.arff"
            #"hb.arff"

initial    = 149
totalFiles = 213
# infoisbeautiful 1-64
# hubspot 1-45
# pinterest 1-146, 149-213 (removed 147,148 => is 290 and 291=143+148 from the lemmatized file => use output of lemmatizedOutputCleaned.txt)
# remaining hubspot 48-82

# write into a file
outClustSummary = open(clusterSummarypath+"%s.txt"%(postfix), 'w')
#outClustSummary.write("imgSize,clust1Frac,clust2Frac,clust3Frac,clust4Frac,clust5Frac,Rimg, Gimg, Bimg, Himg, Simg, Vimg, R1,R2,R3,R4,R5,G1,G2,G3,G4,G5,B1,
# B2,B3,B4,B5,H1,H2,H3,H4,H5,S1,S2,S3,S4,S5,V1,V2,V3,V4,V5\n")

# function to convert list of string to list of floats
def tofloat(seq):
    #use: list(tofloat(sq))
        for x in seq:
            try:
                yield float(x)
            except ValueError:
                yield x
def origIndextoSortedList(myList):
    return [i[0] for i in sorted(enumerate(myList), key=lambda x:x[1])]
def returnIndexList(myList,indexList):
    return [myList[i] for i in indexList]

for curimg in range(initial,totalFiles+1,1):
    print 'start to extract output of %s of %s images'%(curimg,totalFiles)
    trainingOutput = RGBHUEARFFpath+"trainingOutput%s%s.txt"%(curimg,postfix)
    import re
    f = open(trainingOutput ,'r')
    temp = f.read()
    import re
    clustersizes= re.findall('\(([0-9]+)\)',temp)
    # run sort algorithm to find order of cluster info
    dataSize = float(clustersizes[0])
    clustersizes.pop(0)
    clusterfrac= [i/dataSize for i in list(tofloat(clustersizes))]
    correctindex = origIndextoSortedList(clusterfrac)
    clusterfrac.sort()

    #use the first one to normalize
    redInfo     = list(re.findall('Red\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])
    greenInfo = list(re.findall('Green\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])
    blueInfo    =  list(re.findall('Blue\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])
    hueInfo       =  list(re.findall('Hue\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])
    valueInfo     =  list(re.findall('Value\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])
    saturationInfo =  list(re.findall('Saturation\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)\D*([0-9.]+)',temp)[0])

    if (len(clusterfrac)==5):
        allInfo = '%s'%dataSize+',' + '%s'%clusterfrac[0] + ',%s'%clusterfrac[1] +',%s'%clusterfrac[2] +',%s'%clusterfrac[3] +',%s'%clusterfrac[4] + ',%s'%redInfo[0] +',' +\
                  '%s'%greenInfo[0] +',' + '%s'%blueInfo[0] +',' + '%s'%hueInfo[0] +',' + '%s'%valueInfo[0] +',' + '%s'%saturationInfo[0]

        #put information of cluster meansTogether
        redInfo.pop(0),greenInfo.pop(0),blueInfo.pop(0),hueInfo.pop(0),valueInfo.pop(0),saturationInfo.pop(0)
        sortedRedInfo=returnIndexList(list(tofloat(redInfo)),correctindex)
        sortedGreenInfo=returnIndexList(list(tofloat(greenInfo)),correctindex)
        sortedBlueInfo=returnIndexList(list(tofloat(blueInfo)),correctindex)
        sortedHueInfo=returnIndexList(list(tofloat(hueInfo)),correctindex)
        sortedValueInfo=returnIndexList(list(tofloat(valueInfo)),correctindex)
        sortedSaturationInfo=returnIndexList(list(tofloat(saturationInfo)),correctindex)

        totalList = sortedRedInfo + sortedGreenInfo + sortedBlueInfo + sortedHueInfo + sortedValueInfo + sortedSaturationInfo

        for item in totalList:
            allInfo = allInfo + ',' + '%s'%item

    outClustSummary.write('line%s\t%s\n'%(curimg,allInfo))