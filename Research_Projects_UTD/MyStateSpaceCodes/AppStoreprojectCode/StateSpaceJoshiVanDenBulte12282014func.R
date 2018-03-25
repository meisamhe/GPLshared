#-------------------------------------------------------------------------------
# Estimation of the Vand den Bulte and Joshi (2007), influential and immitators
# By: Meisam Hejazi Nia
# Date: Dec 28, 2014
#-------------------------------------------------------------------------------
rm(list=ls(pattern="^tmp"))
rm(list=ls())
library(bayesm)
library(foreach)
library(abind)
library(doSNOW)
library(DEoptim)
library(MASS)
library(numDeriv)
library("corpcor")
library(psych)
library(Matrix) #to find the nearest positive definite matrix: matrix(nearPD(temp)$mat,ncol=2)
cl=makeCluster(7)
registerDoSNOW(cl)
set.seed(66)
par(mfrow=c(3,1))


StateSpaceJoshiVanDenBulte12282014func=
  function(logfilename,categoryDiffData,CategoryHBData){
    # #wrap into function to make sure it runs faster, and I can use JIT
    logfile = file(logfilename)  
    sink(logfile,append=TRUE)
    
    
    #---------------------------------------------------------------------------
    # Read data of category diffusion
    #===========================================================================
    ncat = 10
    T    = 258
    categoryDiff= matrix(rep(0,ncat*T),ncol=ncat)
    for (i in 1:ncat){
      categoryDiff[,i]=categoryDiffData[[i+1]]
    }
    categoryDiff=t(categoryDiff)
    # plot(categoryDiff[1,])
    
    catlatent = categoryDiff
    totalForce = catlatent # b/c in FFBS we only would need aggregate
    categoryDiffWeekly = matrix(rep(0,((T-(T%%7))/7*ncat)),ncol=ncat)
    # prepare data for FFBS by aggregating
    for (i in 1:ncat){
      currentCat = i
      currentSales = totalForce[currentCat,]
      currentSalesTemp = t(matrix(currentSales[1:(T-(T%%7))],nrow=7))
      categoryDiffWeekly[,i]=rowMeans(currentSalesTemp)
    }
    categoryDiffWeekly = t(categoryDiffWeekly)
    T = dim(categoryDiffWeekly)[2]
    # set the scale
    categoryDiffWeekly = categoryDiffWeekly /10
    #---------------------------------------------------------------------------
    # Read CategoryHB data
    #===========================================================================
    nzcat = 1
    CategoryHB= matrix(rep(0,ncat*nzcat),ncol=nzcat)
    CategoryHB[,1]=CategoryHBData[[3]]
    
    
    #-------------------------------------------------------------------------------
    # first: simulate state space of category in a for loop for j=1...J (HB)+ complementarity
    # HB includes: popularity of category
    #-------------------------------------------------------------------------------
    Zcat=CategoryHB
    Zcat=t(t(Zcat)-apply(Zcat,2,mean))          # demean Zcat, popularity explanator of category
    ncompcat= 3                                 # no of mixture components of category is consider 3
    Deltacat=matrix(runif(3)*1e-20,ncol=1) # generate Delta for thetacat=Deltacat*Zcat+ujcat
    Deltacat[1,]=0.0003 # set p's mean data
    Deltacat[2,]=0.001 # set q's mean data
    Deltacat[3,]=1000 # set Cj's mean data
    compscat=NULL
    compscat[[1]]=list(mu=runif(3)*1e-6,rooti=diag(rep(1,3)*1e6))
    compscat[[2]]=list(mu=runif(3)*1e-7,rooti=diag(rep(1,3)*1e6))
    compscat[[3]]=list(mu=runif(3)*1e-9,rooti=diag(rep(1,3)*1e6))
    pveccat=c(.4,.2,.4)
    
    # error of the state equationn for the diffusion of category
    wcat = 0.5*diag(ncat)
    wcat[is.infinite(wcat)] = 10
    wcat[is.nan(wcat)] = 10
    wcat = matrix(nearPD(make.positive.definite(wcat))$mat,ncol=sqrt(length(wcat)))
    ewcat = t(chol(wcat))%*%matrix(rnorm(ncat*T,mean=0,sd=1),ncol=T)
    
    catlatent = categoryDiffWeekly;   # initialize state and allocate space
    thetacatj = matrix(rep(1,ncat*(3)),ncol=3)
    colnames(thetacatj) <- c("p","q","Cj")
    for (i in 1:ncat){
      thetacatj[i,]=Deltacat%*%Zcat[i,]+as.vector(rmixture(1,pveccat,compscat)$x)
      # make sure that market size (M), p and q are positive for the sake of simulation
      thetacatj[i,1]=abs(thetacatj[i,1]);
      thetacatj[i,2]=abs(thetacatj[i,2]);
      thetacatj[i,3]=abs(thetacatj[i,3]);
    }
    
    # check the data generated
    #     plot( catlatent[1,], type="l")
    #     plot( catlatent[2,], type="l")
    # for (i in 1:ncat){
    #    plot(catlatent[i,],type="l")
    #    par(ask=TRUE)
    # }
    
    #=====================================================================================
    #                            End of Simulating the data
    #=====================================================================================
    
    #=====================================================================================
    #                            Beginning  of Estimation
    #=====================================================================================
    
    #-------------------------------------------------------------------------------------
    #                             Extended Kalman Filter for Category
    #-------------------------------------------------------------------------------------
    
    #----------------------------
    #   Bass function for the Category
    #----------------------------
    # for test:
    #ctbar=catlatent[,1]
    
    #ctbar = mtcat
    #thetacatj = thetacatjest
    
    #Van den Bulte and Joshi (2007) model of influential and immitators
    
    # j: category t: time
    # total adopters: D(jt) = tt1.I(jt) + (1-tt1).M(jt)+ ep(jt)
    # influentials: I'(jt) = (p1+ q1.I(jt-1)/N(inf)) (N(inf) - I(jt-1)) + v(jt)
    # immitatrs: M'(jt)= (p2 + q2*w*I(jt-1)/N(inf)+ q2*(1-w)*M(jt-1)/N(imm))(N(imm)- M(jt-1))
    
    #Discretize
    # j: category t: time
    # total adopters: D(jt) = tt1.I(jt) + (1-tt1).M(jt)+ ep(jt)
    # influentials: I(jt+1) = I(jt) + (p1+ q1.I(jt-1)/N(inf)) (N(inf) - I(jt-1)) + v(jt)
    # immitatrs: M(jt+1) = M(jt) +  (p2 + q2*w*I(jt-1)/N(inf)+ q2*(1-w)*M(jt-1)/N(imm))(N(imm)- M(jt-1))
    
    fccat= function(ctbar,thetacatj) {
      # ctbar: vector of ncat*2 latent (mean of previous period) for latent number of influentials and immitators
      # odd lines are for influentials and even lines for immitators
      # thetacatj: ncat x 8 vector for ("p1", "p2", "q1", "q2","Ninf", "Nimm", "w")
      ##  VJ diffusion function for category, getting old vector of latent mean and returning the next latent mean
      cat("fS")
      ncat = length(ctbar)/2
      #cat ('number of clusters are',ncat)
      thetacatj =matrix(as.numeric(thetacatj),nrow=ncat)
      newmean = rep(0,2*ncat)
      maxDiff = rep(0,2*ncat)
      colnames(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w");
      
      for (i in 1:(ncat)){
        # for influentials
        newmean[(i-1)*2+1]=ctbar[(i-1)*2+1]+
          (thetacatj[i,"p1"]+thetacatj[i,"q1"]*(ctbar[(i-1)*2+1]/thetacatj[i,"Ninf"]))*
          (thetacatj[i,"Ninf"]-ctbar[(i-1)*2+1]);
        if (abs(thetacatj[i,"Ninf"])<abs(ctbar[(i-1)*2+1])){
          newmean[(i-1)*2+1]=ctbar[(i-1)*2+1]
        }
        maxDiff[(i-1)*2+1] = thetacatj[i,"Ninf"]
        
        # for immitators
        newmean[(i-1)*2+1]=ctbar[(i-1)*2+2]+
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
      newmean = pmax(0,newmean)
      cat("fD")
      return(list(newmean=newmean,maxDiff=maxDiff))
    }
    
    #----------------------------
    #   Jacobian of Bass for Category
    #----------------------------
    # for test:
    #ctbar=catlatent[,1]
    Jccat= function(ctbar,thetacatj,maxDiff) {
      cat("JS") 
      ctbar= pmin(ctbar,maxDiff)
      ctbar= pmax(0,ctbar)
      
      # ctbar is vector of ncat latent (mean of previous period)
      ##  Bass diffusion function for category, getting old vector of latent mean and returning the next latent mean
      ncat = length(ctbar)/2
      #cat ('number of clusters are',ncat)
      
      newJacob = matrix(rep(0,4*ncat*ncat),ncol=2*ncat);
      colnames(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm", "w");
      
      for (i in 1:(ncat)){
        # for influentials
        newJacob[(i-1)*2+1,(i-1)*2+1]=1+
          (thetacatj[i,"q1"]/thetacatj[i,"Ninf"])* (thetacatj[i,"Ninf"]-ctbar[(i-1)*2+1]) - 
          (thetacatj[i,"p1"]+thetacatj[i,"q1"]*(ctbar[(i-1)*2+1]/thetacatj[i,"Ninf"])) ;
        
        newJacob[(i-1)*2+1,(i-1)*2+1] = 0
        
        # for immitators
        newJacob[(i-1)*2+2,(i-1)*2+1]= (thetacatj[i,"q2"]*(thetacatj[i,"w"]/thetacatj[i,"Ninf"]))*
          (thetacatj[i,"Nimm"]-ctbar[(i-1)*2+2]);
        
        newJacob[(i-1)*2+2,(i-1)*2+2]= 1 +
          (thetacatj[i,"q2"]*(1-thetacatj[i,"w"])/(thetacatj[i,"Nimm"]))*
          (thetacatj[i,"Nimm"]-ctbar[(i-1)*2+2])-          
          (thetacatj[i,"p2"]+thetacatj[i,"q2"]*(thetacatj[i,"w"]*(ctbar[(i-1)*2+1]/thetacatj[i,"Ninf"])+                                              
                                                  (1-thetacatj[i,"w"])*(ctbar[(i-1)*2+2]/thetacatj[i,"Nimm"])))
      }
      # sanity check of the parameters
      newJacob[is.nan(newJacob)]=0
      newJacob[is.infinite(newJacob)]=10    
      cat("JD")
      return(list(newJacob=newJacob))
    }
    
    
    #----------------------------
    # EKF of the app categories
    # for now assume v is diagonal, so I do not use matrix form as it  is complex (simplification)
    # As vectorization was not possible I will use parallelization
    #----------------------------
    # to test:
    # ycat = catIndvlatent
    # Fcat = gammaIndv
    # pcat = ncat
    # m0cat = 3*matrix(c(rep(1,2*pcat)),ncol=2*ncat)
    # C0cat = 2*diag(c(rep(1,2*pcat)))
    # vcat = array(rep(0,nIndv*nIndv*ncat),dim=c(nIndv,nIndv,ncat))
    # for (j in 1:ncat){
    #       vcat[,,j] = 0.1*diag(nIndv)
    # }
    # wcat = 0.5*diag(c(rep(1,2*pcat)))
    # thetacatj = thetacatjest
    catEKF= function(ycat,Fcat,pcat,m0cat,C0cat,vcat,wcat,thetacatj) {
      # Definition of Variables
      # ycat: [I*J*T]  data to use as observation equation
      # Fcat   : [I*1]  it is the same across time
      # pcat   : 1 for now as only one state is running EKF
      # m0cat: [p*J] for the mean of the state of current category
      # C0cat: [p*p*J] for the variance of state equation at each point in time
      # vcat : [I*I*J]   for simplicity it could be diagonal but general case is also possible
      # wcat : [J*J]   for the variance of state equation of current category
      # thetacatj: [J*(2+J)] for the coefficients, generaly it is GT
      
      #sanity check of the parameters
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
      thetacatj[is.infinite(thetacatj)] = 0.2
      thetacatj[is.nan(thetacatj)] = 0.2
      
      T    = dim(ycat)[1]
      ncat = dim(ycat)[2]
      MSEcat = matrix(c(rep(0,T*ncat)),ncol=ncat)                        # in each loop sum for all the individuals
      MADcat = matrix(c(rep(0,T*ncat)),ncol=ncat)                                        # in each loop sum for all the individuals
      Y1cat = array(c(rep(0,T*ncat)),dim=c(ncat,T))    # T*J matrix
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
      
      # Kalman Filtering
      for (t in 1:T){
        acat = fccat(mtcat,thetacatj)$newmean
        maxDiff= fccat(mtcat,thetacatj)$maxDiff
        gcat = Jccat(mtcat,thetacatj,maxDiff)$newJacob
        acat = pmin(acat ,maxDiff)
        acat = pmax(0,acat )
        # based on the modification rcat is now     
        rcat = gcat%*%Ctcat%*%t(gcat)+wcat      #variance of prior t-1  
        # sanity check
        rcat[is.infinite(rcat)]=10
        rcat[is.nan(rcat)]=10
        
        Jacat = Fcat            # a vector as there is no nonlinearity
        #for (j in 1:pcat){
        hcat  = Fcat%*%acat
        Fcat  = Jacat           # for readability only
        forecastcat  = hcat     # for readability only
        Y1cat[,t]= as.vector(forecastcat)  # step ahead forecast saving
        qcat = Fcat%*%rcat%*%t(Fcat) + vcat  #variance of one step ahead forecast
        
        #sanity check
        qcat = (qcat + t(qcat))/2
        qcat[is.infinite(qcat)]=10
        qcat[is.nan(qcat)]=10
        
        ecat    = ycat[t,] - forecastcat   # error of forecast 
        Acat = t(Fcat%*%rcat)%*%ginv(qcat)
        MSEcat[t,]=sum(ecat**2)
        MADcat[t,]= sum(abs(ecat))
        mtcat = acat + Acat %*% ecat
        Ctcat = rcat - Acat%*%qcat%*%t(Acat)
        Ctcat = (Ctcat+t(Ctcat))/2
        
        #catharsis
        Ctcat[is.infinite(Ctcat)]=10
        Ctcat[is.nan(Ctcat)]=10
        
        Ccat[,,t] =Ctcat  
        mcat[,t] = mtcat  
        mcat[,t]= pmin(mcat[,t],maxDiff)
        mcat[,t]= pmax(0,mcat[,t])
        mtcat = mcat[,t]
        cat(t, ",") 
      }
      
      
      cat("\n")
      
      currentCcat = Ccat[,,T]
      currentCcat[is.infinite(currentCcat)]=10
      currentCcat[is.nan(currentCcat)]=10
      Ccat[,,T] = currentCcat
      
      #backward smoothing
      tt1cat = matrix(rep(0,2*pcat*T),ncol=T)
      if (!is.positive.definite(Ccat[,,T])){
        #         stop("Negative Variance Found in C Matrix",Call.=FALSE)
        Ccat[,,T]= diag(rep(1e-6,sqrt(length(Ccat[,,T]))))
      }
      Ccat[,,T] = matrix(nearPD(make.positive.definite(Ccat[,,T]))$mat,ncol=sqrt(length(Ccat[,,T])))
      
      tt1cat[,T] = mcat[,T]+as.vector(t(chol(Ccat[,,T]))%*%as.matrix(rnorm(pcat*2)))
      tt1cat[,T]= pmin( tt1cat[,T],maxDiff)
      tt1cat[,T]= pmax(0, tt1cat[,T])                                                                                  
      
      for (t in (T-1):1){
        acat = fccat(mcat[,t],thetacatj)$newmean
        # sanity check
        acat[is.infinite(acat)]=100
        acat[is.nan(acat)]=100
        
        maxDiff= fccat(mcat[,t],thetacatj)$maxDiff
        # sanity check
        maxDiff[is.infinite(maxDiff)]=100
        maxDiff[is.nan(maxDiff)]=100      
        
        gcat = Jccat(mcat[,t],thetacatj,maxDiff)$newJacob
        
        # sanity check
        gcat[is.infinite(gcat)]=10
        gcat[is.nan(gcat)]=10
        
        
        rcat = gcat%*%Ccat[,,t]%*%t(gcat)+wcat      #variance of prior t-1
        # sanity check
        
        rcat[is.infinite(rcat)]=10
        rcat[is.nan(rcat)]=10
        
        if (!is.positive.definite(rcat)){
          #         stop("Negative Variance Found in C Matrix",Call.=FALSE)
          rcat= diag(rep(1e-6,sqrt(length(rcat))))
        }
        
        rcat[is.infinite(rcat)]=10
        rcat[is.nan(rcat)]=10
        
        bcat = Ccat[,,t]%*%t(gcat)%*%ginv(rcat)
        # sanity check
        bcat[is.infinite(bcat)]=10
        bcat[is.nan(bcat)]=10        
        
        ucat = Ccat[,,t]%*%t(gcat)
        
        Cmcat = Ccat[,,t] - ucat%*%ginv(rcat)*t(ucat)
        tmcat = mcat[,t]  + bcat%*%(tt1cat[,t+1]-acat)
        Cmcat=(Cmcat+t(Cmcat))/2
        
        
        if ((sum(is.nan(Cmcat))>0) ||(sum(is.infinite(Cmcat))>0)){
          Cmcat  = diag(rep(1e-6,sqrt(length(Cmcat  ))))
        }
        
        # sanity check
        Cmcat[is.infinite(Cmcat)]=10
        Cmcat[is.nan(Cmcat)]=10 
        
        if (!is.positive.definite(Cmcat)){
          #         stop("Negative Variance Found in C Matrix",Call.=FALSE)
          Cmcat= diag(rep(1e-6,sqrt(length(Cmcat))))
        }
        
        # sanity check
        Cmcat[is.infinite(Cmcat)]=10
        Cmcat[is.nan(Cmcat)]=10   
        
        # save mean and variance of posterior at time t
        Ccat[,,t]   = Ccat[,,t] - bcat%*%(rcat-Ccat[,,t+1])%*%t(bcat)
        mcat[,t]    = mcat[,t]  + bcat%*%(mcat[,t+1]-acat) 
        mcat[,t]= pmin( mcat[,t],maxDiff)
        mcat[,t]= pmax(0, mcat[,t])
        
        Cmcat = matrix(nearPD(make.positive.definite(Cmcat))$mat,ncol=sqrt(length(Cmcat)))
        
        tt1cat[,t]  = tmcat     + t(chol(Cmcat))%*%as.matrix(rnorm(2*pcat)) 
        tt1cat[,t]= pmin( tt1cat[,t],maxDiff)
        tt1cat[,t]= pmax(0, tt1cat[,t])                                                                                  
      }
      
      #now ad-hoc treatment of start value
      m0cat  = mcat[,1]
      C0cat  = Ccat[,,1]
      C0cat  = (C0cat  +t(C0cat  ))/2
      if ((sum(is.nan(C0cat))>0) ||(sum(is.infinite(C0cat))>0)){
        C0cat  = diag(rep(1e-6,sqrt(length(C0cat  ))))
      }
      
      C0cat[is.infinite(C0cat)] = 10
      C0cat[is.nan(C0cat)] = 10
      
      if (!is.positive.definite(C0cat)){
        #         stop("Negative Variance Found in C Matrix",Call.=FALSE)
        C0cat  = diag(rep(1e-6,sqrt(length(C0cat  ))))
      }
      
      C0cat=matrix(nearPD(make.positive.definite(C0cat))$mat,ncol=sqrt(length(C0cat)))
      tt0cat    =m0cat     + t(chol(C0cat))%*%as.matrix(rnorm(2*pcat))
      tt0cat    = pmin( tt0cat    ,maxDiff)
      tt0cat    = pmax(0, tt0cat)  
      tt0cat    = matrix(tt0cat,ncol=1)
      return(list(mcat=mcat,Ccat=Ccat,m0cat=m0cat,C0cat=C0cat,tt1cat=tt1cat,tt0cat=tt0cat,Y1cat=Y1cat,MADcat=MADcat,MSEcat=MSEcat))
    }
    
    #-------------------------------------------------------------------------------------
    #                            FFBS estimation
    #-------------------------------------------------------------------------------------
    #           Inputs
    #---------------------------------------------------
    #Data:list(p=p,lgtdata=simlgtdata,Z=Z)
    #---------------------------------------------------
    #Zc  =Zcat    # pc x nzcat matrix
    # to explain heterogeneity in category(with no intercept)
    #---------------------------------------------------
    # McMc = list(R=R,keep=keep)
    #---------------------------------------------------
    #R: number of iterations of draw
    #keep : thining (1 for no thinning)
    
    #---------------------------------------------------
    # Prior = list(ncomp=5)
    #---------------------------------------------------
    #ncomcat:    number of components in normal mixture of category coefficients
    
    
    #---------------------------------------------------
    #  Output: out$betadraw, out$nmix
    #---------------------------------------------------
    #out$thetacatdraw:    [ncat x nvaretaIndvapp x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvaretaIndvapp (number of var relevant to choice)
    
    
    #out$DeltaCatdraw:   [(R/keep)x(nzalphai*nvaralphai)] 
    #  Delta draws, with first row as initial value
    
    #out$nmixDiffcat     :    list of list of lists (length: R/keep)
    # out$nmixDiffcat[[i]]: i's draw of component of mixture
    
    #out$llikeDiffcat           :    loglikelihood at each kept draw
    
    #---------------------------------------------------
    #  Code:
    #---------------------------------------------------
    
    #------------------------------
    #prepare Data
    #------------------------------
    Data = list( Zc=Zcat)
    jumps      =    1
    idx = 0
    jp = 0
    ndraw=10000;  
    ndraw0 = 5000
    burnIn = ndraw0
    McMc = list(R=ndraw,keep=jumps)
    Prior= list(ncomcat=ncompcat)
    ncat = ncat
    
    #---------------------------------------------------
    #  check arguments of DGP, or real data to make sure conformity
    #---------------------------------------------------
    #  function to through error and stop
    pandterm=function(message) { stop(message,call.=FALSE) }
    
    #------------------------------
    #check the Data
    #------------------------------
    
    #-------------------------------
    # Component heterogeneity data check
    #-------------------------------
    drawdeltathetacatj=TRUE
    if(is.null(Data$Zc)) { cat("Zc not specified",fill=TRUE); fsh() ; drawdelta=FALSE} else {Zc=Data$Zc}
    
    if(drawdeltathetacatj) {
      nzthetacatj=ncol(Zc)
      colmeans=apply(Zc,2,mean)
      if(sum(colmeans) > .00001) 
      {pandterm(paste("Zc does not appear to be de-meaned: colmeans= ",colmeans))}
    }
    
    #---------------------------------------------
    #     Check McMc
    #---------------------------------------------
    if(missing(McMc)) {pandterm("Requires Mcmc list argument")}
    if(!missing(McMc)){ 
      if(is.null(McMc$keep)) {keep=1} else {keep=McMc$keep}
      if(is.null(McMc$R)) {pandterm("Requires R argument in Mcmc list")} else {R=McMc$R}
    }
    #---------------------------------------------
    # check on priors
    #---------------------------------------------
    if(missing(Prior)) 
    {pandterm("Requires Prior list argument (at least ncompIndv,ncomcat,ncomapp)")} 
    if(is.null(Prior$ncomcat)) {pandterm("Requires Prior element ncomcat (num of mixture components for categories)")} else {ncomcat=Prior$ncomcat}
    
    # prior for mubar across 6 HB
    # number of coefficients should be set for the number of means
    
    #thetacatj
    nvarthetacatj = 8
    if(is.null(Prior$mubarthetacatj)) {mubarthetacatj=matrix(rep(0,(nvarthetacatj)),nrow=1)} else { mubarthetacatj=matrix(Prior$mubarthetacatj,nrow=1)}
    if(ncol(mubarthetacatj) != (nvarthetacatj)) {pandterm(paste("mubar must have ncomp cols, ncol(mubarthetacatj)= ",ncol(mubarthetacatj)))}
    if(is.null(Prior$Amuthetacatj)) {Amuthetacatj=matrix(.01,ncol=1)} else {Amuthetacatj=matrix(Prior$Amuthetacatj,ncol=1)}
    if(ncol(Amuthetacatj) != 1 | nrow(Amuthetacatj) != 1) {pandterm("Amthetacatj must be a 1 x 1 array")}
    if(is.null(Prior$nuthetacatj)) {nuthetacatj=nvarthetacatj+3}  else {nuthetacatj=Prior$nuthetacatj}
    if(nuthetacatj < 1) {pandterm("invalid nuthetacatj value")}
    if(is.null(Prior$Vthetacatj)) {Vthetacatj=nuthetacatj*diag(nvarthetacatj)} else {Vthetacatj=Prior$Vthetacatj}
    if(sum(dim(Vthetacatj)==c(nvarthetacatj,nvarthetacatj)) !=2) pandterm("Invalid Vthetacatj in prior")
    if(is.null(Prior$Adthetacatj) & drawdeltathetacatj) {Adthetacatj=.01*diag(nvarthetacatj*nzthetacatj)} else {Adthetacatj=Prior$Adthetacatj}
    if(drawdeltathetacatj) {if(ncol(Adthetacatj) != nvarthetacatj*nzthetacatj | nrow(Adthetacatj) != nvarthetacatj*nzthetacatj) {pandterm("Adthetacatj must be nvarthetacatj*thetacatj x nvarthetacatj*thetacatj")}}
    if(is.null(Prior$deltabarthetacatj)& drawdeltathetacatj) {deltabarthetacatj=rep(0,nzthetacatj*nvarthetacatj)} else {deltabarthetacatj=Prior$deltabarthetacatj}
    if(drawdeltathetacatj) {if(length(deltabarthetacatj) != nzthetacatj*nvarthetacatj) {pandterm("deltabar must be of length nvarthetacatj*nzthetacatj")}}
    if(is.null(Prior$athetacatj)) { athetacatj=rep(5,ncomcat)} else {athetacatj=Prior$athetacatj}
    if(length(athetacatj) != ncomcat) {pandterm("Requires dim(athetacatj)= ncomp (no of components)")}
    badathetacatj=FALSE
    for(i in 1:ncomcat) { if(athetacatj[i] < 1) badathetacatj=TRUE}
    if(badathetacatj) pandterm("invalid values in a vector in thetacatj")
    
    #-------------------------------------------------------------------------
    # print out problem description
    #-------------------------------------------------------------------------
    cat(" ",fill=TRUE)
    cat("Starting MCMC Inference for Hierarchical Logit with Dynamic Non-Linear Model (Bass Model):",fill=TRUE)
    cat("   Normal Mixture with",
        ncomcat,"components of categories, for first stage prior",fill=TRUE)
    
    #thetacatj
    cat("Prior Parms for thetacatj: ",fill=TRUE)
    cat("nuthetacatj =",nuthetacatj,fill=TRUE)
    cat("Vthetacatj ",fill=TRUE)
    print(Vthetacatj)
    cat("mubarthetacatj ",fill=TRUE)
    print(mubarthetacatj)
    cat("Amuthetacatj ", fill=TRUE)
    print(Amuthetacatj)
    cat("athetacatj ",fill=TRUE)
    print(athetacatj)
    if(drawdeltathetacatj) 
    {
      cat("deltabarthetacatj",fill=TRUE)
      print(deltabarthetacatj)
      cat("Adthetacatj",fill=TRUE)
      print(Adthetacatj)
    }
    
    cat(" ",fill=TRUE)
    cat("MCMC Parms: ",fill=TRUE)
    cat(paste(" R= ",R," keep= ",keep),fill=TRUE)
    cat("",fill=TRUE)
    
    
    #--------------------------------------------------------------------
    # allocate space for draws
    #--------------------------------------------------------------------
    
    #thetacatj
    if(drawdeltathetacatj) Deltadrawthetacatj=matrix(double((floor((R-burnIn)/keep))*nzthetacatj*nvarthetacatj),ncol=nzthetacatj*nvarthetacatj)
    thetacatjdraw=array(double((floor((R-burnIn)/keep))*ncat*nvarthetacatj),dim=c(ncat,nvarthetacatj,floor((R-burnIn)/keep)))
    probdrawthetacatj=matrix(double((floor((R-burnIn)/keep))*ncomcat),ncol=ncomcat)
    oldcomthetacatj=NULL
    compdrawthetacatj=NULL
    
    #----------------------------------------------------------
    #           Draw from the hierarchy
    #----------------------------------------------------------
    drawDelta=
      function(x,y,z,comps,deltabar,Ad){
        # delta = vec(D)
        #  given z and comps (z[i] gives component indicator for the ith observation, 
        #   comps is a list of mu and rooti)
        #y is n x p
        #x is n x k
        #y = xD' + U , rows of U are indep with covs Sigma_i given by z and comps
        p=ncol(y)
        k=ncol(x)
        xtx = matrix(0.0,k*p,k*p)
        xty = matrix(0.0,p,k) #this is the unvecced version, have to vec after sum
        for(i in 1:length(comps)) {
          nobs=sum(z==i)
          if(nobs > 0) {
            if(nobs == 1) 
            { yi = matrix(y[z==i,],ncol=p); xi = matrix(x[z==i,],ncol=k)}
            else
            { yi = y[z==i,]; xi = x[z==i,]}
            
            yi = t(t(yi)-comps[[i]][[1]])
            sigi = crossprod(t(comps[[i]][[2]]))
            xtx = xtx + crossprod(xi) %x% sigi
            xty = xty + (sigi %*% crossprod(yi,xi))
          }
        }
        xty = matrix(xty,ncol=1)
        
        # then vec(t(D)) ~ N(V^{-1}(xty + Ad*deltabar),V^{-1}) V = (xtx+Ad)
        TmpDm = make.positive.definite(xtx+Ad)
        pDm = matrix(nearPD(TmpDm)$mat,ncol=sqrt(length(TmpDm)))
        
        cov=ginv(pDm)
        cov = make.positive.definite((cov+t(cov))/2)
        
        # to avoid leading minor of order 8 in chol
        cov = matrix(nearPD(cov)$mat,ncol=sqrt(length(cov)))
        
        return(cov%*%(xty+Ad%*%deltabar) + t(chol(cov))%*%rnorm(length(deltabar)))
      }
    
    #------------------------------------------------------------------------------------------------------
    #  Likelihood for app category diffusion level
    #------------------------------------------------------------------------------------------------------
    
    #-------------------------
    # Categories
    #-------------------------
    bassErrorsCat= function(thetacatjest,tt0cat,tt1cat,wcat,curcat){
      ncat = dim(tt1cat)[1]/2
      T    = dim(tt1cat)[2]
      predictedcat = matrix(rep(0,(T)),ncol=T)
      i = curcat
      
      thetacatjest =matrix(as.numeric(thetacatjest),nrow=ncat) 
      colnames(thetacatjest) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w");
      
      # for influentials
      predictedcat[1]=tt0cat[(i-1)*2+1]+
        (thetacatjest[i,"p1"]+thetacatjest[i,"q1"]*(tt0cat[(i-1)*2+1]/thetacatjest[i,"Ninf"]))*
        (thetacatjest[i,"Ninf"]-tt0cat[(i-1)*2+1]);
      
      # for immitators
      predictedcat[2]=tt0cat[(i-1)*2+2]+
        (thetacatjest[i,"p2"]+thetacatjest[i,"q2"]*(thetacatjest[i,"w"]*(tt0cat[(i-1)*2+1]/thetacatjest[i,"Ninf"])+
                                                      (1-thetacatjest[i,"w"])*(tt0cat[(i-1)*2+2]/thetacatjest[i,"Nimm"])))*
        (thetacatjest[i,"Nimm"]-tt0cat[(i-1)*2+2]);
      
      for(t in 2:T){     
        # for influentials
        predictedcat[(t-1)*2+1]=tt1cat[(i-1)*2+1,t-1]+
          (thetacatjest[i,"p1"]+thetacatjest[i,"q1"]*(tt1cat[(i-1)*2+1,t-1]/thetacatjest[i,"Ninf"]))*
          (thetacatjest[i,"Ninf"]-tt1cat[(i-1)*2+1,t-1]);
        
        # for immitators
        predictedcat[(t-1)*2+2]=tt1cat[(i-1)*2+2,t-1]+
          (thetacatjest[i,"p2"]+thetacatjest[i,"q2"]*(thetacatjest[i,"w"]*(tt1cat[(i-1)*2+1,t-1]/thetacatjest[i,"Ninf"])+
                                                        (1-thetacatjest[i,"w"])*(tt1cat[(i-1)*2+2,t-1]/thetacatjest[i,"Nimm"])))*
          (thetacatjest[i,"Nimm"]-tt1cat[(i-1)*2+2,t-1]);
        
      }
      errortempcat = tt1cat[i,]-predictedcat
      return (errortempcat)
    }
    
    basslikelihoodCat= function(thetacatjestcur,thetacatjest,tt0cat,tt1cat,wcat,oldcompthetacatj,indthetacatj,curcat,meansuntilcur,betabarthetacatj){ 
      #meansuntilcur is an array but I will use until curcat of it
      ncat =  dim(tt1cat)[1]/2
      T    =  dim(tt1cat)[2]
      
      thetacatjest[curcat,1:7]=thetacatjestcur
      # structure of thetacatjest: [p1,p2,q1,12,N(inf),N(immt),w]
      
      #original parameters to be used with prior
      originalParam = thetacatjest
      
      # to make sure there is no overflow problem
      thetacatjest[curcat,5:7] = pmax(pmin(thetacatjest[curcat,5:7],20),-500)
      
      # N(inf) and N(immt) are positive per theory so exp(x) transofmration
      thetacatjest[curcat,5]=exp(thetacatjest[curcat,5])
      thetacatjest[curcat,6]=exp(thetacatjest[curcat,6])
      
      # weight is also between zero and one so the logit transformation used
      thetacatjest[curcat,7]=exp(thetacatjest[curcat,7])/(1+exp(thetacatjest[curcat,7]))
      
      thetacatjest=matrix(thetacatjest,nrow=ncat)
      errortempcat = t(bassErrorsCat(thetacatjest,tt0cat,tt1cat,wcat,curcat))  
      errortempcat = t(matrix(errortempcat,nrow=2))
      wcatconditional = abs(wcat[((curcat-1)*2+1):((curcat-1)*2+2),((curcat-1)*2+1):((curcat-1)*2+2)] - 
                              wcat[((curcat-1)*2+1):((curcat-1)*2+2),-(((curcat-1)*2+1):((curcat-1)*2+2))]%*%
                              ginv(wcat[-(((curcat-1)*2+1):((curcat-1)*2+2)),-(((curcat-1)*2+1):((curcat-1)*2+2))])%*%
                              wcat[-(((curcat-1)*2+1):((curcat-1)*2+2)),((curcat-1)*2+1):((curcat-1)*2+2)])
      wcatconditional = (wcatconditional+t(wcatconditional))/2
      #sanity check
      wcatconditional[is.nan(wcatconditional)] = 10
      wcatconditional[is.infinite(wcatconditional)]=10
      
      LLcat        = -0.5*tr(ginv(wcatconditional)*crossprod(errortempcat,errortempcat))-0.5*T*log(2*pi)-
        0.5*T*log(det(wcatconditional))
      
      LLpriorcat = 0;
      
      # to test
      clt = curcat
      rootpithetacatj=oldcompthetacatj[[indthetacatj[clt]]]$rooti[1:7,1:7] - oldcompthetacatj[[indthetacatj[clt]]]$rooti[1:7,-(1:7)]%*%
        matrix(oldcompthetacatj[[indthetacatj[clt]]]$rooti[-(1:7),-(1:7)],ncol=1)%*%oldcompthetacatj[[indthetacatj[clt]]]$rooti[-(1:7),+(1:7)]
      rootpithetacatj = (rootpithetacatj+t(rootpithetacatj))/2
      #sanity check
      rootpithetacatj[is.nan(rootpithetacatj)] = 10
      rootpithetacatj[is.infinite(rootpithetacatj)]=10
      
      betabarthetacatj= betabarthetacatj[curcat,1:7]
      # as the prior is over the exponent item rather than main
      LLpriorcat = lndMvn(originalParam[curcat,1:7],betabarthetacatj,rootpithetacatj)
      output = sum(LLpriorcat)+LLcat
      if (is.nan(output)){
        output = -Inf
      }
      if (is.infinite(output)){
        output = -1e40
      }
      return(-output) #make sure I send back negative likelihood
    }
    
    # new likelihood function to find the variable of the linear system under constraint of zero and 1
    # in the observation equation
    
    segmentLikelihood= function(threshold,ycat, tt1cat,vcat,curcat,betabarthetacatj,oldcompthetacatj,indthetacatj){ 
      ncat =  dim(tt1cat)[1]/2
      T    =  dim(tt1cat)[2]
      
      #truncate to make sure it is relevant (sanity check)
      thresholds = pmax(pmin(threshold,20),-500)
      
      # it is the tts in y(jt)=tts*tt1cat(influe,jt)+(1-tts)*tt1caj(immit,jt)
      # threfore I should use the transformation (exp(threshold)/(1+exp(threshold))) 
      tts  =  exp(threshold)/(1+exp(threshold)) 
      
      tt1cat=matrix(tt1cat,nrow=ncat*2)
      prediction = matrix(c(tts,1-tts),ncol=2)%*%tt1cat[((curcat-1)*2+1):((curcat-1)*2+2),]
      errortempcat = ycat[curcat,] - prediction
      errortempcat = t(errortempcat)
      
      LLcat        = -0.5*crossprod(errortempcat,errortempcat)/vcat[curcat,curcat]-0.5*T*log(2*pi)-
        0.5*T*log(vcat[curcat,curcat])
      
      LLpriorcat = 0;
      
      # to test
      clt = curcat
      rootpithetacatj=oldcompthetacatj[[indthetacatj[clt]]]$rooti[8,8] - oldcompthetacatj[[indthetacatj[clt]]]$rooti[8,-(8)]%*%
        oldcompthetacatj[[indthetacatj[clt]]]$rooti[-(8),-(8)]%*%oldcompthetacatj[[indthetacatj[clt]]]$rooti[-(8),+(8)]
      
      #sanity check
      rootpithetacatj = (rootpithetacatj+t(rootpithetacatj))/2
      rootpithetacatj[is.nan(rootpithetacatj)]=10
      rootpithetacatj[is.infinite(rootpithetacatj)]=10
      
      
      betabarsegThreshold= betabarthetacatj[curcat,8]
      
      # as the prior is over the exponent item rather than main
      LLpriorcat = lndMvn(threshold,betabarsegThreshold,rootpithetacatj)
      output = sum(LLpriorcat)+LLcat
      if (is.nan(output)){
        output = -Inf
      }
      if (is.infinite(output)){
        output = -1e40
      }
      return(-output) #make sure I send back negative likelihood
    }
    
    #-------------------------------------------------------------------------------------------------------
    #  initialize values
    #-------------------------------------------------------------------------------------------------------
    
    #--------------------------------------------------------------
    # set initial values for the indicators
    #     ind is of length(nlgt) and indicates which mixture component this obs
    #     belongs to.
    #--------------------------------------------------------------
    
    #thetacatj
    #-------------------------
    indthetacatj=NULL
    nincthetacatj=floor(ncat/ncomcat)
    for (i in 1:(ncomcat-1)) {indthetacatj=c(indthetacatj,rep(i,nincthetacatj))}
    if(ncomcat != 1) {indthetacatj = c(indthetacatj,rep(ncomcat,ncat-length(indthetacatj)))} else {indthetacatj=rep(1,ncat)}
    # initialize delta
    if (drawdeltathetacatj) olddeltathetacatj=rep(0,nzthetacatj*nvarthetacatj)
    # initialize probs
    oldprobthetacatj=rep(1/ncomcat,ncomcat)
    # initialize comps
    tcompthetacatj=list(list(mu=rep(0,nvarthetacatj),rooti=diag(nvarthetacatj)))
    oldcompthetacatj=rep(tcompthetacatj,ncomcat)
    
    #--------------------------------------------------------------
    # set initial values for the state space portion of the model
    #--------------------------------------------------------------
    
    #app categories
    #---------------------------------------
    ycat = array(rep(0,ncat*T), dim=c(ncat,T))
    pcat = ncat
    
    # for start assume that influentials are 0.2 and immitators are 0.8
    Fcat = rep(c(0.2,0.8),ncat)
    thetacatjest = matrix(rep(0.01,ncat*3),ncol=3)
    m0cat        = 0.01*matrix(c(rep(1,2*ncat)),ncol=ncat)
    C0cat        = 2*diag(c(rep(1,2*pcat)))
    vcat = diag(0.1*rep(1,ncat))
    
    wcat = 0.5*diag(c(rep(1,pcat*2)))
    tt0cat = 0.01*matrix(c(rep(1,2*ncat)),nrow=2*ncat)
    tt1cat = 0.01*matrix(c(rep(1,2*ncat*T)),ncol=T)
    Y1cat  = array(rep(0,ncat*T),dim=c(ncat,T))
    MADcat = matrix(rep(0,T*ncat),ncol=ncat)
    MSEcat = matrix(rep(0,T*ncat),ncol=ncat)
    # i did not save v because of its large size
    crossseclengthcat = ((ncat+4*ncat*ncat)*(R-burnIn))
    ccat_=matrix(rep(0,crossseclengthcat),ncol=(R-burnIn))
    bcat_ = matrix(rep(0,(length(tt0cat)+length(tt1cat))*(R-burnIn)),ncol=(R-burnIn))
    llcat_ = rep(0,(R-burnIn))
    Y1cat_ = array(rep(0,ncat*T*(R-burnIn)),dim=c(ncat,T,(R-burnIn))) #memory explosion so it does not work
    MADcat_ = rep(0,(R-burnIn))
    MSEcat_ = rep(0,(R-burnIn))
    b0catst  = rep(0, nvarthetacatj)
    S0catstInv  = diag(rep(1.5e-7,nvarthetacatj))
    b0catobs = 0
    S0catobsInv = 1.5e-7
    v0ivcat     = 30
    Svivcat     = diag(rep(0.1,ncat))
    
    #-----------------------------------
    # initial values for the pooled
    #-----------------------------------
    oldthetacatj  = thetacatj
    
    
    # estimate non-state parameters of state equation
    #-----------------------------------------------------
    #cat
    #---------------------
    pcThetacatj = 6e-5
    pcThreshold = 6e-5
    cumjThetacatj = 0
    cumjThreshold = 0
    thetacatjNew = matrix(rep(0,(nvarthetacatj-1)*ncat), ncol=(nvarthetacatj-1))
    thresholdNew = rep(0,ncat)
    varModeCat = matrix(rep(0,(nvarthetacatj-1)*ncat), ncol=(nvarthetacatj-1))
    varModeCatThreshold = rep(0,ncat)
    errorwtempcat =matrix(rep(0,(T*ncat*2)), nrow=2*ncat)
    w0ivcat = ncat
    Swivcat = diag(rep(0.1,2*ncat))
    
    
    #inverse gamma, diagonal matrix for v
    #---------------------------------------------------------
    wa0=0.1; wv02=.1; 
    vcatcomp=rep(0,ncat)
    
    # mean of the coefficient (prior mean)
    #-------------------
    betabarthetacatj = matrix(rep(0, ncat*nvarthetacatj),ncol=nvarthetacatj)
    
    #--------------------------------------------------------------------------
    #           Main iterations of MCMC
    #--------------------------------------------------------------------------
    #  start main iteration loop
    itime=proc.time()[3]
    cat("MCMC Iteration (est time to end - min) ",fill=TRUE)
    fsh()
    
    thetacatjest = cbind(thetacatj[,1],thetacatj[,1],thetacatj[,2],thetacatj[,2],thetacatj[,3],thetacatj[,3],
                         rep(0.3,ncat))
    
    oldthetacatj = thetacatjest
    thetacatj = thetacatjest
    thresholds = rep(2,ncat)
    ycat = categoryDiffWeekly
    prediction = matrix(rep(0,ncat*T),ncol = T)
    
    for(iterrep in 1:R){
        if (floor(iterrep/5)==iterrep/5){
          sink()
        }
      cat('==========================================================================\n')
      cat('\nStarted new iteration.....\n')
      cat (iterrep)
      cat ('\n')
      cat('==========================================================================\n')
      itimetest=proc.time()[3]
      #-----------------------------------------------------------------
      #parameters to set burn in
      #------------------------------------------------------------------ 
      sw=0;
      if   (iterrep                >     ndraw0) { #  Discarding burnin
        idx               =     idx + 1
        
      }            
      
      if   (idx  ==     jumps){
        idx   =     0;
        jp    =     jp + 1
        sw    =     1
      }
      
      #-----------------------------------------------------------------
      # intialize compute quantities for Metropolis (pooled)
      #------------------------------------------------------------------
      cat("initializing loop for  ",ncat," app category units ...",fill=TRUE)
      fsh()
      
      
      #----------------------------------------------------------------------
      # first draw comps,ind,p | {beta_i}, delta
      #        ind,p need initialization comps is drawn first in sub-Gibbs
      # the data includes (p1,p2,q1,q2,N(inf),N(immit),w)
      # and just add the threshold variables for segment which results in tts=exp(threshold)/(1+exp(threshold))
      # at beginning and remove at the end
      #----------------------------------------------------------------------   
      
      #thetacatj
      #----------
      tempoldthetacatj = oldthetacatj
      oldthetacatj = cbind(oldthetacatj,thresholds)
      
      # sanity check to avoid leading minor of order 8
      for (comp in ncompcat){
        oldcompthetacatj[[comp]]$rooti = (oldcompthetacatj[[comp]]$rooti + t(oldcompthetacatj[[comp]]$rooti))/2
        oldcompthetacatj[[comp]]$rooti = matrix(nearPD(make.positive.definite(oldcompthetacatj[[comp]]$rooti))$mat,
                                                ncol=nvarthetacatj)
      }
      
      if(drawdeltathetacatj) 
      {mgoutthetacatj=rmixGibbs(oldthetacatj-Zcat%*%t(matrix(olddeltathetacatj,ncol=nzthetacatj)),
                                mubarthetacatj,Amuthetacatj,nuthetacatj,Vthetacatj,athetacatj,oldprobthetacatj,indthetacatj,
                                oldcompthetacatj)
      }else
      {mgoutthetacatj=rmixGibbs(oldthetacatj,
                                mubarthetacatj,Amuthetacatj,nuthetacatj,Vthetacatj,athetacatj,oldprobthetacatj,indthetacatj,
                                oldcompthetacatj)}
      oldprobthetacatj=mgoutthetacatj[[1]]
      oldcompthetacatj=mgoutthetacatj[[3]]
      indthetacatj=mgoutthetacatj[[2]]
      
      #--------------------------------------------------------------
      # now draw delta | {beta_i}, ind, comps
      #--------------------------------------------------------------
      if(drawdeltathetacatj) {olddeltathetacatj=drawDelta(Zcat,oldthetacatj,indthetacatj,oldcompthetacatj,deltabarthetacatj,Adthetacatj)}
      
      #thetacatj
      #--------------------------------
      #  note: beta_i = Deltabetai*zIndv_i + u_i  Deltabetai is nvarbetai x nzbetai
      for (clgt in 1:ncat) {
        if(drawdeltathetacatj) {
          betabarthetacatj[clgt,]=oldcompthetacatj[[indthetacatj[clgt]]]$mu+matrix(olddeltathetacatj,ncol=nzthetacatj)%*%
            as.vector(Zcat[clgt,])
        }else {
          betabarthetacatj[clgt,]=oldcompthetacatj[[indthetacatj[clgt]]]$mu }
        
      }
      
      cat('\nEstimation of HB of thetacatj parameters done successfully...\n') 
      oldthetacatj = tempoldthetacatj
      
      
      #-------------------------------------------------------------------------------------
      #                             EKF for the  categories
      #-------------------------------------------------------------------------------------
      #itime=proc.time()[3]
      outcatEKF = catEKF(ycat=t(categoryDiffWeekly),Fcat=Fcat,pcat=ncat,m0cat=m0cat,C0cat=C0cat,vcat=vcat,wcat=wcat
                         ,thetacatj=thetacatjest) 
      #ctime=proc.time()[3]
      #timetoend=(ctime-itime)
      mcat = outcatEKF$mcat
      Ccat = outcatEKF$Ccat
      m0cat = outcatEKF$m0cat
      C0cat = outcatEKF$C0cat
      tt1cat = outcatEKF$tt1cat
      tt0cat = outcatEKF$tt0cat
      Y1cat  = outcatEKF$Y1cat
      MADcat = outcatEKF$MADcat
      MSEcat = outcatEKF$MSEcat
      cat('\nEKF of category done successfully...\n')    
      
      
      #-------------------------------------------------------------------------------------
      #   Estimating size of the segments
      #-------------------------------------------------------------------------------------
      # recovering parameters of the  segment size
      alpha         = 0.5
      rndacceptance = 0.8
      meansuntilcurthreshold = thresholds
      
      #------------------------------------------
      #   First find the optimal distribution mean and variance
      #-----------------------------------------
      # using conditioning technique (cannot be parallelized due to dependance)
      itime=proc.time()[3]  
      for (clt in 1:ncat){
        cat(clt)
        #   itime=proc.time()[3]  
        #       segmentLikelihood(thresholds[clt],ycat = ycat, tt1cat=tt1cat,
        #                     vcat=vcat,oldcompthetacatj=oldcompthetacatj,
        #                     indthetacatj=indthetacatj,curcat=clt,
        #       						  betabarthetacatj=betabarthetacatj)
        outcatst=optim(thresholds[clt],segmentLikelihood,method="BFGS",control=list( fnscale=1,trace=1,reltol=1e-5),hessian=TRUE,
                       ycat = ycat, tt1cat=tt1cat,
                       vcat=vcat,oldcompthetacatj=oldcompthetacatj,
                       indthetacatj=indthetacatj,curcat=clt,
                       betabarthetacatj=betabarthetacatj)
        # ctime=proc.time()[3]
        #   timetoend=(ctime-itime)
        meansuntilcurthreshold[clt]=outcatst$par
        #thresholds[clt] = meansuntilcurthreshold[clt]
        
        #it seems it is hessian of function and not the negative value
        hessiancatTemp=outcatst$hessian 
        hessiancatTemp=(hessiancatTemp+t(hessiancatTemp))/2
        
        #sanity check
        hessiancatTemp[is.infinite(hessiancatTemp)]=10
        hessiancatTemp[is.nan(hessiancatTemp)]=10
        
        if (is.positive.definite(hessiancatTemp)){
          varcattemp  = diag(chol2inv(chol(matrix(nearPD(make.positive.definite(hessiancatTemp))$mat,
                                                  ncol=sqrt(length(hessiancatTemp))))))
        }else{
          varcattemp  = diag(ginv(make.positive.definite(hessiancatTemp)))
        }
        varcattemp  =pmax(1e-20,varcattemp  )
        varModeCatThreshold[clt] = varcattemp
      }
      ctime=proc.time()[3]
      timetoend=(ctime-itime)
      
      # to test
      #end test
      #------------------------------------------
      #   Second run M-H on the draws of optimal distribution mean and variance
      #-----------------------------------------
      j = 0
      cat("\nM-H loop to find the appropriate parameters for segment size category latent state equation\n")
      
      postPlatentNewTempThreshold=rep(0,ncat)
      postPlatentOldTempThreshold =rep(0,ncat)
      thetacatjestNewTempThreshold = rep(0,ncat)
      while (alpha < rndacceptance){
        j              = j+1
        cat(j,",")
        
        for (clt in 1:ncat) {
          wpm            = pcThreshold*varModeCatThreshold[clt]
          wpm            = pmax(wpm,c(rep(1e-6,length(wpm))))
          thresholdNew=meansuntilcurthreshold[clt] + wpm*rnorm(length(thresholds[clt]))
          
          postPlatentNew = -segmentLikelihood(thresholdNew,ycat = ycat, tt1cat=tt1cat,
                                              vcat=vcat,oldcompthetacatj=oldcompthetacatj,
                                              indthetacatj=indthetacatj,curcat=clt,
                                              betabarthetacatj=betabarthetacatj)
          
          postPlatentOld = - segmentLikelihood(thresholds[clt],ycat = ycat, tt1cat=tt1cat,
                                               vcat=vcat,oldcompthetacatj=oldcompthetacatj,
                                               indthetacatj=indthetacatj,curcat=clt,
                                               betabarthetacatj=betabarthetacatj)
          postPlatentNewTempThreshold[clt] = postPlatentNew
          postPlatentOldTempThreshold[clt] = postPlatentOld 
          thetacatjestNewTempThreshold[clt] = thresholdNew
          
        }      
        
        postPlatentNewThreshold = sum(postPlatentNewTempThreshold)
        postPlatentOldThreshold = sum(postPlatentOldTempThreshold)
        alpha          = postPlatentNew - postPlatentOld
        if (is.nan(alpha)){
          if (is.nan(postPlatentOld)){
            alpha=Inf
          }else{
            alpha=-Inf
          }
        }
        rndacceptance  = log(runif(1))
        if (j > 100){
          pcThreshold = pcThreshold /10;
          thetacatjestNewTempThreshold = thresholds
          postPlatentNewThreshold = postPlatentOldTempThreshold
          break
        }
      }
      
      #========================================================================
      # save result and update adaptive parameters
      #========================================================================
      
      thresholds=thetacatjestNewTempThreshold
      cumjThreshold = cumjThreshold + j          # to keep cumulative value
      accptrate = iterrep/cumjThreshold    # acceptance rate until now
      if (floor (iterrep/5) == iterrep/5){
        if (accptrate > 0.15){
          pcThreshold = pcThreshold*3;
          cumjThreshold = iterrep/0.15
        }else{
          if(accptrate < 0.01){
            pcThreshold = pcThreshold/3
            cumjThreshold = iterrep/0.01
          }
        }
      }
      llcatObsEq = postPlatentNewThreshold
      
      # sanity check for the leading minor of zero in cholesky
      thresholds = pmax(pmin(thresholds,10),-500)
      Fcat = as.vector((rbind(exp(thresholds)/(1+exp(thresholds)),1-exp(thresholds)/(1+exp(thresholds)))))
      
      cat('\nestimation of non-state prameters of observation equation parameters for category......successfully done\n')
      
      
      #----------------------------------------------------------------------------------------
      # Estimating Observation equation's variance
      #----------------------------------------------------------------------------------------
      # IW to find the misperception variance 
      viwmucat = v0ivcat + T  
      for (curcat in 1:ncat){
        tts = Fcat[(curcat-1)*2+1]
        prediction[curcat,] = matrix(c(tts,1-tts),ncol=2)%*%tt1cat[((curcat-1)*2+1):((curcat-1)*2+2),]
      }
      
      errortempcat = t(categoryDiffWeekly - prediction[,])  #dim=c(nIndv,T)
      errortempcat[is.nan(errortempcat )]=1e-6
      
      # draw from IW(sigmaiwmu,viwmu)  
      wa1  = (wa0+T)/2
      for (clt in 1:ncat){
        wv12        = (wv02+ t(t(errortempcat[clt,]))%*%t(errortempcat[clt,]))/2
        vcatcomp[clt] = rgamma(1, shape = wa1 , scale = 1/wv12)
      }
      vcatTemp = diag(vcatcomp)
      #sanity check
      vcatTemp = (vcatTemp+t(vcatTemp))/2
      vcatTemp[is.nan(vcatTemp)] = 10
      vcatTemp[is.infinite(vcatTemp)]=10 
      
      llcatObsEqCur =  - 0.5*sum(diag(matrix(nearPD(make.positive.definite(vcatTemp))$mat,ncol=sqrt(length(vcatTemp))))%*%crossprod(errortempcat,errortempcat))-
        0.5*ncat*T*log(2*pi)-0.5*T*det(vcatTemp)
      cat('\nestimation of misperception parameters for category......successfully done\n')
      # new form joint estimation of state variables
      vcat = vcatTemp
      cat('\n Maximum Variance of observation equation is:\n')
      cat(max(vcat))
      cat('\n')
      
      #-------------------------------------------------------------------------------------
      #                             Category Latent Coefficient mean and Variance
      #-------------------------------------------------------------------------------------
      alpha         = 0.5
      rndacceptance = 0.8
      meansuntilcur = thetacatjest
      # using conditioning technique (cannot be parallelized due to dependance)
      
      # transforming back variables to make them ready to use in the estimation procedure (M-H)
      thetacatjest[,5]= pmin(10,log(abs(thetacatjest[,5])))
      thetacatjest[,6]= pmin(10,log(abs(thetacatjest[,6])))
      thetacatjest[,7]= pmin(10,log(abs(thetacatjest[,7]/(1-thetacatjest[,7]))))
      
      #------------------------------------------------------------------------
      # finding the mode of the proposal distribution (mode and variance)
      #------------------------------------------------------------------------   
      itime=proc.time()[3]  
      for (clt in 1:ncat){
        cat(clt)
        #   itime=proc.time()[3]  
        #basslikelihoodCat(thetacatjest[clt,],thetacatjest=thetacatjest, tt0cat=tt0cat,tt1cat=tt1cat,
        #               wcat=wcat,oldcompthetacatj=oldcompthetacatj,
        #               indthetacatj=indthetacatj,curcat=clt,meansuntilcur=meansuntilcur,
        #						  betabarthetacatj=betabarthetacatj[clt,])
        outcatst=optim(thetacatjest[clt,],basslikelihoodCat,method="BFGS",control=list( fnscale=1,trace=1,reltol=1e-5),hessian=TRUE,
                       thetacatjest=thetacatjest, tt0cat=tt0cat,tt1cat=tt1cat,
                       wcat=wcat,oldcompthetacatj=oldcompthetacatj,
                       indthetacatj=indthetacatj,curcat=clt,meansuntilcur=meansuntilcur,
                       betabarthetacatj=betabarthetacatj)
        # ctime=proc.time()[3]
        #   timetoend=(ctime-itime)
        meansuntilcur[clt,]=outcatst$par
        thetacatjestTemp   = thetacatjest
        thetacatjestTemp[clt,]=meansuntilcur[clt,]
        
        #it seems it is hessian of function and not the negative value
        #sanity check
        hessiancatTemp=outcatst$hessian 
        hessiancatTemp=(hessiancatTemp+t(hessiancatTemp))/2
        
        hessiancatTemp[is.nan(hessiancatTemp)]=10
        hessiancatTemp[is.infinite(hessiancatTemp)]=10
        hessiancatTemp =  matrix(nearPD(make.positive.definite(hessiancatTemp))$mat,ncol=sqrt(length(hessiancatTemp)))
        if (is.positive.definite(hessiancatTemp)){
          varcattemp  = diag(chol2inv(chol(hessiancatTemp)))
        }else{
          varcattemp  = diag(ginv(hessiancatTemp))
        }
        varcattemp  =pmax(1e-20,varcattemp  )
        varModeCat[clt,] = varcattemp
      }
      ctime=proc.time()[3]
      timetoend=(ctime-itime)
      
      # to test
      #end test
      #=======================================================================================
      # second step the Metropolis hasting step
      #=======================================================================================
      j = 0
      cat("\nM-H loop to find the appropriate parameters for category latent state equation\n")
      
      postPlatentNewTemp=rep(0,ncat)
      postPlatentOldTemp =rep(0,ncat)
      thetacatjestNewTemp = matrix(rep(0,ncat*7),ncol=7)
      while (alpha < rndacceptance){
        j              = j+1
        cat(j,",")
        
        for (clt in 1:ncat) {
          wpm            = pcThetacatj*varModeCat[clt,]
          wpm            = pmax(wpm,c(rep(1e-6,length(wpm))))
          thetacatjestNew=meansuntilcur[clt,] + wpm*rnorm(length(thetacatjest[clt,]))
          
          postPlatentNew = -basslikelihoodCat(thetacatjestNew, thetacatjest=thetacatjest, tt0cat=tt0cat,tt1cat=tt1cat,
                                              wcat=wcat,oldcompthetacatj=oldcompthetacatj,
                                              indthetacatj=indthetacatj,curcat=clt,meansuntilcur=meansuntilcur,
                                              betabarthetacatj=betabarthetacatj)
          postPlatentOld = -basslikelihoodCat(thetacatjest[clt,], thetacatjest=thetacatjest, tt0cat=tt0cat,tt1cat=tt1cat,
                                              wcat=wcat,oldcompthetacatj=oldcompthetacatj,
                                              indthetacatj=indthetacatj,curcat=clt,meansuntilcur=meansuntilcur,
                                              betabarthetacatj=betabarthetacatj)
          
          postPlatentNewTemp[clt] = postPlatentNew
          postPlatentOldTemp[clt] = postPlatentOld 
          thetacatjestNewTemp[clt,] = thetacatjestNew
          
        }      
        
        postPlatentNew = sum(postPlatentNewTemp)
        postPlatentOld = sum(postPlatentOldTemp)
        alpha          = postPlatentNew - postPlatentOld
        if (is.nan(alpha)){
          if (is.nan(postPlatentOld)){
            alpha=Inf
          }else{
            alpha=-Inf
          }
        }
        rndacceptance  = log(runif(1))
        if (j > 100){
          pcThetacatj = pcThetacatj /10;
          thetacatjestNewTemp = thetacatjest
          postPlatentNew = postPlatentOld 
          break
        }
      }
      
      #======================================================
      # step three: done with the M-H, just one last step to adopt the metrapolis
      #====================================================
      thetacatjest=thetacatjestNewTemp
      cumjThetacatj = cumjThetacatj + j          # to keep cumulative value
      accptrate = iterrep/cumjThetacatj    # acceptance rate until now
      if (floor (iterrep/5) == iterrep/5){
        if (accptrate > 0.15){
          pcThetacatj = pcThetacatj*3;
          cumjThetacatj = iterrep/0.15
        }else{
          if(accptrate < 0.01){
            pcThetacatj = pcThetacatj/3
            cumjThetacatj = iterrep/0.01
          }
        }
      }
      llcatStateEq = postPlatentNew
      
      #===========================================================================
      # step 4: transform back variables to be used in the HB step
      #=============================================================================
      # For prior the original are used rather than the transformed as it is MVN, and 
      # most probably this is the reason why I got minor zero in cholesky
      
      #sanity check to make sure the range is preserved
      thetacatjest[,5:7] = pmax(pmin(thetacatjest[,5:7],20),-500)
      
      oldthetacatj= thetacatjest
      
      #thetacatjest[,3]=exp(thetacatjest[,3])
      thetacatjest[,5]= exp(pmax(pmin(thetacatjest[,5],10),1))
      thetacatjest[,6]= exp(pmax(pmin(thetacatjest[,6],10),1))
      thetacatjest[,7]= exp(pmax(pmin(thetacatjest[,7],10),1))/(1+exp(pmax(pmin(thetacatjest[,7],10),1)))
      
      #sanity check
      thetacatjest[is.nan(thetacatjest)] = 100
      thetacatjest[is.infinite(thetacatjest)] = 100
      
      cat('\nestimation of non-state prameters of state equation parameters for category......successfully done\n')
      #make sure that it never becomes zero
      pcThetacatj=max(pcThetacatj,1e-30)
      pcThetacatj=min(pcThetacatj,10)
      cat('\n The current value of pcThetacatj is..\n')
      cat(pcThetacatj)
      cat('\n')
      #-----------------------------------------------
      # Inverse Wishart Variance of State Equation
      #-----------------------------------------------
      wiwmucat = w0ivcat + T
      for (clt in 1:ncat){
        errorwtempcat[((clt-1)*2+1):((clt-1)*2+2),] = matrix(bassErrorsCat(thetacatjest,tt0cat,tt1cat,wcat,clt),nrow=2)
      }
      errorwtempcatt = t(errorwtempcat)
      
      sigmawmucat = Swivcat+crossprod(errorwtempcatt,errorwtempcatt)
      
      #sanity check
      sigmawmucat = (t(sigmawmucat)+sigmawmucat)/2
      sigmawmucat[is.nan(sigmawmucat)]=10
      sigmawmucat[is.infinite(sigmawmucat)]=10
      
      sigmaiwmucat = ginv(sigmawmucat)
      # draw from IW(sigmaiwmu,viwmu)
      sigmaiwmucat=(sigmaiwmucat+t(sigmaiwmucat))/2
      
      #sanity check
      sigmaiwmucat[is.nan(sigmaiwmucat)]=10
      sigmaiwmucat[is.infinite(sigmaiwmucat)]=10
      
      if (!is.positive.definite(sigmaiwmucat)){
        sigmaiwmucat = ginv(Swivcat)}
      
      #sanity check
      sigmaiwmucat = (sigmaiwmucat+t(sigmaiwmucat))/2
      sigmaiwmucat[is.nan(sigmaiwmucat)]=10
      sigmaiwmucat[is.infinite(sigmaiwmucat)]=10
      
      wcat = rwishart(wiwmucat,sigmaiwmucat)$IW
      wcat  = (wcat +t(wcat ))/2
      
      #sanity check
      wcat[is.nan(wcat)]=10
      wcat[is.infinite(wcat)]=10
      
      if (!is.positive.definite(wcat)){
        wcat=matrix(nearPD(make.positive.definite(wcat))$mat,ncol=sqrt(length(wcat)))
      }
      cat('\nestimation of variance prameters of state equation for category......successfully done\n')
      cat('\n Maximum Variance of state equation is:\n')
      cat(max(wcat))
      cat('\n')
      
      #-------------------------------------------------------------------------
      #       save every keepth draw
      #-------------------------------------------------------------------------         
      if (sw == 1)
      { 
        
        # thetacatj
        thetacatjdraw[,,jp] = cbind(thetacatjest,exp(thresholds)/(1+exp(thresholds)))
        probdrawthetacatj[jp,]=oldprobthetacatj
        llcat_[jp] = llcatObsEqCur + llcatStateEq + llcatObsEqCur
        Deltadrawthetacatj[jp,]= olddeltathetacatj 
        compdrawthetacatj[[jp]]=oldcompthetacatj
        
        #variances
        ccat_[,jp]=c(as.vector(diag(vcatTemp)),as.vector(wcat))
        bcat_ [,jp] = c(as.vector(tt0cat),as.vector(tt1cat))
        
        MADcat_[jp]  = sum(MADcat)/T/ncat
        
        MSEcat_[jp]  = sum(MSEcat)/T/ncat
        
        Y1cat_[,,jp]= Y1cat # I can not save due to memory explodes
        
      }
      ctimetest=proc.time()[3]
      cat('\nTotal loop duration:')
      ctimetest - itimetest
      cat('==========================================================================\n')
      cat('\nwhole loop ....................done\n')
      cat (iterrep)
      cat('==========================================================================\n')
        if (floor(iterrep/5)==iterrep/5){
          sink(logfile,append=TRUE)
        }
    }
    
    #-----------------------------------------------------
    # end of iterations
    #-----------------------------------------------------
    
    
    #---------------------------------------------------
    #  Output: out$betadraw, out$nmix
    #---------------------------------------------------
    #out$alphadraw:    [nlgt x nvaralphai x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvaralphai (number of var relevant to choice)
    #out$betadraw:    [nlgt x nvarbetai x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvarbetai of var relevant to choice)
    #out$etaIndvdraw:    [nlgt x nvarthetacatj x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvarthetacatj (number of var relevant to choice)
    #out$gammaIndvdraw:    [nlgt x nvarthetaappa x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvarthetaappa (number of var relevant to choice)
    #out$thetacatdraw:    [ncat x nvaretaIndvapp x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvaretaIndvapp (number of var relevant to choice)
    #out$thetaappdraw:    [napp x nvargammaIndv x (R/keep)]   coefficient draws for #units (nlgt)   
    #  and for #nvargammaIndv (number of var relevant to choice)
    
    
    #out$DeltaCatdraw:   [(R/keep)x(nzalphai*nvaralphai)] 
    #  Delta draws, with first row as initial value
    #out$DeltaAppdraw:   [(R/keep)x(nzbetai*nvarbetai)] 
    #  Delta draws, with first row as initial value
    #out$DeltaIndvcatdraw:   [(R/keep)x(nzthetacatj*nvarthetacatj)] 
    #  Delta draws, with first row as initial value
    #out$DeltaIndvappdraw:   [(R/keep)x(nzthetaappa*nvaretaIndvapp)] 
    #  Delta draws, with first row as initial value
    #out$DeltaIndv3draw:   [(R/keep)x(nzetaIndvapp*nvaretaIndvapp)] 
    #  Delta draws, with first row as initial value
    #out$DeltaIndv4draw:   [(R/keep)x(nzgammaIndv*nvargammaIndv)] 
    #  Delta draws, with first row as initial value
    
    
    #out$nmixcat         :    list of list of lists (length: R/keep)
    # out$nmixcat[[i]]: i's draw of component of mixture
    #out$nmixapp         :    list of list of lists (length: R/keep)
    # out$nmixapp[[i]]: i's draw of component of mixture
    #out$nmixIndvcat     :    list of list of lists (length: R/keep)
    # out$nmixIndvcat[[i]]: i's draw of component of mixture
    #out$nmixIndvapp     :    list of list of lists (length: R/keep)
    # out$nmixIndvapp[[i]]: i's draw of component of mixture
    #out$nmixDiffcat     :    list of list of lists (length: R/keep)
    # out$nmixDiffcat[[i]]: i's draw of component of mixture
    #out$nmixDiffapp     :    list of list of lists (length: R/keep)
    # out$nmixDiffapp[[i]]: i's draw of component of mixture
    
    #out$llikecat               :    loglikelihood at each kept draw
    #out$llikeapp               :    loglikelihood at each kept draw
    #out$llikeIndvcat           :    loglikelihood at each kept draw
    #out$llikeIndvapp           :    loglikelihood at each kept draw
    #out$llikeDiffcat           :    loglikelihood at each kept draw
    #out$llikeDiffapp           :    loglikelihood at each kept draw
    
    
    #=====================================================================================
    #                            End of Estimation Procedures
    #=====================================================================================
    
    return(list(thetacatjdraw,ccat_,Y1cat_,categoryDiffWeekly,Deltadrawthetacatj,
                bcat_,probdrawthetacatj,llcat_,MADcat_,MSEcat_
                ,compdrawthetacatj))
}