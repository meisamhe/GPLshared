#==========================================
# Code written by: Meisam Hejazi Nia
# on 05/08/2016
# For Correlation One Interview challange
#==========================================
library(data.table)
setwd("C:/Users/Meisam/Desktop/CorrelationOne/data/")


# Response Data
#===================================
response = setDT(response)
response = read.csv("responseLog.csv")
head(response)
#Time article_id user_id status_code byteSize
#1: 02/Jan/2015:08:07:32        162    5475         200     4352
dim(response)
#1,770,781       5
#convert to correct date format
#test first:
# as.POSIXct(strptime(
#   as.character(response$Time[1]), "%d/%b/%Y:%H:%M:%S"))
response$Time=as.POSIXct(strptime(
  as.character(response$Time), "%d/%b/%Y:%H:%M:%S"))
#separate date
response[,Date:=as.Date(Time)]
unique(response[,Date])
#"2015-01-02" to "2015-04-01"

#separate time of day
#------------------
response[,Hour:=hour(Time)]
unique(response[,Hour])
#source of hour of day def: http://www.learnersdictionary.com/qa/parts-of-the-day-early-morning-late-morning-etc
response[,ToD:=ifelse(Hour>=5 & Hour<8, "Early Morning",
                ifelse(Hour>=8 & Hour<11, "Morning",
                ifelse(Hour>=11 & Hour<12, "Late Morning",
                ifelse(Hour>=12 & Hour<13,"Noon",
                ifelse(Hour>=13 & Hour<15,"Early afternoon",
                ifelse(Hour>=15 & Hour<16,"Afternoon",
                ifelse(Hour>=16 & Hour<17,"Late Afternoon",
                ifelse(Hour>=17 & Hour<19,"Early Evening",
                ifelse(Hour>=19 & Hour<21,"Evening",
                ifelse(Hour>=21 & Hour<5,"Night","Unknown"
                          ))))))))))]
table(response$ToD)

#separate month
#-------------
response[,Month:=month(Time)]
table(response$Month)

#separate day of week
#-----------------
DoWIndx=read.csv("DoW.csv")
DoWIndx=setDT(DoWIndx)
DoWIndx$Date=as.character(DoWIndx$Date)
response$Date=as.character(response$Date)
response=merge(response,DoWIndx,by="Date")
table(response$DoW)
dim(response)

#check unique status codes
#---------
table(response$status_code)
# 200     400 
# 1,762,015    8,766
#outlier to filer: 400 is error, when bad request: length of message problem
# 200
dir.create('./Results')
write.csv(t(t(table(response$byteSize))),"./Results/byteSizeHist.csv")
responseFilt = response[status_code==200,]
gc()
#===================================
#End Response file


# Articles
#============================================
#other files
articles = read.csv("articles.csv")
articles=setDT(articles)
head(articles)
# article_id author_id topic_id type_id            submission_time
# 1          1     13746       72      31 2015-01-01 00:01:14.412609
dim(articles) #17029  x  5
#convert to correct date format
#test first:
# as.POSIXct(strptime(
#   as.character(articles$submission_time[1]), "%Y-%m-%d %H:%M:%S"))
articles$submission_time=as.POSIXct(strptime(
  as.character(articles$submission_time), "%Y-%m-%d %H:%M:%S"))
#============================================
# End of Articles analysis

# Beginning of email content Analysis
#============================================
email_content = read.csv("email_content.csv")
email_content=setDT(email_content)
head(email_content)
#content_id email_id user_id article_id                  send_time
#1          1        1   11460         66 2015-01-02 08:06:20.070850
dim(email_content)
#10,738,006   x   5

email_content$send_time=as.POSIXct(strptime(
  as.character(email_content$send_time), "%Y-%m-%d %H:%M:%S"))

#separate time of day
#------------------
email_content[,Hour:=hour(send_time)]
unique(email_content[,Hour])
#source of hour of day def: http://www.learnersdictionary.com/qa/parts-of-the-day-early-morning-late-morning-etc
email_content[,ToD:=ifelse(Hour>=5 & Hour<8, "Early Morning",
                      ifelse(Hour>=8 & Hour<11, "Morning",
                             ifelse(Hour>=11 & Hour<12, "Late Morning",
                                    ifelse(Hour>=12 & Hour<13,"Noon",
                                           ifelse(Hour>=13 & Hour<15,"Early afternoon",
                                                  ifelse(Hour>=15 & Hour<16,"Afternoon",
                                                         ifelse(Hour>=16 & Hour<17,"Late Afternoon",
                                                                ifelse(Hour>=17 & Hour<19,"Early Evening",
                                                                       ifelse(Hour>=19 & Hour<21,"Evening",
                                                                              ifelse(Hour>=21 & Hour<5,"Night","Unknown"
                                                                              ))))))))))]
table(email_content$ToD)

#separate month
#-------------
email_content[,Month:=month(send_time)]
table(email_content$Month)

#separate day of week
#-----------------
email_content[,Date:=as.Date(send_time)]
unique(email_content[,Date])
#ranges from "2015-01-02" to "2015-03-31"
DoWIndx=read.csv("DoW.csv")
DoWIndx=setDT(DoWIndx)
DoWIndx$Date=as.character(DoWIndx$Date)
email_content$Date=as.character(email_content$Date)
dim(email_content)
email_content=merge(email_content,DoWIndx,by="Date")
table(email_content$DoW)
dim(email_content)

length(unique(content_id$email_id)) #10,738,006
length(unique(email_content$email_id)) #1,058,436
# each email has a unique id and it can contain on average 10 articles

gc()
#============================================
# End of email content Analysis


#Beginning of Topic, Type, and article
#============================================
topics = read.csv("topics.csv")
topics=setDT(topics)
head(topics)
#topic_id        name
#1:        1 Advertising
#2:        2    Auditing

