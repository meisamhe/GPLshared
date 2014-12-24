__author__ = 'MeisamHe'
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

trainingSet = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Papers\\netflix\\TrainingRatings.txt"   # second dataset
testSet = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW3\\Papers\\netflix\\TestingRating.txt"   #first dataset

print "program started to read an parse Netflix Data................."
f = open(trainingSet,'r')
temp = f.read()
import re
result = re.findall('([0-9]*),([0-9]*),([0-9.])*\n', temp)
movieIDs = {}
userIDs = {}
for item in result:
    if item[0] in movieIDs:
        movieIDs[item[0]] = movieIDs[item[0]] + 1
    else:
        movieIDs[item[0]] = 1
    if item[1] in userIDs:
        userIDs[item[1]] = userIDs[item[1]] + 1
    else:
        userIDs[item[1]] = 1

individualList = userIDs.keys()
movieList = movieIDs.keys()
print "program Finished analyzing the training data................."

movieIndex = {}
indx = 0
for movie in movieList:
    movieIndex[movie] = indx
    indx = indx + 1

userIndex = {}
indx = 0
for user in individualList:
    userIndex[user] = indx
    indx = indx + 1

print "Program started to put ratings into the huge matrix of individual * movies................."
import numpy
firstDim=len(individualList)
secondDim = len(movieList)
from scipy import sparse
import math
a = sparse.lil_matrix((firstDim,secondDim))
#    numpy.zeros(shape=(firstDim,secondDim))
numberOfIndvRating = numpy.zeros(shape=(firstDim,1))
for item in result:
    a[userIndex[item[1]],movieIndex[item[0]]] = item[2]
    numberOfIndvRating[userIndex[item[1]]] = numberOfIndvRating[userIndex[item[1]]]+1
#mtx = sparse.csr_matrix((data, (firstDim, secondDim)), shape=(3, 3))
indvMean = a.sum(1)/numberOfIndvRating

print "Program finished putting ratings into huge matrix of individual * movies................."

print "Program started to build the weighting matrix................."

# Calculate Weights:
weights = numpy.zeros(shape=(firstDim,firstDim))
for actv in range(0,len(userIndex),1):
    for i in range(0,len(userIndex),1):
        denominator = (a[actv]-indvMean[actv])*((a[actv]-indvMean[actv]).transpose())
        denominator = denominator * (a[i]-indvMean[i])*((a[i]-indvMean[i]).transpose())
        numerator = ((a[actv]-indvMean[actv])*((a[i]-indvMean[i]).transpose()))
        weights[actv,i] = numerator/math.sqrt(math.abs(denominator))

normalizationFactor = weights.sum(1)

print "Program finished building the huge weighting matrix and normalization factors................."

print "Program started to fetch the test data to calculate RMSE and MAE................."

f = open(testSet,'r')
temp = f.read()
testData = re.findall('([0-9]*),([0-9]*),([0-9.])*\n', temp)

MAE = 0
MSE = 0
RMSE = 0
for item in testData:
    prediction = indvMean[userIndex[item[1]]] + 1/normalizationFactor[userIndex[item[1]]]*weight[userIndex[item[1]]]*(a[:,movieIndex[item[0]]]-indvMean[movieIndex[item[0]]]).transpose
    error  = prediction - item[2]
    MAE = MAE + math.abs(error)
    MSE = MSE + math.abs(error)
RMSE = math.sqrt(MSE/len(testData))
MAE  = MSE / len(testData)

print "Program finished prediction on the test set and the results in terms of RMSE and MAE are :................."

print "RMSE is : ", RMSE, "\n"
print "MAE is : ", MAE , "\n"
