#================================================
# Homework 3: Sentiment Analysis 
# Code Written By: Meisam Hejazi Nia
# Date: 03/06/2015
#=================================================

import nltk.classify.util
from nltk.classify import MaxentClassifier
#from nltk.classify import NaiveBayesClassifier
from nltk.corpus import movie_reviews

#stop words
from nltk.corpus import stopwords
stops = set(stopwords.words('english'))

# check the readme file
#print(movie_reviews.readme())


##
# recognizing punctuations
##
import string
punctuations = list(string.punctuation)
# remove by simply dropping if it is in this list

def word_feats(words):
    return dict([(word, True) for word in words])
 
negids = movie_reviews.fileids('neg')
posids = movie_reviews.fileids('pos')

# check the first file's content
test = movie_reviews.words(fileids=negids[0])
review = ''
for word in test:
	review += word + ' '
	print '%s\n'%word
	#if word == '.': print 'found!'
plot(movie_reviews.words(fileids=negids[0]))
 
negfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'neg') for f in negids]
posfeats = [(word_feats(movie_reviews.words(fileids=[f])), 'pos') for f in posids]
 
negcutoff = len(negfeats)*1/16
poscutoff = len(posfeats)*1/16

negcutoff

trainfeats = negfeats[:negcutoff] + posfeats[:poscutoff]
# shuffling to reduce the potential order effect
random.shuffle(trainfeats)
testfeats = negfeats[negcutoff:] + posfeats[poscutoff:]
# shuffling to reduce the potential order effect
random.shuffle(testfeats)
print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))
 
## 
# input data includes: [({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos ),({word1:True, word2: True, word3:True, ...}, 'neg' || 'pos )]
# src: http://nbviewer.ipython.org/github/datadave/GADS9-NYC-Spring2014-Lectures/blob/master/lessons/lesson08_probability_naive_bayes/.ipynb_checkpoints/NLTK%20Movie%20Review%20GADS%20Working-checkpoint.ipynb
# training: training the parameters
#classifier = NaiveBayesClassifier.train(trainfeats)
#train on 124 instances, test on 1876 instances
#accuracy: 0.665778251599
classifier = MaxentClassifier.train(trainfeats)
# testing: accuracy on the test set
print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
# list of informative features
classifier.show_most_informative_features()

#====================================================
# Max entropy configuration  with cutoff
#====================================================
from nltk.classify import maxent
train = [  ({'a': 1, 'b': 1, 'c': 1}, 'y'),\
		({'a': 5, 'b': 5, 'c': 5}, 'x'),\
		({'a': 0.9, 'b': 0.9, 'c': 0.9}, 'y'),\
		({'a': 5.5, 'b': 5.4, 'c': 5.3}, 'x'),\
		({'a': 0.8, 'b': 1.2, 'c': 1}, 'y'),\
		({'a': 5.1, 'b': 4.9, 'c': 5.2}, 'x')\
		]

test = [\
		{'a': 1, 'b': 0.8, 'c': 1.2},\
		{'a': 5.2, 'b': 5.1, 'c': 5}\
		]

encoding = maxent.TypedMaxentFeatureEncoding.train(\
		train, count_cutoff=3, alwayson_features=True)
		
classifier = maxent.MaxentClassifier.train(\
		train, bernoulli=False, encoding=encoding, trace=0,  max_iter=100)

classifier.classify_many(test)

#importing nltk for lemmatization, using wordNet corpus
#===============================================
import nltk
import math
import sys
# if the wordnet Corpora is not available then use the following command
# nltk.download()

from nltk.stem.wordnet import WordNetLemmatizer
lmtzr = WordNetLemmatizer()
#usage: lmtzr.lemmatize('cars') >> cars

#reading the corpus file
#========================================
#interestingUsersFilePath = "C:\\Users\\MeisamHe\\Desktop\\Desktop\\BackupToRestoreComputerApril15\\NLPSpring2015\\HWs\\HW2\\Corpus.txt"  # interestingUsers
interestingUsersFilePath = sys.argv[1]
print('file name is:%s'%(sys.argv[1]))
f = open(interestingUsersFilePath)
content = f.read()

#remove useless \r\next
#============================
content = content.replace("\r\n", " ")
content = content.replace("\n", " ")

# split sentences: tokenize sentences
#========================================
from nltk.tokenize import sent_tokenize
sent_tokenize_list = sent_tokenize(content)


