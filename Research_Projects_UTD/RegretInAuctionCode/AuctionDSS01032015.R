#=============================================================================
#           Testing simple Kalman Filter on the Bid Data
#=============================================================================

#=====================================
# Libraries required
#=====================================
require(corpcor)
require(MASS)
require(Matrix)
#install.packages("dlm")
library(dlm)
require(mvtnorm)
library(foreach) # for Parallel loop
library(doSNOW) # for parallelization
library(matrixStats)
cl=makeCluster(6)
registerDoSNOW(cl)
# running LDA
library(topicmodels)
library(mclust)


#==============================================
# clean the space
#==============================================
rm(list=ls(pattern="^tmp"))
rm(list=ls())

#==============================================================================
# Variational Bayesian for Dirichlet Process (Infinite Mixture Guassian Process)
# code by: Meisam Hejazinia (Doctoral Candidate in Marketing at University of Texas at Dallas)
# Date: 12/31/2014
# Based on the model by Blei and Jordan 2005
# W.D.Penny, Variational Bayesian for d-dimensional Gaussian Mixture Models
# the code has similar structure to MATLAB code written by: Jacob Eisenstein shared on Gits based on GPL
#==============================================================================
# the functions can be parallelized later at the point of for loops

#==============================================
# clean the space
#==============================================
# rm(list=ls(pattern="^tmp"))
# rm(list=ls())

#=============================================================================
# function: initialize varidation difference Dirichlet Process for Guassian Mixture
#==============================================================================

vdpmm_init = function(data,K){
  #data is a matrix of #data points x features
  num = nrow(data)
  dim = ncol (data)
  
  # initializing variational parameters: vector of probability of membership of each data item in each cluster
  gammas = matrix(runif(num*K),ncol = K) # n[num x K]
  gammas = gammas/ matrix(rep(apply(gammas,1,sum),K),ncol=K) # n[num x K]
  
  #initializing other parameters of the model
  params = list(eq_alpha = 1, #according to Blei and Jordan 2005 it is hyperparameter of beta distribution (stick breaking probability)
                beta = matrix(rep(0,K),nrow = K), # variance parameter of Gaussian mean (conjugate of Gamma) according to Penny 2001
                a = matrix(rep(0,K),nrow = K), # First parameter of Wishart density Penny 2001
                mean = matrix(rep(0,K*dim),nrow = K), #[K x dim] mean of each cluster at each feature Penny 2001
                B = array(rep(0,dim*dim*K),dim=c(dim,dim,K)), # [dim*dim*K] the covariance matrix of features at each cluster point
                g = matrix(rep(0,K*2),nrow = K), # [K x 2] gamma1 and gamma2 according to Blei and Jordan 2005
                ll = -Inf )# keep the likelihood
  return(list(params=params,gammas = gammas))
}

