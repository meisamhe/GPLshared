#===========================================================================
# running counterfactual on how 5% increase in regret (i.e. more negative) can affect revenue
# of auction platform
#============================================================================

auctionSpecificParamPath = 
  "C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/RunLog/AuctionSpecificParamToRead.csv"
bidderSpecificParamPath = 
  "C:/Users/MeisamHe/Desktop/Desktop/Projects/RegretInAuction/RunLog/BiddersSpecificParametersToRead.csv"


# reading the parameters estimated
#====================
auctionSpecificParam  = read.csv(file=auctionSpecificParamPath,head=TRUE,sep=",")
bidderSpecificParam  = read.csv(file=bidderSpecificParamPath,head=TRUE,sep=",")



tau = as.vector(auctionSpecificParam[,"tau"])
drift = as.vector(auctionSpecificParam[,"gamaj"])
eta = as.vector(auctionSpecificParam[,"eta"])
driftN = as.vector(auctionSpecificParam[,"nuj"])
varObs = as.vector(auctionSpecificParam[,"varBidObsvEq"])
varState = as.vector(auctionSpecificParam[,"varBidStateEq"])
varObsN = as.vector(auctionSpecificParam[,"varNbidderObs"])
varStateN = as.vector(auctionSpecificParam[,"varNbidderState"])
varObsValue = as.vector(auctionSpecificParam[,"varObsVal"])
varStateValue = as.vector(auctionSpecificParam[,"varStateVal"])
alpha = as.vector(bidderSpecificParam[,"alphai"])
beta = as.vector(bidderSpecificParam[,"betai"])
delta = as.vector(bidderSpecificParam[,"deltai"])
rho = as.vector(bidderSpecificParam[,"rhoi"])

initialValue = c(tau,drift,eta,driftN,
                alpha, beta, delta, rho,
                 varObs,varState,varObsN,varStateN,
                 varObsValue,varStateValue)

#First use the current initial Values to recover latent valuations
#================================================================
#================================================================================================
#                    Main Function: MCVEM
#================================================================================================

latentVjtM_1 = list()
latentVjtV_1 = list()
latentNM_1 = list()
latentNV_1 = list()

