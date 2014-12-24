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

postfix =  "hb.arff"
            #".arff"
            #"pn.arff"
            #"hb.arff"

initial    = 48
totalFiles = 82
# infoisbeautiful 1-64
# hubspot 1-45
# pinterest 1-146, 149-213
# remaining hubspot 48-82


classifier = "weka.clusterers.SimpleKMeans -N 5 -I 100"
Wekapath = "C:/Python27/jars/weka.jar"

for curimg in range(initial,totalFiles+1,1):
    print 'start to create arff file of %s of %s images'%(curimg,totalFiles)
    trainFile = RGBHUEARFFpath+"%s%s"%(curimg,postfix)
    inputFile = trainFile
    modelFile = RGBHUEARFFpath+"modelFile.wkm"
    trainingOutput = RGBHUEARFFpath+"trainingOutput%s%s.txt"%(curimg,postfix)
    trainingCommand = 'java -Xmx6G -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
    #print 'training command is%s'%trainingCommand
    print "running the classifier \"%s\" on the training data set %s "%(classifier,curimg)
    os.system(trainingCommand)


