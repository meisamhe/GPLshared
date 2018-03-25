#=============================================================================
#           Testing simple Kalman Filter on the Bid Data
#=============================================================================
#==============================================
# clean the space
#==============================================
rm(list=ls(pattern="^tmp"))
rm(list=ls())

#install.packages("dlm")
library(dlm)
require(mvtnorm)
library(foreach) # for Parallel loop
library(doSNOW) # for parallelization
cl=makeCluster(4)
registerDoSNOW(cl)

#==============================================
# Reading bid Data: File reading
#==============================================
auctionFilePath ="C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/auction.csv"
auctionDocWordFilePath ="C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/AuctionDocWordMatrix.csv"
auctionCharLinePath ="C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/mapAuctionIDLineNumber.csv"
auctionSeqIDPath ="C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/AuctionSequenceID.csv"
auctionProfilePath ="C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/AuctionProfile.csv"
biddersProfilePath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/CleanedData/BiddersProfile.csv"

bidsDF = read.csv(file=auctionFilePath,head=TRUE,sep=",")
auctionDocWord = read.csv(file=auctionDocWordFilePath,head=FALSE,sep=",")
auctionCharLine = read.csv(file=auctionCharLinePath,head=FALSE,sep=",")
auctionSeqID  = read.csv(file=auctionSeqIDPath,head=FALSE,sep=",")
auctionProfile  = read.csv(file=auctionProfilePath,head=TRUE,sep=",")
biddersProfile  = read.csv(file=biddersProfilePath,head=TRUE,sep=",")

#==============================================
# Building Data Matrixes
#==============================================

bidsFull = data.matrix(bidsDF)   #change from data from to matrix
bidIndx = list()                 #list of index of bids and the corresponding index in the array
curBidID = 0                     # to keep the ID of the currend auction and compare wheather new is created
AuctionList =list()              # list of auctions, in which each auction is list of bids
curbidList = list()
BidderPrimaryKey = list()        # the primary key consists of ID+Score 
NumberBidder = list()            # for each point in time counts the count of bidders
NumberBidderAuction = list()
maxBid = list()
maxBidList = list()             # keeps maximum number of bids to this points
bidderDirectory = list()        # it is a hash of ID to number
invertedBidderDirectory = list()        # keeps track of which bidder entered at what time (i.e. Bidder ID)
bidderIndex = list()
bidderIndexList = list()        # at each point in time the number of bidder who bidds (like a dummy variable)
auctionIDList = list()          # to keep the list of auctions' key


for (i in 1:nrow(bidsFull)){#
  if (!(paste(bidsDF[i,3]) %in% names(bidderDirectory))){ #+1 to make sure that it starts with 1
    bidderDirectory[paste(bidsDF[i,3])]=length(bidderDirectory)+1
    invertedBidderDirectory[length(invertedBidderDirectory)+1]=paste(bidsDF[i,3])
  }
  if (bidsFull[i,1]!=curBidID){
    auctionIDList[length(auctionIDList)+1]=bidsFull[i,1]
    if (i>1){
      AuctionList[length(AuctionList)+1]=list(rev(as.numeric(curbidList)))           #because the order is reverse
      NumBidders=as.numeric(NumberBidder)
      NumberBidderAuction[length(NumberBidderAuction)+1] = list((max(NumBidders)+1)-rev(NumBidders))
      bidderIndexList [length(bidderIndexList)+1]=list(rev(as.numeric(bidderIndex))) 
    }
    curbidList = list()
    BidderPrimaryKey = list()
    NumberBidder = list()
    bidderIndex = list()
    curbidList[length(curbidList)+1]=bidsFull[i,2]
    BidderPrimaryKey[length(BidderPrimaryKey)+1] = bidsFull[i,3]
    bidderIndex[length(bidderIndex)+1]= bidderDirectory[paste(bidsDF[i,3])]
    NumberBidder[length(NumberBidder)+1] = 1
    curBidID = bidsFull[i,1]                    #assign new ID
  }else{
    curbidList[length(curbidList)+1]=bidsFull[i,2]
    bidderIndex[length(bidderIndex)+1]= bidderDirectory[paste(bidsDF[i,3])]
    if (!(bidsFull[i,3] %in% BidderPrimaryKey)){ #if this is a new entrant then update the number of bidders
      BidderPrimaryKey[length(BidderPrimaryKey)+1] = bidsFull[i,3]
      NumberBidder[length(NumberBidder)+1] = length(BidderPrimaryKey)
    }else{
      NumberBidder[length(NumberBidder)+1] = length(BidderPrimaryKey)
    }
  }
}

