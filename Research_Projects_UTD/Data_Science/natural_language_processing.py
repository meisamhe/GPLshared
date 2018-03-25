#! pip install nltk
#! pip install numpy
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.probability import FreqDist
from nltk.corpus import wordnet as wn
from nltk.corpus.reader.wordnet import Synset
import nltk.corpus.reader.wordnet
import numpy
import math
#nltk.download()
#nltk.download('punkt')

Tokenizing and separating sentences¶
# separate sentences and tokenize the tweets
tweetSentenced = []
tweetTokenized = []
for text in tweets:
    sentences = sent_tokenize(text)
    tweetSentenced.append(sentences)
    tokenized_sentences = [word_tokenize(s) for s in sentences]
    tweetTokenized.append(tokenized_sentences)
#     print('sentences are:')
#     print(sentences)
#     print('tokenized sentences are:')
#     print(tokenized_sentences)

print('the sentences are:')
print(tweetSentenced[1])
print('the tokenized sentence is:')
print(tweetTokenized[1])
fdist = FreqDist(word.lower() for s in tweetTokenized[1] for word in s )
print 'frequency distribution is:\n'
for word in fdist:
    print word, fdist[word]

flatten = lambda l: [item for sublist in l for item in sublist]
fdist = FreqDist(word.lower() for s in flatten(tweetTokenized) for word in s )
print 'frequency distribution is:\n'
type(fdist)
# for word in fdist:
#     print word, fdist[word]

#Visualization
#!pip install wordcloud
# http://www.lfd.uci.edu/~gohlke/pythonlibs/#wordcloud using whl file
# to avoid wheel support: python -m pip install <filename.whl>

Twitter
len(' .'.join(tweets))

from wordcloud import WordCloud
from wordcloud import WordCloud, STOPWORDS
import numpy as np
from PIL import Image
from os import path

textWordCloud = u'. '.join(tweets)
textWordCloud = textWordCloud.replace('https','')

stopwords = set(STOPWORDS)
stopwords.add("said")
alice_mask = np.array(Image.open("alice_mask.png"))

wc = WordCloud(background_color="Black", max_words=20000, 
               stopwords=stopwords)

# Generate a word cloud image
wordcloud = wc.generate(textWordCloud)

# Display the generated image:
# the matplotlib way:
import matplotlib.pyplot as plt
plt.figure( figsize=(20,10), facecolor='k' )
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()

Consumer Affairs
from wordcloud import WordCloud

textWordCloud = u'. '.join(consumerAffairs)
textWordCloud = textWordCloud.replace('https','')

stopwords = set(STOPWORDS)
stopwords.add("said")
alice_mask = np.array(Image.open("alice_mask.png"))

wc = WordCloud(background_color="Black", max_words=20000, 
               stopwords=stopwords)

# Generate a word cloud image
wordcloud = wc.generate(textWordCloud)

# Display the generated image:
# the matplotlib way:
import matplotlib.pyplot as plt
plt.figure( figsize=(20,10), facecolor='k' )
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()

Quora
from wordcloud import WordCloud

textWordCloud = u'. '.join(quora)
textWordCloud = textWordCloud.replace('https','')

stopwords = set(STOPWORDS)
stopwords.add("said")
alice_mask = np.array(Image.open("alice_mask.png"))

wc = WordCloud(background_color="Black", max_words=20000, 
               stopwords=stopwords)

# Generate a word cloud image
wordcloud = wc.generate(textWordCloud)

# Display the generated image:
# the matplotlib way:
import matplotlib.pyplot as plt
plt.figure( figsize=(20,10), facecolor='k' )
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()

Yelp
from wordcloud import WordCloud

textWordCloud = u'. '.join(yelpCorpus)
textWordCloud = textWordCloud.replace('https','')

stopwords = set(STOPWORDS)
stopwords.add("said")
alice_mask = np.array(Image.open("alice_mask.png"))

