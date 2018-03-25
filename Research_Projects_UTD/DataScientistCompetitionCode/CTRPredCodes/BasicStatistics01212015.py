# Basic statistics
'''
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
'''


from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt


# TL; DR, the main training process starts on line: 250,
# you may want to start reading the code from there


##############################################################################
# parameters #################################################################
##############################################################################

# A, paths
train ="C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\train\\train.csv"
test = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\test\\test.csv" 
trainBasicStat = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\trainBasicStat.csv"  # path of to be outputted submission file
testBasicStat =  "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\testBasicStat.csv"  # path of to be outputted submission file

#train = 'train_rev2'               # path to training file
#test = 'test_rev2'                 # path to testing file
#submission = 'submission1234.csv'  # path of to be outputted submission file


# B, model
alpha = .1  # learning rate
beta = 1.   # smoothing parameter for adaptive learning rate
L1 = 1.     # L1 regularization, larger value means more regularized
L2 = 1.     # L2 regularization, larger value means more regularized

# C, feature/hash trick
D = 2 ** 18            # number of weights to use
interaction = False     # whether to enable poly2 feature interactions

# D, training/validation
epoch = 1       # learn training data for N passes
holdafter = 9   # data after date N (exclusive) are used as validation
holdout = None  # use every N training instance for holdout validation


##############################################################################
# class, function, generator definitions #####################################
##############################################################################

def data(path, D,basicStat):
	''' GENERATOR: Apply hash-trick to the original csv row
				and for simplicity, we one-hot-encode everything
        
		INPUT:
			path: path to training or testing file
			D: the max index that we can hash to
		YIELDS:
			ID: id of the instance, mainly useless
			x: a list of hashed and one-hot-encoded 'indices'
				we only need the index since all values are either 0 or 1
			y: y = 1 if we have a click, else we have y = 0
	'''
	for t, row in enumerate(DictReader(open(path))):
		ID = row['id'] # process id
		del row['id']
		# process clicks
		y = 0.
		if 'click' in row:
			if row['click'] == '1':
				y = 1.
			del row['click']

		# extract date
		date = int(row['hour'][4:6])
		# turn hour really into hour, it was originally YYMMDDHH
		row['hour'] = row['hour'][6:]
		# build x Meisam and Ali update
		#x = [0] * D
		for key in row:
			#print('key is')
			#print(key)
			value = row[key]# one-hot encode everything with hash trick
			if key in basicStat:
				currentElement = basicStat[key]
				if value in currentElement:
					currentElement[value] = currentElement[value] + 1
				else:
					currentElement[value] = 1
				# update the basic stat
				basicStat[key] = currentElement
			else:
				currentElement = {}
				currentElement[value] = 1
				basicStat[key] = currentElement
			#index = abs(hash(key + '_' + value)) % D
			#print('index is:')
			#print(index)
			#x[index] = x[index] + 1  #x.append(index)
		#print('xvector is:')
		#print(sum(x))
		yield t, date, ID, y,basicStat


##############################################################################
# start training #############################################################
##############################################################################

start = datetime.now()

# start training
#====================================================================================
numberOfObsTest = 1e5
counterTest = 0
yCounterTest = 0

basicStat = {}

for e in xrange(epoch):
    loss = 0.
    count = 0

    for t, date, ID, y, basicStat in data(train, D,basicStat):  # data is a generator
        #    t: just a instance counter
        # date: you know what this is
        #   ID: id provided in original data
        #    x: features
        #    y: label (click)

        # step 1, get prediction from learner
		counterTest = counterTest + 1
		if (float(counterTest)/5000==counterTest/5000):
			print('train')
			print(counterTest)
		#p = learner.predict(x)
		if (y == 1):
			yCounterTest = yCounterTest + 1
		

   # print('Epoch %d finished, validation logloss: %f, elapsed time: %s' % (
   #     e, loss/count, str(datetime.now() - start)))

trainingObsCounter = counterTest

#save basic stat to file
with open(trainBasicStat, 'w') as outfile:
	outfile.write('feature, instantiation, frequencey\n')
	for i in basicStat:
		Elements = basicStat[i]
		for j in Elements:
			outfile.write('%s,%s,%s\n' %(i,j, Elements[j]))
			
basicStat = {}



##############################################################################
# start testing, and build Kaggle's submission file ##########################
##############################################################################
basicStat = {}
counterTest = 0
#with open(submission, 'w') as outfile:
#	outfile.write('id,click\n')
for t, date, ID, y, basicStat in data(test, D,basicStat):
	counterTest = counterTest + 1
	if (float(counterTest)/5000==counterTest/5000):
		print('test')
		print(counterTest)
	#p = learner.predict(x)
	#outfile.write('%s,%s\n' % (ID, str(p)))
	#if (counterTest>numberOfObsTest):
	#	break;
#save basic stat to file
with open(testBasicStat, 'w') as outfile:
	outfile.write('feature, instantiation, frequencey\n')
	for i in basicStat:
		Elements = basicStat[i]
		for j in Elements:
			outfile.write('%s,%s,%s\n' %(i,j, Elements[j]))
		
print('number of training observation is:\n')
print('===============================\n')
print(trainingObsCounter)
print('number of test observation is:\n')
print('===============================\n')
print(counterTest)
print('number of positive examples:\n')
print('===============================\n')
print(yCounterTest)