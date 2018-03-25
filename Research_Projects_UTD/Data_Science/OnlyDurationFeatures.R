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

# turn each dummy into duration
#create the data matrix, but to avoid multicolinearity drop the first element for Training set
#====================================
pageVisitDummies = cbind(
  firstDummy[,1:9]*duration[,1],
  secondDummy[,1:9]*duration[,2],
  thirdDummy[,1:9]*duration[,3],
  fourthDummy[,1:9]*duration[,4],
  fifthDummy[,1:9]*duration[,5],
  sixthDummy[,1:9]*duration[,6],
  seventhDummy[,1:9]*duration[,7],
  eighthDummy[,1:9]*duration[,8])
dimnames(pageVisitDummies)[[2]] #check the names

#test to make sure the coding is correct
trainingSet[1,]
pageVisitDummies[1,]


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

#create the data matrix, but to avoid multicolinearity drop the first element for Test set
#====================================
pageVisitDummiesTest = cbind(
  firstDummy[,1:9]*durationTest[,1],
  secondDummy[,1:9]*durationTest[,2],
  thirdDummy[,1:9]*durationTest[,3],
  fourthDummy[,1:9]*durationTest[,4],
  fifthDummy[,1:9]*durationTest[,5],
  sixthDummy[,1:9]*durationTest[,6],
  seventhDummy[,1:9]*durationTest[,7],
  eighthDummy[,1:9]*durationTest[,8])
dimnames(pageVisitDummiesTest)[[2]] #check the names

#test to make sure the coding is correct
testSet[1,]
pageVisitDummiesTest[1,]



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

VarNames= c("firstACCOUNT","firstCART","firstCLASS","firstDEPARTMENT", "firstHOME","firstOTHER_PAGE","firstSEARCH_RESULTS","firstSKU","firstSKUSET",    
            "secondACCOUNT","secondCART","secondCLASS","secondDEPARTMENT","secondHOME","secondOTHER_PAGE","secondSEARCH_RESULTS","secondSKU","secondSKUSET",   
            "thirdACCOUNT","thirdCART","thirdCLASS","thirdDEPARTMENT","thirdHOME","thirdOTHER_PAGE","thirdSEARCH_RESULTS","thirdSKU","thirdSKUSET",    
            "fourthACCOUNT","fourthCART","fourthCLASS","fourthDEPARTMENT","fourthHOME", "fourthOTHER_PAGE","fourthSEARCH_RESULTS","fourthSKU","fourthSKUSET",   
            "fifthACCOUNT","fifthCART", "fifthCLASS","fifthDEPARTMENT","fifthHOME","fifthOTHER_PAGE", "fifthSEARCH_RESULTS","fifthSKU","fifthSKUSET",    
            "sixthACCOUNT","sixthCART","sixthCLASS","sixthDEPARTMENT", "sixthHOME","sixthOTHER_PAGE", "sixthSEARCH_RESULTS","sixthSKU","sixthSKUSET",    
            "seventhACCOUNT","seventhCART","seventhCLASS","seventhDEPARTMENT","seventhHOME","seventhOTHER_PAGE","seventhSEARCH_RESULTS","seventhSKU","seventhSKUSET",  
            "eighthACCOUNT","eighthCART","eighthCLASS","eighthDEPARTMENT","eighthHOME", "eighthOTHER_PAGE","eighthSEARCH_RESULTS","eighthSKU", "eighthSKUSET",   
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
#====================================================
# test adaboost: cp (improvement check), maxcompete(competing to keep), 
#xval (cross validation) and maxdepth(depth of the tree) increase
#cp = -1, maxdepth = 14,maxcompete = 3,xval = 5, iter = 70
#====================================================
#install.packages("ada")
library(ada)
control <- rpart.control(cp = -1, maxdepth = 14,maxcompete = 3,xval = 5)
gen1 <- ada(purchase ~ firstACCOUNT+firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondACCOUNT+secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdACCOUNT+thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthACCOUNT+fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthACCOUNT+fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthACCOUNT+sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhACCOUNT+seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthACCOUNT+eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
              firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
              home+other_page+search_results+sku+skuset, data = TSet, type = "gentle", control = control, iter = 70)
gen1 <- addtest(gen1, VSet[,-90], VSet[,90])
summary(gen1)
varplot(gen1)

predictionCat =predict(gen1,newdata = VSet[,-90])

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionCat)){
  if (predictionCat[i]==1 && VSet[i,90]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,90]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 1){
    FN = FN + 1
  }
}

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.755184 more
recall = TP/(TP+FN)               #0.4053563 more
precision = TP/(TP+TN)            #0.1417423 more

#==========================================================
# test k-nearest neighbour: kernel = rectangular, second distance, but with more neighbors (75 rather than 7)
#==========================================================
#install.packages("kknn")
library(kknn)
fit.kknn <- kknn(purchase ~ firstACCOUNT+firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
                   secondACCOUNT+secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
                   thirdACCOUNT+thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
                   fourthACCOUNT+fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
                   fifthACCOUNT+fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
                   sixthACCOUNT+sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
                   seventhACCOUNT+seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
                   eighthACCOUNT+eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
                   firstDur+secondDur+ThirdDur+ FourthDur+FifthDur+SixthDur+SeventhDur+EighthDur+account+cart+classProd+department+     
                   home+other_page+search_results+sku+skuset, k=75, TSet, VSet,kernel = "rectangular", distance = 1)

