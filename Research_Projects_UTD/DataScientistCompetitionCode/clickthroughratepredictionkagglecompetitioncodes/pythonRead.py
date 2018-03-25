import re
import os
trainingset =  "C:\\Users\\MeisamHe\\Desktop\\Desktop\\BackupToRestoreComputerApril15\\DataScienceCompetition\\clickStream\\train\\train.csv"

testset =  "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\test\\test.csv"

testFile = open(testset, 'r')
testFileData = testFile.read()
testFileDataLine = re.findall('(..+)\n',testFileData)
# 4,577,465
#================================================================================================
# Training file is very large, so I should use different technique to read
#================================================================================================

#trainingFile = open(trainingset, 'r')
#trainingFileData = trainingFile.read()
#trainingFileDataLine = re.findall('(..+)\n',trainingFileData)
# number of lines are: 40,931,409

import time
import numpy as np
import csv

start = time.time()
def elapsed():
    return time.time() - start

# count data rows, to preallocate array
f = open(trainingset, 'rb')
def count(f):
    while 1:
        block = f.read(65536)
        if not block:
             break
        yield block.count(',')

linecount = sum(count(f))
print '\n%.3fs: file has %s rows' % (elapsed(), linecount)

# pre-allocate array and load data into array
m = np.zeros(linecount, dtype=[('a', np.uint32), ('b', np.uint32)])
f.seek(0)
f = csv.reader(open(trainingFile, 'rb'))
for i, row in enumerate(f):
    m[i] = int(row[0]), int(row[1])

print '%.3fs: loaded' % elapsed()
# sort in-place
m.sort(order='b')

print '%.3fs: sorted' % elapsed()