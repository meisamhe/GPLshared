#===========================================
# cleaning up 
#===========================================
rm(list=ls(pattern="^tmp"))
rm(list=ls())

#===========================================
# Useful Libraries
#===========================================
library(bayesm)
library(foreach)
library(abind)
library(doSNOW)
library(DEoptim)
library(MASS)
library(numDeriv)
library("corpcor")

#--------------------------------------------------------------------
# run factor model to fine appropriate variables of category
#---------------------------------------------------------------------
FactorModelData = read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/FactorModelData.csv",header=T)
library(psych)
fit <- principal(as.matrix(FactorModelData), nfactors=3, rotate="varimax")
FactorLevel = as.matrix(FactorModelData)%*%fit$loading
outputFilePath = "C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/FactorsLevelData.csv"
write.csv(FactorLevel/1000, file = outputFilePath)

#---------------------------------------------
#read the local and global diffusion level
#---------------------------------------------
#start with local level diffusion
LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/LocalDiffusionImmitDecomLatent.csv",header=T)
#Global Diffusion
#LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/GlobalDiffusionImmitatorLatent.csv",header=T)
LocalImitDensity = as.matrix(LocalDiffusionDecom[,2:(ncat+1)])
# Tw = dim(LocalDiffusionDecom)[1]
# LocalImitInovForce= array(rep(0,2*Tw*ncat),dim=c(Tw,ncat,2))
# for (i in 1:ncat){
#   LocalImitInovForce[1:Tw,i,1:2]=as.matrix(as.vector(LocalDiffusionDecom[,((2*(i-1))+2):((2*i)+1)]),ncol=2)
# }

#----------------------------------------------------------------------------
# Read choice characteristics
#===========================================================================
categoryChoicCharData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/CategoryChoiceChar.csv",header=T)
nDataChoiceChar = 1
Tchoice = nrow(LocalImitDensity)

# create all U-shaped and normal variables
nDataChoiceChar = 3               # to account for u-shaped relationships
categoryChoicChar= matrix(rep(0,nDataChoiceChar*Tchoice*ncat),ncol=nDataChoiceChar)
choiceRows = nrow(categoryChoicChar)
categoryChoicChar = as.matrix(categoryChoicCharData[,3:(nDataChoiceChar+2)])

#deman, to be able to put category intercept in
categoryChoicChar = categoryChoicChar- t(matrix(rep(apply(categoryChoicChar,2,mean),choiceRows),ncol=choiceRows))


#=======================================================================================
# Aggregate weekly
#=======================================================================================
#vectorize with blocks of choice charact (i.e immitators level) at each point in time
immitatorLevelTemp = as.vector(t(LocalImitDensity)-mean(LocalImitDensity))

# length of ncat*T (in days)
lengthChoiceChar = nrow(categoryChoicCharData)

#replicate the first missing days to make sure it is multiple of 70
categoryChoicCharWeeklyTemp=rbind(categoryChoicChar[1:(70-(lengthChoiceChar%%70)),], categoryChoicChar[1:lengthChoiceChar,])
immitatorLevelTemp=c(immitatorLevelTemp[1:(70-(lengthChoiceChar%%70))], immitatorLevelTemp[1:lengthChoiceChar])

Tchoice=nrow(categoryChoicCharWeeklyTemp)/70
categoryChoicCharWeekly = matrix(rep(0,Tchoice*ncat*nDataChoiceChar),ncol=nDataChoiceChar)
immitatorLevel = matrix(rep(0,Tchoice*ncat),ncol=1)

# Weekly aggregation for both immitator level
for (t in 1:Tchoice){
   categoryChoicCharWeekly[((t-1)*ncat+1):(t*ncat),]= (categoryChoicCharWeeklyTemp[(70*(t-1)+1):(70*(t-1)+10),]+
      categoryChoicCharWeeklyTemp[(70*(t-1)+11):(70*(t-1)+20),]+categoryChoicCharWeeklyTemp[(70*(t-1)+21):(70*(t-1)+30),]+
   categoryChoicCharWeeklyTemp[(70*(t-1)+31):(70*(t-1)+40),]+categoryChoicCharWeeklyTemp[(70*(t-1)+41):(70*(t-1)+50),]+
      categoryChoicCharWeeklyTemp[(70*(t-1)+51):(70*(t-1)+60),]+categoryChoicCharWeeklyTemp[(70*(t-1)+61):(70*(t-1)+70),])/7
  

    immitatorLevel[((t-1)*ncat+1):(t*ncat),]   =   (immitatorLevelTemp[(70*(t-1)+1):(70*(t-1)+10)]+
                          immitatorLevelTemp[(70*(t-1)+11):(70*(t-1)+20)]+immitatorLevelTemp[(70*(t-1)+21):(70*(t-1)+30)]+
                          immitatorLevelTemp[(70*(t-1)+31):(70*(t-1)+40)]+immitatorLevelTemp[(70*(t-1)+41):(70*(t-1)+50)]+
                          immitatorLevelTemp[(70*(t-1)+51):(70*(t-1)+60)]+immitatorLevelTemp[(70*(t-1)+61):(70*(t-1)+70)])/7
     
    
}