#=====================================================================================================
# Function: Maximization step of Variational Bayesian (VEM) for Dirichlet Process for Guassian Mixture Model
#=====================================================================================================
vdpmm_maximize = function(data,params,gammas){
  #setting priors
  #==========================
  D = ncol(data)
  K = length(params$a)
  a0 = D #prior on Wishart density Penny 2001
  beta0 = 1 # prior on variance of mean of Gaussian Penny 2001
  mean0 = apply(data,2,mean) # prior on mean of the clusters Penny 2001
  B0 = .1*D*cov(data)  # prior on covariance of clusters Penny 2001
  
  # defining primitives according to (16) and (17) Penny 2001
  #=================================================================
  #Ns is the density of each cluster
  Ns = apply(gammas,2,sum) # the same name in Penny 2001
  mus = matrix(rep(0,K*D),ncol=D) #initialize means of clusters to zero
  sigs = array(rep(0,D*D*K),dim=c(D,D,K)) # initialize the cov of clusters (each D*D matrix)
  mus = crossprod(gammas,data)/matrix(rep(Ns,D),ncol=D)
  
  #update variational parameters based on primitives defined above according to (19-23) of Penny (2001)
  #=================================================================
  params$g[,1] = 1 + apply(gammas,2,sum) #according to equations in section 4.1 of Blei and Jordan (2005)
  # interesting approach to calculate double sum of equations in section 4.1. of Blei and Jordan (2005), Kudos to Jacob Eisenstein
  params$g[,2] = params$eq_alpha + rev(cumsum(rev(apply(gammas,2,sum)))) - apply(gammas,2,sum)
  params$beta = Ns + beta0 #equation 21 Penny (2001)
  params$a = Ns + a0 #equation 23 Penny (2001)
  params$mean = # equation 21 of Penny (2001)
    (matrix(rep(Ns,D),ncol=D)*mus + beta0 * t(matrix(rep(mean0,length(Ns)),ncol=length(Ns))))/matrix(rep(Ns+beta0,D),ncol=D)
  
  # K-L divergance based on K-L Divergence of Normal, Gamma, Dirichlet and Wishart Densities, by Penny (2001)
  # also equation 25 of Penny (2001)
  
  #===================================================================
  # KL-divergence (Kullback Leibler) , or relative entropy calculation
  #===================================================================
  #only change to refer back to Blei and Jordan, replace Dirichlet with Beta, as (Vk|Z,x)~Beta (gammak1,gammak2)
  #KL-Beta taken from Wikipedia
  #==================================
  alphap = params$g[,1]
  betap = params$g[,2]
  alpha = 1
  beta = params$eq_alpha
  
  #KL-Wishart
  #==============================
  q = params$a
  p = a0
  P = B0
  KLWishart = list()
  
  #KL-Normal
  #==============================
  KLNorm = list()
  
  for (i in 1:K){
    # sigma = sum wi*sigma**2
    diff0 = data -  t(matrix(rep(mus[i,],nrow(data)),nrow=ncol(mus)))
    diff1 = matrix(rep(sqrt(gammas[,i]),D),ncol=D)*diff0
    sigs[,,i]=crossprod(diff1) 
    #Penny (2001) equation 23 to update Bs
    diff = mus[i,] - mean0
    params$B[,,i] = sigs[,,i] + Ns[i]*beta0 * crossprod(t(diff)) /(Ns[i]+beta0)+B0
    Q = params$B
    LqQ = sum(psigamma((q[i]+1-(1:D))/2))-log(det(Q[,,i])+1e-10)+D*log(2)
    LpP = sum(psigamma((p+1-(1:D))/2))-log(det(P)+1e-10)+D*log(2) 
    multiVarGammaDp2 = pi**(D*(D-1)/4)*prod(gamma((p+1-1:D)/2))
    multiVarGammaDq2 = pi**(D*(D-1)/4)*prod(gamma((q[i]+1-1:D)/2))
    ZpP = 2**(p*D/2)*((1e-10+det(P))**(-p/2))*multiVarGammaDp2
    ZqQ = 2**(q[i]*D/2)*(det(Q[,,i])**(-q[i]/2))*multiVarGammaDq2
    KLWishart[i] = ((q[i]-D-1)/2)*LqQ - ((p-D-1)/2)*LpP - q[i]*D/2 + 
      q[i]/2*sum(diag(P%*%ginv(Q[,,i]))) + log (ZpP/(1e-10+ZqQ)+1e-10)
    muq = params$mean[i,]
    Sigq = params$B[,,i] /params$beta[i]/params$a[i]
    mup = mean0
    Sigp = B0/beta0/a0
    KLNorm[i]= 0.5*log(det(Sigp)/(det(Sigq)+1e-5)+1e-5)+
      0.5*sum(diag(Sigq%*%ginv(Sigp)))+0.5*crossprod((muq-mup),diag(c(rep(1,D)))%*%ginv(Sigp))%*%
      (muq-mup)-D/2
    
  }
  
  KLBeta = #lambda;lambda0 
    log(beta(alphap, betap)/beta(alpha,beta)+1e-10) + (alpha-alphap)*psigamma(alpha)+ (beta-betap)*psigamma(beta)+
    (alphap-alpha+betap-beta)*psigamma(alpha+beta)
  KLBeta = -sum(KLBeta) #as they are independent KL measure is simple sum
  
  KLWishart = -sum(as.numeric(KLWishart))
  
  KLNorm = -sum(as.numeric(KLNorm))
  
  kldiv = KLNorm + KLWishart+KLBeta
  return(list(params=params,kldiv=kldiv))
}
#=====================================================================================================
# Function: Expectation step of Variational Bayesian (VEM) for Dirichlet Process for Guassian Mixture Model
#=====================================================================================================
vdpmm_expectation = function (data,params,infinite,gammas){
  K = length(params$a)
  N = nrow(data)
  D = ncol(data)
  
  eq_log_Vs = rep(0,K)
  eq_log_1_Vs = rep(0,K)              # E[log(Vi)] from Blei and Jordan (2005) section 4.1
  log_gamma_tilde = matrix(rep(0,nrow(data)*K),ncol=K) # E[log(1-Vi)] from Blei and Jordan (2005) section 4.1
  log_Z_V =matrix(rep(0,N*K),nrow=N)
  weights = 1-t(apply(gammas,1,cumsum)) #q(z_n>i), where q(z_n=i) = gammas[n,i] to use Blei and Jordan (2005 weighting)
  eq_log_pi = rep(0,K)                 #for the finite scheme of Penny (2001)
  NWLiklihood = matrix(rep(0,N*K),ncol=K) #Normal wishart portion of update of gammas according to E-step of  Penny (2001)
  logGamma_tildes= rep(0,K) # equation 14 of Penny (2001)
  Ns = apply(gammas,2,sum) # the same name in Penny (2001)
  mus = crossprod(gammas,data)/matrix(rep(Ns,D),ncol=D)   #equation 17 Penny(2001)
  sigs = array(rep(0,D*D*K),dim=c(D,D,K)) # initialize the cov of clusters (each D*D matrix), equation (17), Penny (2001)
  TRGamsSigs = rep(0,K)   # used in likelihood in Penny (2001) equation 26
  
  for (i in 1:K){
    # for infinite scheme: Scheme of Blei and Jordan (2005)
    eq_log_Vs[i] = digamma(params$g[i,1]) - digamma(params$g[i,1]+params$g[i,2])
    eq_log_1_Vs[i] = digamma(params$g[i,2])- digamma(params$g[i,1]+params$g[i,2])
    #apply weighting scheme of Blei and Jordan (2005) section 4.1: E[log[1-Vi|gi]]*(q(zn>i))+E[log Vi|gi]*q(zn=i)
    log_Z_V[,i] = weights[,i] * eq_log_1_Vs[i] + gammas[,i]*eq_log_Vs[i] 
    
    # for finite scheme where g[i,2] is irrelevant: Scheme of Penny (2001)
    eq_log_pi[i] = digamma(params$g[i,1]) - digamma(sum(params$g[,1]));
    
    #Normal Wishart log likelihood by Penny (2001)
    
    #     #some sanity check of the covariance matrix
    #     curComponentB = params$B[,,i]
    #     curComponentB[is.nan(curComponentB)] = 10
    #     curComponentB[is.infinite(curComponentB)] = 10
    #     curComponentB= (curComponentB + t(curComponentB))/2
    
    params$B[,,i] = make.positive.definite(params$B[,,i]) #nearPD()
    #     print (params$B[,,i])
    #     fsh()
    
    Gamma_tildes = params$a[i]*chol2inv(chol(params$B[,,i]))
    logGamma_tildes[i]  = sum(psigamma((params$a[i]+1-(1:D))/2))-log(det(params$B[,,i])+1e-10)+D*log(2)
    NWLiklihood[,i] = 0.5*logGamma_tildes[i]-
      0.5*diag(crossprod(t(data-params$mean[i]),Gamma_tildes)%*%t(data-params$mean[i]))-D/(2*params$beta[i])
    
    # sum the two portions based on the scheme requested
    if (infinite ==1){
      log_gamma_tilde[,i] = log_Z_V[,i] +  NWLiklihood[,i]
    }else{
      log_gamma_tilde[,i] = eq_log_pi[i] +  NWLiklihood[,i]
    }
    diff0 = data -  t(matrix(rep(mus[i,],nrow(data)),nrow=ncol(mus)))
    diff1 = matrix(rep(sqrt(gammas[,i]),D),ncol=D)*diff0
    sigs[,,i]=crossprod(diff1) 
    TRGamsSigs[i] = sum(diag(Gamma_tildes*sigs[,,i]))
  }
  # to make sure that I don't face the problem of underflow
  log_gamma_tilde = pmax(log_gamma_tilde,-700)
  
  # turn back into normal scale from log scale
  gammas = exp(log_gamma_tilde)
  # normalize according to equation 15 of Penny (2001) to find actual probabilisity of segment membership
  gammas = gammas / matrix(rep(apply(gammas,1,sum)+1e-10,K),ncol=K)
  
  #==================================================================
  # likelihood: according to beta distribution of Blei and Jordan (2005) and Penny (2001)
  #==================================================================
  loglike = sum(log_Z_V) - sum(gammas*log(gammas+1e-10)) - sum(Ns)*log(2*pi+1e-10)/2 + sum(logGamma_tildes*Ns/2) - sum(Ns*TRGamsSigs/2)-
    sum(D/params$beta*Ns/2)
  
  #update the mean of beta distribution (prior) with normalization, in Jacob Eisenstein's code, it is like cooling temprature
  # in the simulated annealing algorithms, so it may be harmless
  h1 = 1
  h2 = 1
  w1 = h1 + K -1
  w2 = h2 - sum((eq_log_1_Vs[(1:length(eq_log_1_Vs)-1)]))
  params$eq_alpha = w1/w2
  
  return (list (params = params, gammas = gammas, loglike=loglike,log_gamma_tilde = log_gamma_tilde))
}
#=======================================================================================
# Main function of Variational Bayesian Dirichlet Process for Guassian Mixture
#=======================================================================================
# data = vdpmm_data[1:500,]
vdpmm = function(data,options){
  # send an empty list if you want to set default options
  # default list of options options=list(K = 50, infinite = 1,verbose=1,maxits=500,minits=10,eps=0.1)
  
  #=================================================
  #       setting the options
  #=================================================
  if (!('K' %in% names(options))){
    K = 50
  }else{
    K = options$K
  }
  if (!('infinite' %in% names(options))){
    infinite = 1
  }else{
    infinite = options$infinite
  }
  if (!('verbose' %in% names(options))){
    verbose = 1
  }else{
    verbose = options$verbose
  }
  if (!('maxits' %in% names(options))){
    maxits = 500
  }else{
    maxits = options$maxit
  }
  if (!('minits' %in% names(options))){
    minits = 10
  }else{
    minits = options$minits
  }
  if (!('eps' %in% names(options))){
    eps = 0.01
  }else{
    eps = options$eps
  }
  #=================================================
  #       initializing vdpmm
  #=================================================
  initOutput = vdpmm_init(data,K)
  params = initOutput$params
  gammas = initOutput$gammas
  numits = 2;
  score = -Inf
  score_change = Inf
  prev_score = -Inf
  #========================================================================
  # iteration until convergance (VEM): model selection based on Penny 2001
  # Coordinated Ascent: Iterating between updates of VEM
  #========================================================================
  
  while ((numits<maxits) && ((numits < minits)|| (abs(score_change) > 1e-1)) ){ #&& (prev_score<=score)
    OuTvdpmm_maximize=vdpmm_maximize(data,params,gammas)
    params = OuTvdpmm_maximize$params
    kldiv = OuTvdpmm_maximize$kldiv
    OuTvdpmm_expectation=vdpmm_expectation(data,params,infinite,gammas)
    params = OuTvdpmm_expectation$params
    gammas = OuTvdpmm_expectation$gammas
    loglike = OuTvdpmm_expectation$loglike
    log_gamma_tilde = OuTvdpmm_expectation$log_gamma_tilde
    numits = numits + 1
    score = -kldiv + loglike
    params$ll = score
    score_change = (score - prev_score)
    if ((is.infinite(score_change)) || (is.nan(score_change))){
      score_change = 50000
    }
    if (verbose == 1){
      cat('DP Iteration: ',numits,' score to maximize: ',score,' score_change:',score_change,'\n')
    }
    prev_score = params$ll
    #     cat((numits<maxits),'first\n')
    #     cat((numits < minits),'second\n')
    #     cat((score_change > 1e-4),'third\n')
  }
  assign = apply(gammas,1,which.max)
  return(list(params=params,gammas=gammas,loglik = params$ll,assign=assign))
}

