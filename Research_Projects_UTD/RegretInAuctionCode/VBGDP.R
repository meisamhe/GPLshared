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

require(corpcor)
require(MASS)
require(Matrix)

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