wc = WordCloud(background_color="Black", max_words=20000, 
               stopwords=stopwords)

# Generate a word cloud image
wordcloud = wc.generate(textWordCloud)

# Display the generated image:
# the matplotlib way:
import matplotlib.pyplot as plt
plt.figure( figsize=(20,10), facecolor='k' )
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()

Reddit
from wordcloud import WordCloud

textWordCloud = u'. '.join(reddit)
textWordCloud = textWordCloud.replace('https','')

stopwords = set(STOPWORDS)
stopwords.add("said")
alice_mask = np.array(Image.open("alice_mask.png"))

wc = WordCloud(background_color="Black", max_words=20000, 
               stopwords=stopwords)

# Generate a word cloud image
wordcloud = wc.generate(textWordCloud)

# Display the generated image:
# the matplotlib way:
import matplotlib.pyplot as plt
plt.figure( figsize=(20,10), facecolor='k' )
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.show()

Filtering and Cleaning
preprocessing
Remove URLs
Remove documents with less than 100 words
Tokenize: aka breaking the documents into words. This also remove punctuation.
Remove stop words, words that only occur once, digits and words composed of only 1 or 2 characters
borrowed code from: http://alexperrier.github.io/jekyll/update/2015/09/04/topic-modeling-of-twitter-followers.html
also from: https://github.com/alexperrier/datatalks/blob/master/twitter/twitter_preprocessing.py
analysisCorpus = 'twitter'
# Remove urls
documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                for tweet in tweets ]
documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                for tweet in documents ]
documents[0]
u'RT  The best pieces of advice. '
# Remove documents with less 100 words (some timeline are only composed of URLs)
documents = [doc for doc in documents if len(doc) > 100]
documents[0]
u'Forgot to order your x Easter ham? Head into the x Plant to pick up your Easter ham. Get your ham: 1111 L\u2026 '
# tokenize
from nltk.tokenize import RegexpTokenizer

tokenizer = RegexpTokenizer(r'\w+')
documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
documents[0]

# Remove stop words
stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
            'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
            'one','com','new','like','great','make','top','awesome','best',
            'good','wow','yes','say','yay','would','thanks','thank','going',
            'new','use','should','could','best','really','see','want','nice',
            'while','know']

unigrams = [ w for doc in documents for w in doc if len(w)==1]
bigrams  = [ w for doc in documents for w in doc if len(w)==2]

stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                + unigrams + bigrams)
documents = [[token for token in doc if token not in stoplist]
                for doc in documents]
				
documents[0]

from collections import defaultdict
# rm numbers only words
documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

# Lammetization
# This did not add coherence ot the model and obfuscates interpretability of the
# Topics. It was not used in the final model.
#   from nltk.stem import WordNetLemmatizer
#   lmtzr = WordNetLemmatizer()
#   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

# Remove words that only occur once
token_frequency = defaultdict(int)

# count all token
for doc in documents:
    for token in doc:
        token_frequency[token] += 1

# keep words that occur more than once
documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]

from gensim import corpora, models, similarities
# Sort words in documents
for doc in documents:
    doc.sort()

# Build a dictionary where for each document each word has its own id
dictionary = corpora.Dictionary(documents)
dictionary.compactify()
# and save the dictionary for future use
dictionary.save('%s.dict'%analysisCorpus)

# We now have a dictionary with 26652 unique tokens
print(dictionary)

# Build the corpus: vectors with occurence of each word for each document
# convert tokenized documents to vectors
corpus = [dictionary.doc2bow(doc) for doc in documents]

# and save in Market Matrix format
corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
# this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

Running LDA
Parameters of LDA
K: the number of topics
Alpha which dictates how many topics a document potentially has. The lower alpha, the lower the number of topics per documents
Beta which dictates the number of word per document. Similarly to Alpha, the lower Beta is, the lower the number for words per topic.
Borrowed code from: http://nbviewer.jupyter.org/github/alexperrier/datatalks/blob/master/twitter/LDAvis.ipynb
# Initialize Parameters
# current Analysis item
# starting with small number of topics
lda_params      = {'num_topics': 10, 'passes': 20, 'alpha': 0.001}