predictionResult = predict(fit.kknn, VSet)
predictionCat = as.numeric(predictionResult> 0.5)

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionResult)){
  if (predictionCat[i]==1 && VSet[i,90]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,90]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 1){
    FN = FN + 1
  }
}

#less accurate, but high recall and precision than ada-boost, even more than other kernels and distances
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7432226  more accuracy
recall = TP/(TP+FN)               #0.2416418 less recall
precision = TP/(TP+TN)            #0.08575624 less precise


#====================================================
# test ensemble back in excel but save them in a file here
#====================================================
# save adaboost validation set
MyData = data.frame(cbind(predictionCat,VSet[,90]))
write.csv(MyData, file = "validResDurationFeature.csv",row.names=FALSE)

#Logistic Regression test with all the variables
#=============================================
model = glm(purchase ~ firstACCOUNT+firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondACCOUNT+secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdACCOUNT+thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthACCOUNT+fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthACCOUNT+fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthACCOUNT+sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhACCOUNT+seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthACCOUNT+eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
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
  if (predictionCat[i]==1 && VSet[i,90]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,90]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 1){
    FN = FN + 1
  }
}

accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7460165
recall = TP/(TP+FN)               #0.324
precision = TP/(TP+TN)            #0.115


#Logistic Regression test with all the variables
#=============================================
model = glm(purchase ~ firstACCOUNT+firstCART+firstCLASS+firstDEPARTMENT+ firstHOME+firstOTHER_PAGE+firstSEARCH_RESULTS+firstSKU+firstSKUSET+    
              secondACCOUNT+secondCART+secondCLASS+secondDEPARTMENT+secondHOME+secondOTHER_PAGE+secondSEARCH_RESULTS+secondSKU+secondSKUSET+   
              thirdACCOUNT+thirdCART+thirdCLASS+thirdDEPARTMENT+thirdHOME+thirdOTHER_PAGE+thirdSEARCH_RESULTS+thirdSKU+thirdSKUSET+    
              fourthACCOUNT+fourthCART+fourthCLASS+fourthDEPARTMENT+fourthHOME+ fourthOTHER_PAGE+fourthSEARCH_RESULTS+fourthSKU+fourthSKUSET+   
              fifthACCOUNT+fifthCART+ fifthCLASS+fifthDEPARTMENT+fifthHOME+fifthOTHER_PAGE+ fifthSEARCH_RESULTS+fifthSKU+fifthSKUSET+    
              sixthACCOUNT+sixthCART+sixthCLASS+sixthDEPARTMENT+ sixthHOME+sixthOTHER_PAGE+ sixthSEARCH_RESULTS+sixthSKU+sixthSKUSET+    
              seventhACCOUNT+seventhCART+seventhCLASS+seventhDEPARTMENT+seventhHOME+seventhOTHER_PAGE+seventhSEARCH_RESULTS+seventhSKU+seventhSKUSET+  
              eighthACCOUNT+eighthCART+eighthCLASS+eighthDEPARTMENT+eighthHOME+ eighthOTHER_PAGE+eighthSEARCH_RESULTS+eighthSKU+ eighthSKUSET+   
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
for (i in 1:length(predictionCat)){
  if (predictionCat[i]==1 && VSet[i,90]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,90]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 1){
    FN = FN + 1
  }
}

#the best so far
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.7356703191 more
recall = TP/(TP+FN)               #0.03790135717 more
precision = TP/(TP+TN)            #0.01358889153 more



#Logistic Regression test with all the variables: Regularized version
#=============================================
#Best model type is: 2 
#Best cost is: 0.01 
#Best accuracy is: 0.74469 

library("LiblineaR")
# Center and scale data
s=scale(TSet[,-90],center=TRUE,scale=TRUE)
s[which(is.nan(s))] = 0

bestCost=0.01
bestAcc=0.74469 
bestType=2


# Re-train best model with best cost value.
m=LiblineaR(data=s,target=TSet[,90],type=bestType,cost=bestCost,bias=TRUE,verbose=FALSE)

# Scale the test data
s2=scale(VSet[,-90],attr(s,"scaled:center"),attr(s,"scaled:scale"))
s2[which(is.nan(s2))] = 0

# Make prediction
pr=FALSE
if(bestType==0 | bestType==7) pr=TRUE

p=predict(m,s2,proba=pr,decisionValues=TRUE)

# Display confusion matrix
res=table(p$predictions,VSet[,90])
print(res)

predictionCat = p$predictions

#calculating confusion matrix
TP = 0
TN = 0
FP = 0
FN = 0
for (i in 1:length(predictionCat)){
  if (predictionCat[i]==1 && VSet[i,90]== 1){
    TP = TP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 0){
    TN = TN + 1
  }
  if (predictionCat[i]==1 && VSet[i,90]== 0){
    FP = FP + 1
  }
  if (predictionCat[i]==0 && VSet[i,90]== 1){
    FN = FN + 1
  }
}

#less accurate, but high recall and precision than ada-boost
accuracy = (TP+TN)/(TP+TN+FP+FN)  #0.735888593 (more than before)
recall = TP/(TP+FN)               #0.02763985435
precision = TP/(TP+TN)            #0.009906863617