#---------------------------------------------------------------------------
# Aggregate and Read individual Choices
#===========================================================================
nIndv = 147
IndvChoiceData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/individualChoice.csv",header=T)
IndvChoice= matrix(rep(0,nrow(IndvChoiceData)*nIndv),ncol=nIndv)
for (i in 1:nIndv){
   IndvChoice[,i]=IndvChoiceData[[i+1]]
}
tempT = dim(IndvChoice)[1]
IndvChoiceTemp=rbind(matrix(rep(1,(7-tempT%%7)*nIndv),ncol=nIndv),IndvChoice)
IndvChoiceWeekly = matrix(rep(0,Tchoice*nIndv),ncol=nIndv)
for (t in 1:Tchoice){ # works because nobody purchases more than 1, and no purchase is 1
   IndvChoiceWeekly[t,]=(IndvChoiceTemp[(7*(t-1)+1),]*
                            IndvChoiceTemp[(7*(t-1)+2),]*IndvChoiceTemp[(7*(t-1)+3),]*
                            IndvChoiceTemp[(7*(t-1)+4),]*IndvChoiceTemp[(7*(t-1)+5),]*
                            IndvChoiceTemp[(7*(t-1)+6),]*IndvChoiceTemp[(7*(t-1)+7),])
}
table(IndvChoiceWeekly)

#---------------------------------------------------------------------------
# Read TenureIndvHB data
#===========================================================================
nzIndv = 1
IndvTenureHBData=read.csv("C:/Users/MeisamHe/Desktop/Desktop/Projects/MTNAppStore/SummarizeData/TenureIndvHB.csv",header=T)
IndvTenureHB= matrix(rep(0,nIndv*nzIndv),ncol=nzIndv)
IndvTenureHB[,1]=ceiling(IndvTenureHBData[[2]])

#-------------------------------------------------------------------------------
# simulate individual with HB of tenure of each individual
# start at moment 1 and create choice and state space for individual
# state of individual for category includes: number of app's in each category
# state of individual for app includes downloads of app in each category [nc*na(c)]
#-------------------------------------------------------------------------------
dummyNoPurchaseCat=c(rep(0,Tchoice)); # for no cat download option
indvCatState = array(rep(0,Tchoice*nIndv*ncat),dim=c(T,nIndv,ncat))   # start with no prior download as it is starting point of this app store

#---------------------------------------------------
#              HB for individual for category choice
#---------------------------------------------------
ncatcoefficients = ncat + 2 + nDataChoiceChar       
  # for all 3 coefficients category characteristics data, 
  #1 coefficient category state, 
  #1 coefficient indiv state, 
  #ncat of utility (for fixed effects)

DeltaIndv3=matrix(runif(ncatcoefficients)*1e-1,ncol=1)         
compsIndv3=NULL
ncompIndv= 5 
ZIndv = IndvTenureHB
ZIndv=t(t(ZIndv)-apply(ZIndv,2,mean))          # demean Zcat, popularity explanator of category

for (i in 1:ncompIndv){
   compsIndv3[[i]]=list(mu=runif(ncatcoefficients)*1e-9,rooti=diag(ncatcoefficients)*1e9)
}
pvecIndv3=rep(1/ncompIndv,ncompIndv)    # equally likely