corpus_filename = '%s.mm'%analysisCorpus
dict_filename   = '%s.dict'%analysisCorpus
lda_filename    = '%s.lda'%analysisCorpus

from gensim import corpora, models, similarities
from time import time
import numpy as np

print("Corpus of %s documents" % len(documents))

# Load the corpus and Dictionary
corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)

print("Running LDA with: %s  " % lda_params)
lda = models.LdaModel(corpus, id2word=dictionary,
                        num_topics=lda_params['num_topics'],
                        passes=lda_params['passes'],
                        alpha = lda_params['alpha'])
print()
lda.print_topics()
lda.save(lda_filename)
print("lda saved in %s " % lda_filename)

Visualize the results
#!pip install pyLDAvis
# Load the corpus and dictionary
from gensim import corpora, models
import pyLDAvis.gensim

corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)
# First LDA model with 10 topics, 10 passes, alpha = 0.001
lda = models.LdaModel.load(lda_filename)
followers_data =  pyLDAvis.gensim.prepare(lda, corpus, dictionary)
pyLDAvis.display(followers_data)

Packaging LDA code to extract insights and benchmark model
Configure by adding more stop words from the above diagram
Yelp
analysisCorpus = 'yelp'
# Initialize Parameters
# current Analysis item
# starting with small number of topics
lda_params      = {'num_topics': 10, 'passes': 20, 'alpha': 0.001}
source_file = yelpCorpus

# Remove urls
documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                for tweet in source_file ]
documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                for tweet in documents ]
# Remove documents with less 100 words (some timeline are only composed of URLs)
documents = [doc for doc in documents if len(doc) > 100]
# tokenize
from nltk.tokenize import RegexpTokenizer

tokenizer = RegexpTokenizer(r'\w+')
documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
# Remove stop words
stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
            'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
            'one','com','new','like','great','make','top','awesome','best',
            'good','wow','yes','say','yay','would','thanks','thank','going',
            'new','use','should','could','best','really','see','want','nice',
            'while','know']

unigrams = [ w for doc in documents for w in doc if len(w)==1]
bigrams  = [ w for doc in documents for w in doc if len(w)==2]

stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                + unigrams + bigrams)
documents = [[token for token in doc if token not in stoplist]
                for doc in documents]
from string import digits
from collections import defaultdict
# rm numbers only words
documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

# Lammetization
# This did not add coherence ot the model and obfuscates interpretability of the
# Topics. It was not used in the final model.
#   from nltk.stem import WordNetLemmatizer
#   lmtzr = WordNetLemmatizer()
#   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

# Remove words that only occur once
token_frequency = defaultdict(int)

# count all token
for doc in documents:
    for token in doc:
        token_frequency[token] += 1

# keep words that occur more than once
documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]
from gensim import corpora, models, similarities
# Sort words in documents
for doc in documents:
    doc.sort()

# Build a dictionary where for each document each word has its own id
dictionary = corpora.Dictionary(documents)
dictionary.compactify()
# and save the dictionary for future use
dictionary.save('%s.dict'%analysisCorpus)

# We now have a dictionary with 26652 unique tokens
print(dictionary)

# Build the corpus: vectors with occurence of each word for each document
# convert tokenized documents to vectors
corpus = [dictionary.doc2bow(doc) for doc in documents]

# and save in Market Matrix format
corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
# this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

corpus_filename = '%s.mm'%analysisCorpus
dict_filename   = '%s.dict'%analysisCorpus
lda_filename    = '%s.lda'%analysisCorpus

from gensim import corpora, models, similarities
from time import time
import numpy as np

