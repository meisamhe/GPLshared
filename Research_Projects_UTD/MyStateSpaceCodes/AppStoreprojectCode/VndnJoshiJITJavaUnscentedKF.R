# library(rJava)
# .jinit()
# obj=.jnew("GibbsR")
#===========================================================
# MCEM implementation of Van den Bulte and Joshi 01/07/2014
# Written by Meisam Hejazi nia
#===========================================================


#===========================
# Cleaning the work space
#===========================
rm(list=ls(pattern="^tmp"))
rm(list=ls())

#===========================
# Selecting libraries to use
#===========================
library(polspline)
library(foreach)
library(doSNOW)
library(MASS)
library(numDeriv)
library("corpcor")
library(psych)
library(Matrix) #to find the nearest positive definite matrix: matrix(nearPD(temp)$mat,ncol=2)
library(mvtnorm)
library(abind)
library(matrixStats)
library(RcppDE)   #C++ implementation of DEoptim
#library(GA)
#library(DEoptim)



#===========================
# Define cluster to run in parallel portions of the code
#===========================
# cl=makeCluster(3)
# registerDoSNOW(cl)
# set.seed(66)
# par(mfrow=c(3,1))

#============================================================================================
#                        Unscented Kalamn Filter for Van den Bulte and Joshi (2007)
#                   By Meisam Hejazi Nia, 01/07/2015
#============================================================================================
fccat= function(ctbar,thetacatj) {
  # ctbar: vector of ncat*2 latent (mean of previous period) for latent number of influentials and immitators
  # odd lines are for influentials and even lines for immitators
  # thetacatj: ncat x 8 vector for ("p1", "p2", "q1", "q2","Ninf", "Nimm", "w")
  ##  VJ diffusion function for category, getting old vector of latent mean and returning the next latent mean
 # cat("fStt")
  ncat = length(ctbar)/2
  #cat ('number of clusters are',ncat)
  thetacatj =matrix(as.numeric(thetacatj),nrow=ncat)
  newmean = rep(0,2*ncat)
  maxDiff = rep(0,2*ncat)
  colnames(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w");
  
  for (i in 1:(ncat)){
    # for influentials
    newmean[(i-1)*2+1]  =   ctbar[(i-1)*2+1]+
      (thetacatj[i,"p1"]+thetacatj[i,"q1"]*(ctbar[(i-1)*2+1]/thetacatj[i,"Ninf"]))*
      (thetacatj[i,"Ninf"]-ctbar[(i-1)*2+1]);
    if (abs(thetacatj[i,"Ninf"])<abs(ctbar[(i-1)*2+1])){
      newmean[(i-1)*2+1]=ctbar[(i-1)*2+1]
    }
    maxDiff[(i-1)*2+1] = thetacatj[i,"Ninf"]
    
    # for immitators
    newmean[(i-1)*2+1]  =    ctbar[(i-1)*2+2]+
      (thetacatj[i,"p2"]+thetacatj[i,"q2"]*(thetacatj[i,"w"]*(ctbar[(i-1)*2+1]/thetacatj[i,"Ninf"])+
                                              (1-thetacatj[i,"w"])*(ctbar[(i-1)*2+2]/thetacatj[i,"Nimm"])))*
      (thetacatj[i,"Nimm"]-ctbar[(i-1)*2+2]);
    if (abs(thetacatj[i,"Nimm"])<abs(ctbar[(i-1)*2+2])){
      newmean[(i-1)*2+2]=ctbar[(i-1)*2+2]
    }
    maxDiff[(i-1)*2+2] = thetacatj[i,"Nimm"]
  }
  #sanity check
  newmean[is.nan(newmean)] = 10
  newmean[is.infinite(newmean)]=100
  
  newmean = pmin(newmean,maxDiff)
  newmean = pmax(ctbar,newmean)
  #cat(",fEnD;")
  return(list(newmean=newmean,maxDiff=maxDiff))
}
  
#----------------------------
# UKF of the app categories
# for now assume v is diagonal, so I do not use matrix form as it  is complex (simplification)
# as a result input v is only a vector
#----------------------------
# to test:
# ycat = categoryDiffWeekly
# pcat = ncat
# m0cat = m0
# C0cat = C0
# vcat = diag(ObsVar)
# wcat = diag(StateVar)
# Gcat = thetacatj

catUKF= function(ycat,Fcat,Gcat,pcat,m0cat,C0cat,vcat,wcat) {
  # Definition of Variables
  # ycat: [I*J*T]  data to use as observation equation
  # Fcat   : [I*1]  it is the same across time
  # pcat   : 1 for now as only one state is running EKF
  # m0cat: [p*J] for the mean of the state of current category
  # C0cat: [p*p*J] for the variance of state equation at each point in time
  # vcat : [J*J]   for simplicity it could be diagonal but general case is also possible
  # wcat : [2*J]   for the variance of state equation of current category
  # thetacatj: [J*(2+J)] for the coefficients, generaly it is GT
  
  
  #===================================
  # solve the problem of original value by setting -5 of the current point
  #===================================
  # rational for assumption, another way to handle is to take initial numbers as 
  # initial starting point and estimate for the rest, but for now this is simpler
  # important is that we have also considered a covariance for it C0
  # seven days a week so at most 7 people at beginning come
  # second at beginning innovators are more
  #m0cat = pmax(ycat[,1]-7,0)%x%c(0.8,0.2)
  
  #*************************************
  #sanity check of the parameters
  #*************************************
  Fcat[is.infinite(Fcat)]   = 0.01
  Fcat[is.nan(Fcat)]   = 0.01
  m0cat[is.infinite(m0cat)] = 100
  m0cat[is.nan(m0cat)] = 100
  C0cat[is.infinite(C0cat)] = 10
  C0cat[is.nan(C0cat)] = 10
  vcat[is.infinite(vcat)] = 10
  vcat[is.nan(vcat)] = 10
  wcat[is.infinite(wcat)] = 10
  wcat[is.nan(wcat)] = 10
  Gcat[is.infinite(Gcat)] = 0.2
  Gcat[is.nan(Gcat)] = 0.2
  
  #========================================
  # Initiale variable definitions
  #========================================
  T    = dim(ycat)[2]
  ncat = dim(ycat)[1]
  mcat = matrix(rep(m0cat,T),ncol=T)
  Ccat = array(rep(0,4*pcat*pcat*T),dim=c(2*pcat,2*pcat,T))
  Ccat[,,1]=C0cat
  mcat[,1]=m0cat
  mtcat = m0cat
  Ctcat = C0cat
  Fcattemp = matrix(rep(0,2*pcat*pcat),ncol = 2*pcat)
  for (j in 1:ncat){
    Fcattemp[j,(j-1)*2+1]=Fcat[(j-1)*2+1]
    Fcattemp[j,(j-1)*2+2]=Fcat[(j-1)*2+2]     
  }
  Fcat = Fcattemp
  MSEcat = matrix(c(rep(0,T*ncat)),ncol=ncat)                        # in each loop sum for all the individuals
  MADcat = matrix(c(rep(0,T*ncat)),ncol=ncat)                                        # in each loop sum for all the individuals
  Y1cat = array(c(rep(0,T*ncat)),dim=c(ncat,T))    # T*J matrix
  
  
  # samples to be used in UKF (L= 2*ncat is the number of samples in Sigma Vector)
  L = 2*ncat
  kappa = 50
  beta = 2
  XtTilde = matrix(rep(0,2*L*2*ncat),nrow=2*ncat)
  alpha = 0.55  # high because otherwise the role of mean is low and I will have negative states
  lambda = alpha^2*(L+kappa) - L
  # defining weights for UKF
  w0m = lambda/(L + lambda)
  w0c = lambda/(L + lambda) + (1-alpha^2+beta)
  wm = matrix(rep(1/(2*(L+lambda)),2*L*2*ncat),nrow=2*ncat)
  wc = matrix(rep(1/(2*(L+lambda)),2*L*2*ncat),nrow=2*ncat) 
  ZtTilde = matrix(rep(0,2*L*2*ncat),nrow=2*ncat) 
  
  # Unscented Kalman Filtering
  for (t in 1:T){
    ##################################################
    # Create a matrix of sigma vector for unscented [ncat x 10]
    # the number of sigma points in Sigma Vector of sample taken is L = 10 with 1 mean
    ##################################################
    # on mean
    fResult = fccat(mtcat,Gcat)
    acat = fResult$newmean
    maxDiff= fResult$maxDiff
    
    #on the 10 points:
    deviation = chol(make.positive.definite((L+lambda)*Ctcat)+diag(rep(1e-2,2*ncat)))
    XtTilde[,1:L] = matrix(rep(matrix(mtcat,ncol=2*ncat),2*ncat),ncol=2*ncat) +deviation
      
    XtTilde[,(L+1):(2*L)] = matrix(rep(matrix(mtcat,ncol=2*ncat),2*ncat),ncol=2*ncat) -
      deviation
    
    # Uncented transformation of sigma vector
    for (i in 1:ncol(XtTilde)){
      ZtTilde[,i] = fccat(XtTilde[,i],Gcat)$newmean 
    }
    acatOld = acat #save the mean to use in variance
    acat = apply(ZtTilde*wm ,1,sum)+ w0m * acat
    
    #***********************************
    # sanity check
    #***********************************
    acat = pmax(pmin(acat ,maxDiff),mtcat)
    
    # Uncertainty about state based on state equation is 
    # I added wcat, because otherwise math does not add up
    rcat = ((ZtTilde-acat)*wc)%*%t(ZtTilde-acat) + w0c * crossprod(t(acatOld-acat))  + wcat
    
      
    #no wcat, because we have already perturbed the initial state, to get new prior
    
    #***********************************
    # sanity check
    #***********************************
    rcat[is.infinite(rcat)]=10
    rcat[is.nan(rcat)]=10
    
    # a step ahead forecast
    hcat  = Fcat%*%acat
    forecastcat  = hcat     # for readability only
    Y1cat[,t]= as.vector(forecastcat)  # step ahead forecast saving
    # based on wan and van der Merve (2000) paper, variance of a step ahead forecast
    qcat = (t(cbind(t(Fcat%*%(ZtTilde-acat)),
                          matrix(rep(0,2*L*ncat),ncol=ncat)))*wc)%*%
      (cbind(t(Fcat%*%(ZtTilde-acat)),
              matrix(rep(0,2*L*ncat),ncol=ncat))) + 
      w0c * crossprod(cbind(t(Fcat%*%(acatOld-acat)),
                            matrix(rep(0,ncat),ncol=ncat))) + diag(c(vcat,rep(0,ncat))) #vcat
    
    #sanity check
    qcat = (qcat + t(qcat))/2
    qcat[is.infinite(qcat)]=10
    qcat[is.nan(qcat)]=10
    
    # built for wan and van der Merve (2000) paper
    nomcat = ((XtTilde-acat)*wc)%*%cbind(t(Fcat%*%(ZtTilde-acat)),
                                         matrix(rep(0,2*L*ncat),ncol=ncat))+ 
      matrix(w0c * (acatOld-acat),ncol=1)%*%cbind(t(Fcat%*%(acatOld-acat)),
                                     matrix(rep(0,ncat),ncol=ncat))
        
    ecat    = ycat[,t] - forecastcat   # error of forecast 
    ecat    = rbind(ecat,matrix(rep(0,ncat),ncol=1))  # to be able to use it in Kalman Gain multiplication
    
    #add extra column of zeros to have [yt 0]=[tt 1-tt; 0 0][ttcatInf ttcatImm]
    
    # Kalman Gain
    Acat = nomcat %*%ginv(qcat)
      
    MSEcat[t,]=sum(ecat**2)
    MADcat[t,]= sum(abs(ecat))
    mtcat = acat + Acat %*% ecat
    Ctcat = rcat - Acat%*%qcat%*%t(Acat)
    Ctcat = (Ctcat+t(Ctcat))/2
    
    #*************************************
    #sanity check
    #**************************************
    Ctcat[is.infinite(Ctcat)]=10
    Ctcat[is.nan(Ctcat)]=10
    
    Ccat[,,t] =Ctcat  
    mcat[,t] = mtcat  
    mcat[,t]= pmin(mcat[,t],maxDiff)
    mcat[,t]= pmax(acat,mcat[,t])
    mtcat = mcat[,t]
    cat(t, ",") 
  }
  
  cat("\n")
  return(list(mcat=mcat,Ccat=Ccat,m0cat=m0cat,C0cat=C0cat,
              Y1cat=Y1cat,MADcat=MADcat,MSEcat=MSEcat))
}


#============================================================================================
#                     End of Unscented Kalman Filter
#============================================================================================

#===========================
# Defining the data input files
#===========================

#categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GlobalCategoryDiffusion.csv",header=T)
categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/CategoryDiffusion.csv",header=T)

CategoryHBData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/CategoryHB.csv",header=T)
vanDenBulteJoshiData = read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/VanJoshiInitial.csv",header=T)
#===========================
# featching the categories data
#===========================
#read the data
ncat = 10
T  = nrow(categoryDiffData)#258 for global
                           # 191 for local
ndiffVar = 8
categoryDiff= matrix(rep(0,ncat*T),ncol=ncat)
for (i in 1:ncat){
  categoryDiff[,i]=categoryDiffData[[i+1]]
}
categoryDiff=t(categoryDiff)

categoryDiffWeekly = matrix(rep(0,((T-(T%%7))/7*ncat)),ncol=ncat)
# prepare data for FFBS by aggregating
for (i in 1:ncat){
  currentCat = i
  currentSales = categoryDiff[currentCat,]
  currentSalesTemp = t(matrix(currentSales[1:(T-(T%%7))],nrow=7))
  categoryDiffWeekly[,i]=rowMeans(currentSalesTemp)
}
categoryDiffWeekly = t(categoryDiffWeekly)

# it seems I do not have enough data, so I will use daily data
categoryDiffWeekly = categoryDiff

nzcat = 1
CategoryHB= matrix(rep(0,ncat*nzcat),ncol=nzcat)
CategoryHB[,1]=CategoryHBData[[3]]

#==============================
# Plot the data to make sure they are loaded properly
#==============================
# daily view
# plot(categoryDiff[1,]);plot(categoryDiff[2,]);plot(categoryDiff[3,])
# plot(categoryDiff[4,]);plot(categoryDiff[5,]);plot(categoryDiff[6,])
# plot(categoryDiff[7,]);plot(categoryDiff[8,]);plot(categoryDiff[9,])
# weekly view
# plot(categoryDiffWeekly[1,]);plot(categoryDiffWeekly[2,]);plot(categoryDiffWeekly[3,])
# plot(categoryDiffWeekly[4,]);plot(categoryDiffWeekly[5,]);plot(categoryDiffWeekly[6,])
# plot(categoryDiffWeekly[7,]);plot(categoryDiffWeekly[8,]);plot(categoryDiffWeekly[9,])

# plot(CategoryHB)



#==========================================================================================
#            Main Function of Van den Bulte and Joshi Unscented Kalman Filter Estimation
#==========================================================================================
VJUKFAppStore= function(appStoreParametersVJ) {
  # appStoreParametersVJ = initialValue
  # appStoreParametersVJ = initialpop[3,]
  thetacatj   = matrix(appStoreParametersVJ[1:(8*ncat)],nrow=ncat)
  ObsVar      = abs(appStoreParametersVJ[(8*ncat+1):(9*ncat)])
  triangElement = appStoreParametersVJ[(9*ncat+1):(9*ncat+(2*ncat*(2*ncat+1)/2))]
  StateVar    = matrix(rep(0,4*ncat^2),
                       ncol = 2*ncat)
  StateVar[lower.tri(StateVar)] = triangElement[1:(2*ncat*(2*ncat-1)/2)]
  diag(StateVar)                =  triangElement[(2*ncat*(2*ncat-1)/2+1):length(triangElement)]
  
  StateVar = StateVar+t(StateVar)
  
  if (!is.positive.definite(StateVar)){
    StateVar = make.positive.definite(StateVar+diag(rep(1e-2,2*ncat)))
  }
  #******************************
  # Sanity check
  #******************************
  StateVar[is.nan(StateVar)] = 1e3
  StateVar[is.infinite(StateVar)] = 1e3
  ObsVar[is.nan(ObsVar)] = 1e3
  ObsVar[is.infinite(ObsVar)] = 1e3
  
  # transforming variables
  #==========================================================
  # N(inf) and N(immt) are positive per theory so exp(x) transofmration
  Ninf=exp(thetacatj[,5])
  Ninf[is.infinite(Ninf)] = 3e3
  Ninf[is.nan(Ninf)] = 3e3
  Ninf = pmin(Ninf,8e3)
  thetacatj[,5] = Ninf
  #thetacatj[,6]=exp(thetacatj[,6])
  
  # weight is also between zero and one so the logit transformation used
  Nimm=exp(thetacatj[,6])
  Nimm[is.infinite(Nimm)] = 3e3
  Nimm[is.nan(Nimm)] = 3e3
  Nimm = pmin(Nimm,8e3)
  thetacatj[,6] = Nimm
  
  thetacatj[,7]=exp(thetacatj[,7])/(1+exp(thetacatj[,7]))
  
  # segment size is also between zero and one so the logit transformation used
  thetacatj[,8]=exp(thetacatj[,8])/(1+exp(thetacatj[,8]))
  
  #sanitcy check
  
  thetacatj[is.nan(thetacatj)] = 1e-2
  thetacatj[is.infinite(thetacatj)] = 1e-2
  
  #=============
  # variable I have used somewhere but I don't know where except UKF
  # also set other variables
  #=============
  pcat = ncat
  Fcat = as.vector((rbind(thetacatj[,8],1-thetacatj[,8])))
  Gcat = matrix(thetacatj[,1:7],ncol=7)

  
  #======================================================
  # Fit a non parametric regression as prior and keep the likelihood
  # Generally it may always be -Inf, but it is good to account for it
  #========================================================
  print (paste('dim of thetacatj is:',dim(thetacatj),'\n'))
  print (paste('dim of CategoryHB is:',length(CategoryHB),'\n'))
  result = polymars(thetacatj, CategoryHB,gcv=1)
  covPrior = cov(thetacatj - result$fitted)
  paramPriorLL = apply(thetacatj-result$fitted,1,function(x) {
    dmvnorm(x=x, mean = rep(0,8),sigma = covPrior+1, log = TRUE)})
  
  paramPriorLL[is.infinite(paramPriorLL)] = -1e5
  
  paramPriorLL = sum(paramPriorLL)
  
  #======================================================
  # run FFBS to estimate vand den Bulte and Joshi (2007)
  #======================================================
  print ('Starting UKF--------------------------------------------------------------\n')
  resultUKF = catUKF(ycat=categoryDiffWeekly,Fcat = Fcat,Gcat = Gcat,pcat = ncat,
                     m0cat = m0,C0cat = C0,vcat = ObsVar,wcat = StateVar)
  
  mcat  = resultUKF$mcat
  Ccat  = resultUKF$Ccat
  m0cat = resultUKF$m0cat
  C0cat = resultUKF$C0cat
  Y1cat = resultUKF$Y1cat
  MADcat = resultUKF$MADcat
  MSEcat = resultUKF$MSEcat
  
  print ('UKF Finished----------------------------------------------------------------\n')
  #====================================================
  # Plot to check how the curves are similar
  #====================================================
  # weekly view
  # plot(categoryDiffWeekly[1,]);plot(categoryDiffWeekly[2,]);plot(categoryDiffWeekly[3,])
  # plot(Y1cat[1,]);plot(Y1cat[2,]);plot(Y1cat[3,])
  
  # plot(categoryDiffWeekly[4,]);plot(categoryDiffWeekly[5,]);plot(categoryDiffWeekly[6,])
  # plot(Y1cat[4,]);plot(Y1cat[5,]);plot(Y1cat[6,])
  
  # plot(categoryDiffWeekly[7,]);plot(categoryDiffWeekly[8,]);plot(categoryDiffWeekly[9,])
  # plot(Y1cat[7,]);plot(Y1cat[8,]);plot(Y1cat[9,])
  
  #===========================================================
  # calculate Expected Likelihood for the influentials and immitators
  #===========================================================
  
  print ('Starting to calculate Expected LL on the cat............................\n')
  
  sN = 50 # as normally 30 sample point is enough, here I reduced 100 to 50 to speed up
  # 1000 point for MC simulation
  
  sample = array(rep(0,sN*(T+1)*2*ncat),dim=c(T+1,2*ncat,sN))        #T+1 
  catMean=cbind(m0cat,mcat)
  catVar = abind(C0cat,Ccat,along=3)
  Fcattemp = matrix(rep(0,2*pcat*pcat),ncol = 2*pcat)
  for (j in 1:ncat){
    Fcattemp[j,(j-1)*2+1]=Fcat[(j-1)*2+1]
    Fcattemp[j,(j-1)*2+2]=Fcat[(j-1)*2+2]     
  }
  FcatCoeff = Fcattemp
  
  obsvEqLLitem = matrix(rep(0,(T+1)*sN),ncol=sN)
  stateEqLLitem = matrix(rep(0,(T+1)*sN),ncol=sN)
  
  for (t in 1:(T+1)){ 
    print (paste('for t=',t,'\n'))
    # make sure the element is positive definite
    varElement =catVar[,,t]
    diag(varElement) = abs(diag(varElement))
    varElement = make.positive.definite(varElement)
    varElement = varElement + diag(rep(1e-2,2*ncat))
    sample[t,,]=t(mvrnorm(n = sN, mu = catMean[,t],Sigma = varElement,tol = 1e-6,
                          empirical = FALSE, EISPACK = FALSE))
    # log (P(Y(1:T)|X(1:T))): loglik of observation equation
    if (t>1){ # because predictions starts at time 2-1
      prediction = apply(sample[t,,],2,function(x){
        FcatCoeff%*%x
      })
      obsvEqLLitem[t,] = apply(matrix(rep(categoryDiffWeekly[,t-1],sN),ncol=sN)-prediction,2,function(x) {
        dmvnorm(x=x, mean = rep(0,length(ObsVar)),sigma = diag(ObsVar), log = TRUE)})
      
      # delibrately ignored tt0, as it may not really affect, or may not be relevant
      statePredic = apply(sample[t-1,,],2,function(x){
        fccat(x,Gcat)$newmean
      })
      stateEqLLitem[t,] = apply(sample[t,,]-statePredic,2,function(x) {
        dmvnorm(x=x, mean = rep(0,sqrt(length(StateVar))),sigma =StateVar, log = TRUE)})
      
    }
  }

  # log(sum(exp(lx))) to calculate  log(sum(x)).: logSumExp(lx, na.rm=TRUE, ...) in library(matrixStats)
  categoryLL =   logSumExp(lx = (apply(obsvEqLLitem,2,sum)+ apply(stateEqLLitem,2,sum)), na.rm=TRUE)
  print ('calculating Expected LL on the cat Finished............................\n')
  
  #=================================================================
  # Wrapping up... calculating maximum posteriori and save results into file
  #=================================================================
  priorSum = sum(paramPriorLL)
  
  #sanity check
  priorSum[is.nan(priorSum)]=-1e50
  categoryLL[is.nan(categoryLL)]=-1e50
  
  MAP = categoryLL + priorSum
  #==================================================
  # Saving into Log Files
  #==================================================
  curFileIndex <<- curFileIndex + 1
  fullCurLogFile = paste(logFilePath,'logFile',curFileIndex,'.txt')
  
  # writing the auction parameters parameters
  write('The value of Joshi and van den Bulte Parameters\n------------------------------------------------------
        \n (p1,p2,q1,q2,M1,M2,w,tt) \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(thetacatj, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(thetacatj), sep = "\t")
  
  write('\n [m0,mt] \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(catMean, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(catMean), sep = "\t")
  
  write('\n Obsv Equation Variance [1 x ncat] \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(ObsVar, file = fullCurLogFile,
        append = TRUE,ncolumns =length(ObsVar), sep = "\t")
  
  write('\n State Equation Variance [1 x ncat] \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(StateVar, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(StateVar), sep = "\t")
  
  write('\n A step ahead forecast \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(Y1cat, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(Y1cat), sep = "\t")
  
  write('\n Mean Absolute Deviation \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(MADcat, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(MADcat), sep = "\t")
  
  write('\n Mean Square Error \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(MSEcat, file = fullCurLogFile,
        append = TRUE,ncolumns =nrow(MSEcat), sep = "\t")
  
  write('\n Maximum Likelihood \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(categoryLL, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  write('\n Prior on the parameters LL \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(paramPriorLL, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  write('\n Maximum A Posteriori \n-------------------------------------\n', file = fullCurLogFile,
        append = TRUE, sep = "\t")
  
  write(MAP, file = fullCurLogFile,
        append = TRUE,sep = "\t")
  
  # I want to maximize MAP which means minimize the negative of it
  return(-MAP)
  
}

#=============================================================================
# Defining Log file, and running Genetic Algorithm to maximize likelihood
#=============================================================================
#================================
# Definies parameters to estimate
#================================
Deltacat=matrix(runif(ndiffVar)*1e-20,ncol=1) # generate Delta for thetacat=Deltacat*Zcat+ujcat
# parameters of Vand del Bulte and Joshi
# parameters sequence (p1,p2,q1,q2,M1,M2,w,tt)
# subscript 1: Influentials
# subscript 2: Immitators
# w: impact of Influentials and Immitators
# tt: size of segment of influentials and 1-tt size of segment of immitators
# added sum perturbation to make sure I don't have problem of regression NaNs
thetacatj = matrix(rep(1,ncat*ndiffVar),ncol=ndiffVar)+matrix(2*runif(ncat*ndiffVar),ncol=ndiffVar)

# set the market size to the maximum for beginnin
thetacatj[,1:2] = 0.001
thetacatj[,3:4] = 0.4
thetacatj[,5] = log(ceiling(apply(categoryDiffWeekly,1,max)*0.2 )) # log because transformed inside
thetacatj[,6] = log(ceiling(apply(categoryDiffWeekly,1,max)*0.8 ))  #log because transformed inside
thetacatj[,7] = log(0.3/(1-0.3))

ObsVar  = rep(1,ncat)     # as only one observation equation exists for each
StateVar = diag(rep (1,ncat*2))  # one for Influentials and one for Immitators
m0 = rep (1,ncat*2)       # one for influentials and one for Immitators
C0 = diag(rep(5,ncat*2))  # a diagonal matrix prior at beginning
Fcat = rep(c(0.2,0.8),ncat)
thetacatj[,8] = log(0.2/(1-0.2))
Gcat = matrix(thetacatj[,1:7],ncol=7)
T = ncol(categoryDiffWeekly)
initialValue = c(thetacatj,ObsVar,
                 StateVar[lower.tri(StateVar)],diag(StateVar))


#==========================================
# Creating initial population to speed up the optimization (NPDE=20 random items)
#==========================================
initialValue = c(thetacatj,ObsVar,
                 StateVar[lower.tri(StateVar)],diag(StateVar))
NPDE=20
numParam = length(initialValue)
initialpop = matrix(rep(0,NPDE*numParam),ncol = numParam) # NPDE x numParam 
#initialpop[1,] = initialValue
InitialStateVarElement = c(StateVar[lower.tri(StateVar)],diag(StateVar))
elementStateVarLength = length(c(StateVar[lower.tri(StateVar)],diag(StateVar)))
thetacatjPerturb = thetacatj
for (i in 1:(NPDE)){
  #   pPerturb = matrix(50*runif(2*ncat),ncol=2)
  #   qPerturb = matrix(5*runif(2*ncat),ncol=2)
  #   Mperturb = matrix(5*runif(2*ncat),ncol=2)
  #   wPerturb = (4-matrix(20*runif(1*ncat),ncol=1))/log(0.3/(1-0.3))
  #   ttPerturb = (4-matrix(20*runif(1*ncat),ncol=1))/log(0.2/(1-0.2))
  #   perturb = cbind(pPerturb,qPerturb,Mperturb,wPerturb,ttPerturb)
  #   thetacatjPerturb = thetacatj*perturb
  # p1, p2, q1, q2, set the same across all
  thetacatjPerturb[,1:4]=(1+runif(ncat)/10)%x%as.matrix(vanDenBulteJoshiData[i,1:4])
  #set w
  thetacatjPerturb[,7]=(1+runif(ncat)/10)%x%(log(as.matrix(vanDenBulteJoshiData[i,5])+1e-4)-log(as.matrix(1-vanDenBulteJoshiData[i,5]))+1e-4)
  thetacatjPerturb[,8]=(1+runif(ncat)/10)%x%(log(as.matrix(vanDenBulteJoshiData[i,6])+1e-4)-log(as.matrix(1-vanDenBulteJoshiData[i,6]))+1e-4)
  
  segmentSize = as.matrix(vanDenBulteJoshiData[i,6])
  # M1 and M2, inflate by 1.2 to make sure it is consistent
  thetacatjPerturb[,5] = log(ceiling((apply(categoryDiffWeekly,1,max)*2)*segmentSize)+1e-4) # log because transformed inside
  thetacatjPerturb[,6] = log(ceiling((apply(categoryDiffWeekly,1,max)*2)*(1-segmentSize) )+1e-4)  #log because transformed inside
  if (i > 10){  # sparse as the solutions are really sparse when I even set 3
    ObsVarPerturb = (ObsVar+1*runif(length(ObsVar)))
    # make sure it is between -1 and 1
    StateVarPerturb = InitialStateVarElement+(c(1-2*runif(length(c(StateVar[lower.tri(StateVar)]))),
                                                2*runif(length(diag(StateVar)))))
    
  }else{ # keep diagonal
    ObsVarPerturb = ObsVar
    StateVarPerturb = InitialStateVarElement
  }
  #make sure it is around 4      
  initialpop[i,]=c(thetacatjPerturb,ObsVarPerturb,
                   StateVarPerturb)
}
#test
#temp=t(matrix(initialpop[1,1:80],nrow=10))

#============================================
# Set lower and higher bounds
#============================================
#resultOfFiltering = slow_func_compiled(logfilename,categoryDiffData,CategoryHBData)
#apply(vanDenBulteJoshiData,2,max)
#apply(vanDenBulteJoshiData,2,min)
# maximum of van den Bulte and Joshi: 
# p1     p2    q1    q2    w    tt
#0.291 0.990 0.074 5.590 0.970 1.000 
#minimum of van den Bulte and Joshi:
# p1    q1    p2    q2    tt     W 
# 1e-05 1e-04 0e+00 1e-04 5e-02 1e-02 
# for Bass model pmax = 0.157 qmax = 0.603
# allow negative to check the significance
thetacatjLow = thetacatj
# max(categoryDiffWeekly) = 2388 for marke tsize
# parameters are: (p1,p2,q1,q2,M1,M2,w,tt)
thetacatjLow = -t(matrix(rep(c(0.291,0.99,0.074, 5.59, 0, 0,
                               log(0.970)-log(1-0.970),log(1)-log(0.0001)),ncat),nrow=8))
thetacatjHigh = t(matrix(rep(c(0.291,0.99,0.074, 5.59, log(2388*2), log(2388*(2)),
                               log(0.970)-log(1-0.970),log(1)-log(0.0001)),ncat),nrow=8))
#for the covariance elements allow 5
# for the variance allow 10
ObsVarLow = rep(0,length(ObsVar))
ObsVarHigh = rep(10,length(ObsVar))
# make sure it is between -2 and 2
StateVarLow = InitialStateVarElement+c(rep(-5,length(c(StateVar[lower.tri(StateVar)]))),
                                       rep(0,length(diag(StateVar))))
StateVarHigh = InitialStateVarElement+c(rep(5,length(c(StateVar[lower.tri(StateVar)]))),
                                        rep(10,length(diag(StateVar))))

lower <- c(thetacatjLow,ObsVarLow,
           StateVarLow)
#(p1,p2,q1,q2) are assumed between 1 and -1 to check significance
upper <- c(thetacatjHigh,ObsVarHigh,
           StateVarHigh)

#=============================================
# Log files to save the the HB and the current Parameters, and Likelihood
#=============================================
logFilePath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/vanDenBulteJoshiResultLog/"
curFileIndex = 1

require(compiler)
library(compiler)
enableJIT(3)


slow_func_compiled <- cmpfun(VJUKFAppStore)

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


resultOfFiltering =
  DEoptim(slow_func_compiled, lower, upper #initialpop=latentitoldpop, # irecieved wiered error Error in match.fun(FUN) : '1'
                                ,DEoptim.control(initialpop = initialpop, itermax=100, NP = NPDE))

# resultOfFiltering$optim$bestmem
# resultOfFiltering$optim$bestval
#LLFinal=slow_func_compiled(resultOfFiltering$optim$bestmem)

#=====================================
# Old tested codes
#=====================================



#   ga(type = "real-valued", fitness = slow_func_compiled,
#                        min = lower, max = upper)

  
#   DEoptim(slow_func_compiled, lower, upper #initialpop=latentitoldpop, # irecieved wiered error Error in match.fun(FUN) : '1'
#                              ,DEoptim.control( reltol=1e-6, itermax=100))
       
  
  
#    optim(initialValue,slow_func_compiled,method="BFGS",control=list( fnscale=1,trace=1,reltol=1e-6), 
# hessian = TRUE)
  
#   outDEoptim <- DEoptim(slow_func_compiled, lower, upper,
#                          DEoptim.control(itermax = 1000,
#                                          storepopfrom = 1, storepopfreq = 2))
  
  
#   optim(initialValue,slow_func_compiled,method="SANN", 
#       control=list( fnscale=1,trace=1,reltol=1e-4,maxit=1000) #hessian = TRUE
#)

# DEoptim.control(VTR = -Inf, strategy = 2, bs = FALSE, NP = NA,
#                 itermax = 200, CR = 0.5, F = 0.8, trace = TRUE, initialpop = NULL,
#                 storepopfrom = itermax + 1, storepopfreq = 1, p = 0.2, c = 0, reltol,
#                 steptol, parallelType = 0, packages = c(), parVar = c(),
#                 foreachArgs = list())
# 
# lower <- rep(-10,length(c(thetacatj,ObsVar,StateVar)))
# upper <- -lower
# 
# outDEoptim <- DEoptim(VJUKFAppStore, lower, upper,
#                       DEoptim.control(itermax = 1000,
#                                       storepopfrom = 1, storepopfreq = 2))