#==========================================================================================================
# test: read sample data of characteristics of category 
#=====================
# sampleFilePath = 'C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/VariationalBayesian/vdpgm/testData.csv'
# num =read.csv(file=sampleFilePath,head=FALSE,sep=",")
# options=list(K = 10, infinite = 1,verbose=1,maxits=500,minits=10,eps=0.1)
# data = data.matrix(num)
# result = vdpmm(data, options);

#==========================================================================================================

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

#=============================================
# Log files to save the the HB and the current Parameters, and Likelihood
#=============================================
logFilePath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/RunLog/"
curFileIndex = 1

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
# there was  problem here before
meaZbiddersProfile = apply(ZbiddersProfile,2,mean)
ZbiddersProfile[as.integer(missingList),] = t(matrix(rep(meaZbiddersProfile,length(missingList)),ncol=length(missingList)))

#=========================================================
# Parameters definitions
#=========================================================
# Defining individual level parameters (initial value according to Ozbay and Ozbay)
alpha = rep(-6.19,I)      #[I*1]
beta = rep(-3.0,I)       #[I*1]
delta = rep(1.1,I)       #[I*1]
rho   = rep(0.2,I)       #[I*1]

aN =length(AuctionList)  #total number of auctions
sN = 100                # number of samples to be taken

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
m0 = rep(0.99,aN)

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
m0N = rep(2,aN) # initial state


#=======================================
# for the valuation FFBS
#=======================================

varObsValue= rep(3,aN)
varStateValue = rep(3,aN)
m0Value = rep(log(2),aN)

# AuctionParameters = cbind(100*(tau+abs(max(tau))),100*(drift+abs(max(drift))),100*(eta+abs(max(eta))),
#                           100*(driftN+abs(max(driftN))))
#=======================================================
# Run LDA to benchmark
#=======================================================
print ('Starting LDA...............................................\n')
k = 50
#auctionCSDataLDA = matrix(as.integer(cbind(auctionDocWordData,ZauctionProfile,AuctionParameters)),nrow = nrow(ZauctionProfile))
auctionCSDataLDA = matrix(as.integer(cbind(auctionDocWordData,ZauctionProfile)),nrow = nrow(ZauctionProfile))

control_LDA_VEM <- list(estimate.alpha = TRUE, alpha = 50/k, estimate.beta = TRUE,
                        verbose = 1, prefix = tempfile(), save = 0, keep = 0,
                        seed = as.integer(Sys.time()), nstart = 1, best = TRUE,
                        var = list(iter.max = 500, tol = 10^-6),
                        em = list(iter.max = 1000, tol = 10^-4),
                        initialize = "random")
#lda = LDA(x = docTermMatrix, k, method = "VEM", control = control_LDA_VEM , model = NULL)
lda = LDA(x = auctionCSDataLDA, k, method = "VEM", control = control_LDA_VEM , model = NULL)
#sum(lda@loglikelihood)   # because it gives likelihood for each individual
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
print ('LDA Finished...............................................\n')

# test the distribution
# for (i in 1:50){
#   print(paste('cluster ',i,'has length',length(which(auctionClusterNumbers==i))))
# }
# 50 clusters for auction found

#================================================================
# Moved DP out, but for the economics conferance decided to run finite one
#==================================================================
#========================================================================================================
# Run DP to test=
#========================================================================================================
print ('Start Bidders DP ...............................................\n')
#ZbiddersProfile
biddersParameters=cbind(alpha,beta,delta,rho)
#vdpmm_data = cbind(ZbiddersProfile,biddersParameters)     #[10757 x 10] where 10 = 6 data + 4 parameters
vdpmm_data = ZbiddersProfile     #[10757 x 10] where 10 = 6 data + 4 parameters
# less number of iterations to speed up
#options=list(K = 50, infinite = 1,verbose=0,maxits=50,minits=10,eps=0.1)

#running in parallel
#divide into 4 sets and run in parallel
breakDown = list(c(1:2000),c(2000:4000),c(4000:6000),c(6000:8000),c(8000:10000),c(10000:nrow(vdpmm_data)))