print("Corpus of %s documents" % len(documents))

# Load the corpus and Dictionary
corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)

print("Running LDA with: %s  " % lda_params)
lda = models.LdaModel(corpus, id2word=dictionary,
                        num_topics=lda_params['num_topics'],
                        passes=lda_params['passes'],
                        alpha = lda_params['alpha'])
print()
lda.print_topics()
lda.save(lda_filename)
print("lda saved in %s " % lda_filename)
# Load the corpus and dictionary
from gensim import corpora, models
import pyLDAvis.gensim

corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)
# First LDA model with 10 topics, 10 passes, alpha = 0.001
lda = models.LdaModel.load(lda_filename)
followers_data =  pyLDAvis.gensim.prepare(lda, corpus, dictionary)
pyLDAvis.display(followers_data)

Reddit
analysisCorpus = 'reddit'
# Initialize Parameters
# current Analysis item
# starting with small number of topics
lda_params      = {'num_topics': 10, 'passes': 20, 'alpha': 0.001}
source_file = reddit

# Remove urls
documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                for tweet in source_file ]
documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                for tweet in documents ]
# Remove documents with less 100 words (some timeline are only composed of URLs)
documents = [doc for doc in documents if len(doc) > 100]
# tokenize
from nltk.tokenize import RegexpTokenizer

tokenizer = RegexpTokenizer(r'\w+')
documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
# Remove stop words
stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
            'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
            'one','com','new','like','great','make','top','awesome','best',
            'good','wow','yes','say','yay','would','thanks','thank','going',
            'new','use','should','could','best','really','see','want','nice',
            'while','know']

unigrams = [ w for doc in documents for w in doc if len(w)==1]
bigrams  = [ w for doc in documents for w in doc if len(w)==2]

stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                + unigrams + bigrams)
documents = [[token for token in doc if token not in stoplist]
                for doc in documents]
from string import digits
from collections import defaultdict
# rm numbers only words
documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

# Lammetization
# This did not add coherence ot the model and obfuscates interpretability of the
# Topics. It was not used in the final model.
#   from nltk.stem import WordNetLemmatizer
#   lmtzr = WordNetLemmatizer()
#   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

# Remove words that only occur once
token_frequency = defaultdict(int)

# count all token
for doc in documents:
    for token in doc:
        token_frequency[token] += 1

# keep words that occur more than once
documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]
from gensim import corpora, models, similarities
# Sort words in documents
for doc in documents:
    doc.sort()

# Build a dictionary where for each document each word has its own id
dictionary = corpora.Dictionary(documents)
dictionary.compactify()
# and save the dictionary for future use
dictionary.save('%s.dict'%analysisCorpus)

# We now have a dictionary with 26652 unique tokens
print(dictionary)

# Build the corpus: vectors with occurence of each word for each document
# convert tokenized documents to vectors
corpus = [dictionary.doc2bow(doc) for doc in documents]

# and save in Market Matrix format
corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
# this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

corpus_filename = '%s.mm'%analysisCorpus
dict_filename   = '%s.dict'%analysisCorpus
lda_filename    = '%s.lda'%analysisCorpus

from gensim import corpora, models, similarities
from time import time
import numpy as np

print("Corpus of %s documents" % len(documents))

# Load the corpus and Dictionary
corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)

print("Running LDA with: %s  " % lda_params)
lda = models.LdaModel(corpus, id2word=dictionary,
                        num_topics=lda_params['num_topics'],
                        passes=lda_params['passes'],
                        alpha = lda_params['alpha'])
print()
lda.print_topics()
lda.save(lda_filename)
print("lda saved in %s " % lda_filename)
# Load the corpus and dictionary
from gensim import corpora, models
import pyLDAvis.gensim

corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)
# First LDA model with 10 topics, 10 passes, alpha = 0.001
lda = models.LdaModel.load(lda_filename)
followers_data =  pyLDAvis.gensim.prepare(lda, corpus, dictionary)
pyLDAvis.display(followers_data)

