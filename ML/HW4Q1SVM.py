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
kernel = 2
trainingSet = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\promoters_data.tar\\promoters_data\\training.new"   # second dataset
validationSet = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\promoters_data.tar\\promoters_data\\validation.new"   #first dataset
arffFilePath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\promoterDataset.arff"
validationArffFilePath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\ValidationpromoterDataset.arff"

print "program started to read an parse both training Data of promoters data set................."

arffFile = open(arffFilePath,"w")
validationArffFile = open(validationArffFilePath,"w")
arffFile.write("@relation promoterDataset\n")
validationArffFile.write("@relation promoterDatasetValidationSet\n")
arffFile.write("\n")
validationArffFile.write("\n")
nfeature = 57
nTrainingInstance = 71
nValidationInstance = 35
xyARFF = []
validationXYARFF = []

f = open(trainingSet,'r')
temp = f.read()
import re
result = re.findall('([0-9]+) ([0-9. :]*)\n', temp)
y = []
x = []
dictionary = {}
for i in range(len(result)):
    xyARFF.insert(len(xyARFF),[])
    if int (result[i][0]) == 0:
        y.insert(len(y),int(-1))
        ytemp = int(0)
    elif int (result[i][0]) == 1:
        y.insert(len(y),int(result[i][0]))
        ytemp = int(1)
    xtemp = re.findall('([0-9.]*):([0-9.]*)',result[i][1])
    dictionary.clear()
    for j in range(len(xtemp)):
        dictionary[int(xtemp[j][0])] = int(xtemp[j][1])
        xyARFF[i].insert(int(xtemp[j][0]), int(xtemp[j][1]))
    x.insert(len(x),dictionary)
    xyARFF[i].insert(len(xyARFF[i]),ytemp)

# run SVM
from svmutil import *
prob = svm_problem(y,x,isKernel=True)
param = svm_parameter('-t %s -c 4 -b 1'%kernel)
print 'option set is:-t %s'%kernel
m = svm_train(prob,param)


print "program continue to read an parse both validation Data of promoters data set................."
f = open(validationSet,'r')
temp = f.read()
import re
result = re.findall('([0-9]+) ([0-9. :]*)\n', temp)
y = []
x = []
dictionary = {}
for i in range(len(result)):
    validationXYARFF.insert(len(validationXYARFF),[])
    if int (result[i][0]) == 0:
        y.insert(len(y),int(-1))
        ytemp = int(0)
    elif int (result[i][0]) == 1:
        y.insert(len(y),int(result[i][0]))
        ytemp = int(1)
    xtemp = re.findall('([0-9.]*):([0-9.]*)',result[i][1])
    dictionary.clear()
    for j in range(len(xtemp)):
        dictionary[int(xtemp[j][0])] = int(xtemp[j][1])
        validationXYARFF[i].insert(int(xtemp[j][0]),int(xtemp[j][1]))
    x.insert(len(x),dictionary)
    validationXYARFF[i].insert(len(validationXYARFF[i]),ytemp)

from svmutil import *
p_label, p_acc, p_val = svm_predict(y,x,m, '-b 1')
print 'y is:', y
print 'x is:', x
print 'the accuracy is:', p_acc


#-------------------------------------------------------------Create ARFF File --------------------------------------------------------------

for i in range(len(xyARFF[0])):
    arffFile.write("@attribute ")
    arffFile.write('something%s'%i)
    arffFile.write(" numeric\n")
    validationArffFile.write("@attribute ")
    validationArffFile.write('something%s'%i)
    validationArffFile.write(" numeric\n")

arffFile.write("@data \n ")
validationArffFile.write("@data \n ")

for line in range(len(xyARFF)):
    tempstring = ""
    for item in range(len(xyARFF[line])-1):
        tempstring= tempstring + str(xyARFF[line][item])
        tempstring= tempstring + ","
    tempstring=tempstring+  str(xyARFF[line][len(xyARFF[line])-1])
    #arffFile.write('len of the Y vector is:')
    #arffFile.write(str(len(tempstring)))
    arffFile.write(tempstring)
    #print(tempstring)
    arffFile.write("\n")
arffFile.close()


for line in range(len(validationXYARFF)):
    tempstring = ""
    for item in range(len(validationXYARFF[line])-1):
        tempstring= tempstring + str(validationXYARFF[line][item])
        tempstring= tempstring + ","
    tempstring=tempstring+  str(validationXYARFF[line][len(validationXYARFF[line])-1])
    #arffFile.write('len of the Y vector is:')
    #arffFile.write(str(len(tempstring)))
    validationArffFile.write(tempstring)
    #print(tempstring)
    validationArffFile.write("\n")
validationArffFile.close()

#configuration of Multilayer Perceptron
#================================================================================================================================
LearningRate = 0.1
Momentum = 0.1
niteration = 50
HiddenUnits = "0"
#================================================================================================================================
import os
# loader = Loader()
# data = loader.load_file("C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\DatasetARFF.arff")
#classifier = 'weka.classifiers.functions.Logistic'
#classifier = 'weka.classifiers.bayes.NaiveBayesUpdateable'
classifier = 'weka.classifiers.functions.MultilayerPerceptron'
numiter = 500
Wekapath = "C:/Python27/jars/weka.jar"
inputFile = arffFilePath
modelFile = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\modelFile.wkm"
trainingOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\trainingOutput.txt"
#trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
#trainingCommand = 'java -cp "%s" %s -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,inputFile,modelFile,trainingOutput)
trainingCommand = 'java -cp "%s" %s -L %s -M %s -N %s -H "%s" -t "%s" -d "%s" > "%s"'% (Wekapath, classifier,LearningRate,Momentum,niteration, HiddenUnits, inputFile,modelFile,trainingOutput)
print trainingCommand
os.system(trainingCommand)

testInputFile = validationArffFilePath
testOutput = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW4\\testOutput.txt"
testCommand = 'java -cp "%s" %s -l "%s" -T "%s" > "%s"'% (Wekapath, classifier,modelFile,testInputFile,testOutput)
print testCommand
os.system(testCommand)

#Calculate Accuracy of Perceptron Algorithm
f = open(testOutput,'r')
temp = f.read()
weights0 = re.findall('Threshold\s*([-0-9.E]+)', temp)
print 'weight 0 is:%s'%weights0
weightVector = re.findall('Attrib something[0-9]*\s*([-0-9.E]+)', temp)
print 'the weight vector is:%s'%weightVector

right = 0
wrong = 0
for line in range(len(validationXYARFF)):
    perceptronOutput = float(weights0[0])
    for item in range(len(validationXYARFF[line])-1):
        perceptronOutput= perceptronOutput + float(validationXYARFF[line][item])*float(weightVector[item])
    if  perceptronOutput >0:
        if int(validationXYARFF[line][len(validationXYARFF[line])-1]) ==1:
            right = right + 1
        else:
            wrong = wrong + 1
    else:
        if int(validationXYARFF[line][len(validationXYARFF[line])-1]) ==0:
            right = right + 1
        else:
            wrong = wrong + 1
print 'the precision is: right/(right+wrong)=%s',float(right)/(right+wrong)
