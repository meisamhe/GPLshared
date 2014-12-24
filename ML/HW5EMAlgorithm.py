__author__ = 'MeisamHe'

import csv
import sys
import math
import random

inputPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW5\\em_data.txt" #third dataset

#-----------------------------------------------------------------------------
#    Read the the file
#-----------------------------------------------------------------------------
f = open(inputPath,'r')
temp = f.read()
import re
tokenizedElements = re.findall('([.0-9]+)\n',temp)

# number of clusters k = 3
k = 2

maxIter = 10000
deltaChange = 1e-3
loglikold = sys.maxint
logliknew = 1

import numpy as np
arrayLength = len(tokenizedElements)
# random initialization
randPermutation = np.random.permutation(arrayLength)

data=np.array(tokenizedElements, dtype='|S13')
data = data.astype(np.float64)
means = np.zeros((k))
vars   = np.zeros((k))
Nk   = np.zeros((k))

#initialization of priors
alpha = float(1)/k * np.ones((k))

#create array of sizes (not just equal but allow it to vary)
curr = arrayLength
# break points
sizeList = np.zeros((k-1))
#stick breaking approach
#first element
sizeList[0] = random.randint(1, curr-k)
for ktemp in range(1,k-1,1):
    sizeList[ktemp] = sizeList[ktemp-1]+ random.randint(1, (arrayLength - sizeList[ktemp-1])-(k-ktemp))

print 'size is:%s'%sizeList
#initialization step (M-step)
#first element
means[0] = np.mean(data[randPermutation[0:sizeList[0]]])
vars[0]  = np.var(data[randPermutation[0:sizeList[0]]])
for ktemp in range(1,k-1,1):
    means[ktemp]=np.mean(data[randPermutation[sizeList[ktemp-1]:sizeList[ktemp]]])
    vars[ktemp]=np.var(data[randPermutation[sizeList[ktemp-1]:sizeList[ktemp]]])

means[k-1]=np.mean(data[randPermutation[sizeList[k-2]:(arrayLength-1)]])
vars[k-1]=np.var(data[randPermutation[sizeList[k-2]:(arrayLength-1)]])

#print'randomPermutationIncludes: %s'%data[randPermutation[sizeList[k-2]:(arrayLength-1)]]
# means[0]= 25.32859478
# means[1] =  10.64637991
# means[2] =  25.83117456
#
# vars[0] = 0.76964529**2
# vars[1] = 27.67398593**2
# vars[2] = 1.01585079**2
#
# alpha[0]= 0.20138298429507084
# alpha[1]= 0.6749031238304013
# alpha[2] = 0.12371389187452786

#test with selecting k different initial point as mean
sizeList = np.zeros((k))
sizeList[0] = random.randint(1, curr-k)
totalVar    = np.var(data)
for ktemp in range(1,k,1):
    sizeList[ktemp] = sizeList[ktemp-1]+ random.randint(1, (arrayLength - sizeList[ktemp-1])-(k-ktemp))
    means[ktemp] = data[sizeList[ktemp]]
    vars[ktemp] = totalVar * np.random.uniform(0,1,1)
    alpha[ktemp] = float(sizeList[ktemp])/arrayLength


print 'initial means are: %s and intial variances are: %s'%(means,vars)

alphavec = np.repeat(np.matrix(alpha),arrayLength,axis=0)
alphavec.shape #(6000,3)

x = np.repeat(np.matrix(data),k,axis=0)
x.shape #(3,6000)
x = x.transpose()
x.shape # (6000,3)

from numpy import linalg

curIter = 0

meanvec = np.repeat(np.matrix(means),arrayLength,axis=0)
meanvec.shape #(6000,3)

while (abs(loglikold-logliknew)>deltaChange) and curIter<maxIter:
    curIter = curIter + 1
    loglikold =   logliknew
    #======================================================================================================
    #E-step, calculating probabilities, and use them with prior to caldulate weights [N*K matrix]
    #======================================================================================================
    # using log scale


    varvec = np.repeat(np.matrix(vars),arrayLength,axis=0)
    #varvec.shape #(6000,3)
    varvecinv = 1.0/varvec        # as it is one element variance it is simply its inverse

    # as it is one element vector its transpose equals to itself
    prob = -05*np.log(2*np.pi)-0.5*np.log(varvec)-0.5*np.multiply(np.multiply((x-meanvec),varvecinv),(x-meanvec))
    #prob.shape # (6000,3)
    #print 'max of prob is %s, and min of prob is %s'%(np.max(prob),np.min(prob))
    #prob [prob<-50] = -50

    prob = prob + np.log(alphavec)
    #print 'max of prob is %s, and min of prob is %s'%(np.max(prob),np.min(prob))
    probexp = np.exp(prob)

    #print 'prob exponent is:%s'%(probexp)

    denom = np.repeat(np.matrix(np.sum(probexp,axis=1)),k,axis=1)
    #print 'denominator is %s'%denom
    denom.shape # (6000,3)

    #denom [denom <1e-50 ] = 1e-50

    weight = np.multiply(probexp,(1.0/denom))
  #  print 'max of weight is %s and min of weight is %s'%(np.max(weight),np.min(weight))
    #======================================================================================================
    #M-Step use membership weights and data to compute the new parameters
    #======================================================================================================
    Nk = np.sum(weight,axis = 0)
   # print 'Nk is %s'%Nk
    alphavec = np.repeat(np.matrix(Nk/float(arrayLength)),arrayLength,axis=0)
  #  print 'new alphavec is:%s',alphavec
    alphavec.shape #(6000,3)
    means = np.diag(weight.transpose()*x)/Nk
    meanvec = np.repeat(np.matrix(means),arrayLength,axis=0)
    vars  = (np.diag(weight.transpose()*np.multiply((x-meanvec),(x-meanvec))))/Nk

    logliknew = sum(np.log(denom))/3.0
    logliknew = logliknew[0,0]
    if curIter>1:
        print 'the current iteration is:%s and its likelihood is: %s with mean: %s and vars: %s'%(curIter,logliknew,means,vars)

print '--------------------the EM operation converged------------------------\n'
print 'the components are:\n'
print 'means:%s\n'%means
print 'variances: %s\n'%vars
print 'the size of each component is:',np.matrix(Nk/float(arrayLength))

print 'log likelihood is:%10.40f'%logliknew

import matplotlib.pyplot as plt
plt.hist(data)
plt.show()

# import SampleEM as sem2


# result = sem2.expectation_maximization(np.matrix(data).transpose(), nbclusters=3, nbiter=3, normalize=False,\
#         epsilon=1e-3, monotony=False, datasetinit=True)
#
# print 'result of sample EM is:%s'%result