Quora
analysisCorpus = 'quora'
# Initialize Parameters
# current Analysis item
# starting with small number of topics
lda_params      = {'num_topics': 10, 'passes': 20, 'alpha': 0.001}
source_file = quora

# Remove urls
documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                for tweet in source_file ]
documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                for tweet in documents ]
# Remove documents with less 100 words (some timeline are only composed of URLs)
documents = [doc for doc in documents if len(doc) > 100]
# tokenize
from nltk.tokenize import RegexpTokenizer

tokenizer = RegexpTokenizer(r'\w+')
documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
# Remove stop words
stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
            'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
            'one','com','new','like','great','make','top','awesome','best',
            'good','wow','yes','say','yay','would','thanks','thank','going',
            'new','use','should','could','best','really','see','want','nice',
            'while','know']

unigrams = [ w for doc in documents for w in doc if len(w)==1]
bigrams  = [ w for doc in documents for w in doc if len(w)==2]

stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                + unigrams + bigrams)
documents = [[token for token in doc if token not in stoplist]
                for doc in documents]
from string import digits
from collections import defaultdict
# rm numbers only words
documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

# Lammetization
# This did not add coherence ot the model and obfuscates interpretability of the
# Topics. It was not used in the final model.
#   from nltk.stem import WordNetLemmatizer
#   lmtzr = WordNetLemmatizer()
#   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

# Remove words that only occur once
token_frequency = defaultdict(int)

# count all token
for doc in documents:
    for token in doc:
        token_frequency[token] += 1

# keep words that occur more than once
documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]
from gensim import corpora, models, similarities
# Sort words in documents
for doc in documents:
    doc.sort()

# Build a dictionary where for each document each word has its own id
dictionary = corpora.Dictionary(documents)
dictionary.compactify()
# and save the dictionary for future use
dictionary.save('%s.dict'%analysisCorpus)

# We now have a dictionary with 26652 unique tokens
print(dictionary)

# Build the corpus: vectors with occurence of each word for each document
# convert tokenized documents to vectors
corpus = [dictionary.doc2bow(doc) for doc in documents]

# and save in Market Matrix format
corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
# this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

corpus_filename = '%s.mm'%analysisCorpus
dict_filename   = '%s.dict'%analysisCorpus
lda_filename    = '%s.lda'%analysisCorpus

from gensim import corpora, models, similarities
from time import time
import numpy as np

print("Corpus of %s documents" % len(documents))

# Load the corpus and Dictionary
corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)

print("Running LDA with: %s  " % lda_params)
lda = models.LdaModel(corpus, id2word=dictionary,
                        num_topics=lda_params['num_topics'],
                        passes=lda_params['passes'],
                        alpha = lda_params['alpha'])
print()
lda.print_topics()
lda.save(lda_filename)
print("lda saved in %s " % lda_filename)
# Load the corpus and dictionary
from gensim import corpora, models
import pyLDAvis.gensim

corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)
# First LDA model with 10 topics, 10 passes, alpha = 0.001
lda = models.LdaModel.load(lda_filename)
followers_data =  pyLDAvis.gensim.prepare(lda, corpus, dictionary)
pyLDAvis.display(followers_data)

consumer affairs
analysisCorpus = 'consumerAffairs'
# Initialize Parameters
# current Analysis item
# starting with small number of topics
lda_params      = {'num_topics': 10, 'passes': 20, 'alpha': 0.001}
source_file = consumerAffairs

# Remove urls
documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                for tweet in source_file ]
documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                for tweet in documents ]
# Remove documents with less 100 words (some timeline are only composed of URLs)
documents = [doc for doc in documents if len(doc) > 100]
# tokenize
from nltk.tokenize import RegexpTokenizer

