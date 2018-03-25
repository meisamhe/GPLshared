#==============================================
# Histogram of Prameters of van den Bulte and Joshi (2007)
#==============================================
#Global Parameters
#======================
estimatedParam=c(0.03924015, 0.01636605, 0.01917346, 0.01928408, 0.03047001, 0.01924611, 0.02087532, 0.01984697, 0.01911369, 0.02041213,
0.1626058, 0.1626608, 0.163479, 0.7802807, 0.1713955, 0.1640984, 0.1779895, 0.1692215, 0.8978191, 0.870783,
-0.008439179, -0.000635481, 0.000100913, 0.000101495, 0.0001058, 0.000101295, 0.00010987, 0.03452309, 0.000100598, 0.000107432,
0.01104114, 0.01104487, -1.229464, -1.24925, -1.272043, 0.01114249, 0.01208571, 0.01149035, 0.01106582, -0.03042803,
40.0001, 320.0001, 81.0001, 112.0001, 99.0001, 111.0001, 101.0001, 101.0001, 27.0001, 147.0001,
555.0001, 4457, 1116, 1557, 1376, 1538, 1400, 1402, 366.0001, 2036,
0.686573, 0.8902108, 0.328193, 0.6840644, 0.08423448, 0.4944232, 0.9605547, 0.1784042, 0.1920549, 0.9525357,
0.06484796, 0.06326682, 0.05747644, 0.06621133, 0.05390583, 0.05450802, 0.05259396, 0.008027988, 0.008827384, 0.007650944)
GlobalParam = matrix(estimatedParam,ncol=8)
#hist(GlobalParam[,1], breaks=5, col="red")
# the immitator's density
# Filled Density Plot(market size)
d <- density(GlobalParam[,6])
plot(d, main="Total Number of Immitator's Histogram (Global)")
polygon(d, col="green", border="green")
# the innovator's density (market size)
d <- density(GlobalParam[,5])
plot(d, main="Total Number of Influentials's Histogram (Global)")
polygon(d, col="blue", border="blue")

#Local Parameters
#======================
estimatedParam=c(0.02437987, 0.02525922, 0.02515938, 0.0251632, 0.1302675, 0.119144, 0.02582285, 0.02616375, 0.02476802, 0.02631489,
                 0.277321, 0.2873236, 0.2861879, 0.2862314, 0.2818919, 0.2942806, 0.293735, 0.2976127, 0.2817363, 0.6303459,
                 -0.01600556, -0.007383041, -0.007838931, 0.000104847, 0.000103257, 0.000107795, 0.000107595, 0.000109016, 0.0001032, 0.000109645,
                 0.1909756, 0.1978639, 0.1970818, -0.7405739, 0.1941234, 0.2026548, 0.202279, 0.2049494, 0.1940162, 0.2061333,
                 5.0001, 103.0001, 3.0001, 7.0001, 6.0001, 11.0001, 6.0001, 12.0001, 3.0001, 6.0001,
                 80.0001, 1952, 56.0001, 120.0001, 99.0001, 200.0001, 113.0001, 225.0001, 48.0001, 113.0001,
                 0.4966583, 0.964441, 0.7435125, 0.2104827, 0.03806709, 0.9679194, 0.9594358, 0.4746846, 0.261594, 0.6011281,
                 0.0439134, 0.04316092, 0.03851686, 0.04646905, 0.04882729, 0.04723542, 0.04079639, 0.04054462, 0.003087256, 0.002622921)
LocalParam = matrix(estimatedParam,ncol=8)
# the immitator's density
# Filled Density Plot(market size)
d <- density(LocalParam[,6])
plot(d, main="Total Number of Immitator's Histogram (Global)")
polygon(d, col="green", border="green")
# the innovator's density (market size)
d <- density(LocalParam[,5])
plot(d, main="Total Number of Influentials's Histogram (Global)")
polygon(d, col="blue", border="blue")

#============================================================================================
# calculate Hessian
#============================================================================================
library(numDeriv)
GlobalDiffLatentPath= "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GloballFullLatent4Hessian.csv"
LocalDiffLatentPath= "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/LocalDiffLatentFull.csv"
LocalVarLatentPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/LocalStateVar.csv"
GlobalVarLatentPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GlobalStateLatentVariance.csv"

# for global
#param = GlobalParam
# GlobalDiffLatent=read.csv(GlobalDiffLatentPath,header=T)
# GlobalLatentVar = read.csv(GlobalVarLatentPath,header=T)
# GlobalLatentVar=as.matrix(GlobalLatentVar[,2:21])

