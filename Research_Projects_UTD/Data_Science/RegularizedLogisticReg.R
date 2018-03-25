#===================================================
# Code written by: Meisam Hejazi Nia
# For: the Code Puzzle for SS
# On: 08/29/2015
#=================================================
rm(list=ls())
set.seed(1)

#reading the data and dummy coding
#==================================
setwd("C:/Users/mxh109420/Desktop/StapleSparx")
trainingSetFile = "train.csv"
testSetFile = "test.csv"

trainingSet = read.csv(file=trainingSetFile,head=FALSE,sep=",")
dim(trainingSet) #122,907 x 17

testSet = read.csv(file=testSetFile,head=FALSE,sep=",")
dim(testSet) #30,967 x 16

#Checking the distributions
#==================
table(trainingSet[,1]) #ACCOUNT, CART, CLASS, DEPARTMENT, HOME, OTHER_PAGE, SEARCH_RESULTS, SKU, SKUSET
table(trainingSet[,2]) # 0 
table(trainingSet[,3]) 
table(trainingSet[,4]) # observation: long tail
hist(trainingSet[,4])
#check other distributions
#=====================
table(trainingSet[,5]) 
table(trainingSet[,7]) 
table(trainingSet[,9]) 
table(trainingSet[,11]) 
table(trainingSet[,13]) 
table(trainingSet[,15]) 

#checking purchase frequency
#================================
table(trainingSet[,17]) # 89,960 no purchase, and 32,947 purchases, i.e. not sparse purchase


#Dummy Variable Creation for training set
#==================================
# first
dummyData = data.frame(trainingSet$V1)
names(dummyData) = "first"
firstDummy = model.matrix( ~ first - 1, data = dummyData)
colSums(firstDummy) # to test
# second
dummyData = data.frame(trainingSet$V3)
names(dummyData) = "second"
secondDummy = model.matrix( ~ second - 1, data = dummyData)
colSums(secondDummy) # to test
#third
dummyData = data.frame(trainingSet$V5)
names(dummyData) = "third"
thirdDummy = model.matrix( ~ third - 1, data = dummyData)
colSums(thirdDummy) # to test
#fourth
dummyData = data.frame(trainingSet$V7)
names(dummyData) = "fourth"
fourthDummy = model.matrix( ~ fourth - 1, data = dummyData)
colSums(fourthDummy) # to test
#fifth
dummyData = data.frame(trainingSet$V9)
names(dummyData) = "fifth"
fifthDummy = model.matrix( ~ fifth - 1, data = dummyData)
colSums(fifthDummy) # to test
#sixth
dummyData = data.frame(trainingSet$V11)
names(dummyData) = "sixth"
sixthDummy = model.matrix( ~ sixth - 1, data = dummyData)
colSums(sixthDummy) # to test
#seventh
dummyData = data.frame(trainingSet$V13)
names(dummyData) = "seventh"
seventhDummy = model.matrix( ~ seventh - 1, data = dummyData)
colSums(seventhDummy) # to test
#eighth
dummyData = data.frame(trainingSet$V15)
names(dummyData) = "eighth"
eighthDummy = model.matrix( ~ eighth - 1, data = dummyData)
colSums(eighthDummy) # to test

#create the data matrix, but to avoid multicolinearity drop the first element for Training set
#====================================
pageVisitDummies = cbind(
  firstDummy[,2:9],
  secondDummy[,2:9],
  thirdDummy[,2:9],
  fourthDummy[,2:9],
  fifthDummy[,2:9],
  sixthDummy[,2:9],
  seventhDummy[,2:9],
  eighthDummy[,2:9])
dimnames(pageVisitDummies)[[2]] #check the names

#test to make sure the coding is correct
trainingSet[1,]
pageVisitDummies[1,]

