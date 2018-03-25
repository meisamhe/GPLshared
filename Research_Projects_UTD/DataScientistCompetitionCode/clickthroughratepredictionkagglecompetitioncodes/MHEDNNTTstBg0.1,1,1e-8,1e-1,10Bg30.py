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
submission = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\submission02042015MHEDNNTTstBg0.1,1,1e-8,1e-1,10Bg30.csv"  # path of to be outputted submission file

#train = 'train_rev2'               # path to training file
#test = 'test_rev2'                 # path to testing file
#submission = 'submission1234.csv'  # path of to be outputted submission file


# B, model
alpha = 0.1 # learning rate
beta = 1  # smoothing parameter for adaptive learning rate
L1 = 1e-8     # L1 regularization, larger value means more regularized
L2 = 1e-1    # L2 regularization, larger value means more regularized

# C, feature/hash trick
D = 2 ** 12          # number of weights to use
interaction = False     # whether to enable poly2 feature interactions

# D, training/validation
epoch = 1       # learn training data for N passes
holdafter = 9   # data after date N (exclusive) are used as validation
holdout = None  # use every N training instance for holdout validation


##############################################################################
# class, function, generator definitions #####################################
##############################################################################

class ftrl_proximal(object):
    ''' Our main algorithm: Follow the regularized leader - proximal

        In short,
        this is an adaptive-learning-rate sparse logistic-regression with
        efficient L1-L2-regularization

        Reference:
        http://www.eecs.tufts.edu/~dsculley/papers/ad-click-prediction.pdf
    '''

    def __init__(self, alpha, beta, L1, L2, D, interaction):
        # parameters
        self.alpha = alpha
        self.beta = beta
        self.L1 = L1
        self.L2 = L2

        # feature related parameters
        self.D = D
        self.interaction = interaction

        # model
        # n: squared sum of past gradients
        # z: weights
        # w: lazy weights
        self.n = [0.] * D
        self.z = [0.] * D
        self.w = [0.]*D

    def _indices(self, x):
        ''' A helper generator that yields the indices in x

            The purpose of this generator is to make the following
            code a bit cleaner when doing feature interaction.
        '''

        # first yield index of the bias term
        yield 0

        # then yield the normal indices
        for index in x:
            yield index

        # now yield interactions (if applicable)
        if self.interaction:
            D = self.D
            L = len(x)

            x = sorted(x)
            for i in xrange(L):
                for j in xrange(i+1, L):
                    # one-hot encode interactions with hash trick
                    yield abs(hash(str(x[i]) + '_' + str(x[j]))) % D

    def predict(self, x):
        ''' Get probability estimation on x

            INPUT:
                x: features

            OUTPUT:
                probability of p(y = 1 | x; w)
        '''

        # parameters
        alpha = self.alpha
        beta = self.beta
        L1 = self.L1
        L2 = self.L2

        # model
        n = self.n
        z = self.z
        w = self.w

        # wTx is the inner product of w and x
        wTx = 0.
        for i in x:
			sign = -1. if z[i] < 0 else 1.  # get sign of z[i]
			if sign * z[i] <= L1:
					# w[i] vanishes due to L1 regularization
					w[i] = 0.
			else:
				# apply prediction time L1, L2 regularization to z and get w
				w[i] = (sign * L1 - z[i]) / ((beta + sqrt(n[i])) / alpha + L2)	
				wTx += w[i]	

        # cache the current w for update stage
        self.w = w
        
        #print('wTx is:')
        #print(wTx)
		
        # bounded sigmoid function, this is the probability estimation
        return 1. / (1. + exp(-max(min(wTx, 35.), -35.)))

    def update(self, x, p, y):
		''' Update model using x, p, y

            INPUT:
                x: feature, a list of indices
                p: click probability prediction of our model
                y: answer

            MODIFIES:
                self.n: increase by squared gradient
                self.z: weights
        '''
		alpha = self.alpha # parameter
		n = self.n # model
		z = self.z
		w = self.w
		sumXi = 0
		for i in x:
			sumXi = sumXi + 1
			g = (p - y)
			sigma = (sqrt(n[i] + g * g) - sqrt(n[i])) / alpha
			z[i] += g - sigma * w[i]
			n[i] += g * g
				
		#print('sum of xi is:')
		#print(sumXi)
		

def logloss(p, y):
    ''' FUNCTION: Bounded logloss

        INPUT:
            p: our prediction
            y: real answer

        OUTPUT:
            logarithmic loss of p given y
    '''

    p = max(min(p, 1. - 10e-15), 10e-15)
    return -log(p) if y == 1. else -log(1. - p)


def data(path, D):
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
		x = list()
		for key in row:
			#print('key is')
			#print(key)
			value = row[key]# one-hot encode everything with hash trick
			keyvalue = key+value
			if keyvalue in dictionaryFeature:
				index = dictionaryFeature[key+value] # now the index is an integer number
				#x[index] = x[index] + 1  #x.append(index)
				x.append(index)
		#print('xvector is:')
		#print(sum(x))
		yield t, date, ID, x, y
		
		
##############################################################################
# Function to create the feature vector #############################################################
##############################################################################
##############################################################################
# class, function, generator definitions #####################################
##############################################################################

def dataFeatureCreation(path, D,basicStat):
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
			if key != "device_id" and key != "device_ip" :
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
# Create a feature vector #############################################################
##############################################################################
start = datetime.now()