# build maximum of bid until this point
for (i in 1:length(AuctionList)){
  curbidList = AuctionList[[i]]
  maxBid = list()
  maxBid[1] = 0
  for (t in 2:length(curbidList)){  #maximum until the previous moment
    maxBid[t] = max(curbidList[1:(t-1)])
  }
  maxBidList[length(maxBidList)+1] = list(as.numeric(maxBid))
}

# plot(AuctionList[[6]])

#============================================
# Auction(Doc)-Word Characteristic of Auction (Auction's cross sectional Data for LDA)
#=============================================
aN =length(AuctionList)  #total number of auctions
auctionDocWordData = matrix(rep(0,aN*(ncol(auctionDocWord))),nrow = aN)  #reason for +3 extra auction profile
auctionDocWordDictionary = auctionCharLine[,2]
names(auctionDocWordDictionary) <- auctionCharLine[,1]

auctionNumBidders = auctionProfile[,2]
auctionNumBids = auctionProfile[,3]
auctionDuration = auctionProfile[,4]
names(auctionNumBidders) <- auctionProfile[,1]
names(auctionNumBids) <- auctionProfile[,1]
names(auctionDuration) <- auctionProfile[,1]
ZauctionProfile = matrix(rep(0,aN*3),ncol=3)


options("scipen"=100)
#auctionSeqID[[1]][2] %in% names(auctionDocWordDictionary)
for (i in 1:aN){
  auctionID = paste(auctionSeqID[[1]][i])
  if (auctionID %in% names(auctionDocWordDictionary)){
    auctionLabel = auctionDocWordDictionary[auctionID]
    auctionDocWordData[i,] = c(as.numeric(auctionDocWord[auctionLabel,])) 
    ZauctionProfile[i,] = c(auctionNumBidders[auctionLabel],
                            auctionNumBids[auctionLabel],auctionDuration[auctionLabel])
  }else{
    auctionDocWordData[i,] = 1
    ZauctionProfile[i,] = 1
  }

}

#=======================================================
# Run factor Analysis to only select 50 features: Didn't work, it makes LDA very slow
#=======================================================

#install.packages("GPArotation")
# library(GPArotation)
# library(psych)
# fit <- principal(auctionDocWordData, nfactors=50, rotate="varimax") #error of standard Deviation = 0
# auctionWDfactors = matrix(as.integer(100*(fit$score+abs(min(fit$score)))),ncol=50) #only keep up until 2 digits

#======================================
# Build bidders' cross sectional data for DP
#======================================
I = length(bidderDirectory)
ZbiddersProfile = matrix(rep(0,I*6),ncol=6) #[I * 6]

# first create a hash table for each variable
feedbackScore = biddersProfile[,2]
BidsNow = biddersProfile[,3]      #bids on current Item
toalBids30 = biddersProfile[,4]   #total bids in the last 30 days
itemBidsOn = biddersProfile[,5]   #number of items that the bidder had bid on
bidActivityCurSeller = biddersProfile[,6]   #number of bids send for the current seller
categoryBidedOn= biddersProfile[,7]   #number of categories the current bidders has bided on

names(feedbackScore) <- biddersProfile[,1]
names(BidsNow) <- biddersProfile[,1]
names(toalBids30) <- biddersProfile[,1]
names(itemBidsOn) <- biddersProfile[,1]
names(bidActivityCurSeller) <- biddersProfile[,1]
names(categoryBidedOn) <- biddersProfile[,1]

missingList = list()
for (i in 1:I){
  currentID = paste(invertedBidderDirectory[i])
  if (currentID %in% names(feedbackScore)){
    ZbiddersProfile[i,] = c(feedbackScore[paste(currentID)],BidsNow[currentID],
                            toalBids30[currentID],itemBidsOn[currentID],
                            bidActivityCurSeller[currentID],categoryBidedOn[currentID])
  }else{
    missingList[length(missingList)+1] = i
  }
}
#replace four missing data with mean
meaZbiddersProfile = apply(ZbiddersProfile,2,mean)
ZbiddersProfile[as.integer(missingList),] = meaZbiddersProfile