#creat the matrix of duration of stay in each page for training set
#========================
duration = cbind(trainingSet$V2,
                 trainingSet$V4,
                 trainingSet$V6-trainingSet$V4,
                 trainingSet$V8-trainingSet$V6,
                 trainingSet$V10-trainingSet$V8,
                 trainingSet$V12-trainingSet$V10,
                 trainingSet$V14-trainingSet$V12,
                 trainingSet$V16-trainingSet$V14)

#use interaction term for training set
#create the variable of total duration of time spending in each page (control for type of customer)
#=====================================================
account = firstDummy[,1]*duration[,1] + secondDummy[,1]*duration[,2] + thirdDummy[,1]*duration[,3] + fourthDummy[,1]*duration[,4]+
  fifthDummy[,1]* duration[,5]+ sixthDummy[,1]*duration[,6]+seventhDummy[,1]*duration[,7]+eighthDummy[,1]*duration[,8]
cart = firstDummy[,2]*duration[,1] + secondDummy[,2]*duration[,2] + thirdDummy[,2]*duration[,3] + fourthDummy[,2]*duration[,4]+
  fifthDummy[,2]* duration[,5]+ sixthDummy[,2]*duration[,6]+seventhDummy[,2]*duration[,7]+eighthDummy[,2]*duration[,8]
classProd = firstDummy[,3]*duration[,1] + secondDummy[,3]*duration[,2] + thirdDummy[,3]*duration[,3] + fourthDummy[,3]*duration[,4]+
  fifthDummy[,3]* duration[,5]+ sixthDummy[,3]*duration[,6]+seventhDummy[,3]*duration[,7]+eighthDummy[,3]*duration[,8]
department= firstDummy[,4]*duration[,1] + secondDummy[,4]*duration[,2] + thirdDummy[,4]*duration[,3] + fourthDummy[,4]*duration[,4]+
  fifthDummy[,4]* duration[,5]+ sixthDummy[,4]*duration[,6]+seventhDummy[,4]*duration[,7]+eighthDummy[,4]*duration[,8]
home = firstDummy[,5]*duration[,1] + secondDummy[,5]*duration[,2] + thirdDummy[,5]*duration[,3] + fourthDummy[,5]*duration[,4]+
  fifthDummy[,5]* duration[,5]+ sixthDummy[,5]*duration[,6]+seventhDummy[,5]*duration[,7]+eighthDummy[,5]*duration[,8]
other_page= firstDummy[,6]*duration[,1] + secondDummy[,6]*duration[,2] + thirdDummy[,6]*duration[,3] + fourthDummy[,6]*duration[,4]+
  fifthDummy[,6]* duration[,5]+ sixthDummy[,6]*duration[,6]+seventhDummy[,6]*duration[,7]+eighthDummy[,6]*duration[,8]
search_results = firstDummy[,7]*duration[,1] + secondDummy[,7]*duration[,2] + thirdDummy[,7]*duration[,3] + fourthDummy[,7]*duration[,4]+
  fifthDummy[,7]* duration[,5]+ sixthDummy[,7]*duration[,6]+seventhDummy[,7]*duration[,7]+eighthDummy[,7]*duration[,8]
sku = firstDummy[,8]*duration[,1] + secondDummy[,8]*duration[,2] + thirdDummy[,8]*duration[,3] + fourthDummy[,8]*duration[,4]+
  fifthDummy[,8]* duration[,5]+ sixthDummy[,8]*duration[,6]+seventhDummy[,8]*duration[,7]+eighthDummy[,8]*duration[,8]
skuset = firstDummy[,9]*duration[,1] + secondDummy[,9]*duration[,2] + thirdDummy[,9]*duration[,3] + fourthDummy[,9]*duration[,4]+
  fifthDummy[,9]* duration[,5]+ sixthDummy[,9]*duration[,6]+seventhDummy[,9]*duration[,7]+eighthDummy[,9]*duration[,8]