# for local
param = LocalParam
GlobalDiffLatent=read.csv(LocalDiffLatentPath,header=T)
GlobalLatentVar = read.csv(LocalVarLatentPath,header=T)
GlobalLatentVar=as.matrix(GlobalLatentVar[,2:21])

#======================================================================
#enumerate over each
#======================================================================

i = 10
influentialIndx = (2*(i-1)+1)
influentials = as.vector(GlobalDiffLatent[,influentialIndx+1])
varInfluentials = GlobalLatentVar[influentialIndx,influentialIndx]-
  GlobalLatentVar[influentialIndx,-influentialIndx]%*%ginv(GlobalLatentVar[-influentialIndx,-influentialIndx])%*%
  GlobalLatentVar[-influentialIndx,influentialIndx]
immitatorIndx = (2*(i-1)+2)
immitators = as.vector(GlobalDiffLatent[,immitatorIndx+1])
immitatorIndx = immitatorIndx-1
varImmitators = GlobalLatentVar[immitatorIndx,immitatorIndx]-
  GlobalLatentVar[immitatorIndx,-immitatorIndx]%*%ginv(GlobalLatentVar[-immitatorIndx,-immitatorIndx])%*%
  GlobalLatentVar[-immitatorIndx,immitatorIndx]
thetacatj  = param[i,]


influentialLL= function(thetacatj,influentials,varInfluentials) {
  # ctbar: vector of ncat*2 latent (mean of previous period) for latent number of influentials and immitators
  # odd lines are for influentials and even lines for immitators
  # thetacatj: ncat x 8 vector for ("p1", "p2", "q1", "q2","Ninf", "Nimm", "w")
  ##  VJ diffusion function for category, getting old vector of latent mean and returning the next latent mean
  # cat("fStt")
  latentt_1 = influentials[-length(influentials)]
  latentt   = influentials[-1]
  #names(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w","tt");
  names(thetacatj) <- c("p1", "q1", "Ninf");
  
  prediction  =   latentt_1+
    (thetacatj["p1"]+thetacatj["q1"]*(latentt_1/thetacatj["Ninf"]))*
    (thetacatj["Ninf"]-latentt_1);
  
  LL = sum(dnorm(latentt, mean = prediction, sd = sqrt(varInfluentials), log = TRUE))
  
  return(-LL)
}

immitatorsLL= function(thetacatj,immitators,influentials,varImmitators,Ninf) {
  
  latentt_1 = immitators[-length(immitatorIndx)]
  influentials_1 = influentials[-length(influentials)]
  latentt   = immitators[-1]
  #names(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w","tt");
  names(thetacatj) <- c("p2","q2","Nimm","w")
  
  # for immitators
  prediction  =    latentt_1+
    (thetacatj["p2"]+thetacatj["q2"]*(thetacatj["w"]*(influentials_1/Ninf)+
                (1-thetacatj["w"])*(latentt_1/thetacatj["Nimm"])))*
    (thetacatj["Nimm"]-latentt_1);                        
  
  LL = sum(dnorm(latentt, mean = prediction, sd = sqrt(varImmitators), log = TRUE))
  return(-LL)
}

#========================================
# calculate Hessian
#=========================================
# for influentials
#====================================

hess <- hessian(func=influentialLL, x=thetacatj[c(1,3,5)],influentials=influentials,
                varInfluentials=varInfluentials)

stdInf = sqrt(abs(diag(ginv(hess)))) #1,3,5

# for immitators
#====================================
hess <- hessian(func=immitatorsLL, x=thetacatj[c(2,4,6,7)],
                varImmitators=varImmitators,
                influentials=influentials, immitators=immitators,
                Ninf=thetacatj[5])

stdImmit = sqrt(abs(diag(ginv(hess)))) #1,3,5

# total standard deviation
#========================================
c(stdInf[1],stdImmit[1],stdInf[2],stdImmit[2],stdInf[3],stdImmit[3],stdImmit[4])




#==========================================================================================
# Maximize expected purchases based on time varying rate of enterance of immitation
#=========================================================================================


# expected purchases
#===========================================
expctedL = function (beta, y, X) 
{
  n = length(y)
  j = nrow(X)/n
  Xbeta = X %*% beta
  Xbeta = matrix(Xbeta, byrow = T, ncol = j)
  ind = cbind(c(1:n), y)
  xby = Xbeta[ind]
  Xbeta = exp(Xbeta)
  iota = c(rep(1, j))
  denom = log(Xbeta %*% iota)
  return(sum(exp(xby - denom)))
}