# to use parallel loop
assignmentList= foreach(i=1:6, .combine=rbind, .packages = c("MASS","corpcor","Matrix","mclust"),
                        .export=c("vdpmm_init","vdpmm_maximize","vdpmm_expectation","vdpmm"))  %dopar%{   # be aware of function scope problem .export=c("fccat")
                          #result = vdpmm(vdpmm_data[breakDown[[i]],], options);
                          #probMatrix = result$gammas
                          #assignment = result$assign
                          mydata = vdpmm_data[breakDown[[i]],]
                          fit <- Mclust(data=mydata, G = 1:20, control = emControl(itmax=100))
                          assignment = fit$classification
                          
                          list(input=breakDown[[i]],assignment=assignment)
                        }
#combine back the assignments
bidderAssignedCluster = rep(0,nrow(vdpmm_data))
bidderAssignedCluster[c(assignmentList[[1]],assignmentList[[2]],
                        assignmentList[[3]],assignmentList[[4]],
                        assignmentList[[5]],assignmentList[[6]])] = c(assignmentList[[7]],20+assignmentList[[8]],
                                                                      40+assignmentList[[9]],60+assignmentList[[10]],
                                                                      80+assignmentList[[11]],100+assignmentList[[12]])

#print ('Start bidders LDA...............................................\n')
#===========================================
# prepare result of auction DP for bidders HB
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
print ('Bidders DP Finished...............................................\n')

# test the distribution
totalTemp = 0
# lots of clusters have zero length
# for (i in 1:maxBidderCluster){
#   totalTemp = length(which(bidderClusterNumbers==i))+totalTemp
#   print(paste('cluster ',i,'has length',length(which(bidderClusterNumbers==i))))
# }
# 47 clusters found

#================================================================================================
#                    Main Function: MCVEM
#================================================================================================
auctionMCVEMELL = function(auctionBidderParameters){
  #auctionBidderParameters = initialValue
  # according to the theory it can not be negative, so for identification I set it to greater than 0
  tau   = abs(auctionBidderParameters[1:aN])
  # according to theory it is the portion that the bidder increases its bid extra to the rate of
  # bid increase
  drift = abs(auctionBidderParameters[(aN+1):(2*aN)])
  # according to theory it is the rate of enterance, so it can not be negative
  eta   = abs(auctionBidderParameters[(2*aN+1):(3*aN)])
  # ========tau==========
  # again according to theory we can not say people leave, but we can say people enter
  driftN  = abs(auctionBidderParameters[(3*aN+1):(4*aN)])
  alpha   = auctionBidderParameters[(4*aN+1):(4*aN+I)]
  beta    = auctionBidderParameters[(4*aN+I+1):(4*aN+2*I)]
  # make sure that it is always positive, because theory does not suggest negative
  # so just avoid the bad region of the value, because I am using it in the log form
  delta   = abs(auctionBidderParameters[(4*aN+2*I+1):(4*aN+3*I)]+1e-4)
  # again theory does not suggest that we have decrease by updating
  rho     = abs(auctionBidderParameters[(4*aN+3*I+1):(4*aN+4*I)])
  
  varObs  = pmax(pmin(auctionBidderParameters[(4*aN+4*I+1):(4*aN+4*I+aN)],1e5),1e-5)
  varState   = pmax(pmin(auctionBidderParameters[(4*aN+4*I+aN+1):(4*aN+4*I+2*aN)],1e5),1e-5)
  varObsN  = pmax(pmin(auctionBidderParameters[(4*aN+4*I+2*aN+1):(4*aN+4*I+3*aN)],1e5),1e-5)
  varStateN = pmax(pmin(auctionBidderParameters[(4*aN+4*I+3*aN+1):(4*aN+4*I+4*aN)],1e5),1e-5)
  varObsValue = pmax(pmin(auctionBidderParameters[(4*aN+4*I+4*aN+1):(4*aN+4*I+5*aN)],1e5),1e-5) 
  varStateValue = pmax(pmin(auctionBidderParameters[(4*aN+4*I+5*aN+1):(4*aN+4*I+6*aN)],1e5),1e-5) 
  
  
 #===========================
 # LDA moved out of the optimization loop for speeding the optimization up at this stage, replaced with the line below it
 #===========================
 # following line is not needed anymore as parameter is not input of LDA
#   AuctionParameters = cbind(100*(tau+abs(max(tau))),100*(drift+abs(max(drift))),100*(eta+abs(max(eta))),
#                             100*(driftN+abs(max(driftN))))

  AuctionParameters = cbind(tau,drift,eta,driftN)

  print ('Starting auction HB...............................................\n')
  
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
      YauctionCur = YauctionCur - apply(YauctionCur,2,mean)  # demean    
      varCurComponent[[i]] = cov(YauctionCur)+1e-2
      XauctionCur = ZauctionProfile[which(auctionClusterNumbers==i),]
    }else{
      YauctionCur = matrix(YauctionCur - mean(YauctionCur),ncol=4) # demean  
      varCurComponent[[i]] = matrix(rep(1e-2,4*4),ncol=4)
      XauctionCur = matrix(ZauctionProfile[which(auctionClusterNumbers==i),],nrow=1)
    }
    
    XTXcurAuctionContrib = crossprod(XauctionCur) %x% varCurComponent[[i]]
    XTYcurAuctionContrib = (varCurComponent[[i]] %*% crossprod(YauctionCur,XauctionCur))
    
    XTXauction = XTXauction + XTXcurAuctionContrib
    XTYauction = XTYauction +  XTYcurAuctionContrib
  }
  XTYauction = matrix(XTYauction,ncol=1)
  parameterEstimate = ginv(XTXauction+diag(rep(1e-2,sqrt(length(XTXauction)))))%*%(XTYauction)
  
  auctionCoeff = matrix(parameterEstimate,ncol=ncol(AuctionParameters))

  #================================================
  # Given Parameter Estimate, calculate log likelihood
  #===============================================
  for (i in 1:length(auctionClusterDictionary)){  # for total number of clusters
    YauctionCur = AuctionParameters[which(auctionClusterNumbers==i),]
    if (length(YauctionCur)!=4){ # because apply does not work on one dimension
      YauctionCur = YauctionCur - apply(YauctionCur,2,mean)  # demean    
      XauctionCur = ZauctionProfile[which(auctionClusterNumbers==i),]
      varCurComponent[[i]] = cov(YauctionCur - XauctionCur%*%auctionCoeff)+1e-2
    }else{
      YauctionCur = matrix(YauctionCur - mean(YauctionCur),ncol=4) # demean  
      XauctionCur = matrix(ZauctionProfile[which(auctionClusterNumbers==i),],nrow=1)
      varCurComponent[[i]] = matrix(rep(1e-2,4*4),ncol=4)
    }
    for (j in 1:nrow(YauctionCur)){
      auctionPriorLL = auctionPriorLL + pmax(dmvnorm(YauctionCur[j,], mean = XauctionCur[j,]%*%auctionCoeff, 
                                                sigma = make.positive.definite(varCurComponent[[i]]), 
                                                log = TRUE), -100)
    }
  }
  # to make sure I don't get irrelevant number due to any reason
  auctionPriorLL = max(auctionPriorLL,-44000000)
  print ('AuctionHB Finished...............................................\n')

  #=====================================
  # removed DP from this procedure to speed it up
  #===========================================
  biddersParameters=cbind(alpha,beta,delta,rho)
  
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
      YbidderCur = YbidderCur - apply(YbidderCur,2,mean)  # demean    
      varCurComponentBidder[i] = list(cov(YbidderCur)+1e-2)
      XbidderCur = ZbiddersProfile[which(bidderClusterNumbers==i),]
    }else{
      YbidderCur = matrix(YbidderCur - mean(YbidderCur),ncol=4) # demean  
      varCurComponentBidder[i] = list(matrix(rep(1e-2,4*4),ncol=4))
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
      YbidderCur = YbidderCur - apply(YbidderCur,2,mean)  # demean    
      varCurComponentBidder[i] = list(cov(YbidderCur)+1e-2)
      XbidderCur = ZbiddersProfile[which(bidderClusterNumbers==i),]
    }else{
      YbidderCur = matrix(YbidderCur - mean(YbidderCur),ncol=4) # demean  
      varCurComponentBidder[i] = list(matrix(rep(1e-2,4*4),ncol=4))
      XbidderCur = matrix(ZbiddersProfile[which(auctionClusterNumbers==i),],nrow=1)
    }
    for (j in 1:nrow(YbidderCur)){
      bidderPriorLL = bidderPriorLL + pmax(dmvnorm(YbidderCur[j,], mean = XbidderCur[j,]%*%bidderCoeff, 
                                              sigma = make.positive.definite(varCurComponentBidder[[i]]), 
                                              log = TRUE),-100)
    }
  }
  # to make sure I don't get irrelevant number due to any reason
  bidderPriorLL = max(bidderPriorLL,-44000000)
  print ('Bidders LDA Finished...............................................\n')  
  
  #================================================================
  # Expected Likelihood for bids, number of bidders, valuation MCEM
  # basically I take sample of 1000 points and calculte LL and get average
  # I had to use sum (pi*log), because computationally otherwise will result in underflow
  #================================================================
  
  print ('Start FFBS on Auction Bids...............................................\n')  
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
                m0 = c(m0[i],1), C0 = diag(c(4,0)))
    
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
    #sanity checks
    Nmean[is.nan(Nmean)] = 10
    Nmean[is.infinite(Nmean)] = 10
    Nvar[is.nan(Nvar)] = 10
    Nvar[is.infinite(Nvar)] = 10
    
    for (t in 1:(T+1)){
      sample[,t]=rnorm(sN, mean = Nmean[t], sd = sqrt(Nvar[t]))
#       probX[,t] =  dnorm(sample[,t], 
#                          mean = Nmean[t], sd =sqrt(Nvar[t]))
    }
    #probX = apply(probX,1,prod)
    
    # log (P(Y(1:T)|X(1:T)))
    LPY1TgX1T = dnorm(t(matrix(rep(bids,sN),ncol=sN)), 
                      mean = sample[,2:(T+1)],
                      sd = sqrt(varObs[i]), log = TRUE)
    
    # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
    LPXTXT_1 =  dnorm(sample[,2:(T+1)], 
                      mean = tau[i]*sample[,1:(T)]+drift[i],
                      sd = sqrt(varState[i]), log = TRUE)
    if (T==1){
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats)      
        expLLBids = logSumExp(lx = ((LPY1TgX1T)+ (LPXTXT_1)), na.rm=TRUE)
    }else{
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats) 
      expLLBids = logSumExp(lx = (apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum)), na.rm=TRUE)
    }
    
  }
  
  print ('bidders FFBS finished...............................................\n')  
  #==============================================
  # Running FFBS on number of bidders in each auction
  #==============================================
  print ('Start Number of Bids FFBS...............................................\n')  
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
                 m0 = c(m0N[i],1), C0 = diag(c(4,0)))
    
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
      sample[,t]=rnorm(sN, mean = Nmean[t], sd = sqrt(Nvar[t]) )