#Dummy Variable Creation for test set
#==================================
# first
dummyData = data.frame(testSet$V1)
names(dummyData) = "first"
firstDummy = model.matrix( ~ first - 1, data = dummyData)
colSums(firstDummy) # to test
# second
dummyData = data.frame(testSet$V3)
names(dummyData) = "second"
secondDummy = model.matrix( ~ second - 1, data = dummyData)
colSums(secondDummy) # to test
#third
dummyData = data.frame(testSet$V5)
names(dummyData) = "third"
thirdDummy = model.matrix( ~ third - 1, data = dummyData)
colSums(thirdDummy) # to test
#fourth
dummyData = data.frame(testSet$V7)
names(dummyData) = "fourth"
fourthDummy = model.matrix( ~ fourth - 1, data = dummyData)
colSums(fourthDummy) # to test
#fifth
dummyData = data.frame(testSet$V9)
names(dummyData) = "fifth"
fifthDummy = model.matrix( ~ fifth - 1, data = dummyData)
colSums(fifthDummy) # to test
#sixth
dummyData = data.frame(testSet$V11)
names(dummyData) = "sixth"
sixthDummy = model.matrix( ~ sixth - 1, data = dummyData)
colSums(sixthDummy) # to test
#seventh
dummyData = data.frame(testSet$V13)
names(dummyData) = "seventh"
seventhDummy = model.matrix( ~ seventh - 1, data = dummyData)
colSums(seventhDummy) # to test
#eighth
dummyData = data.frame(testSet$V15)
names(dummyData) = "eighth"
eighthDummy = model.matrix( ~ eighth - 1, data = dummyData)
colSums(eighthDummy) # to test

#create the data matrix, but to avoid multicolinearity drop the first element for Test set
#====================================
pageVisitDummiesTest = cbind(
  firstDummy[,2:9],
  secondDummy[,2:9],
  thirdDummy[,2:9],
  fourthDummy[,2:9],
  fifthDummy[,2:9],
  sixthDummy[,2:9],
  seventhDummy[,2:9],
  eighthDummy[,2:9])
dimnames(pageVisitDummiesTest)[[2]] #check the names

#test to make sure the coding is correct
testSet[1,]
pageVisitDummiesTest[1,]

#creat the matrix of duration of stay in each page for Test set
#========================
durationTest = cbind(testSet$V2,
                     testSet$V4,
                     testSet$V6-testSet$V4,
                     testSet$V8-testSet$V6,
                     testSet$V10-testSet$V8,
                     testSet$V12-testSet$V10,
                     testSet$V14-testSet$V12,
                     testSet$V16-testSet$V14)

#response variable
#====================
purchase = trainingSet$V17

#use interaction term for test set
#create the variable of total duration of time spending in each page (control for type of customer)
#=====================================================
accountTest = firstDummy[,1]*durationTest[,1] + secondDummy[,1]*durationTest[,2] + thirdDummy[,1]*durationTest[,3] + fourthDummy[,1]*durationTest[,4]+
  fifthDummy[,1]* durationTest[,5]+ sixthDummy[,1]*durationTest[,6]+seventhDummy[,1]*durationTest[,7]+eighthDummy[,1]*durationTest[,8]
cartTest = firstDummy[,2]*durationTest[,1] + secondDummy[,2]*durationTest[,2] + thirdDummy[,2]*durationTest[,3] + fourthDummy[,2]*durationTest[,4]+
  fifthDummy[,2]* durationTest[,5]+ sixthDummy[,2]*durationTest[,6]+seventhDummy[,2]*durationTest[,7]+eighthDummy[,2]*durationTest[,8]
classProdTest = firstDummy[,3]*durationTest[,1] + secondDummy[,3]*durationTest[,2] + thirdDummy[,3]*durationTest[,3] + fourthDummy[,3]*durationTest[,4]+
  fifthDummy[,3]* durationTest[,5]+ sixthDummy[,3]*durationTest[,6]+seventhDummy[,3]*durationTest[,7]+eighthDummy[,3]*durationTest[,8]