#=========================================================
# Parameters definitions
#=========================================================
# Defining individual level parameters
alpha = rep(-0.2,I)      #[I*1]
beta = rep(-0.1,I)       #[I*1]
delta = rep(1.1,I)       #[I*1]
rho   = rep(0.2,I)       #[I*1]

aN =length(AuctionList)  #total number of auctions
sN = 1000                # number of samples to be taken

#=======================================
# for the bids FFBS
#=======================================

#set variance of observation and state equation
varObs  = rep(2,aN)      # [aN*1] vector of observation variance
varState  = rep(2,aN)      # [aN*1] vector of observation variance

#set the model non-state parameters gammai = drift, and tau
tau = rep(1.2,aN)
drift = rep(5,aN)

# initial state
m0 = rep(3,aN)

#=======================================
# for the number Of bidders FFBS
#=======================================

aN =length(AuctionList)  #total number of auctions

#parameters of updating the number of bidders based on the time remained
eta = rep(0.2,aN)

#set variance of observation and state equation
varObsN = rep(2,aN)
varStateN = rep(2,aN)

#set the model non-state parameters nu: drift (poisson rate of enterance)
driftN = rep(1.5,aN)
m0N = rep(3,aN) # initial state


#=======================================
# for the valuation FFBS
#=======================================

varObsValue= rep(3,aN)
varStateValue = rep(3,aN)
m0Value = rep(3,aN)


#=======================================================
# Run LDA to benchmark
#=======================================================
# running LDA
library(topicmodels)
AuctionParameters = cbind(100*(tau+abs(max(tau))),100*(drift+abs(max(drift))),100*(eta+abs(max(eta))),
                          100*(driftN+abs(max(driftN))))
k = 50
auctionCSDataLDA = matrix(as.integer(cbind(auctionDocWordData,ZauctionProfile,AuctionParameters)),nrow = nrow(ZauctionProfile))
control_LDA_VEM <- list(estimate.alpha = TRUE, alpha = 50/k, estimate.beta = TRUE,
                        verbose = 1, prefix = tempfile(), save = 0, keep = 0,
                        seed = as.integer(Sys.time()), nstart = 1, best = TRUE,
                        var = list(iter.max = 500, tol = 10^-6),
                        em = list(iter.max = 1000, tol = 10^-4),
                        initialize = "random")
#lda = LDA(x = docTermMatrix, k, method = "VEM", control = control_LDA_VEM , model = NULL)
lda = LDA(x = auctionCSDataLDA, k, method = "VEM", control = control_LDA_VEM , model = NULL)
sum(lda@loglikelihood)   # because it gives likelihood for each individual
#lda_inf <- posterior(lda, docTermMatrix)
lda_inf <- posterior(lda, auctionCSDataLDA)
#lda_inf$topics

#===========================================
# prepare result of auction LDA for auction HB
#===========================================
auctionClusterNumbers = apply(lda_inf$topics,1,which.max)
auctionClusterHistogram = list()
auctionClusterDictionary = list()
maxAuctionCluster = 0
for (i in 1:length(auctionClusterNumbers)){
  curCluster = auctionClusterNumbers[i]
  if (paste(auctionClusterNumbers[i]) %in% names(auctionClusterHistogram)){
    auctionClusterHistogram[paste(auctionClusterNumbers[i])] = 
      as.numeric(auctionClusterHistogram[paste(auctionClusterNumbers[i])])  + 1
    }else{
      auctionClusterHistogram[paste(auctionClusterNumbers[i])]  = 1
      maxAuctionCluster = maxAuctionCluster + 1
      auctionClusterDictionary[paste(auctionClusterNumbers[i])] = maxAuctionCluster
  }
  auctionClusterNumbers[i] = auctionClusterDictionary[paste(auctionClusterNumbers[i])]
}
#=======================================================
# calculate Coefficient of auction HB and the Likelihood contribution
#=======================================================
varCurComponent = list()
auctionPriorLL = 0
XTXauction = 0
XTYauction = 0
for (i in 1:length(auctionClusterDictionary)){  # for total number of clusters
  YauctionCur = AuctionParameters[which(auctionClusterNumbers==i),]
  if (length(YauctionCur)!=4){ # because apply does not work on one dimension
    YauctionCur = YauctionCur - apply(YauctionCur,1,mean)  # demean    
    varCurComponent[[i]] = cov(YauctionCur)+1e-10
    XauctionCur = ZauctionProfile[which(auctionClusterNumbers==i),]
  }else{
    YauctionCur = matrix(YauctionCur - mean(YauctionCur),ncol=4) # demean  
    varCurComponent[[i]] = matrix(rep(1e-10,4*4),ncol=4)
    XauctionCur = matrix(ZauctionProfile[which(auctionClusterNumbers==i),],nrow=1)
  }

  XTXcurAuctionContrib = crossprod(XauctionCur) %x% varCurComponent[[i]]
  XTYcurAuctionContrib = (varCurComponent[[i]] %*% crossprod(YauctionCur,XauctionCur))
  
  XTXauction = XTXauction + XTXcurAuctionContrib
  XTYauction = XTYauction +  XTYcurAuctionContrib
}
XTYauction = matrix(XTYauction,ncol=1)
parameterEstimate = ginv(XTXauction)%*%(XTYauction)

