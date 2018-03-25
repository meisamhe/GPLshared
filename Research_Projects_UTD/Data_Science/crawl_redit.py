# !pip install praw
# !pip install user_agents
import praw
rdtClientID = 'hjMLvnvg_kxpEw'
rdtClientSecret = 'RYvuG-nnO76KF3oLpviJzppAoLs'
rdtPassword = '123456'
rdtUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
rdtUserName = 'meisamhe'
# r = praw.Reddit(client_id= rdtClientID , client_secret= rdtClientSecret,
#                      password= rdtPassword, user_agent= rdtUserAgent,
#                      username= rdtUserName)
r = praw.Reddit(client_id=rdtClientID,
                     client_secret=rdtClientSecret,
                     user_agent=rdtUserAgent)
#print(r.read_only)  # Output: True
# updating subreddit
#-------------------
# submission = r.subreddit('x')
# print(submission.description)
# Subreddit instance
#-------------------
# Now that you have a Subreddit instance, you can iterate through some of its submissions, 
# each bound to an instance of Submission. There are several sorts that you can iterate through:
# controversial
# gilded
# hot
# new
# rising
# top
reddit = []
for submission in r.subreddit('x').new():
    reddit.append(submission.title)
#     print(submission.title)  # Output: the submission's title
#     top_level_comments = list(submission.comments)
#     all_comments = submission.comments.list()
#     for element in all_comments:
#         print(element)
#     print(submission.score)  # Output: the submission's score
#     print(submission.id)     # Output: the submission's ID
#     print(submission.url)    # Output: the URL the submission points to

# Also search the posts
#------------------
posts = r.subreddit('all').search('x', limit=1000)
cnt=0
for submission in posts:
    reddit.append(submission.title)
#     cnt += 1
#     print (cnt),
#     #print(submission.title)
print(len(reddit))
471
pwd()
u'C:\\Users\\Meisam\\Desktop\\work\\x'
# write the scraped result into a file
import pickle

with open('reddit.txt', 'wb') as fp:
    pickle.dump(reddit, fp)
# redditFile = open('reddit.txt', 'w')
# for item in reddit:
#     redditFile.write("%s\n" % item.encode('utf-8'))
# redditFile.close()
# read the reddit file back
import pickle
with open ('reddit.txt', 'rb') as fp:
    reddit = pickle.load(fp)
# sanity check
print(len(reddit))