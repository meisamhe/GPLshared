__author__ = 'MeisamHe'

#=================================Start with the first data set farm ads=======================================================
import csv
import sys
import math
import random
import numpy as np
import os
#-----------------------------------------------------------------------------
#    Read the Ham file
#-----------------------------------------------------------------------------
currentDatasetName = "BankData"
   # "FeatureSelectedDatasetARFF"
    #"DresssSales"
    #
numiter = 30
        # test also for 30
        # test also for 100
        # test also for 150

newDatasetPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\tenfold\\"
#classifier = 'weka.classifiers.trees.J48 -C 0.25' # options -C 0.25
#classifier = 'weka.classifiers.functions.Logistic'
#classifier = 'weka.classifiers.bayes.NaiveBayes'
classifier = 'weka.classifiers.trees.DecisionStump'
if classifier== 'weka.classifiers.trees.J48 -C 0.25':
    testclassifier = 'weka.classifiers.trees.J48'
else:
    testclassifier = classifier

baggingclassifier = 'weka.classifiers.meta.Bagging -I %s -W %s'%(numiter, classifier) #options -W   Full name of base classifier.   (default: weka.classifiers.trees.REPTree)
                                                    # option -I number of iterations
                                                    #e.g. weka.classifiers.meta.Bagging -P 100 -S 1 -num-slots 1 -I 10 -W weka.classifiers.trees.J48 -- -C 0.25 -M 2
boostingclassifier = 'weka.classifiers.meta.AdaBoostM1 -I %s -P 100000 -W %s'%(numiter, classifier) # option -I number of iterations
                                                        # option -P 100000 (percentage of weight mass used for training)

#for Bagging
# classifier = baggingclassifier#'weka.classifiers.meta.Bagging -I %s -W %s'%(numiter, classifier) #-- -C 0.25
# testclassifier = 'weka.classifiers.meta.Bagging'

# for boosting
classifier = boostingclassifier
testclassifier = 'weka.classifiers.meta.AdaBoostM1'

# classifier = boostingclassifier
Wekapath = "C:/Python27/jars/weka.jar"


for i in range(1,11,1):
    validFile = newDatasetPath+"valid"+currentDatasetName+"%s"%i+".arff"
    trainFile = newDatasetPath+"train"+currentDatasetName+"%s"%i+".arff"
    inputFile = trainFile
    modelFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\models\\modelFile%s%s.wkm"%(currentDatasetName,i)
    trainingOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\trainingResults\\trainingOutput%s%s.txt"%(currentDatasetName,i)
    trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
    #print 'training command is%s'%trainingCommand
    print "running the classifier \"%s\" on the training data set %s in the %s fold"%(classifier,currentDatasetName,i)
    os.system(trainingCommand)
    #---------------------running validation------------------------------
    testInputFile = validFile
    testOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\DataSets\\ARFF\\testOutput\\testOutput%s%s.txt"%(currentDatasetName,i)
    testCommand = 'java -cp "%s" %s -l "%s" -T "%s" > "%s"'% (Wekapath, testclassifier,modelFile,testInputFile,testOutput)
    print "running the classifier \"%s\" on the validation data set %s in the %s fold"%(classifier,currentDatasetName,i)
    os.system(testCommand)




# #Calculate Accuracy of Perceptron Algorithm
# f = open(testOutput,'r')
# temp = f.read()
# weights0 = re.findall('Threshold\s*([-0-9.E]+)', temp)
# print 'weight 0 is:%s'%weights0
# weightVector = re.findall('Attrib something[0-9]*\s*([-0-9.E]+)', temp)
# print 'the weight vector is:%s'%weightVector