# initial configuration for optimization to maximize expected adoption
#=========================
GlobalChoiceCoeffPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/ChoiceCoefficients.csv"
GlobalChoiceCoeff  =  read.csv(GlobalChoiceCoeffPath,header=T)

coefficients= GlobalChoiceCoeff[,2:15]
Tchoice = 18
param = GlobalParam
thetacatj = param
ncat = 10

#initialize time varying p
Timm = 259
p2vec = (matrix(rep(thetacatj[,2],Timm),nrow=Timm))

#param = GlobalParam
GlobalDiffLatent=read.csv(GlobalDiffLatentPath,header=T)
GlobalDiffLatent = GlobalDiffLatent[,2:21]
influentials = as.matrix(GlobalDiffLatent[,c(1,3,5,7,9,11,13,15,17,19)])
immitators = as.matrix(GlobalDiffLatent[,c(2,4,6,8,10,12,14,16,18,20)])

#==============================================================
# Aggregate weekly: initialization
#===============================================================
#vectorize with blocks of choice charact (i.e immitators level) at each point in time
immitatorLevelTemp = as.vector(t(LocalImitDensity)-mean(LocalImitDensity))

#=================================================================
# Optimization of the enterance of immitators through promotion
#=================================================================
# p2vec: [Timm x ncat]
expectedAdoptionFunc = function(p2vec){  # p2vec: [Timm x ncat]
  
  #===================================
  # recover p2vec
  #===================================
  p2vec = matrix(p2vec,ncol=ncat)
  
  
  #===============================
  # inside optimal procedure
  #===============================
  colnames(thetacatj) <- c("p1", "p2", "q1", "q2","Ninf", "Nimm","w","tt");
  immitatorLevelExp = matrix(rep(1,ncat*(Timm+1)),ncol=Timm+1)
  
  # create the expected immitators based on the time varying p
  for (t in 2:(Timm+1)){
    latentt_1 = immitatorLevelExp[,t-1]
    influentialsEffect = matrix(thetacatj[,"w"]*(influentials[t-1,]/thetacatj[,"Ninf"]),ncol=1)
    immitatorsEffect = matrix((1-thetacatj[,"w"])*(latentt_1/thetacatj[,"Nimm"]),ncol=1)
    immitatorLevelExp[,t]  =    latentt_1+
      (p2vec[t-1,]+thetacatj[,"q2"]*(as.vector(influentialsEffect)+
                                       as.vector(immitatorsEffect)))*
      (thetacatj[,"Nimm"]-latentt_1)
    
    # make sure it is always positive increasing
    immitatorLevelExp[,t] = pmax(pmin(immitatorLevelExp[,t],thetacatj[,"Nimm"]),latentt_1)
  }
  LocalImitDensity = immitatorLevelExp[,2:(Timm+1)]
  #plot(LocalImitDensity[3,])
  
  #==================================
  #aggregate weekly
  #==================================
  # length of ncat*T (in days)
  lengthChoiceChar = 1240
  
  immitatorLevelTemp = as.vector(t(LocalImitDensity)-mean(LocalImitDensity))
  
  #replicate the first missing days to make sure it is multiple of 70
  immitatorLevelTemp=c(immitatorLevelTemp[1:(70-(lengthChoiceChar%%70))], immitatorLevelTemp[1:lengthChoiceChar])
  
  immitatorLevel = matrix(rep(0,Tchoice*ncat),ncol=1)
  
  
  # Weekly aggregation for both immitator level
  for (t in 1:Tchoice){ 
    immitatorLevel[((t-1)*ncat+1):(t*ncat),]   =   (immitatorLevelTemp[(70*(t-1)+1):(70*(t-1)+10)]+
                                                      immitatorLevelTemp[(70*(t-1)+11):(70*(t-1)+20)]+immitatorLevelTemp[(70*(t-1)+21):(70*(t-1)+30)]+
                                                      immitatorLevelTemp[(70*(t-1)+31):(70*(t-1)+40)]+immitatorLevelTemp[(70*(t-1)+41):(70*(t-1)+50)]+
                                                      immitatorLevelTemp[(70*(t-1)+51):(70*(t-1)+60)]+immitatorLevelTemp[(70*(t-1)+61):(70*(t-1)+70)])/7
  }
  
  immitatorLevelChoice= array(immitatorLevel,dim=c(ncat,Tchoice,1))
  
  #initialize expected purchases to zero
  expPurch = 0
  
  for (i in 1:nIndv){       # given individual
    # create individual coefficients of utility for category and app choice
    alphai= GlobalChoiceCoeff[i,2:16]  # 1 x 15
    for (t in 1:Tchoice){         # given time
      #---------------------------------------------------
      #        Choice of Category
      #---------------------------------------------------
      # include outside option as vector of zeros
      
      Xacat=matrix(c(c(0,indvCatState[t,i,]),c(0,immitatorLevelChoice[,t,1])
                     ,as.vector(rbind(rep(0,dim(catchar)[3]),catchar[,t,]))),nrow=1);  
      
      Xcat=createX(p=ncat+1,na=ncatcoefficients-ncat,nd=NULL,Xa=Xacat,Xd=NULL,base=1)  
      Xcattemp[(((t-1)*(ncat+1)+1):(t*(ncat+1))),]=Xcat #pooling choice situations
      #ycatTemp[t]=IndvChoiceWeekly[t,i]
      
      # Update state vector of individual choic
      if ((t<Tchoice)&&(ycatTemp[t]!=1)){ # the first choice is no purchase
        indvCatState[(t+1):Tchoice,i,(ycatTemp[t]-1)]=indvCatState[(t+1):Tchoice,i,(ycatTemp[t]-1)]+1; # keep total number of purchases within the category
      }
    }
    # sum up choice prob for every app category except no purchase option
    for (j in 2:(ncat+1)){
      # iterate on probability of purchase of each of the choices except outside one
      expPurch=expPurch + expctedL(t(alphai),rep(j,Tchoice),Xcattemp)
    }
  }
  # return negative as I want to maximize the positive
  print (paste('Meisam current expected adoption is:',expPurch,'\n'))
  return (-expPurch)
}