auctionMCVEMELL4Valuation = function(auctionBidderParameters){
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
    latentNM_1[i] <<- list(c(m0Ntemp,latentN[1:(T-1)]))#a moment before
    latentNV_1[i] <<- list(c(C0Ntemp,CtNtemp[1:(T-1)]))#a moment before
    
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
  latentNM_1Temp = latentNM_1
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
      numBidders = max(ceiling(latentNM_1Temp[[i]][t]),1)
      
      valuationObserved <- function(x) {
        #print(paste('entered function with:',x,"\n"))
        ttjt = x;
        weight = dnorm(ttjt, mean = latentbidM_1[[i]][t], sd = sqrt(latentbidV_1[[i]][t]));
        # according to the theory the number of bidders cannot be negative
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
    latentVjtM_1[i] <<- list(c(m0Valuetemp,mtValuetemp[1:(T-1)]))#a moment before
    latentVjtV_1[i] <<- list(c(C0Valuetemp,CtValuetemp[1:(T-1)]))#a moment before
    
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

# old original one
#initialValue = c(tau,drift,eta,driftN,alpha,beta,delta,rho,
#                 varObs,varState,varObsN,varStateN,varObsValue,varStateValue)

slow_func_compiled <- cmpfun(auctionMCVEMELL4Valuation)


#==========================================================
# Running the program in just in time mode to speed up (it will only print every 5 transactions on 
# the screen, and the rest are printed in the file)
#===========================================================

resultedMapNeg = slow_func_compiled(initialValue)

# define the utility of bidder function to maximize
#=================================================

# for integration inside the utility of action regret
actionReg2Integ = function(zt,meanBid,varBid,nt){
  returnValue= (zt*nt*dnorm(zt, mean = meanBid, sd = sqrt(varBid), log = FALSE)*
            pnorm(zt, mean = meanBid, sd = sqrt(varBid), log = FALSE)**(nt-1))
  if ((is.infinite(returnValue)) || (is.nan(returnValue))){
    returnValue = 0
  }
  return (sum(returnValue))
}

# for integration inside the utility of inaction regret
inActionReg2Integ = function(zt,meanBid,varBid,vt,nt){
  returnValue= ((vt-zt)*nt*dnorm(zt, mean = meanBid, sd = sqrt(varBid), log = FALSE)*
            pnorm(zt, mean = meanBid, sd = sqrt(varBid), log = FALSE)**(nt-1))
  if ((is.infinite(returnValue)) || (is.nan(returnValue))){
    returnValue = 0
  }
  return (sum(returnValue))
}

# utility of the midder to maximize with respect to bit with optim
utility = function(bit,alphait,betait,mtBid,Ctbid,vit,nt){
  # to make sure bid is positive
  bit = max(1,abs(bit))
  Mu1b <- Vectorize(actionReg2Integ, "zt") 
  actionRegretResult=integrate(Mu1b, lower=0, upper=bit,abs.tol = 1,meanBid = mtBid,
            varBid = Ctbid,nt=nt,rel.tol=1,stop.on.error=FALSE,subdivisions=15)
  Mu2b <- Vectorize(inActionReg2Integ, "zt") 
  incationRegretResult = integrate(Mu2b, lower=bit, upper=vit,abs.tol = 1,meanBid = mtBid,
                                   varBid = Ctbid,vt=vit,nt=nt,rel.tol=1,stop.on.error=FALSE,subdivisions=15)
  
  utilityValue = (vit - bit)*pnorm(bit, mean = mtBid, sd = sqrt(Ctbid), log = FALSE)-
    alphait*bit*(pnorm(bit, mean = mtBid, sd = sqrt(sqrt(Ctbid)), log = FALSE)**nt)+
    alphait*actionRegretResult$value -
    betait*incationRegretResult$value
  if ((is.infinite(utilityValue)) || (is.nan(utilityValue))){
    utilityValue = -exp(100)
  }
  # because I want to maximize the utility
  return(-utilityValue) 
}

#==================================================================================================================
# a Jewlery Auction
#==================================================================================================================
# check the values with plot
require(ggplot2)
i = 22
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }

  optimalBidVector[t] = optimalBid
#    utility(bit = bidVector[t],
#            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
#   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A sample Jewelry Auction")+
  ylab("Bid in $")+ xlab("Bid entry")


#==================================================================================================================
# a Watch Auction
#==================================================================================================================

# check the values with plot
require(ggplot2)
i = 127
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }
  
  optimalBidVector[t] = optimalBid
  #    utility(bit = bidVector[t],
  #            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
  #   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A Sample Watch Auction")+
  ylab("Bid in $")+ xlab("Bid entry")

#==================================================================================================================
# a Pottery and Glasses Auction
#==================================================================================================================

# check the values with plot
require(ggplot2)
i = 220
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }
  
  optimalBidVector[t] = optimalBid
  #    utility(bit = bidVector[t],
  #            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
  #   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A Sample Pottery and Glasses Auction")+
  ylab("Bid in $")+ xlab("Bid entry")


#==================================================================================================================
# a Craft Auction
#==================================================================================================================

# check the values with plot
require(ggplot2)
i = 343
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }
  
  optimalBidVector[t] = optimalBid
  #    utility(bit = bidVector[t],
  #            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
  #   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A Sample Craft Auction")+
  ylab("Bid in $")+ xlab("Bid entry")

#==================================================================================================================
# a Toy and Hobby auction Auction
#==================================================================================================================

# check the values with plot
require(ggplot2)
i = 437
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }
  
  optimalBidVector[t] = optimalBid
  #    utility(bit = bidVector[t],
  #            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
  #   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A Sample Toy and Hobby Auction")+
  ylab("Bid in $")+ xlab("Bid entry")