#-----------------------------------------------------
#                  Simulating Choice
#-----------------------------------------------------
# individual coefficients for category and app
alphai = matrix(rep(0,nIndv*ncatcoefficients),ncol=ncatcoefficients)
catchar = array(categoryChoicCharWeekly,dim=c(ncat,Tchoice,nDataChoiceChar))
immitatorLevelChoice= array(immitatorLevel,dim=c(ncat,Tchoice,1))
Xcattemp=matrix(rep(0,Tchoice*(ncat+1)*ncatcoefficients),nrow=Tchoice*(ncat+1))   #as ncat is number of choices
ycatTemp       = c(rep(0,Tchoice))
simCatChoice=NULL

# # integrate to get total force until a given point in time
# immitatorForce=t(as.matrix(LocalImitInovForce[,,2],ncol=ncat))
# innovatorForce=t(as.matrix(LocalImitInovForce[,,1],ncol=ncat))

for (i in 1:nIndv){       # given individual
   # create individual coefficients of utility for category and app choice
   alphai[i,]=DeltaIndv3%*%ZIndv[i,]+as.vector(rmixture(1,pvecIndv3,compsIndv3)$x)
   for (t in 1:Tchoice){         # given time
      #---------------------------------------------------
      #        Choice of Category
      #---------------------------------------------------
      # include outside option as vector of zeros
      
      Xacat=matrix(c(c(0,indvCatState[t,i,]),c(0,immitatorLevelChoice[,t,1])
                     ,as.vector(rbind(rep(0,dim(catchar)[3]),catchar[,t,]))),nrow=1);  
      
      Xcat=createX(p=ncat+1,na=ncatcoefficients-ncat,nd=NULL,Xa=Xacat,Xd=NULL,base=1)  
      # outa=simmnlwX(1,Xcat,alphai[i,])
      Xcattemp[(((t-1)*(ncat+1)+1):(t*(ncat+1))),]=Xcat #pooling choice situations
      ycatTemp[t]=IndvChoiceWeekly[t,i]
      # Update state vector of individual choic
      if ((t<Tchoice)&&(ycatTemp[t]!=1)){ # the first choice is no purchase
         indvCatState[(t+1):Tchoice,i,(ycatTemp[t]-1)]=indvCatState[(t+1):Tchoice,i,(ycatTemp[t]-1)]+1; # keep total number of purchases within the category
      }
   }
   simCatChoice[[i]]=list(y=ycatTemp,X=Xcattemp,beta=alphai[i,])
}


#----------------------------------------------------------------------------
#============================================================================
# running estimation procedure
#----------------------------------------------------------------------------
#============================================================================
##   set parms for priors and Z
Prior1=list(ncomp=ncompIndv)
keep=5
Mcmc1=list(R=10000,keep=keep)
Data1=list(p=ncat+1,lgtdata=simCatChoice,Z=ZIndv)
out=rhierMnlRwMixture1(Data=Data1,Prior=Prior1,Mcmc=Mcmc1)


cat("Summary of Delta draws",fill=TRUE)
summary(out$Deltadraw,tvalues=as.vector(Delta))
plot(out$Delta[,5])
cat("Summary of Normal Mixture Distribution",fill=TRUE)
summary(out$nmix)

if(0) {
   ## plotting examples
   plot(out$betadraw)

}
names(out)

#==============================================================================
# Generate REsults and curves
#===============================================================================
#alphai
alphaidraw = out$betadraw
apply(alphaidraw,c(1,2),quantile,probs=c(0.05,0.95))
apply(alphaidraw,c(1,2),sd)
meanIndivalphai=apply(alphaidraw,c(1,2),mean)
apply(meanIndivalphai,2,quantile,probs=c(0.05,0.95))
apply(meanIndivalphai,2,mean)
apply(meanIndivalphai,2,sd)

#delta draw
deltadraw = out$Delta
apply(deltadraw,2,quantile,probs=c(0.05,0.95))
apply(deltadraw,2,mean)
apply(deltadraw,2,sd)

#loglikelihood
loglikelihood=out$loglike
mean(loglikelihood)

plot(out$nmix)


#Saving workspace
#------------------------------------------------------
#alphaidraw
outdata=data.frame(array(as.vector(alphaidraw),dim=c(nIndv,Tchoice,2000)))
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/MhRossiResultGlobaLatent08242014alphaidraw.csv")

#deltadraw
outdata=data.frame(array(deltadraw))
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/MhRossiResultGlobalLatent08242014deltaDraw.csv")

#likelihood
outdata=data.frame(array(loglikelihood))
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/MhRossiResultGlobalLatent08242014LogLikelihood.csv")

#save workspace
getwd()
save.image()