#==================================================================
#compile function and run optimization
#==================================================================
require(compiler)
library(compiler)
enableJIT(3)

slow_func_compiled <- cmpfun(expectedAdoptionFunc)

#==========================================================
# Running the program in just in time mode to speed up 
#===========================================================
#constraint p to be between 0 and 1
library(RcppDE)   #C++ implementation of DEoptim
lower = rep(0,length(p2vec))
upper = rep(1,length(p2vec))

resultOfFiltering =
  DEoptim(slow_func_compiled, lower, upper #initialpop=latentitoldpop, # irecieved wiered error Error in match.fun(FUN) : '1'
          ,DEoptim.control(itermax=100, NP = 10,trace = TRUE))

resultOfFiltering$optim$bestval
matrix(resultOfFiltering$optim$bestmem,ncol=ncat)

# slow_func_compiled(lower)
# slow_func_compiled(upper)
# slow_func_compiled(as.vector(p2vec))
#=============================================================
# plot optimal
#=============================================================
optimalTrialPulsingPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/optimalPulses.csv"
optimalTrialPulsingData  =  read.csv(optimalTrialPulsingPath,header=T)
# plot an optimal solution
plot(optimalTrialPulsingData[,1],type="l",col = "green")


#====================================================================
# Plot of step ahead forecast
#====================================================================
# for global step ahead
#============================
#GlobalStepAheadPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GlobalStepAheadForecast.csv"

# for local step ahead
#============================
GlobalStepAheadPath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/LocalStepAheadForecast.csv"


GlobalStepAheadData  =  read.csv(GlobalStepAheadPath,header=T)
GlobalStepAheadData = as.matrix(GlobalStepAheadData[,2:21])
timeFrame = nrow(GlobalStepAheadData)


i = 2
#curappcatTitle = "Device Tools app Category"
curappcatTitle = "Games app Category"
#curappcatTitle = "University app Category"
# 1: Device tools
# 3: Games
# 10: university
indx = ((i-1)*2+1):((i-1)*2+2)
x = 1:timeFrame
y1 = GlobalStepAheadData[,indx[1]]
plot( x, y1, type="l", col="red" )
par(new=TRUE)
y2 = GlobalStepAheadData[,indx[2]]
plot( x, y2, type="l", col="green" )


require(ggplot2)

df <- data.frame(x,y1,y2)
ggplot(df, aes(x)) +                    # basic graphical object
  geom_line(aes(y=y1), colour="red") +  # first layer
  geom_line(aes(y=y2), colour="green")+
    labs(title = curappcatTitle)+
  ylab("Diffusion Level")+ xlab("Days(t)")


    # second layer