#for each of the sentences tokenize words after cleaning and lemmatize them and put them into word dictionary
# also to create bigram probabilities:  Save in a form of sparse matrix to save memory
#================================================================
import re
wordDic = {}
# to save bigram count
bigram = {}

for s in sent_tokenize_list:
	curSent = s
	#remove useless punctuations
	s = s.replace(".", " ")
	s = s.replace(",", " ")
	s = s.replace("!", " ")
	s = s.replace("?", " ")
	s = s.replace("$", " ")
	s = s.replace("@", " ")
	s = s.replace('"', " ")
	s = s.replace("'", " ")
	s = s.replace("``", " ")
	s = s.replace("`", " ")
	s = s.replace("@", " ")
	s = s.replace("1", " ")
	s = s.replace("2", " ")
	s = s.replace("3", " ")
	s = s.replace("4", " ")
	s = s.replace("5", " ")
	s = s.replace("6", " ")
	s = s.replace("7", " ")
	s = s.replace("8", " ")
	s = s.replace("9", " ")
	s = s.replace("0", " ")
	s = s.replace("_", " ")
	s = s.replace("-", " ")
	s = s.replace("%", " ")
	s = s.replace("&", " ")
	s = s.replace("\\", " ")
	s = s.replace("/", " ")
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	if prevWord in wordDic:
		wordDic[prevWord] +=1
	else:
		wordDic[prevWord] =1
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)
		if lemm in wordDic:
			wordDic[lemm] +=1
		else:
			wordDic[lemm] =1
		
		#save the bigram count
		if prevWord+" "+lemm in bigram:
			bigram[prevWord+" "+lemm] += 1
		else:
			bigram[prevWord+" "+lemm] = 1
		#print ('%s %s\n'%(prevWord,lemm))
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	if prevWord+" "+'<END>' in bigram:
		bigram[prevWord+" "+'<END>'] += 1
	else:
		bigram[prevWord+" "+'<END>'] = 1

#============================================================
# Read input and calculate the bigram probabilities
#============================================================
#options to use to find bigram probabilities
#option = 'without-smoothing'
#option = 'add-one-smoothing'
#option = 'Good-Turing-discounting'
print ('option is:%s'%(sys.argv[2]))
option = sys.argv[2]

# two alternative sentences
sentence = 'The company chairman said he will increase the profit next year'
sentenceAlternative = 'The president said he believes the last year profit were good'

#the probabilities of the alternative sentences
logProbSent = 0
logProbAlterSent = 0

#print('length of the bigram: %s, and length of the wordDic is:%s'%(len(bigram),len(wordDic)))
#==================================================================
# the case of without smoothing, where the actual count are used
#==================================================================
if option == 'without-smoothing':
	#first calculate the probability for the sentence
	s = sentence
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
		else:
			currLogProb = -1e100
		logProbSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	if prevWord+" "+'<END>' in bigram:
		currLogProb = math.log(bigram[prevWord+" "+'<END>'])-math.log(wordDic[prevWord])
	else:
		currLogProb = -1e100
	logProbSent += currLogProb
	
	#second calculate the probability for the alternative sentence
	s = sentenceAlternative
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
		else:
			currLogProb = -1e100
		logProbAlterSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	if prevWord+" "+'<END>' in bigram:
		currLogProb = math.log(bigram[prevWord+" "+'<END>'])-math.log(wordDic[prevWord])
	else:
		currLogProb = -1e100
	logProbAlterSent += currLogProb

#==================================================================
# the case of with add-one smoothing
#==================================================================
if option == 'add-one-smoothing':
	#first calculate the probability for the sentence
	s = sentence
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			currLogProb = math.log(bigram[prevWord+" "+lemm]+1)-math.log(wordDic[prevWord]+len(wordDic))
		else:
			wordOccur = 0
			if prevWord in wordDic:
				wordOccur = wordDic[prevWord]
			currLogProb = -math.log(wordOccur+len(wordDic))
		logProbSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	if prevWord+" "+'<END>' in bigram:
		currLogProb = math.log(bigram[prevWord+" "+'<END>']+1)-math.log(wordDic[prevWord]+len(wordDic))
	else:
		wordOccur = 0
		if prevWord in wordDic:
			wordOccur = wordDic[prevWord]
		currLogProb = -math.log(wordOccur+len(wordDic))
	logProbSent += currLogProb
	
	#second calculate the probability for the alternative sentence
	s = sentenceAlternative
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			currLogProb = math.log(bigram[prevWord+" "+lemm]+1)-math.log(wordDic[prevWord]+len(wordDic))
		else:
			wordOccur = 0
			if prevWord in wordDic:
				wordOccur = wordDic[prevWord]
			currLogProb = -math.log(wordOccur+len(wordDic))
		logProbSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	if prevWord+" "+'<END>' in bigram:
		currLogProb = math.log(bigram[prevWord+" "+'<END>']+1)-math.log(wordDic[prevWord]+len(wordDic))
	else:
		wordOccur = 0
		if prevWord in wordDic:
			wordOccur = wordDic[prevWord]
		currLogProb = -math.log(wordOccur+len(wordDic))
	logProbAlterSent += currLogProb
	