auctionCoeff = matrix(parameterEstimate,ncol=ncol(AuctionParameters))

#================================================
# Given Parameter Estimate, calculate log likelihood
#===============================================
for (i in 1:length(auctionClusterDictionary)){  # for total number of clusters
  YauctionCur = AuctionParameters[which(auctionClusterNumbers==i),]
  if (length(YauctionCur)!=4){ # because apply does not work on one dimension
    YauctionCur = YauctionCur - apply(YauctionCur,1,mean)  # demean    
    XauctionCur = ZauctionProfile[which(auctionClusterNumbers==i),]
    varCurComponent[[i]] = cov(YauctionCur - XauctionCur%*%auctionCoeff)+1e-10
  }else{
    YauctionCur = matrix(YauctionCur - mean(YauctionCur),ncol=4) # demean  
    XauctionCur = matrix(ZauctionProfile[which(auctionClusterNumbers==i),],nrow=1)
    varCurComponent[[i]] = matrix(rep(1e-10,4*4),ncol=4)
  }
  for (j in 1:nrow(YauctionCur)){
    auctionPriorLL = auctionPriorLL + dmvnorm(YauctionCur[j,], mean = XauctionCur[j,]%*%auctionCoeff, 
                                              sigma = make.positive.definite(varCurComponent[[i]]), 
                                              log = TRUE)
  }
}


#========================================================================================================
# Run DP to test=
#========================================================================================================
#ZbiddersProfile
biddersParameters=cbind(alpha,beta,delta,rho)
vdpmm_data = cbind(ZbiddersProfile,biddersParameters)     #[10757 x 10] where 10 = 6 data + 4 parameters
# less number of iterations to speed up
options=list(K = 50, infinite = 1,verbose=0,maxits=50,minits=10,eps=0.1)

#running in parallel
#divide into 4 sets and run in parallel
breakDown = list(c(1:3000),c(3000:6000),c(6000:9000),c(9000:nrow(vdpmm_data)))


# to use parallel loop
assignmentList= foreach(i=1:4, .combine=rbind, .packages = c("MASS","corpcor","Matrix"))  %dopar%{   # be aware of function scope problem .export=c("fccat")
  result = vdpmm(vdpmm_data[breakDown[[i]],], options);
  #probMatrix = result$gammas
  assignment = result$assign
  
  list(input=breakDown[[i]],assignment=assignment)
}
#combine back the assignments
bidderAssignedCluster = rep(0,nrow(vdpmm_data))
bidderAssignedCluster[c(assignmentList[[1]],assignmentList[[2]],
                        assignmentList[[3]],assignmentList[[4]])] = c(assignmentList[[5]],50+assignmentList[[6]],
                                                                      100+assignmentList[[7]],150+assignmentList[[8]])