departmentTest= firstDummy[,4]*durationTest[,1] + secondDummy[,4]*durationTest[,2] + thirdDummy[,4]*durationTest[,3] + fourthDummy[,4]*durationTest[,4]+
  fifthDummy[,4]* durationTest[,5]+ sixthDummy[,4]*durationTest[,6]+seventhDummy[,4]*durationTest[,7]+eighthDummy[,4]*durationTest[,8]
homeTest = firstDummy[,5]*durationTest[,1] + secondDummy[,5]*durationTest[,2] + thirdDummy[,5]*durationTest[,3] + fourthDummy[,5]*durationTest[,4]+
  fifthDummy[,5]* durationTest[,5]+ sixthDummy[,5]*durationTest[,6]+seventhDummy[,5]*durationTest[,7]+eighthDummy[,5]*durationTest[,8]
other_pageTest = firstDummy[,6]*durationTest[,1] + secondDummy[,6]*durationTest[,2] + thirdDummy[,6]*durationTest[,3] + fourthDummy[,6]*durationTest[,4]+
  fifthDummy[,6]* durationTest[,5]+ sixthDummy[,6]*durationTest[,6]+seventhDummy[,6]*durationTest[,7]+eighthDummy[,6]*durationTest[,8]
search_resultsTest = firstDummy[,7]*durationTest[,1] + secondDummy[,7]*durationTest[,2] + thirdDummy[,7]*durationTest[,3] + fourthDummy[,7]*durationTest[,4]+
  fifthDummy[,7]* durationTest[,5]+ sixthDummy[,7]*durationTest[,6]+seventhDummy[,7]*durationTest[,7]+eighthDummy[,7]*durationTest[,8]
skuTest = firstDummy[,8]*durationTest[,1] + secondDummy[,8]*durationTest[,2] + thirdDummy[,8]*durationTest[,3] + fourthDummy[,8]*durationTest[,4]+
  fifthDummy[,8]* durationTest[,5]+ sixthDummy[,8]*durationTest[,6]+seventhDummy[,8]*durationTest[,7]+eighthDummy[,8]*durationTest[,8]
skusetTest = firstDummy[,9]*durationTest[,1] + secondDummy[,9]*durationTest[,2] + thirdDummy[,9]*durationTest[,3] + fourthDummy[,9]*durationTest[,4]+
  fifthDummy[,9]* durationTest[,5]+ sixthDummy[,9]*durationTest[,6]+seventhDummy[,9]*durationTest[,7]+eighthDummy[,9]*durationTest[,8]

#create the interaction matrix
#==============================
interactionTerms = cbind(account, cart, classProd, department, home, 
                         other_page, search_results, sku, skuset)

interactionTermsTest = cbind(accountTest, cartTest, classProdTest, departmentTest, homeTest, 
                             other_pageTest, search_resultsTest, skuTest, skusetTest)

#creating the design matrix
#==========================
X = cbind(pageVisitDummies,duration,interactionTerms)
Xtest = cbind(pageVisitDummiesTest,durationTest,interactionTermsTest)