#==================================================================
# the case of with Good-Turing-discounting smoothing
#==================================================================
if option == 'Good-Turing-discounting':
	# create a histogram of n-gram counts
	bigramHist = {}
	for item in bigram:
		if bigram[item] in bigramHist:
			bigramHist[bigram[item]] +=1
		else:
			bigramHist[bigram[item]] =1
	print(bigramHist)
	#calculate the tuned probability
	#first calculate the probability for the sentence
	s = sentence
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			if bigram[prevWord+" "+lemm] > 5:  # no need to modify
				currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
			else:
				count = bigram[prevWord+" "+lemm]
				count1 = count + 1
				numerator = math.log(count1*bigramHist[count1])-math.log(bigramHist[count])
				curLogProb = numerator- math.log(wordDic[prevWord])
		else:
			count1 =1
			numerator = count1*bigramHist[count1]
			curLogProb = math.log(numerator) - math.log(wordDic[prevWord])
		logProbSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	lemm = '<END>'
	if prevWord+" "+lemm in bigram:
		if bigram[prevWord+" "+lemm] > 5:  # no need to modify
			currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
		else:
			count = bigram[prevWord+" "+lemm]
			count1 = count + 1
			numerator = math.log(count1*bigramHist[count1])-math.log(bigramHist[count])
			curLogProb = numerator- math.log(wordDic[prevWord])
	else:
		count1 =1
		numerator = count1*bigramHist[count1]
		curLogProb = math.log(numerator) - math.log(wordDic[prevWord])
	logProbSent += currLogProb
	
	#second calculate the probability for the alternative sentence
	s = sentenceAlternative
	pattern = '([a-zA-Z]+)'
	curWordList = re.findall(pattern, s)
	prevWord = '<S>'       # mark starting with <S>
	for w in curWordList:
		lemm = lmtzr.lemmatize(w)		
		#save the bigram count
		currLogProb = 0
		if prevWord+" "+lemm in bigram:
			if bigram[prevWord+" "+lemm] > 5:  # no need to modify
				currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
			else:
				count = bigram[prevWord+" "+lemm]
				count1 = count + 1
				numerator = math.log(count1*bigramHist[count1])-math.log(bigramHist[count])
				curLogProb = numerator- math.log(wordDic[prevWord])
		else:
			count1 =1
			numerator = count1*bigramHist[count1]
			curLogProb = math.log(numerator) - math.log(wordDic[prevWord])
		logProbAlterSent += currLogProb
		prevWord = lemm
	
	#also put '<END> at the end of the sentence
	#save the bigram count
	lemm = "<END>"
	if prevWord+" "+lemm in bigram:
		if bigram[prevWord+" "+lemm] > 5:  # no need to modify
			currLogProb = math.log(bigram[prevWord+" "+lemm])-math.log(wordDic[prevWord])
		else:
			count = bigram[prevWord+" "+lemm]
			count1 = count + 1
			numerator = math.log(count1*bigramHist[count1])-math.log(bigramHist[count])
			curLogProb = numerator- math.log(wordDic[prevWord])
	else:
		count1 =1
		numerator = count1*bigramHist[count1]
		curLogProb = math.log(numerator) - math.log(wordDic[prevWord])
	logProbAlterSent += currLogProb
	
print('=================================================================\n')	
print('The program written by Meisam Hejazi Nia\n')
print('to calculate the bigram probability of two alternative sentences\n')
print('=================================================================\n')
print('The current option Exercised: %s\n'%option)
print('the log prob truncated at -1e-100 for 0 prob for the following sentence is: %s \n sentence:%s\n'%(logProbSent,sentence))
print('the log prob truncated at -1e-100 for 0 prob for the following sentence is: %s \n sentence:%s\n'%(logProbAlterSent,sentenceAlternative))