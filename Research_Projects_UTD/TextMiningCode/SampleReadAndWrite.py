__author__ = 'MeisamHe'
import glob

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

from nltk.stem.wordnet import WordNetLemmatizer
lmtzr = WordNetLemmatizer()

def smart_lemmatization(word):
    lemmas = []
    lemmas.append(lmtzr.lemmatize(word, 'n'))
    lemmas.append(lmtzr.lemmatize(word, 'v'))
    lemmas.append(lmtzr.lemmatize(word, 'a'))
    return min(lemmas, key=len)

def main():
    text = "A good, camera, works well. Can use it everywhere - like a lot."
    sentences = sent_tokenize(text)
    tokenized_sentences = [word_tokenize(s) for s in sentences]
    print 'tokened sentences are:\n'
    print sentences
    print 'tokenized sentences includes:\n'
    print tokenized_sentences

    fdist = FreqDist(word.lower() for s in tokenized_sentences for word in s )
    print 'frequency distribution is:\n'
    for word in fdist:
        print word, fdist[word]

    word1 = tokenized_sentences[0][1]
    word2 = tokenized_sentences[0][6]
    synsets1 = wn.synsets(word1)
    synsets2 = wn.synsets(word2)
    print 'similarity according to word net is:\n'
    print 'word 1 is:\n'
    print word1
    print 'word 2 is:\n'
    print word2
    print sim(synsets1, synsets2, word1, word2, 'wup_similarity')
    #cheating for testing purposes: word1, word1, because dictionary is very little
    print 'similarity according to word2vec is:\n'
    print sim(synsets1, synsets2, word1, word1, 'word2vec')
    print 'lemmatization of the word being is:\n'
    print smart_lemmatization('being')
    print 'test similarity of two different word'
    word1 = 'recommend'
    word2 = 'loyalty'
    word1=smart_lemmatization(word1)
    word2=smart_lemmatization(word2)
    synsets1 = wn.synsets(word1)
    synsets2 = wn.synsets(word2)
    print sim(synsets1, synsets2, word1, word2, 'wup_similarity')
    print sim(synsets1, synsets2, word1, word1, 'word2vec')

if __name__ == '__main__':
    main()




file = open('C:/Users/MeisamHe/Desktop/Projects/TextMining/CleanedData/reviews/1.Camera.txt', 'r')

filecontent = "";

for line in file:
    filecontent = "%s %s" % (filecontent,line.rstrip("\n"));

file.close(),

file = open('C:/Users/MeisamHe/Desktop/Projects/TextMining/CleanedData/reviews/test.txt', "w")
file.write(filecontent)

# filecontent=  line.rstrip("\n"),