#===========================================
# prepare result of auction LDA for bidders HB
#===========================================
bidderClusterNumbers = bidderAssignedCluster
bidderClusterHistogram = list()
bidderClusterDictionary = list()
maxBidderCluster = 0
for (i in 1:length(bidderClusterNumbers)){
  curCluster = bidderClusterNumbers[i]
  if (paste(bidderClusterNumbers[i]) %in% names(bidderClusterHistogram)){
    bidderClusterHistogram[paste(bidderClusterNumbers[i])] = 
      as.numeric(bidderClusterHistogram[paste(bidderClusterNumbers[i])])  + 1
  }else{
    bidderClusterHistogram[paste(bidderClusterNumbers[i])]  = 1
    maxBidderCluster = maxBidderCluster + 1
    bidderClusterDictionary[paste(bidderClusterNumbers[i])] = maxBidderCluster
  }
  bidderClusterNumbers[i] = bidderClusterDictionary[paste(bidderClusterNumbers[i])]
}
#=======================================================
# calculate Coefficient of bidders HB and the Likelihood contribution
#=======================================================
varCurComponentBidder = list()
bidderPriorLL = 0
XTXbidder = 0
XTYbidder = 0
bidderPriorLL = 0
for (i in 1:length(bidderClusterDictionary)){  # for total number of clusters
  YbidderCur = biddersParameters[which(bidderClusterNumbers==i),]
  if (length(YbidderCur)!=6){ # because apply does not work on one dimension
    YbidderCur = YbidderCur - apply(YbidderCur,1,mean)  # demean    
    varCurComponentBidder[i] = list(cov(YbidderCur)+1e-10)
    XbidderCur = ZbiddersProfile[which(bidderClusterNumbers==i),]
  }else{
    YbidderCur = matrix(YbidderCur - mean(YbidderCur),ncol=4) # demean  
    varCurComponentBidder[i] = list(matrix(rep(1e-10,4*4),ncol=4))
    XbidderCur = matrix(ZbiddersProfile[which(auctionClusterNumbers==i),],nrow=1)
  }
  
  XTXcurBidderContrib = crossprod(XbidderCur) %x% varCurComponentBidder[[i]]
  XTYcurBidderContrib = (varCurComponentBidder[[i]] %*% crossprod(YbidderCur,XbidderCur))
  
  XTXbidder = XTXbidder + XTXcurBidderContrib
  XTYbidder = XTYbidder +  XTYcurBidderContrib
}
XTYbidder = matrix(XTYbidder,ncol=1)
parameterEstimate = ginv(XTXbidder)%*%(XTYbidder)

bidderCoeff = matrix(parameterEstimate,ncol=ncol(biddersParameters))

#================================================
# Given Parameter Estimate, calculate log likelihood
#===============================================
for (i in 1:length(bidderClusterDictionary)){  # for total number of clusters
  YbidderCur = biddersParameters[which(bidderClusterNumbers==i),]
  if (length(YbidderCur)!=6){ # because apply does not work on one dimension
    YbidderCur = YbidderCur - apply(YbidderCur,1,mean)  # demean    
    varCurComponentBidder[i] = list(cov(YbidderCur)+1e-10)
    XbidderCur = ZbiddersProfile[which(bidderClusterNumbers==i),]
  }else{
    YbidderCur = matrix(YbidderCur - mean(YbidderCur),ncol=4) # demean  
    varCurComponentBidder[i] = list(matrix(rep(1e-10,4*4),ncol=4))
    XbidderCur = matrix(ZbiddersProfile[which(auctionClusterNumbers==i),],nrow=1)
  }
  for (j in 1:nrow(YbidderCur)){
    bidderPriorLL = bidderPriorLL + dmvnorm(YbidderCur[j,], mean = XbidderCur[j,]%*%bidderCoeff, 
                                              sigma = make.positive.definite(varCurComponentBidder[[i]]), 
                                              log = TRUE)
  }
}


#================================================================
# Expected Likelihood for bids, number of bidders, valuation MCEM
# basically I take sample of 1000 points and calculte LL and get average
# I had to use sum (pi*log), because computationally otherwise will result in underflow
#================================================================


#==============================================
# Running FFBS on Auction bid data using R dlm package
#==============================================
# run on auction i
i = 1
latentbidM_1 = list()
latentbidV_1 = list()

expLLBids = 0