#==================================================================================================================
# a Stamp auction Auction
#==================================================================================================================

# check the values with plot
require(ggplot2)
i = 530
# don't forget that we have valuation log in the latent
valuationVec = exp(latentVjtM_1[[i]])
bidVector    = AuctionList[[i]]
NbiddersVec    = latentNM_1[[i]]
plot(valuationVec)
plot(NbiddersVec)
plot(bidVector)
bidderIndex = bidderIndexList[[i]]

T = length(valuationVec)
optimalBidVector = bidVector

C0temp = 1e+07
m0temp = 3

# first run the utility given the initial value
#==================================================
for (t in 1:T){
  alphajt = 0.95* alpha[bidderIndex[[t]]]
  betajt  = beta[bidderIndex[[t]]]
  #t = 1
  # inflate the regret by 0.05
  C0 = diag(c(C0temp,0))
  m0 = c(m0temp,1)
  if (t ==1){
    Ct = C0[1]
    mt = m0[1]
  }else{
    Ct = Cttemp[t-1]
    mt = mttemp[t-1]
  }
  optimalBidResult=optim(bidVector[t], utility, NULL, 
                         alphait=alphajt,betait=betajt,mtBid=mt,Ctbid=Ct,vit=valuationVec[t],nt=NbiddersVec[t],
                         method = "BFGS")
  # theory suggests that the bid can not be greater when we have action regret
  # computationally we may have jump to irrelevant values (some irrelevant space)
  # constraint patch to make sure not too much unreasonable
  # also make sure that the bids are increasing according to the rules (always increasing)
  if (t==1){
    optimalBid = min(max(abs(optimalBidResult$par),0.99),5*bidVector[t])
  }else{
    optimalBid = min(max(abs(optimalBidResult$par),max(optimalBidVector[1:t-1])),5*bidVector[t])
  }
  
  optimalBidVector[t] = optimalBid
  #    utility(bit = bidVector[t],
  #            alphait=alphajt[t],betait=betajt[t],mtBid=m0[1],Ctbid=C0[1],vit=valuationVec[t],nt=NbiddersVec[t])
  #   
  # update the distribution of bids (bitp is the new bid that bidder will select with more regret)
  #============================================================================================
  
  # at each step new data with t will be added, so the bids vector will have a new element
  
  dlmstub=dlm(FF = matrix(c(1,0,0,0),ncol=2), V = matrix(c(varObs[i],0,0,0),ncol=2), 
              GG = matrix(c(tau[i],0,drift[i],1),ncol=2), W = matrix(c(varState[i],0,0,0),ncol=2),
              m0 = m0, C0 = C0)
  optimalBids = optimalBidVector[1:t]
  FO = dlmFilter(cbind(optimalBids,rep(0,length(optimalBids))),dlmstub)
  FiltStateM = FO$m[,1]         # m: filtered state
  SaheadFrcst = FO$f            # step-ahead forecast
  #plot(FiltStateM)
  
  SO = dlmSmooth(FO$m[-1,],dlmstub)
  #Ct: the variance of the first state
  Ttemp = t
  Ct = rep(0,Ttemp+1)
  for (t in 1:(Ttemp+1)){
    Ct[t]=SO$U.S[[t]][1] * (SO$D.S[t,1])**2 * t(SO$U.S[[t]][1])
  }
  C0temp = Ct[1]
  Cttemp = Ct[-1]
  m0temp = SO$s[1,1]
  mttemp = SO$s[-1,1]
}

# plot the previous bids versus new bids
x = 1:T
df <- data.frame(x,bidVector,optimalBidVector)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=bidVector), colour="red") +  # first layer
  geom_line(aes(y=optimalBidVector), colour="blue")+
  labs(title = "A Sample Stamp Auction")+
  ylab("Bid in $")+ xlab("Bid entry")