types = read.csv("types.csv")
types=setDT(types)
head(types)
# type_id        name
#1:       1   Blog Post
#2:       2 Book Review

users = read.csv("users.csv")
users=setDT(users)
head(users)
#user_id                       email
#1:       1    portia.johnson@gwxga.com
#2:       2 marilyn.chavarria@tkvzv.com
dim(users) #20000  x  2
length(unique(users$email)) #users are unique, so we don't need to take them
# later maybe it might be useful to use users domain for segmentation, but not a priority now

#extract type and topic of articles (merge)
#-----------------
dim(articles)
articles = merge(articles,topics,by="topic_id")
dim(articles)
head(articles)
articles = merge(articles,types,by="type_id")
dim(articles)
head(articles)
setnames(articles,c("name.x","name.y"),c("topics","types"))
#============================================
#End of Topic, Type, and article

#Begin merging topics, response and emails
#================================
# first: emails
#-----------------
dim(email_content)
email_content=merge(email_content,articles, by=c("article_id"))
dim(email_content)
head(email_content)

#second: responses
#----------------
dim(responseFilt)
responseFilt=merge(responseFilt,articles, by=c("article_id"))
dim(responseFilt)
#setnames(responseFilt,c("name.x","name.y"),c("topics","types"))
head(responseFilt)


#Duplicate Analysis
#===============================
#make sure there is no duplicate (double clicks)
dim(responseFilt[,list(article_id,user_id)]) #1762015  x   2
dim(unique(responseFilt[,list(article_id,user_id,topics,types)])) #16969   x 2
dim(email_content[,list(article_id,user_id)]) #10,738,006        2
dim(unique(email_content[,list(article_id,user_id)])) #16,982 x   2
dim(users) #20000 x  2
dim(unique(email_content[,list(email_id,user_id)])) #1,058,436  x 2

# basic statistics of typics and types
# email_content
# responseFilt

#check the distribution of topics
#---------------------
write.csv(table(email_content$topics),"./Results/emailTopicsBasicStat.csv")
write.csv(table(responseFilt$topics),"./Results/ResponseTopicsBasicStat.csv")

write.csv(table(email_content$types),"./Results/emailTypeBasicStat.csv")
write.csv(table(responseFilt$types),"./Results/ResponseTypeBasicStat.csv")

#distribution of number of contents per article
#------------------------
write.csv(table(email_content[,.N,by=email_id]$N),"./Results/contentPerEmail.csv")


# test the number of topics and types per article
dim(articles)
length(unique(articles$article_id))
# every article has only one topic and type

#check the number of articles a given author writes (article generation frequency)
table(table(articles$author_id))
write.csv(table(table(articles$author_id)),"./Results/numberOfArticlesAuthorWrites.csv")

#check the number/frequency of article consumption
table(table(responseFilt$author_id))
write.csv(table(table(responseFilt$author_id)),"./Results/numberOfArticlesUsersConsume.csv")

#Dynamic (time) summary per type/topic over 3 month: weekly
#---------------------------------
#first for response
firstDate = min(responseFilt$Time)
responseFilt[, t := round(as.numeric(Time - firstDate,
                                 units = 'days'), 0)]
unique(responseFilt$t)
responseFilt[, Week := ceiling(t/7)]
head(responseFilt)
unique(responseFilt$Week)
t(t(table(responseFilt$Week)))

#second for sent
email_content[, t := round(as.numeric(send_time - firstDate,
                                     units = 'days'), 0)]
unique(email_content$t)
email_content[, Week := ceiling(t/7)]
head(email_content)
unique(email_content$Week)
t(t(table(email_content$Week)))

#Binomial test
prop.test(477152, 2890752, p = 0.163975)

# test for each of the topics
#---------------------
write.csv(t(table(responseFilt[, list(topics,Week)])),"./Results/weeklytopicsResponse.csv")
write.csv(t(table(email_content[, list(topics,Week)])),"./Results/weeklytopicsSent.csv")

write.csv(t(table(responseFilt[, list(topics,Week)]))/t(table(email_content[, list(topics,Week)])),"./Results/weeklytopicsRatio.csv")


# test for each of the types
#---------------------
write.csv(t(table(responseFilt[, list(types,Week)])),"./Results/weeklytypesResponse.csv")
write.csv(t(table(email_content[, list(types,Week)])),"./Results/weeklytypesSent.csv")

write.csv(t(table(responseFilt[, list(types,Week)]))/t(table(email_content[, list(types,Week)])),"./Results/weeklytypesRatio.csv")

#check correlation between content topic and type
#----------------------------
chisq.test(table(responseFilt[,list(topics,types)]))
fisher.test(table(email_content[,list(topics,types)]))
# tests did not work


#cluster users based on the topic of their response
#----------------------------------
responseFilt$topics = as.character(responseFilt$topics )
indivUserTopics=aggregate(topics~user_id,c,data=responseFilt)
head(indivUserTopics)
dim(indivUserTopics)

#create the user- topic matrix
#--------------------
library(tm)
mycorpus = Corpus(VectorSource(indivUserTopics$topics))
dtm <- DocumentTermMatrix(mycorpus) 
library(topicmodels)
lda=LDA(dtm, k = 10, method = "VEM",control = list(alpha=0.1,verbose = 1))
lda_inf<- posterior(lda, dtm)

write.csv(lda_inf$terms,"./Results/LDATerms.csv")

#check response time statistics with respect to type and topic of article (ToD)
#--------------



# to do:
#think about generation and consumption (UGC) of the contents
#     each article has topic, type, author
#consider that recency of article might affect the response
# control for the number of times an article in a given topic shown
# control for the number of items shown to each customer
# future: customer level
# check the duration since email