for (i in 1:aN){
  bids = AuctionList[[i]]
  T = length(bids)
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = c(m0[i],1), C0 = diag(c(1e+07,0)))
  
  FO = dlmFilter(cbind(bids,rep(0,length(bids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  
  #Ct: the variance of the first state
  Ct = rep(0,T+1)
  for (t in 1:(T+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
  #plot(mt)
  
  latentbidM_1[i] = list(c(m0temp,mttemp[1:(T-1)]))#a moment before
  latentbidV_1[i] = list(c(C0temp,Cttemp[1:(T-1)]))#a moment before
  
  #===========================================================
  # calculate Expected Likelihood for the Bids
  #===========================================================
  sample = matrix(rep(0,sN*(T+1)),ncol=T+1)        #T+1 
  #prob (X(1:T)): based on the state distribution to take expectation
  probX  =  matrix(rep(0,sN*(T+1)),ncol=T+1) 
  Nmean=SO$s[,1]
  Nvar = Ct
  for (t in 1:(T+1)){
    sample[,t]=rnorm(sN, mean = Nmean[t], sd = sqrt(Nvar[t]))
    probX[,t] =  dnorm(sample[,t], 
                       mean = Nmean[t], sd =sqrt(Nvar[t]))
  }
  probX = apply(probX,1,prod)
  
  # log (P(Y(1:T)|X(1:T)))
  LPY1TgX1T = dnorm(t(matrix(rep(bids,sN),ncol=sN)), 
                    mean = sample[,2:(T+1)],
                    sd = sqrt(varObs[i]), log = TRUE)
  
  # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
  LPXTXT_1 =  dnorm(sample[,1:T], 
                    mean = sample[,2:(T+1)]+drift[i],
                    sd = sqrt(varState[i]), log = TRUE)
  if (T==1){
    expLLBids = log(sum(exp(sum(LPY1TgX1T)+ sum(LPXTXT_1))*probX))
  }else{
    expLLBids = log(sum(exp(apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum))*probX))
  }

}

#==============================================
# Running FFBS on number of bidders in each auction
#==============================================
# run on auction i
i = 1
latentNM_1 = list()
latentNV_1 = list()
Tauction = list()

expLLNBidders = 0

for (i in 1:aN){
  nbidrsAuction = NumberBidderAuction[[i]]
  T = length(nbidrsAuction)
  Tauction[length(Tauction)+1] = T
  
  #time to the end
  remainT = T:1
  
  #data to be filtered
  toFilterData = nbidrsAuction - eta[i]*remainT
  
  dlmstubN=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObsN[i],0,0,0),ncol=2)
               , GG = matrix(c(1,0,driftN[i],1),ncol=2), W = matrix(c(varStateN[i],0,0,0),ncol=2),
               m0 = c(m0N[i],1), C0 = diag(c(1e+07,0)))
  
  FON = dlmFilter(cbind(toFilterData,rep(0,length(toFilterData))),dlmstubN)
  FiltStateMN = FON$m[,1]         # m: filtered state
  SaheadFrcstN = FON$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SON = dlmSmooth(FON$m[-1,],dlmstubN)
  
  #Ct: the variance of the first state for number of bidders
  CtN = rep(0,T+1)
  for (t in 1:(T+1)){
    CtN[t]=SON$U.S[[t]][1] * (SON$D.S[t,1])**2 * t(SON$U.S[[t]][1])
  }
  C0Ntemp = CtN[1]
  CtNtemp = CtN[-1]
  m0Ntemp = SON$s[1,1]
  mtNtemp = SON$s[-1,1]
  
  #plot(mtN)
  
  #The actual latent is sum of the change in observation equation and this latent state
  latentN = mtNtemp + eta[i]*remainT
  latentNM_1[i]= list(c(m0Ntemp,latentN[1:(T-1)]))#a moment before
  latentNV_1[i] = list(c(C0Ntemp,CtNtemp[1:(T-1)]))#a moment before
  
  #===========================================================
  # calculate Expected Likelihood for the number of Bidders
  #===========================================================
  sample = matrix(rep(0,sN*(T+1)),ncol=T+1)        #T+1 
  #prob (X(1:T)): based on the state distribution to take expectation
  probX  =  matrix(rep(0,sN*(T+1)),ncol=T+1) 
  Nmean=SON$s[,1]
  Nvar = CtN
  for (t in 1:(T+1)){
    sample[,t]=rnorm(sN, mean = Nmean[t], sd = Nvar[t]) 
    probX[,t] =  dnorm(sample[,t], 
                      mean = Nmean[t], sd = sqrt(Nvar[t]))
  }
  probX = apply(probX,1,prod)
  
  # log (P(Y(1:T)|X(1:T)))
  LPY1TgX1T = dnorm(t(matrix(rep(toFilterData,sN),ncol=sN)), 
                    mean = sample[,2:(T+1)],
                    sd = sqrt(varObsN[i]), log = TRUE)
  
  # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
  LPXTXT_1 =  dnorm(sample[,1:T], 
                    mean = sample[,2:(T+1)]+driftN[i],
                    sd = sqrt(varStateN[i]), log = TRUE)
  if (T==1){
    expLLNBidders = log(sum(exp(sum(LPY1TgX1T)+ sum(LPXTXT_1))*probX))
  }else{
    expLLNBidders = log(sum(exp(apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum))*probX))
  }
}