VarNames= c("firstCART","firstCLASS","firstDEPARTMENT", "firstHOME","firstOTHER_PAGE","firstSEARCH_RESULTS","firstSKU","firstSKUSET",    
            "secondCART","secondCLASS","secondDEPARTMENT","secondHOME","secondOTHER_PAGE","secondSEARCH_RESULTS","secondSKU","secondSKUSET",   
            "thirdCART","thirdCLASS","thirdDEPARTMENT","thirdHOME","thirdOTHER_PAGE","thirdSEARCH_RESULTS","thirdSKU","thirdSKUSET",    
            "fourthCART","fourthCLASS","fourthDEPARTMENT","fourthHOME", "fourthOTHER_PAGE","fourthSEARCH_RESULTS","fourthSKU","fourthSKUSET",   
            "fifthCART", "fifthCLASS","fifthDEPARTMENT","fifthHOME","fifthOTHER_PAGE", "fifthSEARCH_RESULTS","fifthSKU","fifthSKUSET",    
            "sixthCART","sixthCLASS","sixthDEPARTMENT", "sixthHOME","sixthOTHER_PAGE", "sixthSEARCH_RESULTS","sixthSKU","sixthSKUSET",    
            "seventhCART","seventhCLASS","seventhDEPARTMENT","seventhHOME","seventhOTHER_PAGE","seventhSEARCH_RESULTS","seventhSKU","seventhSKUSET",  
            "eighthCART","eighthCLASS","eighthDEPARTMENT","eighthHOME", "eighthOTHER_PAGE","eighthSEARCH_RESULTS","eighthSKU", "eighthSKUSET",   
            "firstDur","secondDur","ThirdDur", "FourthDur","FifthDur","SixthDur","SeventhDur","EighthDur","account","cart","classProd","department",     
            "home","other_page","search_results","sku","skuset")

names(X) = VarNames
colnames(X) = VarNames
names(Xtest) = VarNames
colnames(Xtest) = VarNames

TSSet = data.frame(Xtest)

#separate Data into Training and Validation set randomly
#============================================
#validation data set
indx = sample(1:nrow(X), size=22907, replace = FALSE, prob = NULL)

#validationset
VSet = data.frame(cbind(X[indx,],purchase[indx]))  #dim = 22907 x 81 + 1 (response)
colnames(VSet)= c(VarNames,"purchase")

#test set 
TSet = data.frame(cbind(X[-indx,],purchase[-indx])) #dim = 100,000 x 81 + 1 (response)
colnames(TSet)= c(VarNames,"purchase")

#===================================================================
# End of Data Cleaning
#===================================================================

#==================================================================
#Beginning of modeling
#==================================================================

#==========================================================
#test regularized logistic regression
#==========================================================
#install.packages('LiblineaR')
library("LiblineaR")
# Center and scale data
s=scale(TSet[,-82],center=TRUE,scale=TRUE)
s[which(is.nan(s))] = 0
# Logistic Regression
t=0

# Find the best model with the best cost parameter via 10-fold cross-validations
tryTypes=c(0:7)
tryCosts=c(1000,100,10,1,0.1,0.01,0.001)
bestCost=NA
bestAcc=0
bestType=NA

for(ty in tryTypes){
  for(co in tryCosts){
    acc=LiblineaR(data=s,target=TSet[,82],type=ty,cost=co,bias=TRUE,cross=10,verbose=FALSE)
    cat("Results for C=",co," : ",acc," accuracy.\n",sep="")
    if(acc>bestAcc){
      bestCost=co
      bestAcc=acc
      bestType=ty
    }
  }
}

cat("Best model type is:",bestType,"\n")
cat("Best cost is:",bestCost,"\n")
cat("Best accuracy is:",bestAcc,"\n")
#Best model type is: 2 
#Best cost is: 0.01 
#Best accuracy is: 0.74469 


# Re-train best model with best cost value.
m=LiblineaR(data=s,target=TSet[,82],type=bestType,cost=bestCost,bias=TRUE,verbose=FALSE)

# Scale the test data
s2=scale(VSet[,-82],attr(s,"scaled:center"),attr(s,"scaled:scale"))
s2[which(is.nan(s2))] = 0

# Make prediction
pr=FALSE
if(bestType==0 | bestType==7) pr=TRUE

p=predict(m,s2,proba=pr,decisionValues=TRUE)

# Display confusion matrix
res=table(p$predictions,VSet[,82])
print(res)

predictionCat = p$predictions

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionCat)){
  if (predictionCat[i]==1 && VSet[i,82]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,82]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,82]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,82]== 1){
    FN = FN + 1
  }
}

#less accurate, but high recall and precision than ada-boost
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7446632 (more than before)
recall = TP/(TP+FN)               #0.3177756
precision = TP/(TP+TN)            #0.1125572





