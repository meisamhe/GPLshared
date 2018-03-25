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
submission = "C:\\Users\\mxh109420\\Desktop\\KaggleCometition\\submission1LocallySensitiveHashing10.csv"  # path of to be outputted submission file

#train = 'train_rev2'               # path to training file
#test = 'test_rev2'                 # path to testing file
#submission = 'submission1234.csv'  # path of to be outputted submission file


# B, model
alpha = .1  # learning rate
beta = 1.   # smoothing parameter for adaptive learning rate
L1 = 1.     # L1 regularization, larger value means more regularized
L2 = 1.     # L2 regularization, larger value means more regularized

# C, feature/hash trick
D = 2 ** 10            # number of weights to use
interaction = False     # whether to enable poly2 feature interactions

# D, training/validation
epoch = 1       # learn training data for N passes
holdafter = 9   # data after date N (exclusive) are used as validation
holdout = None  # use every N training instance for holdout validation


# build vector of sum choice, and count choice
sumChoice = [0] * D
countChoice = [0] * D

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
        self.w = {}

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
        w = [0]*D

        # wTx is the inner product of w and x
        wTx = 0.
        for i in range(1,D,1):
			if x[i]!=0:
				sign = -1. if z[i] < 0 else 1.  # get sign of z[i]
				#print(i)
				# build w on the fly using z and n, hence the name - lazy weights
				# we are doing this at prediction instead of update time is because
				# this allows us for not storing the complete w
				if sign * z[i] <= L1:
					# w[i] vanishes due to L1 regularization
					w[i] = 0.
				else:
					# apply prediction time L1, L2 regularization to z and get w
					w[i] = (sign * L1 - z[i]) / ((beta + sqrt(n[i])) / alpha + L2)
					
				wTx += w[i]*x[i]

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
		#print('x is:')
		#print(len(x))
		#print('n is:')
		#print(len(n))
		#print('z is:')
		#print(len(z))
		#print('w is:')
		#print(len(w))
		# update z and n
		sumXi = 0
		for i in range(1,D,1):
			if (x[i]!=0):
				#self._indices(x):
				#print(i)
				# gradient under logloss (meisam and Ali update)
				#print(p-y)
				sumXi = sumXi + x[i]
				g = (p - y)*x[i]
				#print('g is:')
				#print(g)
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
		
		document = ""
		for key in row:
			value = row[key]# one-hot encode everything with hash trick
			document = document + key + '_' + value+ " "
		
		# use locally sensitive hashing
		index = abs(hash(document)) % D

		yield y,index,ID


##############################################################################
# start training #############################################################
##############################################################################

start = datetime.now()

# initialize ourselves a learner
learner = ftrl_proximal(alpha, beta, L1, L2, D, interaction)

# start training
#====================================================================================
numberOfObsTest = 1e5
counterTest = 0
yCounterTest = 0
for e in xrange(epoch):
    loss = 0.
    count = 0

    for y,index,ID in data(train, D):  # data is a generator
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
		
		# update locally sensitive hashing data
		sumChoice[index]   = sumChoice[index] + y
		countChoice[index] = countChoice[index] + 1  #x.append(index)
		
		#p = learner.predict(x)
		if (y == 1):
			yCounterTest = yCounterTest + 1
		

trainingObsCounter = counterTest
##############################################################################
# start testing, and build Kaggle's submission file ##########################
##############################################################################
counterTest = 0
with open(submission, 'w') as outfile:
	outfile.write('id,click\n')
	for y,index,ID in data(test, D):
		counterTest = counterTest + 1
		if (float(counterTest)/5000==counterTest/5000):
			print('test')
			print(counterTest)
		p = float(sumChoice[index])/countChoice[index] 
		
		# truncate to smooth
		if p<0.1:
			p = 0.1
		
		if p>0.9:
			p = 0.9
		#learner.predict(x)
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