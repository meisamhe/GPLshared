# Bass Model nonlinear least square approach
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
cl=makeCluster(7)
registerDoSNOW(cl)
set.seed(66)
par(mfrow=c(3,1))

#------------------------------------------------------------------------
# Diffusion 
#------------------------------------------------------------------------
ncat = 10
# T    = 258
# categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalCategoryDiffusion.csv",header=T)
T=191
categoryDiffData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/CategoryDiffusion.csv",header=T)
categoryDiff= matrix(rep(0,ncat*T),ncol=ncat)
for (i in 1:ncat){
   categoryDiff[,i]=categoryDiffData[[i+1]]
}
categoryDiff=t(categoryDiff)
plot(categoryDiff[1,])

# seperate the total innovator and immitator
catlatent = categoryDiff
totalForce = t(apply(catlatent,1,diff))
plot(totalForce[1,])

# run NLLS on one
currentCat = 10
currentSales = totalForce[currentCat,]
currentSalesTemp = t(matrix(currentSales[1:(T-(T%%7))],nrow=7))
currentSales=rowSums(currentSalesTemp)
t(t(currentSales))
t = 1:length(currentSales)
result = nls(currentSales ~ m*(((1-exp(-(p+q)*t))/(1+q/p*exp(-(p+q)*t)))-((1-exp(-(p+q)*(t-1)))/(1+q/p*exp(-(p+q)*(t-1))))),
             data=list(currentSales=currentSales),
             start=list(p=0.002,q=0.2,m=500))
coef(summary(result))

#---------------------------------------------
#read the local and global diffusion level
#---------------------------------------------
#start with local level diffusion
LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/LocalDiffusionDecomLatent.csv",header=T)
#LocalDiffusionDecom=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/GlobalDiffusionDecomLatent.csv",header=T)
Tw = dim(LocalDiffusionDecom)[1]
LocalImitInovForce= array(rep(0,2*Tw*ncat),dim=c(Tw,ncat,2))
for (i in 1:ncat){
   LocalImitInovForce[1:Tw,i,1:2]=as.matrix(as.vector(LocalDiffusionDecom[,((2*(i-1))+2):((2*i)+1)]),ncol=2)
}

#----------------------------------------------------------------------------
# Read choice characteristics
#===========================================================================
categoryChoicCharData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/CategoryChoiceChar.csv",header=T)
nDataChoiceChar = 1
Tchoice = 124

#negate to assume that it is about breath of the category
categoryChoicCharTemp= -matrix(categoryChoicCharData[[3]],ncol=1)

# create all U-shaped and normal variables
nDataChoiceChar = 5               # to account for u-shaped relationships
categoryChoicChar= matrix(rep(0,nDataChoiceChar*Tchoice*ncat),ncol=nDataChoiceChar)

# U shaped relationships
# paid apps
categoryChoicChar[,1] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])
categoryChoicChar[,2] = categoryChoicCharTemp[,1]**2 - mean(categoryChoicCharTemp[,1]**2)

#Fremumness of the category
categoryChoicCharTemp= matrix(categoryChoicCharData[[4]],ncol=1)

# U shaped relationships
# paid apps
categoryChoicChar[,3] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])
categoryChoicChar[,4] = categoryChoicCharTemp[,1]**2 - mean(categoryChoicCharTemp[,1]**2)

#Infancy of the category
categoryChoicCharTemp= matrix(categoryChoicCharData[[5]],ncol=1)
categoryChoicChar[,5] = categoryChoicCharTemp[,1] - mean(categoryChoicCharTemp[,1])

# to make sure I have corresponding weeks
# for local: 1220
# for global 1180
lengthChoiceChar = 1220
#lengthChoiceChar = 1180
categoryChoicCharWeeklyTemp=rbind(categoryChoicChar[1:(70-(lengthChoiceChar%%70)),], categoryChoicChar[1:lengthChoiceChar,])
Tchoice=dim(categoryChoicCharWeeklyTemp)[1]/70
categoryChoicCharWeekly = matrix(rep(0,Tchoice*ncat*nDataChoiceChar),ncol=nDataChoiceChar)
for (t in 1:Tchoice){
   categoryChoicCharWeekly[((t-1)*ncat+1):(t*ncat),]= (categoryChoicCharWeeklyTemp[(70*(t-1)+1):(70*(t-1)+10)]+
      categoryChoicCharWeeklyTemp[(70*(t-1)+11):(70*(t-1)+20)]+categoryChoicCharWeeklyTemp[(70*(t-1)+21):(70*(t-1)+30)]+
   categoryChoicCharWeeklyTemp[(70*(t-1)+31):(70*(t-1)+40)]+categoryChoicCharWeeklyTemp[(70*(t-1)+41):(70*(t-1)+50)]+
      categoryChoicCharWeeklyTemp[(70*(t-1)+51):(70*(t-1)+60)]+categoryChoicCharWeeklyTemp[(70*(t-1)+61):(70*(t-1)+70)])/7
}

