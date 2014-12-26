# read response
vc<-read.csv("d:/firefoxproject/firefoxregressor.csv",header=F) # viewed category: 365 per day moving average last 10
d<-read.csv("d:/firefoxproject/Dwnld.csv",header=F) # downloads count (dayl one year): 365 days
dc<-read.csv("d:/firefoxproject/DocCategory.csv",header=F) #each review category frequency: 1212 items
s<-read.csv("d:/firefoxproject/Stars.csv",header=F) # stars for ordinal probit
s1<-read.csv("d:/firefoxproject/Stars1.csv",header=F) # one star (23)
s2<-read.csv("d:/firefoxproject/Stars2.csv",header=F) # two star (14)
s3<-read.csv("d:/firefoxproject/Stars3.csv",header=F) # Three star (56)
s4<-read.csv("d:/firefoxproject/Stars4.csv",header=F) # Four star (235)
s5<-read.csv("d:/firefoxproject/Stars5.csv",header=F) # Five star (884)
vc=as.matrix(vc)
d=as.matrix(d)
dc=as.matrix(dc)
s=as.matrix(s)
s1=as.matrix(s1)
s2=as.matrix(s2)
s3=as.matrix(s3)
s4=as.matrix(s4)
s5=as.matrix(s5)

#First models (frequentist)
#Gausian OLS
GOLSfit<-lm(d ~vc)
summary(GOLSfit)

#poisson regression
Poisfit <- glm(d ~ vc, family=poisson())
summary(Poisfit)

#First Models Bayesian
vcb<-cbind(1,vc)
dt1 <- list(y=d,X=vcb) #data for bayesian analysis
betabar1 <- as.numeric(coefficients(GOLSfit)) # c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) #priors  
A1 <- 10 * diag(21) # Pecision matrix for the normal prior. Again we have 2
n1 <- 21 # degrees of freedom for the inverse chi-square prior
ssq1 <- var(d) # scale parameter for the inverse chi-square prior
Prior1 <- list(betabar=betabar1, A=A1, nu=n1, ssq=ssq1)
iter <- 10000 # number of iterations of the Gibbs sampler
slice <- 1 # thinning/slicing parameter. 1 means we keep all all values
MCMC <- list(R=iter, keep=slice)
sim1 <- runiregGibbs(dt1, Prior1, MCMC)
pdf('BGOLSM.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(sim1$betadraw)
dev.off()
pdf('BGOLSS.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(sim1$sigmasqdraw)
dev.off()
summary(sim1$betadraw)
summary(sim1$sigmasqdraw)
posterior<-MCMCregress(d~vc,verbose=1000, b0=betabar1, B0=A1, mrginal.likelihood="Chib95") #log likelihood (generates a sample from the posterior distribution )
raftery.diag(posterior) # run length control diagnostic based on a criterion of accuracy of estimation of the quantile q
post2 <- MCMCregress(log(d)~vc,verbose=1000,b0=betabar1, B0=A1, marginal.likelihood="Chib95") 
raftery.diag(post2) 
summary(posterior) ;
summary(post2);
BayesFactor(posterior, post2);

#tobit
Tobitfit <- MCMCtobit(d~vc, mcmc=30000, verbose=1000)
pdf('Tobit.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(Tobitfit)
dev.off()
raftery.diag(Tobitfit)
summary(Tobitfit)

#ordinal probit
dcb<-cbind(1,dc)
set.seed(66)  
nobs=1212 
k=5 #for five categories
Data=list(X=dcb,y=s, k=k)
Mcmc=list(R=10000)   
OProb=rordprobitGibbs(Data=Data,Mcmc=Mcmc)
names(OProb) #gives sub variables
pdf('OrProbitBeta.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(OProb$betadraw)
dev.off()
pdf('OrdProbitCutdraw.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(OProb$cutdraw)
dev.off()
summary(OProb$betadraw)
summary(OProb$cutdraw)

#binary probit (i number of starst at specific level)
bfp<-glm( s4~dc, family=binomial(link=probit))
summary(bfp)

#Bayesian Binary probit
Data1=list(X=dcb,y=s4)
Mcmc1=list(R=10000,keep=1)
BProb=rbprobitGibbs(Data=Data1,Mcmc=Mcmc1)
names(BProb)
pdf('BinProbit.pdf',width=11, height=8.5,pointsize=12, paper='special') #pring multiple page of graph into one file
plot(BProb$betadraw)
dev.off()
summary(BProb$betadraw)

#binary logit
BLGF<-glm(s4~dc,family=binomial())
summary(BLGF)

#Bayesian Binary Logit
library(mcmc)
x=dcb;
dimnames(x)<-NULL;
lupost<-function(beta,x,y){
	eta <- x%*%beta
	p<-1/(1+exp(-eta))
	logl<-sum(log(p[y==1]))+sum(log(1-p[y==0]))
	return(logl+sum(dnorm(beta,0,2,log=TRUE)))
}
set.seed(57)
beta.init <- as.numeric(coefficients(BLGF)) #c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) #
BBLGF <- metrop(lupost, beta.init, 1000, x=x, y=s4)
names(BBLGF)
BBLGF$accept
plot(BBLGF$betadraw)

#binary Logit