tokenizer = RegexpTokenizer(r'\w+')
documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
# Remove stop words
stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
            'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
            'one','com','new','like','great','make','top','awesome','best',
            'good','wow','yes','say','yay','would','thanks','thank','going',
            'new','use','should','could','best','really','see','want','nice',
            'while','know']

unigrams = [ w for doc in documents for w in doc if len(w)==1]
bigrams  = [ w for doc in documents for w in doc if len(w)==2]

stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                + unigrams + bigrams)
documents = [[token for token in doc if token not in stoplist]
                for doc in documents]
from string import digits
from collections import defaultdict
# rm numbers only words
documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

# Lammetization
# This did not add coherence ot the model and obfuscates interpretability of the
# Topics. It was not used in the final model.
#   from nltk.stem import WordNetLemmatizer
#   lmtzr = WordNetLemmatizer()
#   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

# Remove words that only occur once
token_frequency = defaultdict(int)

# count all token
for doc in documents:
    for token in doc:
        token_frequency[token] += 1

# keep words that occur more than once
documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]
from gensim import corpora, models, similarities
# Sort words in documents
for doc in documents:
    doc.sort()

# Build a dictionary where for each document each word has its own id
dictionary = corpora.Dictionary(documents)
dictionary.compactify()
# and save the dictionary for future use
dictionary.save('%s.dict'%analysisCorpus)

# We now have a dictionary with 26652 unique tokens
print(dictionary)

# Build the corpus: vectors with occurence of each word for each document
# convert tokenized documents to vectors
corpus = [dictionary.doc2bow(doc) for doc in documents]

# and save in Market Matrix format
corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
# this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

corpus_filename = '%s.mm'%analysisCorpus
dict_filename   = '%s.dict'%analysisCorpus
lda_filename    = '%s.lda'%analysisCorpus

from gensim import corpora, models, similarities
from time import time
import numpy as np

print("Corpus of %s documents" % len(documents))

# Load the corpus and Dictionary
corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)

print("Running LDA with: %s  " % lda_params)
lda = models.LdaModel(corpus, id2word=dictionary,
                        num_topics=lda_params['num_topics'],
                        passes=lda_params['passes'],
                        alpha = lda_params['alpha'])
print()
lda.print_topics()
lda.save(lda_filename)
print("lda saved in %s " % lda_filename)
# Load the corpus and dictionary
from gensim import corpora, models
import pyLDAvis.gensim

corpus = corpora.MmCorpus(corpus_filename)
dictionary = corpora.Dictionary.load(dict_filename)
# First LDA model with 10 topics, 10 passes, alpha = 0.001
lda = models.LdaModel.load(lda_filename)
followers_data =  pyLDAvis.gensim.prepare(lda, corpus, dictionary)
pyLDAvis.display(followers_data)