#---------------------------------------------------------------------------
# Read individual Choices
#===========================================================================
nIndv = 147
IndvChoiceData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/individualChoice.csv",header=T)
IndvChoice= matrix(rep(0,dim(IndvChoiceData)[1]*nIndv),ncol=nIndv)
for (i in 1:nIndv){
   IndvChoice[,i]=IndvChoiceData[[i+1]]
}
tempT = dim(IndvChoice)[1]
IndvChoiceTemp=rbind(matrix(rep(1,(7-tempT%%7)*nIndv),ncol=nIndv),IndvChoice)
IndvChoiceWeekly = matrix(rep(0,Tchoice*nIndv),ncol=nIndv)
for (t in 1:Tchoice){
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
IndvTenureHBData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/TenureIndvHB.csv",header=T)
IndvTenureHB= matrix(rep(0,nIndv*nzIndv),ncol=nzIndv)
IndvTenureHB[,1]=IndvTenureHBData[[2]]

#---------------------------------------------------------------------------
# Read CategoryHB data
#===========================================================================
nzcat = 1
CategoryHBData=read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/CategoryHB.csv",header=T)
CategoryHB= matrix(rep(0,ncat*nzcat),ncol=nzcat)
CategoryHB[,1]=CategoryHBData[[3]]

#-------------------------------------------------------------------------------
# simulate individual with HB of tenure of each individual
# start at moment 1 and create choice and state space for individual
# state of individual for category includes: number of app's in each category
# state of individual for app includes downloads of app in each category [nc*na(c)]
#-------------------------------------------------------------------------------
dummyNoPurchaseCat=c(rep(0,T)); # for no cat download option
indvCatState = array(rep(0,T*nIndv*ncat),dim=c(T,nIndv,ncat))   # start with no prior download as it is starting point of this app store

#---------------------------------------------------
#              HB for individual for category choice
#---------------------------------------------------
ncatcoefficients = ncat + 3 + nDataChoiceChar       # for all 11 coefficients for data, 2 coefficient category state, 1 coefficient indiv state, ncat of utility (for fixed effects)
DeltaIndv3=matrix(runif(ncatcoefficients)*1e-1,ncol=1)         
compsIndv3=NULL
ncompIndv= 5 
ZIndv = IndvTenureHB
ZIndv=t(t(ZIndv)-apply(ZIndv,2,mean))          # demean Zcat, popularity explanator of category

for (i in 1:ncompIndv){
   compsIndv3[[i]]=list(mu=runif(ncatcoefficients)*1e-9,rooti=diag(ncatcoefficients)*1e9)
}
pvecIndv3=rep(1/ncompIndv,ncompIndv)    # equally likely

#--------------------------------------------------------------------
# run factor model to fine appropriate variables of category
#---------------------------------------------------------------------
FactorModelData = read.csv("C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/SummarizeData/FactorModelData.csv",header=T)
fit <- princomp(FactorModelData, cor=TRUE)
summary(fit) # print variance accounted for 
loadings(fit) # pc loadings 
plot(fit,type="lines") # scree plot 
fit$scores # the principal components
biplot(fit)

#-----------------------------------------------------
#                  Simulating Choice
#-----------------------------------------------------
# individual coefficients for category and app
alphai = matrix(rep(0,nIndv*ncatcoefficients),ncol=ncatcoefficients)
catchar = array(categoryChoicCharWeekly,dim=c(ncat,Tchoice,nDataChoiceChar))
Xcattemp=matrix(rep(0,Tchoice*(ncat+1)*ncatcoefficients),nrow=Tchoice*(ncat+1))   #as ncat is number of choices
ycatTemp       = c(rep(0,Tchoice))
simCatChoice=NULL

# integrate to get total force until a given point in time
immitatorForce=t(as.matrix(LocalImitInovForce[,,2],ncol=ncat))
innovatorForce=t(as.matrix(LocalImitInovForce[,,1],ncol=ncat))

for (i in 1:nIndv){       # given individual
   # create individual coefficients of utility for category and app choice
   alphai[i,]=DeltaIndv3%*%ZIndv[i,]+as.vector(rmixture(1,pvecIndv3,compsIndv3)$x)
   for (t in 1:Tchoice){         # given time
      #---------------------------------------------------
      #        Choice of Category
      #---------------------------------------------------
      # include outside option as vector of zeros
      
      Xacat=matrix(c(c(0,indvCatState[t,i,]),c(0,innovatorForce[,Tw-1-Tchoice+t]),c(0,immitatorForce[,Tw-1-Tchoice+t]),as.vector(rbind(rep(0,dim(catchar)[3]),catchar[,t,]))),nrow=1);  
      
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


#------------------------------------------------------------------------
# running estimation procedure
#----------------------------------------------------------------------------
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
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/LocalDiffusion/MhRossiResultLocalLatent08252014alphaidraw.csv")

#deltadraw
outdata=data.frame(array(deltadraw))
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/LocalDiffusion/MhRossiResultLocalLatent08252014deltaDraw.csv")

#likelihood
outdata=data.frame(array(loglikelihood))
write.csv(outdata, file = "C:/Users/MeisamHe/Desktop/Projects/MTNAppStore/Results/LocalDiffusion/MhRossiResultLocalLatent08252014LogLikelihood.csv")

#save workspace
getwd()
save.image()


#-----------------------------------------------------------------------------------------------
# Old Codes
#-----------------------------------------------------------------------------------------------

# run NLLS on one (Jain and Rao 1990)
currentCat = 4
currentSales = totalForce[currentCat,]
t = 1:length(currentSales)
result = nls(currentSales ~ (m-categoryDiff[currentCat,])*
                (((1-exp(-(p+q)*t))/(1+(q/p)*exp(-(p+q)*t)))-((1-exp(-(p+q)*(t-1)))/(1+(q/p)*exp(-(p+q)*(t-1)))))/(1-((1-exp(-(p+q)*(t-1)))/(1+(q/p)*exp(-(p+q)*(t-1))))),
             data=list(currentSales=currentSales),
             start=list(p=0.002,q=0.2,m=5000))
coef(summary(result))