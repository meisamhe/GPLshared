#!python -m pip install --upgrade pip
#!pip install twython
from twython import Twython
APP_KEY = 'xx'
APP_SECRET = 'xx'

# twitter = Twython(APP_KEY, APP_SECRET)
twitter = Twython(APP_KEY, APP_SECRET, oauth_version=2)
ACCESS_TOKEN = twitter.obtain_access_token()
twitter = Twython(APP_KEY, access_token=ACCESS_TOKEN)
# auth = twitter.get_authentication_tokens()
# OAUTH_TOKEN = auth['oauth_token']
# OAUTH_TOKEN_SECRET = auth['oauth_token_secret']
search = twitter.search(q='#x',   #**supply whatever query you want here**
                  count=100)
tweets = search['statuses']
print(len(tweets))
tweet = tweets[1]
print tweet['id_str'], '\n', tweet['text'], '\n\n\n'
# for tweet in tweets:
#     print tweet['id_str'], '\n', tweet['text'], '\n\n\n'


from twython import Twython, TwythonError
import time
newtweets = twitter.search(q='schwab',  
                  count=10)['statuses']
tweets = []
#print(newtweets['statuses'][0])
for tweet in newtweets:
    #print(tweet)
    # Add whatever you want from the tweet, here we just add the text
    tweets.append(tweet['text'])
while len(tweets) <(15*50): # this is based on rate limit 
    try:
        print('maximum was: %s'%(newtweets[len(newtweets)-1]['id']-1))
        newtweets = twitter.search(q='schwab',   #**supply whatever query you want here**
                  count=10,
                  max_id=newtweets[len(newtweets)-1]['id']-1)['statuses']
        time.sleep(5)
        #print(newtweets)
    except TwythonError as e:
        print e
    print len(newtweets)
    for tweet in newtweets:
        # Add whatever you want from the tweet, here we just add the text
        tweets.append(tweet['text'])

print(len(tweets))
753
# write the scraped result into a file
import pickle

with open('tweets.txt', 'wb') as fp:
    pickle.dump(tweets, fp)
# read the reddit file back
import pickle
with open ('tweets.txt', 'rb') as fp:
    tweets = pickle.load(fp)
# sanity check
print(len(tweets))