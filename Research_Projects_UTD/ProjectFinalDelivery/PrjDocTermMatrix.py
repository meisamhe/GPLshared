__author__ = 'MeisamHe'

# create word-term matrix and remove stop words

import re
from nltk.corpus import wordnet as wn

threshold = 0

stopwordPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\HW\\HW2\\stopwords.txt"
f = open(stopwordPath,'r')
temp = f.read()
stopwordList= re.split('\W+',temp)
dictionary = {}
for word in stopwordList:
    dictionary[word]=""

import csv
import sys
import math
import random
import re

# use the output of lemmatized and cleaning process ( cleaning is simply removing items for which I do not have the image)
inputfilePath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\lemmatizedOutputCleaned.txt"
inputfile = open(inputfilePath,'r')

# docTerm Matrix of Words
outputFilePath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\docTermMatrix.txt"
outputFile = open(outputFilePath,'w')

# docDoc Matrix of Words
outputFilePathSim = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\docDocMatrix.txt"
outputFileSimilarity = open(outputFilePathSim,'w')

temp = inputfile.read()
docs = temp.split('\n')
print(len(docs))
print docs[0]
print 'docs 1 is:%s'%docs[1]

FreqTable = {}

for doc in docs:
    words = re.split(' ',doc)
    for word in words:
        #synsets = wn.synsets(word)
        #for item in synsets:
            #word = re.findall('\'(A-Za-z]*)\.[a-z]+\.[0-9]+',item)
        if (word in FreqTable) and (word not in dictionary):  # remove stop word
            FreqTable[word]= FreqTable[word] + 1
        else:
            FreqTable[word]=1

# for bag of word method
# create glossary of words to create word-term matrix
wordGlossary = []
for term in FreqTable:
    if FreqTable[term]>threshold:
        wordGlossary.insert(len(wordGlossary),term)
docWordMatrix = []
for doc in docs:
    words = re.split(' ',doc)
    docterms = {}
    curwordVector = []
    for word in words:
        if (word in docterms):  # remove stop word
            docterms[word]= docterms[word] + 1
        else:
            docterms[word]=1
    for term in wordGlossary:
        if term in docterms:
            curwordVector.insert(len(curwordVector),docterms[term])
        else:
            curwordVector.insert(len(curwordVector),0)
    docWordMatrix.insert(len(docWordMatrix),curwordVector)

for doc in docWordMatrix:
    for wordfreq in doc:
        outputFile.write(',%s'%wordfreq)
    outputFile.write('\n')

#========================================================================================================================
# use my kernel method (using domain knowledge of wordnet and google vector)
#========================================================================================================================
# coding=utf-8
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.probability import FreqDist
from nltk.corpus import wordnet as wn
from nltk.corpus.reader.wordnet import Synset
import nltk.corpus.reader.wordnet
import numpy
import math


IC = nltk.corpus.wordnet_ic.ic('ic-brown.dat')
SIMILARITY_MEASURES = {'path_similarity':[], 'lch_similarity':[], 'wup_similarity':[],
                        'res_similarity':[IC,], 'jcn_similarity':[IC,], 'lin_similarity':[IC,], 'word2vec': []}

def cosine_distance(u, v):
    """
    Returns the cosine of the angle between vectors v and u. This is equal to
    u.v / |u||v|.
    """
    return numpy.dot(u, v) / (math.sqrt(numpy.dot(u, u)) * math.sqrt(numpy.dot(v, v)))

class word2vec:
    def __init__(self, filepath):
        self.vectors = {}
        with open(filepath, 'rb') as fin:
            header = fin.readline()
            vocab_size, vector_size = map(int, header.split())
            binary_len = numpy.dtype(numpy.float32).itemsize * vector_size
            for line_no in xrange(vocab_size):
                # mixed text and binary: read text first, then binary
                word = ''
                while True:
                    ch = fin.read(1)
                    if ch == ' ':
                        break
                    if ch == '': return
                    word += ch
                #print  word
                data = fin.read(binary_len)
                vector = numpy.fromstring(data, numpy.float32)
                self.vectors[word] = vector


    def sim(self, w1, w2):
        try:
            v1 = self.vectors[w1]
            v2 = self.vectors[w2]
            return cosine_distance( v1, v2 )
        except:
            return 0.0

    def in_dict(self, w):
        return w in self.vectors

w2v = word2vec('subset.bin')


def compute_similarity_(synset1, synset2, measure):
    args = [synset2,]
    args.extend(SIMILARITY_MEASURES[measure])
    try:
        if measure == 'word2vec':
            sim = sim_w2v(synset1, synset2)
        else:
            sim = getattr(synset1, measure)(*args)
    except:
        sim = -1
    #logging.debug("%s %s %s %s" % (synset1, synset2, measure, sim))
    return sim


def compute_max_similarity_(s1, synsets2, measure):
    max_sim = -1
    for s2 in synsets2:
        sim = compute_similarity_(s1, s2, measure)
        if sim > max_sim:
            max_sim = sim
    if max_sim > 1e+10:
        max_sim = 1e+10
    return max_sim

def sim(synsets1, synsets2, word1, word2, measure):
    max = 0
    if measure == 'word2vec':
        s = w2v.sim(word1, word2)
        return s
    else:
        for s1 in synsets1:
            s = compute_max_similarity_(s1, synsets2, measure)
            if s > max:
                max = s
    return max


#extract word vectors for given vocabulary
def extract_subset_word2vec(vocab, input_file = '../../GoogleNews-vectors-negative300.bin', output_file = 'subset.bin'):
    out = open(output_file, 'wb')
    already_read = 0
    total_read = 0
    written = 0
    with open(input_file, 'rb') as fin:
        header = fin.readline()
        vocab_size, vector_size = map(int, header.split())
        binary_len = numpy.dtype(numpy.float32).itemsize * vector_size
        for line_no in xrange(vocab_size):
            # mixed text and binary: read text first, then binary
            word = ''
            while True:
                ch = fin.read(1)
                if ch == ' ':
                    break
                word += ch
            data = fin.read(binary_len)
            if word == 'kitten':
                k = 0
            if word in vocab:
                out.write( word )
                out.write( ' ' )
                out.write( data )
                #print word
                written += 1
                already_read = already_read + 1
                if already_read == len(vocab):
                    return
            total_read = total_read + 1
            #if total_read % 100 == 0:
            #    print(total_read)
    out.close()

    header = str(written) + ' ' + str(300) + '\n'
    with file(output_file, 'rb') as original: data = original.read()
    with file(output_file, 'wb') as modified: modified.write(header + data)
docDocMatrix = []
for doc in docs:
    words1 = re.split(' ',doc)
    synset1 = []
    for word in words1:
        if word not in dictionary:
            synsets1 =synset1 +  wn.synsets(word)
    for doc in docs:
        words2 = re.split(' ',doc)
        synset2=[]
        for word in words2:
            if word not in dictionary:
                synsets2 =synset2 +  wn.synsets(word)

        curwordVector = []
        wordNetSimilarity = sim(synsets1, synsets2, "dummy1", "dummy2", 'wup_similarity')
        word2vecSim = 0
        counter = 0
        for word1 in words1:
            for word2 in words2:
                word2vecSim=sim(synsets1, synsets2, word1, word1, 'word2vec')
                counter = counter + 1
        word2vecSim = word2vecSim/counter
        similarityAvg = (wordNetSimilarity+word2vecSim)/2
        # write the similarity into file
        print '%s,'%similarityAvg,
        outputFileSimilarity.write(',%s'%similarityAvg)
    print '\n'
    outputFileSimilarity.write('\n')