#===============================================================
#    Build the RHS observatin of observation equation of valuation
#================================================================
LogAList = vector()
logA = vector()
# build the Right Hand Side of Observation equation
# to use parallel loop
#LogAList[length(LogAList)+1] =
LogAList= foreach(i=1:length(AuctionList), .combine=rbind, .packages = c("MASS","corpcor","Matrix"))  %dopar%{   # be aware of function scope problem .export=c("fccat")
  #print(paste('i=',i,"\n"))
  curbidList = AuctionList[[i]]
  bidderIndex = bidderIndexList[[i]]
  maxBid = maxBidList[[i]]
  T = length(curbidList)
  logA = rep(0,T)
  for (t in 1:T){  #maximum until the previous moment
    #print(paste('t=',t,"\n"))
    alphajt = alpha[bidderIndex[[t]]]
    betajt  = beta[bidderIndex[[t]]]
    deltajt = delta[bidderIndex[[t]]]
    rhojt   = rho[bidderIndex[[t]]]
    maxAllBid = 100*max(maxBid)
    
    valuationObserved <- function(x) {
      #print(paste('entered function with:',x,"\n"))
      ttjt = x;
      weight = dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]));
      numerator = 
        as.numeric(
          pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
            ttjt*dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
            alphajt*(pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**latentNM_1[[i]][t])+
            alphajt*ttjt*
            (pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(latentNM_1[[i]][t]-1))*
            dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
            (alphajt + betajt)*ttjt* (pnorm(ttjt, mean = latentbidM_1[[i]][t],
                                            sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(latentNM_1[[i]][t]-1))*
            dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)
        ) ; 
      denominator = (
        dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
          betajt*dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)*
          (pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(latentNM_1[[i]][t]-1)) 
      );
      denominator = (denominator + denominator)/2;
      
      if (is.null(denominator)){
        return(1e-9);
      }
      if (is.infinite(denominator)){
        return(1e-9);
      }
      
      At=numerator/denominator
      At = min(At,maxAllBid)
      At = weight*At;
      
      # abs because it cannot be negative from programming stand point (before convergance)
      # also drift is captured at observation equation level 
      
      #put condition to make sure I don't hit infinity
      # this may be good condition for identification as the market is competitive
      # an alternative approach is to find starting value, or threshold of buyer
      if ((is.nan (At)) || (is.infinite (At))){
        At = 1e-18;
      }  
      #print(paste(x,At,'\n'))
      return (sum(At+1e-9));
    }
    
    #ttjt = rnorm(1, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]))
    #valuationObserved(ttjt)
    
    #latentNM_1
    #latentNV_1: for simplicity for now it is ignored
    # basically it starts at 1, and we can allow 2 times misperception
    
    Mu1b <- Vectorize(valuationObserved, "x") 
    expected_valuation  = integrate(Mu1b, lower=0, upper=2*max(maxBid),abs.tol = 1,
                                    rel.tol=1,stop.on.error=FALSE,subdivisions=15) 
    
    #integrate(valuationObserved, lower = 0 ,  5*max(maxBid)) 
    
    #quadrature(valuationObserved, 0, 5*max(maxBid))
    #integrate(valuationObserved, lower = 0 , upper =0) 
    
    # value to be used in the valuation state space (to make sure the logarithm does not hit -Inf)
    logA[t] =log(abs(expected_valuation$value-rhojt*maxBid[t])+1e-5)
  }
  list(as.numeric(logA))
}


