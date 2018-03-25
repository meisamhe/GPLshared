#================================================
# Homework 3: Sentiment Analysis 
# Code Written By: Meisam Hejazi Nia
# Date: 03/06/2015
#=================================================

# First experiment: No Lemmatization
#==================================================
import random 
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*1/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

#=========================================================================================================================================================
#=========================================================================================================================================================
# Second experiment: Lemmatization 
#==================================================
import random
from nltk.stem.wordnet import WordNetLemmatizer
lmtzr = WordNetLemmatizer()

import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
    return dict([(lmtzr.lemmatize(word), True) for word in words])


negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*1/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

#=========================================================================================================================================================
#=========================================================================================================================================================
# Third experiment: Filtering out stop words 
#==================================================
import random 
#stop words
from nltk.corpus import stopwords
stops = set(stopwords.words('english'))

import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
	tempDic = {}
	for word in words:
		if word not in stops:
			tempDic[word] = True
	return tempDic
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*1/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for filtered for stop words:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

#=========================================================================================================================================================
#=========================================================================================================================================================
# Fourth experiment: Filtering out punctuations
#==================================================
##
# recognizing punctuations
##
import random
import string
punctuations = list(string.punctuation)
# remove by simply dropping if it is in this list

import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
	tempDic = {}
	for word in words:
		if word not in punctuations:
			tempDic[word] = True
	return tempDic
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*1/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for filtered punctuation case:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()
#=========================================================================================================================================================
#=========================================================================================================================================================

# Fifth experiment: unbalanced Collection of positive to negative, more negative
#==================================================
# as I guess like any other review negative reviews are much more than the positive, increase their weight in the sample size
import random
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*2/16
poscutoff = len(posfeats)*1/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()
#=========================================================================================================================================================
#=========================================================================================================================================================
# Sixth experiment: unbalanced Collection of positive to negative, more positive
#==================================================
# as I guess like any other review negative reviews are much more than the positive, increase their weight in the sample size
import random
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*2/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()
#=========================================================================================================================================================
#=========================================================================================================================================================

# Seventh experiment: Increase data training size 8/16
#==================================================
import random 
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews
import math

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*8/16
poscutoff = len(posfeats)*8/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for the big training set 9/10:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

#=========================================================================================================================================================
#=========================================================================================================================================================

# Eight experiment: Increase data training size 12/16
#==================================================
import random 
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews
import math

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

random.shuffle(negids)
random.shuffle(posids)

negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*12/16
poscutoff = len(posfeats)*12/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for the big training set 9/10:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

#=========================================================================================================================================================
#=========================================================================================================================================================
# Ninth experiment: Only 2500 top words
#==================================================

import random 
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews
import math

# take out the ngative and positive file ids
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

# create a dictionary of top keywords (high frequency)
#===============================================
negativeDict = {}

def top_words_selection_negative(words):
	for word in words:
		if word not in negativeDict:
			negativeDict[word] = 1
		else:
			negativeDict[word] +=1 

for f in negids:
	top_words_selection_negative(movie_reviews.words(fileids=[f]))

# select only top 2500
d = negativeDict
originValue = list(d.values())
v=list(d.values())
k=list(d.keys())
# sort the list, to make sure top 2500 are at the beginning of the list
v.sort(reverse = True)
v = v[:2500]

max_negative = []
for value in v:
	if len(max_negative) > 2500: break
	indexes = [i for i, j in enumerate(originValue) if j == value]
	for index in indexes:
		max_negative.append(k[index])
 


# create a dictionary of top keywords (high frequency)
#===============================================
positiveDict = {}

def top_words_selection_positive(words):
	for word in words:
		if word not in positiveDict:
			positiveDict[word] = 1
		else:
			positiveDict[word] += 1

for f in posids:
	top_words_selection_positive(movie_reviews.words(fileids=[f]))
	
# select only top 2500
d = positiveDict
originValue = list(d.values())
v=list(d.values())
k=list(d.keys())
# sort the list, to make sure top 2500 are at the beginning of the list
v.sort(reverse = True)
v = v[:2500]

max_positive = []
for value in v:
	if len(max_positive) > 2500: break
	indexes = [i for i, j in enumerate(originValue) if j == value]
	for index in indexes:
		max_positive.append(k[index])

#customized function for negative word list creation		
#=================================
def word_feats_negative(words):
	tempDic = {}
	for word in words:
		if word not in max_negative:
			tempDic[word] = True
	return tempDic

#customized function for positive word list creation		
#=================================
def word_feats_positive(words):
	tempDic = {}
	for word in words:
		if word not in max_positive:
			tempDic[word] = True
	return tempDic
 

negfeats = [(word_feats_negative(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats_positive(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*8/16
poscutoff = len(posfeats)*8/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for the big training set 8/10, but with only 2500 features per positive and negative:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()


#=========================================================================================================================================================
#=========================================================================================================================================================
# Tenth experiment: Only 2500 top words, filtered the punctuation and stop words
#==================================================

import string
punctuations = list(string.punctuation)
# remove by simply dropping if it is in this list

from nltk.corpus import stopwords
stops = set(stopwords.words('english'))

import random 
import nltk.classify.util
from nltk.classify import MaxentClassifier
from nltk.corpus import movie_reviews
import math

# take out the ngative and positive file ids
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

# create a dictionary of top keywords (high frequency)
#===============================================
negativeDict = {}

def top_words_selection_negative(words):
	for word in words:
		if word not in negativeDict:
			negativeDict[word] = 1
		else:
			negativeDict[word] +=1 

for f in negids:
	top_words_selection_negative(movie_reviews.words(fileids=[f]))

# select only top 2500
d = negativeDict
originValue = list(d.values())
v=list(d.values())
k=list(d.keys())
# sort the list, to make sure top 2500 are at the beginning of the list
v.sort(reverse = True)
v = v[:2500]

max_negative = []
for value in v:
	if len(max_negative) > 2500: break
	indexes = [i for i, j in enumerate(originValue) if j == value]
	for index in indexes:
		if k[index] not in punctuations and k[index] not in stops:
			max_negative.append(k[index])
		if len(max_negative) > 2500: break
 


# create a dictionary of top keywords (high frequency)
#===============================================
positiveDict = {}

def top_words_selection_positive(words):
	for word in words:
		if word not in positiveDict:
			positiveDict[word] = 1
		else:
			positiveDict[word] += 1

for f in posids:
	top_words_selection_positive(movie_reviews.words(fileids=[f]))
	
# select only top 2500
d = positiveDict
originValue = list(d.values())
v=list(d.values())
k=list(d.keys())
# sort the list, to make sure top 2500 are at the beginning of the list
v.sort(reverse = True)
v = v[:2500]

max_positive = []
for value in v:
	if len(max_positive) > 2500: break
	indexes = [i for i, j in enumerate(originValue) if j == value]
	for index in indexes:
		if k[index] not in punctuations and k[index] not in stops:
			max_positive.append(k[index])
		if len(max_positive) > 2500: break

#customized function for negative word list creation		
#=================================
def word_feats_negative(words):
	tempDic = {}
	for word in words:
		if word not in max_negative:
			tempDic[word] = True
	return tempDic

#customized function for positive word list creation		
#=================================
def word_feats_positive(words):
	tempDic = {}
	for word in words:
		if word not in max_positive:
			tempDic[word] = True
	return tempDic
 

negfeats = [(word_feats_negative(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats_positive(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*8/16
poscutoff = len(posfeats)*8/16

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# Code template source: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy for the big training set 8/10, but with only 2500 features per positive and negative:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
#classifier.show_most_informative_features()

