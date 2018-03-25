#===================================================
# Code written by: Meisam Hejazi Nia
# For: the Code Puzzle for Stable SparX
# On: 08/29/2015
#=================================================
rm(list=ls())
set.seed(1)

#reading the data and dummy coding
#==================================
setwd("C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/InternshipPractice/StapleSparx")
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

#Logistic Regression test with all the variables
#=============================================
model = glm(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, family="binomial", data=TSet)
summary(model)
predictionResult = predict(model, VSet, type = "response") # predicted values
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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

accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7460165
recall = TP/(TP+FN)               #0.324
precision = TP/(TP+TN)            #0.115

#Logistic Regression test without the timing on each page
#=============================================
model = glm(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur, family="binomial", data=TSet)
summary(model)
predictionResult = predict(model, VSet, type = "response") # predicted values
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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

accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7464094 (marginally improved)
recall = TP/(TP+FN)               #0.325
precision = TP/(TP+TN)            #0.115

#====================================================
# test ensemble back in excel but save them in a file here
#====================================================
# save logistic regression validation set
MyData = data.frame(cbind(predictionCat,VSet[,82]))
write.csv(MyData, file = "validLogisticDummyFeature.csv",row.names=FALSE)

#Logistic Regression test only with duration
#=============================================
model = glm(purchase ~   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur, family="binomial", data=TSet)
summary(model)
predictionResult = predict(model, VSet, type = "response") # predicted values
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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

accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7347099 (less accurate improved)
recall = TP/(TP+FN)               #0
precision = TP/(TP+TN)            #0

# Test SVM
#====================================
#install.packages("kernlab")
library(kernlab)
model <- ksvm(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
                    secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
                    thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
                    fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
                    fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
                    sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
                    seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
                    eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
                    firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
                    home+other_page+search_results+sku+skuset, data = TSet,
                    type = "C-bsvc", kernel = "rbfdot",
                    kpar = list(sigma = 0.1), C = 10,
                    prob.model = TRUE)

svmModel2= model
summary(model)
predictionResult = predict(model, VSet, type = "probabilities")
predictionCat = as.numeric(predictionResult[,2]> 0.5)

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

accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7362378 (less accurate improved)
recall = TP/(TP+FN)               #0
precision = TP/(TP+TN)            #0

#===========================================================
# testing second svm package
#===========================================================
#install.packages("e1071")
library("e1071")
model <- svm(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
                 secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
                 thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
                 fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
                 fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
                 sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
                 seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
                 eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
                 firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
                 home+other_page+search_results+sku+skuset, data = TSet,
                 method = "C-classification", kernel = "radial",
                cost = 10, gamma = 0.1)
svmModel1= model
summary(model)

predictionResult = predict(model, VSet, type = "response") # predicted values
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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
#less than above
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7362378 (less accurate improved)
recall = TP/(TP+FN)               #0
precision = TP/(TP+TN)            #0

#============================================================
# Test factor analysis effect on binary choice model
#============================================================
library(nFactors)
mydata = TSet
#sum(is.nan(as.matrix(mydata)))
#sum(is.infinite(as.matrix(mydata)))
# Pricipal Components Analysis
# entering raw data and extracting PCs 
# from the correlation matrix 
fit <- prcomp(mydata[,1:81])
summary(fit) # print variance accounted for 
plot(fit,type="lines") # scree plot 
factorLoading = fit$rotation[,1:7] #factor loading weights
factorData = data.frame(cbind(as.matrix(mydata[1:81])%*%as.matrix(factorLoading),mydata[82]))
VsetFactor = data.frame(cbind(as.matrix(VSet[1:81])%*%as.matrix(factorLoading),VSet[82]))

model = glm(purchase ~   
              PC1+PC2+PC3+PC4+PC5+PC6+PC7, family="binomial", data=factorData)
summary(model)
predictionResult = predict(model, VsetFactor, type = "response") # predicted values
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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
#less than above
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7350155 (less accurate improved)
recall = TP/(TP+FN)               #0.02896392
precision = TP/(TP+TN)            #0.01039378


#====================================================
# test adaboost
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 1,xval = 0)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7524338
recall = TP/(TP+FN)               #0.3867925
precision = TP/(TP+TN)            #0.1355883

#============================================================
# test decision tree
#===========================================================
#install.packages("rpart")
library(rpart)

# grow tree 
fit <- rpart(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
               secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
               thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
               fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
               fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
               sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
               seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
               eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
               firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
               home+other_page+search_results+sku+skuset, 
               method="class",data = TSet)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits
# plot tree 
plot(fit, uniform=TRUE, 
     main="Classification Tree for Kyphosis")
text(fit, use.n=TRUE, all=TRUE, cex=.8)
# prune the tree 
pfit<- prune(fit, cp=   fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
# plot the pruned tree 
plot(pfit, uniform=TRUE, 
     main="Pruned Classification Tree for Kyphosis")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)
post(pfit, file = "c:/ptree.ps", 
     title = "Pruned Classification Tree for Kyphosis")

predictionCat =predict(fit,newdata = VSet[,-82],type="class")

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

#less precise and accurate than ada-boost
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7447505
recall = TP/(TP+FN)               #0.2239325
precision = TP/(TP+TN)            # 0.07930832

#============================================================
# test random forest
#============================================================
#install.packages("randomForest")
library(randomForest)
fit <- randomForest(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
                      secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
                      thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
                      fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
                      fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
                      sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
                      seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
                      eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
                      firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
                      home+other_page+search_results+sku+skuset,   data=TSet)
print(fit) # view results 
importance(fit) # importance of each predictor

#save the model for later predictions
randomForestModel = fit

#save back the result
fit = randomForestModel

predictionCat =predict(fit,newdata = VSet[,-82],type="class")
predictionResult = predictionCat
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
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

#more accurate than adaboost, but less recall and less precise
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7561881
recall = TP/(TP+FN)               #0.3755379
precision = TP/(TP+TN)            #0.1309895

#====================================================
# test ensemble back in excel but save them in a file here
#====================================================
# save random forest validation set
MyData = data.frame(cbind(predictionCat,VSet[,82]))
write.csv(MyData, file = "validRandForDummyFeature.csv",row.names=FALSE)


#====================================================
# run random forest on the test set
#===================================================
#save back the result
fit = randomForestModel
predictionCat =predict(fit,newdata = TSSet,type="class")
predictionResult = predictionCat
predictionCat = as.numeric(predictionResult> 0.5)
# save random forest on the test set
MyData = data.frame(predictionCat)
write.csv(MyData, file = "testSetPredictionWithRandForest.csv",row.names=FALSE)

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = 0.01, maxdepth = 20,maxcompete = 4,xval = 5
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = 0.01, maxdepth = 20,maxcompete = 4,xval = 5)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7362378
recall = TP/(TP+FN)               #0
precision = TP/(TP+TN)            #0

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 20,maxcompete = 1,xval = 0
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 20,maxcompete = 1,xval = 0)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7510805 less
recall = TP/(TP+FN)               #0.3732208 less
precision = TP/(TP+TN)            #0.1310666 less

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 10,maxcompete = 1,xval = 0
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 10,maxcompete = 1,xval = 0)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7514297 less
recall = TP/(TP+FN)               #0.3824892 less
precision = TP/(TP+TN)            #0.134259 less

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 14,maxcompete = 3,xval = 0
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 3,xval = 0)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7533068 less
recall = TP/(TP+FN)               #0.3968884 less
precision = TP/(TP+TN)            #0.1389662 less

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 14,maxcompete = 6,xval = 0
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 6,xval = 0)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7520409 less
recall = TP/(TP+FN)               #0.3950679 less
precision = TP/(TP+TN)            #0.1385616 less

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 14,maxcompete = 3,xval = 5, iter = 70
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 3,xval = 5)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7564063 less
recall = TP/(TP+FN)               #0.3932473 less
precision = TP/(TP+TN)            #0.137127 less

#===================================================
# visualization of the correlation between variables of training set
#===================================================
#cbind(pageVisitDummies,duration,interactionTerms)
library(corrplot)
M <- cor(pageVisitDummies[,1:32])
corrplot(M, method = "circle")
M <- cor(pageVisitDummies[,33:64])
corrplot(M, method = "circle")

#====================================================
# test ensemble back in excel but save them in a file here
#====================================================
# save adaboost validation set
MyData = data.frame(cbind(predictionCat,VSet[,82]))
write.csv(MyData, file = "validResDummyFeature.csv",row.names=FALSE)

#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 14,maxcompete = 3,xval = 5, iter = 140
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 3,xval = 5)
gen1 <- ada(purchase ~ firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 140)
gen1 <- addtest(gen1, VSet[,-82], VSet[,82])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-82])

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

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7523028 less
recall = TP/(TP+FN)               #0.3841443 less
precision = TP/(TP+TN)            #0.1346835 less