# start feature creation
#====================================================================================
numberOfObsTest = 1e5
counterTest = 0
yCounterTest = 0

basicStat = {}

for e in xrange(epoch):
    loss = 0.
    count = 0

    for t, date, ID, y, basicStat in dataFeatureCreation(train, D,basicStat):  # data is a generator
        #    t: just a instance counter
        # date: you know what this is
        #   ID: id provided in original data
        #    x: features
        #    y: label (click)

        # step 1, get prediction from learner
		counterTest = counterTest + 1
		if (float(counterTest)/5000==counterTest/5000):
			print('create feature vector')
			print(counterTest)
		#p = learner.predict(x)
		if (y == 1):
			yCounterTest = yCounterTest + 1
		

   # print('Epoch %d finished, validation logloss: %f, elapsed time: %s' % (
   #     e, loss/count, str(datetime.now() - start)))

trainingObsCounter = counterTest


##############################################################################
# start testing, and build Kaggle's submission file ##########################
##############################################################################
basicStatTest = {}
counterTest = 0
#with open(submission, 'w') as outfile:
#	outfile.write('id,click\n')
for t, date, ID, y, basicStatTest in dataFeatureCreation(test, D,basicStatTest):
	counterTest = counterTest + 1
	if (float(counterTest)/5000==counterTest/5000):
		print('test')
		print(counterTest)
	#p = learner.predict(x)
	#outfile.write('%s,%s\n' % (ID, str(p)))
	#if (counterTest>numberOfObsTest):
	#	break;
#save basic stat to file

#====================================================
# Vector creation
#====================================================
# start with zero D, and add up
D = 0
dictionaryFeature = {}
#save basic stat to file
#with open(trainBasicStat, 'w') as outfile:
#	outfile.write('feature, instantiation, frequencey\n')
for i in basicStat:
	if (i in basicStatTest):
		Elements = basicStat[i]
		ElementsTest = basicStatTest[i]
		for j in Elements:
			if (j in ElementsTest):
				dictionaryFeature[i+j]=D
				D = D + 1
			#outfile.write('%s,%s,%s\n' %(i,j, Elements[j]))
		
# remove last useless element (removed for now to avoid error)
#D = D -1 			
#basicStat = {}
print('congratualtions the number of features is:')
print (D)



##############################################################################
# start training #############################################################
##############################################################################

start = datetime.now()

# initialize ourselves a learner
#learner = ftrl_proximal(alpha, beta, L1, L2, D, interaction)

# start training
#====================================================================================
numberOfObsTest = 1e5
counterTest = 0
yCounterTest = 0

start = datetime.now()

#numberOfObsTest = 2e6
counterTest = 0
yCounterTest = 0
nClassifiers= 30

# initialize ourselves a learner
import random
learner = list()
for i in range(1,nClassifiers+2,1):
	learner.append(ftrl_proximal(alpha, beta, L1, L2, D, interaction))
	#learner[i] = 
#currentClassifier = random.randint(1, nClassifiers)

for e in xrange(epoch):
    loss = 0.
    count = 0

    for t, date, ID, x, y in data(train, D):  # data is a generator
        #    t: just a instance counter
        # date: you know what this is
        #   ID: id provided in original data
        #    x: features
        #    y: label (click)
		
		#Meisam & Ali
		currentClassifier = random.randint(1, nClassifiers)
		#currentClassifier = int(counterTest/1e6)

        # step 1, get prediction from learner
		counterTest = counterTest + 1
		if (float(counterTest)/5000==counterTest/5000):
			print('train')
			print(counterTest)
		p = learner[currentClassifier].predict(x)
		
		if (y == 1):
			yCounterTest = yCounterTest + 1
		#if (holdafter and date > holdafter) or (holdout and t % holdout == 0):
			# step 2-1, calculate validation loss
            #           we do not train with the validation data so that our
            #           validation loss is an accurate estimation
            #
            # holdafter: train instances from day 1 to day N
            #            validate with instances from day N + 1 and after
            #
            # holdout: validate with every N instance, train with others
			#loss += logloss(p, y)
			#count += 1
		#else:
            # step 2-2, update learner with label (click) information
			#learner.update(x, p, y)
		learner[currentClassifier].update(x, p, y)
		#if (counterTest>numberOfObsTest):
		#	break;

   # print('Epoch %d finished, validation logloss: %f, elapsed time: %s' % (
   #     e, loss/count, str(datetime.now() - start)))

trainingObsCounter = counterTest
##############################################################################
# start testing, and build Kaggle's submission file ##########################
##############################################################################
counterTest = 0
with open(submission, 'w') as outfile:
	outfile.write('id,click\n')
	for t, date, ID, x, y in data(test, D):
		counterTest = counterTest + 1
		if (float(counterTest)/5000==counterTest/5000):
			print('test')
			print(counterTest)
		psum = 0
		# a new correction to sum
		for i in range(1,nClassifiers+1,1):
			psum = psum+learner[i].predict(x)
		p = float(psum) / nClassifiers 
		outfile.write('%s,%s\n' % (ID, str(p)))
		#if (counterTest>numberOfObsTest):
		#	break;
print('number of training observation is:\n')
print('===============================\n')
print(trainingObsCounter)
print('number of test observation is:\n')
print('===============================\n')
print(counterTest)
print('number of positive examples:\n')
print('===============================\n')
print(yCounterTest)