Model Selection
This method which is in gensim library, does not give the log likelihood directly, but it gives log lower bound.
In my quick search, I did not find how it is treating preplexity as this lower, bount, but my understanding is that it is using evidence lower bound, which is maximized (while preplexity is minimized). As the numbeer it returns is negative, and it mentions that perplexity is 2 power (-bound), I can treat this negative number as likelihood, and the best model is the one that maximizes this value.
A good way is to use likelihood ratio test to find the best number of topics, but for now just for the sake of simplicity, I will only look at the value of preplexity across different number of topics.
lda.log_perplexity(corpus) 
-4.7605830432082943
logPreplexityVector = []
for i in [5,10,15,25,30,40]:
    analysisCorpus = 'modelselection/consumerAffairs%s'%i
    # Initialize Parameters
    # current Analysis item
    # starting with small number of topics
    lda_params      = {'num_topics': i, 'passes': 20, 'alpha': 0.001}
    source_file = consumerAffairs

    # Remove urls
    documents = [re.sub(r"(?:\@|http?\://)\S+", "", tweet)
                    for tweet in source_file ]
    documents = [re.sub(r"(?:\@|https?\://)\S+", "", tweet)
                    for tweet in documents ]
    # Remove documents with less 100 words (some timeline are only composed of URLs)
    documents = [doc for doc in documents if len(doc) > 100]
    # tokenize
    from nltk.tokenize import RegexpTokenizer

    tokenizer = RegexpTokenizer(r'\w+')
    documents = [ tokenizer.tokenize(doc.lower()) for doc in documents ]
    # Remove stop words
    stoplist_tw=['amp','get','got','hey','hmm','hoo','hop','iep','let','ooo','par',
                'pdt','pln','pst','wha','yep','yer','aest','didn','nzdt','via',
                'one','com','new','like','great','make','top','awesome','best',
                'good','wow','yes','say','yay','would','thanks','thank','going',
                'new','use','should','could','best','really','see','want','nice',
                'while','know']

    unigrams = [ w for doc in documents for w in doc if len(w)==1]
    bigrams  = [ w for doc in documents for w in doc if len(w)==2]

    stoplist  = set(nltk.corpus.stopwords.words("english") + stoplist_tw
                    + unigrams + bigrams)
    documents = [[token for token in doc if token not in stoplist]
                    for doc in documents]
    from string import digits
    from collections import defaultdict
    # rm numbers only words
    documents = [ [token for token in doc if len(token.strip(digits)) == len(token)] for doc in documents ]

    # Lammetization
    # This did not add coherence ot the model and obfuscates interpretability of the
    # Topics. It was not used in the final model.
    #   from nltk.stem import WordNetLemmatizer
    #   lmtzr = WordNetLemmatizer()
    #   documents=[[lmtzr.lemmatize(token) for token in doc ] for doc in documents]

    # Remove words that only occur once
    token_frequency = defaultdict(int)

    # count all token
    for doc in documents:
        for token in doc:
            token_frequency[token] += 1

    # keep words that occur more than once
    documents = [ [token for token in doc if token_frequency[token] > 1] for doc in documents  ]
    from gensim import corpora, models, similarities
    # Sort words in documents
    for doc in documents:
        doc.sort()

    # Build a dictionary where for each document each word has its own id
    dictionary = corpora.Dictionary(documents)
    dictionary.compactify()
    # and save the dictionary for future use
    dictionary.save('%s.dict'%analysisCorpus)

    # We now have a dictionary with 26652 unique tokens
    print(dictionary)

    # Build the corpus: vectors with occurence of each word for each document
    # convert tokenized documents to vectors
    corpus = [dictionary.doc2bow(doc) for doc in documents]

    # and save in Market Matrix format
    corpora.MmCorpus.serialize('%s.mm'%analysisCorpus, corpus)
    # this corpus can be loaded with corpus = corpora.MmCorpus('alexip_followers.mm')

    corpus_filename = '%s.mm'%analysisCorpus
    dict_filename   = '%s.dict'%analysisCorpus
    lda_filename    = '%s.lda'%analysisCorpus

    from gensim import corpora, models, similarities
    from time import time
    import numpy as np

    print("Corpus of %s documents" % len(documents))

    # Load the corpus and Dictionary
    corpus = corpora.MmCorpus(corpus_filename)
    dictionary = corpora.Dictionary.load(dict_filename)

    print("Running LDA with: %s  " % lda_params)
    lda = models.LdaModel(corpus, id2word=dictionary,
                            num_topics=lda_params['num_topics'],
                            passes=lda_params['passes'],
                            alpha = lda_params['alpha'])
    print()
    lda.print_topics()
    lda.save(lda_filename)
    print("lda saved in %s " % lda_filename)
    logPreplexityVector.append(lda.log_perplexity(corpus) )
	
print ([5,10,15,25,30,40])
print(logPreplexityVector)
import matplotlib.pyplot as plt
plt.plot([5,10,15,25,30,40],logPreplexityVector)
plt.show()

