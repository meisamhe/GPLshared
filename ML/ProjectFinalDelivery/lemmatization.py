__author__ = 'MeisamHe'


textPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\textsOnly.txt" #third dataset
textOutputPath = "C:\\Users\\MeisamHe\\Desktop\\BackupToRestoreComputerApril15\\MachineLearning\\Project\\textInput\\textsOnlyOutput.txt" #third dataset

f = open(textPath,'r')
out = open(textOutputPath,'w')
temp = f.read()
import re

# split into sentences
tokenizedSentences = re.split('\n',temp)
tokenizedSentences=tokenizedSentences[0:(len(tokenizedSentences)-1)]


from nltk.stem.wordnet import WordNetLemmatizer
lmtzr = WordNetLemmatizer()

def smart_lemmatization(word):
    lemmas = []
    lemmas.append(lmtzr.lemmatize(word, 'n'))
    lemmas.append(lmtzr.lemmatize(word, 'v'))
    lemmas.append(lmtzr.lemmatize(word, 'a'))
    return min(lemmas, key=len)

from nltk.corpus import wordnet as wn

for  i in range(1,len(tokenizedSentences),1):
    words = re.split(' ',tokenizedSentences[i])
    word1 = []
    for word in words:
        # turn into ascii format
        word = ''.join([i if ord(i) < 128 else ' ' for i in word])
        lemma = smart_lemmatization(word)
        word1.append(lemma)
        out.write(lemma)
        out.write (' ')
    out.write('\n')

    #word1.append(wn.synsets(smart_lemmatization(word)))


#tokenizedSentences = re.findall('([a-zA-Z0-9.;,: ]+)\n',temp)