#       probX[,t] =  dnorm(sample[,t], 
#                          mean = Nmean[t], sd = sqrt(Nvar[t]))
    }
    #probX = apply(probX,1,prod)
    
    # log (P(Y(1:T)|X(1:T)))
    LPY1TgX1T = dnorm(t(matrix(rep(toFilterData,sN),ncol=sN)), 
                      mean = sample[,2:(T+1)],
                      sd = sqrt(varObsN[i]), log = TRUE)
    
    # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
    LPXTXT_1 =  dnorm(sample[,2:(T+1)], 
                      mean = sample[,1:(T)]+driftN[i],
                      sd = sqrt(varStateN[i]), log = TRUE)
    if (T==1){
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats) 
      expLLNBidders = logSumExp(lx =((LPY1TgX1T)+ (LPXTXT_1)), na.rm=TRUE)
    }else{
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats) 
      expLLNBidders = logSumExp(lx = (apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum)), na.rm=TRUE)
    }
  }
  
  print ('Calculating Expected Valuation A(tt)...............................................\n')  
  #===============================================================
  #    Build the RHS observatin of observation equation of valuation
  #================================================================
  LogAList = vector()
  logA = vector()
  # build the Right Hand Side of Observation equation
  # to use parallel loop
  #LogAList[length(LogAList)+1] =
  AuctionListReplica = AuctionList
  bidderIndexListReplica  = bidderIndexList
  maxBidListReplica = maxBidList
  LogAList= foreach(i=1:length(AuctionListReplica), .combine=rbind, .packages = c("MASS","corpcor","Matrix"))  %dopar%{   # be aware of function scope problem .export=c("fccat")
    #print(paste('i=',i,"\n"))
    curbidList = AuctionListReplica[[i]]
    bidderIndex = bidderIndexListReplica[[i]]
    maxBid = maxBidListReplica[[i]]
    T = length(curbidList)
    logA = rep(0,T)
    for (t in 1:T){  #maximum until the previous moment
      #print(paste('t=',t,"\n"))
      alphajt = alpha[bidderIndex[[t]]]
      betajt  = beta[bidderIndex[[t]]]
      deltajt = delta[bidderIndex[[t]]]
      rhojt   = rho[bidderIndex[[t]]]
      # according to Ozbay and Ozbay 0.77, 
      # according to Engelbrecht-Wiggans and Kotok, 0.69 
      #but I put 0.25 to make sure 0.25 is 
      # from consumer point of view they have the expectation of the max valuation
      # So their valuation is rational
      # from mathematical point of view and model it means truncation for identification (so a constraint)
      maxAllBid = 4*max(maxBid)
      # because number of bidders are integer
      numBidders = max(ceiling(latentNM_1[[i]][t]),1)
      
      valuationObserved <- function(x) {
        #print(paste('entered function with:',x,"\n"))
        ttjt = x;
        weight = dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]));
        # according to the theory the number of bidders cannot be negative
        #numBidders = max(latentNM_1[[i]][t],1)
        numerator = 
          as.numeric(
            pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
              ttjt*dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
              alphajt*(pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**numBidders)-
              alphajt*ttjt*numBidders*
              (pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(numBidders-1))*
              dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
              (alphajt + betajt)*ttjt*numBidders* (pnorm(ttjt, mean = latentbidM_1[[i]][t],
                                              sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(numBidders-1))*
              dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)
          ) ; 
        denominator = (
          dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)+
            betajt*dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)*numBidders*
            (pnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]), log = FALSE)**ceiling(numBidders-1)) 
        );
        denominator = (denominator + denominator)/2;
        
        if (is.null(denominator)){
          return(1e-9);
        }
        if (is.infinite(denominator)){
          return(1e-9);
        }
        
        At=numerator/denominator
        # based on Engelbrech-Wiggans and Kotak paper usually the rate is greater than 0.5, so truncate irrelevant
        At = min(At,2*maxAllBid)
        At = weight*At;
        
        # abs because it cannot be negative from programming stand point (before convergance)
        # also drift is captured at observation equation level 
        
        #put condition to make sure I don't hit infinity
        # this may be good condition for identification as the market is competitive
        # an alternative approach is to find starting value, or threshold of buyer
        if ((is.nan (At)) || (is.infinite (At))){
          At = 2*maxAllBid;
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
  
  print ('Calculating Expected Valuation A(tt) Finished...............................................\n') 
  print ('Start individual valuation FFBS...............................................\n')
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
      logDeltajt[t] = log(delta[bidderIndex[[t]]]+1e-5)
    }
    # move to the observation equation for simplicity
    toFilterData = logA - logDeltajt
    
    dlmstubValue=dlm(FF =1, V = varObsValue[i],
                     GG = 1, W = varStateValue[i],
                     m0 = m0Value[i], C0 = 4)
    
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
    # calculate Expected Likelihood for the Valuations
    #===========================================================
    sample = matrix(rep(0,sN*(T+1)),ncol=T+1)        #T+1 
    #prob (X(1:T)): based on the state distribution to take expectation
    probX  =  matrix(rep(0,sN*(T+1)),ncol=T+1) 
    Nmean=SOValue$s
    Nvar = CtValue
    #sanity checks
    Nmean[is.nan(Nmean)] = 10
    Nmean[is.infinite(Nmean)] = 10
    Nvar[is.nan(Nvar)] = 10
    Nvar[is.infinite(Nvar)] = 10
    
    for (t in 1:(T+1)){
      sample[,t]=rnorm(sN, mean = Nmean[t], sd = sqrt(Nvar[t]))
#       probX[,t] =  dnorm(sample[,t], 
#                          mean = Nmean[t], sd = sqrt(Nvar[t]))
    }
    #probX = apply(probX,1,prod)
    
    # log (P(Y(1:T)|X(1:T)))
    LPY1TgX1T = dnorm(t(matrix(rep(toFilterData,sN),ncol=sN)), 
                      mean = sample[,2:(T+1)],
                      sd = sqrt(varObsValue[i]), log = TRUE)
    
    # log (P(X(1:T)|X(1:T-1))): as it has drift we should take it out
    LPXTXT_1 =  dnorm(sample[,2:(T+1)], 
                      mean = sample[,1:(T)],
                      sd = sqrt(varStateValue[i]), log = TRUE)
    
    if (length(LPXTXT_1) != nrow(sample)){ #when T>1
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats) 
      expLLValuation = logSumExp(lx = (apply(LPY1TgX1T,1,sum)+ apply(LPXTXT_1,1,sum)), na.rm=TRUE)
    }else{
      # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE) in library(matrixStats)      
      expLLValuation = logSumExp(lx = ((LPY1TgX1T)+ (LPXTXT_1)), na.rm=TRUE)
    }  
  }
  print ('Individual Valuation FFBS finished...............................................\n')
  #==================================================
  # Monte Carlo Expectation Maximization used
  #==================================================
  LL =  expLLNBidders + expLLBids + expLLValuation  
  MAP = LL+ auctionPriorLL + bidderPriorLL

  
  #==================================================
  # Saving into Log Files
  #==================================================
  curFileIndex <<- curFileIndex + 1
  fullCurLogFile = paste(logFilePath,'logFile',curFileIndex,'.txt')
  
  # writing the auction parameters parameters
  write('The value of Auction Parameters\n------------------------------------------------------
        \n tau \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(tau, file = fullCurLogFile,
        append = TRUE,ncolumns =length(tau), sep = "\t")
  
  write('\n gammaj \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(drift, file = fullCurLogFile,
        append = TRUE,ncolumns =length(drift), sep = "\t")
  
  write('\n eta \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(eta, file = fullCurLogFile,
        append = TRUE,ncolumns =length(eta), sep = "\t")
  
  write('\n nuj \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(driftN, file = fullCurLogFile,
        append = TRUE,ncolumns =length(driftN), sep = "\t")
  
  write('The value of Bidders Parameters\n------------------------------------------------------
        \n alphai \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(alpha, file = fullCurLogFile,
        append = TRUE,ncolumns =length(alpha), sep = "\t")
  
  write('\n betai \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(beta, file = fullCurLogFile,
        append = TRUE,ncolumns =length(beta), sep = "\t")
  
  write('\n deltai \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(delta, file = fullCurLogFile,
        append = TRUE,ncolumns =length(delta), sep = "\t")
  
  write('\n rhoi \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(rho, file = fullCurLogFile,
        append = TRUE,ncolumns =length(rho), sep = "\t")
  
  write('The value of LDA Parameters for Auction Parameters\n------------------------------------------------------
        \n HB Parameter (Coefficients) \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  # auctionCoeff
  write(auctionCoeff, file = fullCurLogFile,
        append = TRUE,ncolumns =ncol(auctionCoeff), sep = "\t")
  
  write('\n varCurComponent \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  for (i in 1:length(varCurComponent)){
    write(paste('for segment ',i, '\n\n'),append = TRUE, sep = "\t")
    write(varCurComponent[[i]], file = fullCurLogFile,
          append = TRUE,ncolumns =length(varCurComponent[[i]]), sep = "\t")
  }
  
  write('\n auctionClusterNumbers \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(as.integer(auctionClusterNumbers), file = fullCurLogFile,
        append = TRUE,ncolumns =length(auctionClusterNumbers), sep = "\t")
  
  
  write('The value of LDA Parameters for Auction Parameters\n------------------------------------------------------
        \n HB Parameter (Coefficients) \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  # bidderCoeff
  write(auctionCoeff, file = fullCurLogFile,
        append = TRUE,ncolumns =ncol(auctionCoeff), sep = "\t")
  
  write('\n bidderClusterNumbers \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(as.integer(bidderClusterNumbers), file = fullCurLogFile,
        append = TRUE,ncolumns =length(bidderClusterNumbers), sep = "\t")
  
  write('\n varCurComponentBidder \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  
  for (i in 1:length(varCurComponentBidder)){
    write(paste('for segment ',i, '\n\n'),append = TRUE, sep = "\t")
    write(varCurComponentBidder[[i]], file = fullCurLogFile,
          append = TRUE,ncolumns =length(varCurComponentBidder[[i]]), sep = "\t")
  }
  
  # Variances: varObs,varState,varObsN,varStateN,varObsValue,varStateValue
  #================================
  write('The value of Bidders Parameters\n------------------------------------------------------
        \n var bid observation \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varObs, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n var of bid state eq \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varState, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n var number of bidders observation \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varObsN, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n var of number of bidders state \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varStateN, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n var valuation of bidders observation \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varObsValue, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n var of valuation of bidders state \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(varStateValue, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  
  #==========================
  
  
  write('Likelihood of the model\n------------------------------------------------------
        \n Likelihood of the model \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(LL, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n MAP estimate \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(MAP, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n expLLNBidders \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(expLLNBidders, file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write('\n expLLBids \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(expLLBids, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  write('\n expLLValuation \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(expLLValuation, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  write('\n auctionPriorLL \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(auctionPriorLL, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  write('\n bidderPriorLL \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(bidderPriorLL, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  # return also assignments, the HB estimates and variance of components
  # auctionCoeff
  # varCurComponent
  # auctionClusterNumbers
  
  # bidderCoeff
  # bidderClusterNumbers
  # varCurComponentBidder
  
  # As I want to maximize map, so I need to minimize its negative
  return(-MAP)
}

#=======================================================================
# JIT: compile the functions to speed up
#========================================================================
require(compiler)
library(compiler)YauctionC
enableJIT(3)

# a little variation test (put some initial perturbation)
initialValue = c(runif(aN)+tau,runif(aN)+drift,runif(aN)+eta,runif(aN)+driftN,
                 -runif(I)+alpha, -runif(I)+beta, runif(I)+delta, runif(I)+rho,
                 runif(aN)+varObs,runif(aN)+varState,runif(aN)+varObsN,runif(aN)+varStateN,
                 runif(aN)+varObsValue,runif(aN)+varStateValue)

# old original one
#initialValue = c(tau,drift,eta,driftN,alpha,beta,delta,rho,
#                 varObs,varState,varObsN,varStateN,varObsValue,varStateValue)

slow_func_compiled <- cmpfun(auctionMCVEMELL)

##### Functions #####

is.compile <- function(func)
{
  # this function lets us know if a function has been byte-coded or not
  #If you have a better idea for how to do this - please let me know...
  if(class(func) != "function") stop("You need to enter a function")
  last_2_lines <- tail(capture.output(func),2)
  any(grepl("bytecode:", last_2_lines)) # returns TRUE if it finds the text "bytecode:" in any of the last two lines of the function's print
}

out = is.compile(slow_func_compiled)



#==========================================================
# Running the program in just in time mode to speed up (it will only print every 5 transactions on 
# the screen, and the rest are printed in the file)
#===========================================================

#resultOfFiltering = slow_func_compiled(logfilename,categoryDiffData,CategoryHBData)


resultOfFiltering = optim(initialValue,slow_func_compiled,method="SANN", 
                          control=list( fnscale=1,trace=1,reltol=1e-4,maxit=1000) #hessian = TRUE
)
resultOfFiltering$value
resultOfFiltering$par

resultedMapNeg = slow_func_compiled(resultOfFiltering$par)

 # slow_func_compiled()

# 
# out             =  optim(initialValue,auctionMCVEMELL,method="SANN", 
#                          control=list( fnscale=-1,trace=1,reltol=1e-4,maxit=1000) #hessian = TRUE
#                       )

# #=======================================================
# # save bidders and auction characteristics for basic statistic
# #=====================================
# # for bidders
# biddersCharacLog = paste(logFilePath,'BiddersCharac.txt')
# write('\n Bidders feedback \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,1], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# write('\n Bids on This Item \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,2], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# write('\n Total 30 days bids \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,3], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# write('\n Num Items Bids \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,4], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# write('\n Number of activities with this seller \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,5], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# write('\n Number of categories bidded On \n--------------------------------------------------------------------------\n', file = biddersCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZbiddersProfile[,6], file = biddersCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZbiddersProfile))
# 
# # for auction profile  
# #dim(ZauctionProfile)
# auctionCharacLog = paste(logFilePath,'AuctionCharac.txt')
# write('\n # Bidders  \n--------------------------------------------------------------------------\n', 
#       file = auctionCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZauctionProfile[,1], file = auctionCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZauctionProfile))
# write('\n # Bids \n--------------------------------------------------------------------------\n',
#       file = auctionCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZauctionProfile[,2], file = auctionCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZauctionProfile))
# write('\n Duration in Days \n--------------------------------------------------------------------------\n',
#       file = auctionCharacLog,
#       append = TRUE, sep = "\t")
# 
# write(ZauctionProfile[,3], file = auctionCharacLog,
#       append = TRUE,sep = "\t",ncolumns=nrow(ZauctionProfile))
# 
# #===========================================================================
# # some basic statistic curves
# #============================================================================
# # Jewelry auction
# #======================
# # bids evoluation curve
# i = 22
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Jewelry Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Jewelry Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# # Watch auction
# #======================
# # bids evoluation curve
# i = 127
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Watch Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Watch Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# # Pottery and Glasses auction
# #======================
# # bids evoluation curve
# i = 220
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Pottery and Glasses Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Pottery and Glasses Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# # Craft auction
# #======================
# # bids evoluation curve
# i = 330
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Craft Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Craft Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# # Toy and Hobby auction
# #======================
# # bids evoluation curve
# i = 437
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Toy and Hobby Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Toy and Hobby Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# # Stamps auction
# #======================
# # bids evoluation curve
# i = 530
# plot(1:length(AuctionList[[i]]), AuctionList[[i]], main="Evolution of Auction bids", 
#      sub="An Sample Stamp Auction",
#      xlab="Bid entry", ylab="Bid in $")
# 
# # number of bidders enterance curve
# plot(1:length(NumberBidderAuction[[i]]),NumberBidderAuction[[i]], main="Evolution of Number of bidders", 
#      sub="An Sample Stamps Auction",
#      xlab="Bid entry", ylab="Number of Bidders")
# 
# 
# #==============================================================
# # bidder's parameter histogram cross segments
# #================================================================
# #deltai  rhoi	alphai	betai
# #======================
# estimatedParam=c(3.69,3.65,-6.597880878,-3.495028646,
#                  4.03,3.19,-5.748145644,-3.609172178,
#                  3.38,3.62,-6.831114092,-3.491565511,
#                  3.60,3.40,-6.39842562,-3.690724909,
#                  3.53,3.49,-6.327488942,-3.37599675,
#                  3.55,3.40,-6.931759419,-3.205991785,
#                  3.30,3.56,-6.36438344,-2.931122905,
#                  3.53,3.24,-6.419409828,-3.571648165,
#                  3.56,3.63,-6.725637918,-3.244320294,
#                  3.83,3.57,-6.828030592,-3.554953402,
#                  3.63,3.56,-6.600385565,-3.618607223,
#                  3.65,3.43,-6.924193035,-3.376345254,
#                  3.57,4.42,-7.069651414,-2.946780955,
#                  3.82,4.07,-6.263473082,-2.954465422,
#                  3.90,3.80,-6.742271598,-3.489155053,
#                  3.56,3.28,-6.103485411,-2.744687715,
#                  3.67,3.72,-5.92054616,-3.201874103,
#                  3.93,3.78,-6.457408746,-3.356936069,
#                  4.14,3.94,-5.925903176,-4.180001069,
#                  3.66,3.49,-6.7986358,-3.188143884,
#                  3.60,3.41,-6.47899525,-3.867508483,
#                  3.66,4.20,-6.125862809,-2.682843032,
#                  3.94,3.68,-7.313477364,-2.396148787,
#                  3.66,4.14,-6.459840322,-3.57262125,
#                  3.67,3.73,-6.966747261,-3.117637661,
#                  3.37,3.68,-6.48956638,-3.611542712,
#                  3.76,3.41,-6.508291531,-3.505991338,
#                  3.23,3.82,-6.675815615,-3.332154178,
#                  3.70,3.61,-6.600145848,-3.505736745,
#                  4.36,3.40,-6.14262142,-3.930651898,
#                  3.75,3.86,-6.696210483,-4.072812777,
#                  3.76,3.87,-6.620214938,-3.165308824,
#                  3.89,4.03,-4.393328389,-1.528107536,
#                  5.35,5.59,-4.602106505,-2.151181642,
#                  3.55,3.68,-6.899537416,-3.383553605,
#                  3.60,3.51,-6.844345402,-3.589149168,
#                  4.37,5.31,-5.352422129,-2.693094513,
#                  3.59,3.46,-6.773710267,-2.750892677,
#                  3.74,3.66,-6.457542761,-3.179297675,
#                  3.86,4.43,-6.397126932,-2.272054199,
#                  3.80,3.56,-6.576090136,-3.500465812,
#                  3.88,3.37,-6.374812855,-3.17659957,
#                  3.81,3.59,-6.996088887,-3.282758326,
#                  3.67,3.68,-6.398108655,-3.017475093,
#                  3.66,3.18,-6.419772065,-3.360353579,
#                  3.63,3.57,-6.733439672,-3.348169435,
#                  3.91,3.92,-6.30798608,-3.240128528)
# bidderSegParam = t(matrix(estimatedParam,nrow=4))
# #hist(bidderSegParam[,1], breaks=5, col="red")
# # the immitator's density
# # Filled Density Plot(market size)
# #==================
# # delta i
# #===================
# d <- density(bidderSegParam[,1])
# plot(d, main="Bidders Valuation Growth")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # rho i
# #===================
# d <- density(bidderSegParam[,2])
# plot(d, main="Bidders Valuation Drift")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # alpha i
# #===================
# d <- density(bidderSegParam[,3])
# plot(d, main="Bidders Action Regret")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # beta i
# #===================
# d <- density(bidderSegParam[,4])
# plot(d, main="Bidders Inaction Regret")
# polygon(d, col="grey",order="grey")
# 
# 
# 
# #==============================================================
# # Auctions's parameter histogram cross segments
# #================================================================
# #tau drift etaj driftN
# #======================
# estimatedAuctionParam=c(3.03,5.62,3.70,3.09,
#                  3.41,6.49,3.32,3.62,
#                  5.54,4.39,4.23,3.51,
#                  3.04,6.46,3.38,3.44,
#                  4.80,5.42,3.93,4.31,
#                  3.92,5.94,3.70,3.75,
#                  4.24,5.21,4.12,4.05,
#                  3.97,7.32,4.24,3.71,
#                  4.37,4.35,4.41,4.55,
#                  4.73,7.22,4.33,5.44,
#                  4.77,7.23,6.33,3.39,
#                  4.16,6.25,3.32,4.33,
#                  3.34,6.87,3.96,5.01,
#                  3.64,6.68,3.71,4.75,
#                  5.32,5.98,4.40,4.06,
#                  3.64,5.73,3.46,4.49,
#                  4.12,6.95,3.68,4.18,
#                  4.25,6.87,3.56,4.18,
#                  11.16,10.73,11.42,12.51,
#                  4.50,8.12,3.42,4.16,
#                  3.36,7.30,3.57,3.68,
#                  4.10,6.53,4.32,4.07,
#                  4.55,6.93,4.56,5.36,
#                  3.52,5.44,3.55,4.83,
#                  6.07,8.55,4.36,5.17,
#                  6.22,7.79,4.53,5.79,
#                  6.54,8.77,7.08,7.94,
#                  4.62,7.57,4.64,4.68,
#                  5.54,6.99,4.07,5.81,
#                  3.83,6.75,4.39,4.40,
#                  4.04,6.49,4.49,3.77,
#                  4.76,6.89,4.19,4.32,
#                  4.76,7.09,4.48,5.12,
#                  5.12,8.60,4.27,4.37,
#                  6.64,8.90,6.12,5.72,
#                  4.48,6.16,3.83,4.74,
#                  4.37,7.69,4.68,4.99,
#                  4.54,6.79,4.67,4.31,
#                  4.39,5.72,3.87,5.26,
#                  7.18,8.65,6.81,5.75,
#                  4.75,6.90,4.53,4.46,
#                  6.68,8.31,6.47,6.79,
#                  16.11,12.44,13.31,12.88,
#                  5.69,8.70,8.33,7.26,
#                  9.06,11.14,9.27,10.30,
#                  12.02,11.82,10.28,11.01,
#                  7.21,9.78,6.38,7.45,
#                  5.22,8.19,5.51,5.81,
#                  19.69,17.25,17.42,18.39)
# auctionClustParam = t(matrix(estimatedAuctionParam,nrow=4))
# #hist(bidderSegParam[,1], breaks=5, col="red")
# # the immitator's density
# # Filled Density Plot(market size)
# #==================
# # tau j
# #===================
# d <- density(auctionClustParam[,1])
# plot(d, main="Bid Growth Rate")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # Drift bid
# #===================
# d <- density(auctionClustParam[,2])
# plot(d, main="Bid Drift")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # eta j
# #===================
# d <- density(auctionClustParam[,3])
# plot(d, main="Flood of Biders at Last Moment Rate")
# polygon(d, col="grey",order="grey")
# 
# #==================
# # Drift N
# #===================
# d <- density(auctionClustParam[,4])
# plot(d, main="Average rate of Bidders enterance")
# polygon(d, col="grey",order="grey")