#================================================================
# Running FFBS on individual valuation data using R dlm package
#================================================================
latentVjtM_1 = list()
latentVjtV_1 = list()

#i auction
# t time
#logA(tt[i,t]) =log(v[i,t])+log(ep[i,t])
#log(v[i,t]) = log(v[i,t-1])+log(delta[i])+log(mu[i,t])

#Tauction[i]
expLLValuation = 0

for (i in 1:length(AuctionList)){
  logA = LogAList[[i]]
  
  T = Tauction[[i]]

  #data to be filtered
  
  #drift of the observation equation
  
  #create data of log(delta(i)) for a given auction
  logDeltajt = rep(0,T)
  bidderIndex = bidderIndexList[[i]]
  for (t in 1:T){ 
    logDeltajt[t] = log(delta[bidderIndex[[t]]])
  }
  # move to the observation equation for simplicity
  toFilterData = logA - logDeltajt

  dlmstubValue=dlm(FF =1, V = varObsValue[i],
               GG = 1, W = varStateValue[i],
               m0 = m0Value[i], C0 = 1e+07)
  
  FOValue = dlmFilter(toFilterData,dlmstubValue)
  FiltStateMValue = FOValue$m        # m: filtered state
  SaheadFrcstValue = FOValue$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SOValue = dlmSmooth(FOValue$m[-1],dlmstubValue)
  
  #Ct: the variance of the first state for number of bidders
  CtValue = rep(0,T+1)
  for (t in 1:(T+1)){
    CtValue[t]=SOValue$U.S[[t]][1] * (SOValue$D.S[t,1])**2 * t(SOValue$U.S[[t]][1])
  }
  C0Valuetemp = CtValue[1]
  CtValuetemp = CtValue[-1]
  m0Valuetemp = SOValue$s[1]
  mtValuetemp = SOValue$s[-1]
  
  #plot(mtN)
  
  #The actual latent is sum of the change in observation equation and this latent state 
  latentVjtM_1[i] = list(c(m0Valuetemp,mtValuetemp[1:(T-1)]))#a moment before
  latentVjtV_1[i] = list(c(C0Valuetemp,CtValuetemp[1:(T-1)]))#a moment before
  
  #===========================================================
  # calculate Expected Likelihood for the Bids
  #===========================================================
  sample = matrix(rep(0,sN*(T+1)),ncol=T+1)        #T+1 
  #prob (X(1:T)): based on the state distribution to take expectation
  probX  =  matrix(rep(0,sN*(T+1)),ncol=T+1) 
  Nmean=SOValue$s
  Nvar = CtValue
  for (t in 1:(T+1)){
    sample[,t]=rnorm(sN, mean = Nmean[t], sd = sqrt(Nvar[t]))
    probX[,t] =  dnorm(sample[,t], 
                       mean = Nmean[t], sd = sqrt(Nvar[t]))
  }
  probX = apply(probX,1,prod)
  
  # log (P(Y(1:T)|X(1:T)))
  LPY1TgX1T = dnorm(t(matrix(rep(toFilterData,sN),ncol=sN)), 
                    mean = sample[,2:(T+1)],
                    sd = sqrt(varObsValue[i]), log = TRUE)
  
  # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
  LPXTXT_1 =  dnorm(sample[,1:T], 
                    mean = sample[,2:(T+1)],
                    sd = sqrt(varStateValue[i]), log = TRUE)
  
  if (length(LPXTXT_1) != nrow(sample)){ #when T>1
    expLLValuation = log(sum(exp(apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum))*probX) )
  }else{
    expLLValuation = log(sum(exp(sum(LPY1TgX1T)+ sum(LPXTXT_1))*probX) )
  }  
}

#==================================================
# Monte Carlo Expectation Maximization used
#==================================================

LL = expLLNBidders + expLLBids + expLLValuation + auctionPriorLL + bidderPriorLL
# return also assignments, the HB estimates and variance of components
# varCurComponent
# auctionClusterNumbers
# auctionCoeff
# bidderClusterNumbers
#varCurComponentBidder
#bidderCoeff
    