A = matrix(c(1,2,3,4,5,6, 7, 8, 9), nrow =3)
a = matrix(c(1,2,3), nrow = 3, byrow=T)
b = matrix(c(1,2,3), ncol = 3)
matrix(runif(3*), ncol=2)
mat.or.vec(3,2)
diag(3)
A = matrix(1:6, nrow=2, byrow=T)
dim(A)
A[1,]
A[1:2,]
diag(1:3)
matrix(1L, 3, 2)
t(A[,1])
A[,1]
A[,1:2]
A[A[,3]==9,]
A[1,1]
as.vector(A)
total_elements = dim(A)[1] * dim(A)[2]
B = matrix(A, ncol=total_elements)
A = matrix(1:6,nrow=2,byrow=T)
B = matrix(7:12,nrow=2,byrow=T)
C = rbind(A,B)
a = matrix(1:3, ncol=3)
b = matrix(4:6, ncol=3)
matrix(rbind(A, B), ncol=2)
rbind(A,B)
A * 2
A + 2
A -2
A / 2
A %*% A
t(b %*% A)
A * A
A - A
A / A
A ^ 2
install.packages('expm')
library(expm)
A %^% 2
t(A)
det(A)
solve(A)
cov(matrix(c(x1, x2, x3), ncol=3))
eigen(A)
install.packages('MASS')
library(MASS)
mvrnorm(n=10, mean, cov)

Install.packages (“DEoptim”)
# r automatically kills the clusters if not used for a long time
# for i7   NEHALEM (use Rblas for speeding up)
A -< available.packages() 
Head (rownames(a), 3) # show the names of the first few packages
Install.packages (c(“slidify”), “ggplot2”, “devtools”))
Source(“http://bioconductor.org/biocLite.R”)
bicoLite()
biocLite(c(GenomicFeatures,”AnnotationDbi”))
library(ggplot2)
search()
find.package(“devtools”)
install.packages(“devtools”)
library(devtools)
find_rtools()
install_github(‘slidify’, ‘ramnathv’)
install_github(‘slidifyLibraries’, ‘ramnathv’)
dir()
str(Data)
subset(data,parameter, Name %in% c(‘index’, …))
aggregate(subset[,’Arithmetic.Mean’])
names(pallavg)[4] <- ‘new name’
newData = transform (data,Parameter.Name = factor (…))

Libraries to use:
library(bayesm) #for Rossi Bayes package
library(foreach) # for Parallel loop
library(doSNOW) # for parallelization
 
# define number of clusters for parallel execution
Library(“parallel”)
cl=makeCluster(6)
cl=makeCluster(detectCores()-1)
registerDoSNOW(cl)
 
# to stop the cluster
stopCluster(cl)
library(parallel)
vignette(parallel)
library(“doparalel”)
library(doMC)
registerDoMC(cores=6)
 
# to use parallel loop
matrix= foreach(i=1:10, .combine=rbind)  % dopar%{   # be aware of function scope problem .export=c(“fccat”)
}
data = foreach(i=1:length(filenames),.packages=c(“ncdf”,”chron”,”stats”),.combine=rbind) %dopar%{
    try({})
}
# just putting the variables in the list in the last line returns the list containing all
For (I in seq_len(p)){}
#Memory function [Lesson: preallocate arry]
# right click on R icon> select properties > shortcut tab> Target field> --max-mem-size=6G
#"C:\Program Files\R\R-3.1.0\bin\i386\Rgui.exe" --max-mem-size=6G
memory.limit()
memory.size()
system.time(R expression) #time it takes to execute
proc.time()[3] # CPU usage in seconds, like tic toc print (end-begin)
getwd() #current working directory
setwd() #set current working directory
Rprof(file=”filename”)  turns on profileing and writes to filename
Rprof(“) turns off profiling
summaryRprof(file=”filename”) summarizes output in profile file
 
#simple for
for (var in 1:10){}

#implicit loop
apply(df[,2:4],2,mean)
ts(apply(gibbsOut$omega_theta[,,-burn],1:2,mean),start=start(y,),freq=4)

#Create diary file
con = file(“test.log”)
sink(con,append=TRUE)
sink(con,append=TRUE,type=”message)
par(ask=TRUE) # for pausing
#ESC for breaking the program
 
# read space seperated:
S1=read.csv(“d:/firefoxproject/stars1.csv”,header=F)
Library(xlsx)
Mydata=read.xlsx(“C:/Users/HE/Desktop?.../cleaned10232013.xlsx”,1)
df=read.table("data.txt",header=TRUE)
scan
tmp= ts(read.table(“…”,header=RUE),start=c(1978,1),frequency=12)*100
Data.frame(matrix(…))
Write.csv(data,file=”thsdata.csv”)
 
#output
Write.table(m,file=”m.txt,sep=”,”,row.names=FALSE,col.names=FALSE)
 
#useful writing
cat("in my reg…")
print(var)
cat(“MCMC Iteration (est time to end – min)”,fill=TRUE)
cat(sprint(“<set name\%s\”value=\”%f\></set>\n”,df$timeStamp,def$Price))
print model.tables(aov,ex1,”means”),digits=3)

#debuging
debug(myreg)
Q: quit
undebug(myreg)
stop(“there are less than 10 predictors”)
 
# to get help
help.search("kewyord")
?doSNOW
?par # all graphic elements available
 
#inspect elements in workspace
ls()
fsh() # flash
rem(list=ls()) # clear workspace
rm(list=ls(pattern=”^tmp”))
 
# get structure of a variable , type or storage mode
str(Games)
mode(df$Y)
lmout=lm(Y~X1+X2,data=df)
summary(lmout)
columns(y) columnes(temp)[1:4]
names(expdFore)
library(Himsc)
describe(mydata)
library(pastecs)
stat.desc9mydata)
library(psych)
describe(mydata)
library™
inspect(firefoxcopy[0:10])

 
#matrix operations
Replicate (10,diag(2), simplify = F)
Install.packages(“corpcor”)
Make.positive.definite()
Is.positive.definite()
colSums
rowSums
colMeans
rowMeans
lowertri(…)
upper.tri(…) # index of upper and lower triangular matrix
%*% 
* #element wise!
Length(array)
Mat[,1:2]
t()
list(rep(0,10))
chol(X)
chol2inv(chol(X)) #inverse using cholesky root
crossprod(X,Y)  # very efficient t(X)%*%Y => use more
diag		 # to create a diagonal matrix
bdiag 		# to creat block diagonal matrix
diag(5)*c(1,2,3,4,5) # matrix with this diagonal
A%o%B outer product AB’
%x% # Kronker
backsolve() # inverse of triangular array
sqrt
Sort
Log
%% #100%%10=0
round
floor
ginv # Moore-Penrose Generalized Inverse of A (in MASS library)
eigen(A) # tgives $val of eigen values and $vec for eigne vectors
svd(A) # single value dcomposition d: singular value u: left singular v: right singular
chol(A) # cholesky R’R=A
qr(A) #QR decomposition upper triangular qr: upper,rank, qaux: addition. info on Q, pivot: pivot strategy
pmax(x,y) elementwise comparison of two vectors
matrix(double(nvar*nz),ncol=nvar) 
market = temp[,”MARKET”]-tmp[,”BKFREE”] 	#address by name
a= NCOL(y)
m2=aMatrix(0,nrow=1000,ncol=1000,sparse=TRUE)
library(‘slam’)
m1=matrix(0,nrow=1000,ncol=1000)
object.size(m1)
rbind  
cbind
nrow(x)
ncol(x)
dim(x)[1]
dim(x)[2]
ceiling()
scale() # convert data to standardized score
min,max,median,sd,
mad # mean absolute deviation
table () # frequency table
cumsum #cumulative sum
cumproduct,cummax,cumin
rev() # reverse the order
order()
corr(x,y,use=”pair”) correlation matrix for pairwise complete data
is.finite(x)
is.infinite(x)
is.nan(x)
 
#function
myreg=function(y,X){
…
}
c<<-1 # for global assignment
 
 
#sequence
If (u<alpha){ }
While
y=ifelse(crabs$sattelite>0,1,0)
 
#distributions
Set.seed(1)
rnorm #normal
runif #uniform
rchisq #chi-square
rgamma (1, shape =sh1, rate=rate)
mean
var
quantile
 
#optimizer
library(optim) #general purpose
# Newton, quasi Newton, Nelder-mead, simulated annealing, BFGS, L-BFGS-B, SANN (simulated annealing)
library(nlminb)
# uses L-BFGS-B, Robust
library(nlm)
# uses Newton algorithm, Fast
library(nlme)
#rgenoud #genetic algorithm, allows parallel processing using SNOW
Library(DEoptim)
# uses different genetic optimization routine
library(Optimplex)
# simplex based algorithm, simplex method of Spendley et al., the method of Nelder and Mead, Box’s algorithm for constraint optimization, and the multi-dimensional search by Torczon
solve(fHess(exp(filt$par),func(x),dlmLL(y+build(log(x))))$Hessian)
#fdHess in nlme package: calculate hessian numerically and we can send transformed parameters
Ans=optimx(fn=function(x) sum(x*x),par=1:2)
constrOptim(theta,f,grad,ui,ci,mu=1e-04,control=list(),method=if(isnull(grad)) “Nelder-Mead” else “BFGS”,outher.iterations=100,outer.eps=1e-05,…,hessian=FALSE)
constrOptim(c(0.99,0.001),func,NULL,ui=rbind(c(-1,1), #the –x-y>0
			c(1,0), #the x>0
			c(0,1)), #the y>0
		     ci=c(-1,0.0001,0.0001)) # the threshold
#Constraints in the form of: bounds = matrix(c(0,5,0,Inf,0,Inf,0,1),nc=2, byrow=True)
#columnes(bounds)=c(“lower”,”upper)
#n<-nrow(bounds)
#ui = rbind (diag(n),…,diag(n))
# ci = c(bound[,1],-bound[,2])
# I <- as.vector(is.finite(bounds))
#ui <- ui[I,]
# ci <- ci[i]
#constroptim (param, f, grad=NULL, ui=ui,ci=ci)
library(BBML)
mle.results=mle2(norm.fit,start=list(mu=1,sigma=1),data=list(x))
out = nlm(mlog,mean(x),x=x)
# send serveral parameters
Mlogl=function(theta,x){
alpha=theta[1] 
lambda=theta[2]
return(-sum(dgamma(x,shape=alpha,rate=lambda,log=TRUE)))
}
Slpha.start=mean(x)^2/var(x)
out= nlm(mlogl,theta.start,x=x,hessian=TRUE,fscale=length(x),print.levle=2)
# Nedler-Mead: downhill simplex method : numerical method, unknown derivative, heuristic search, converges non stationary points
#SANN: variant of simulated annealing, stochastic global optimization (only func value), temperature decreases according to logarithmic cooling schedule, t current iteration step, ritically dependant upon setting control parameter, not general purpose method, very useful getting to a good rough surface, works for non differentiable function, metropolis function for acceptance probability (Gaussian Markov Kernel with scale proportional to the actual temperature), use for combinatorial problems (if func generates a new point)
 
 
#multidimensional array
ar=array(c(1,2,3,4,5,6),dim=c(3,2,2))
reject=array(0,dim(c(R/kee))
gibbsTheta=array(0,dim=c(TT+1,r,MC-1))
gibbsV[1,1,-burn]   # remove elements
window(cbind(..,..,..),start=1880,end=1920) # to remove irrelevant part
 
#change
as.matrix(df)
as.numeric
as.vector
is.matrix
is.list
library(abind) #abind(array1,array2,along=2)
install.packages(“abind”)
matrix(c(0,1,2,0,1,2,0,1,2),byrow=T,ncol=3)
 
# vector
c(1,2,..,5)
c(0:13)
ts(retailSales,start=c(1995,1),end=c(1977,12),frequency12)
lrtsm2=diff(lrtsm,difference=1)
library(TTR)
library(forecast)
decompose
forecast(fit,24)
 
#list
l=list(num=1,char="a",vec=c(4,4),list=list(FALSE,2))
l$list
l$num
lgtdata[[i]]=list(y=y,X=X)
Mcmc=list(R=2000,sbeta=0.2,keep=20)
 
#access elements and subsetting
index=c(3:5) #3 4 5
vec = c(1,2,3,2,5)
Vec[index]
index=vec==2
vec[vec!=2]
Z[,1]=rep(1,nrow(Z))

# size of matrix
Dim

Assess Convergence and summary of posterior
BOA package in R: Robert and Casella (2004) #diagnostic tools
library(dlm)
mcmcMean(cbind(gibbsOut$dV[-(1:burn),],gibbsOut$dW[-(1:burn),]))
mcmcMeans(outGibbs$phi[-burn,],names=paste(“phi”,1:2))
apply(outGibbs$phi[-burn,],2,quantile,probs=c(0.5,.95))
apply(sqrt(outGibbs$vars[-burn,]),2,quantile,probs=c(0.05,.95))
#confidence interval using expected Fisher info
Z = qnorm ((1+0.95)/2)
Alpha.hat+c(-1,1)*z/(sqrt(n*trigamma(alpha.hat))
#using observed fisher info
Alpha.hat+c(-1,1)*z/sqrt(out$hessian)
Hpd(qbeta,shape1=a,shape2=b)

Data Presentation and q-q plot
Round(mcmcMean(sqrt(gibbsV[-(1:burn),])),4)
Qqnorm(residual(damFilt,sd=False)
Tsdiag(damFilt)
Shapiro.test(res)  	# Shapiro normality test
 
#elementary Graphic
Par(mfrow=c(2,2)) # multiple images in one
hist(rnorm(1000),breaks=50,col="magenta")
plot(x,y)
line # to add to existing curve
which ((locInd == 1) %in% c(TRUE))
plot(x)
abline(c(0,1),lwd=2,lty=2) # for drawing extra lines
title ("Scatterplot") to put title on the figure
matplot(X) # sequence of plot of columns of X
acf(x) # autocorr func of time series
#Parameters:col,xlab,ylab,main
#other parameters: type="l"   #connect scatter plot  points with line
#lwd=x # width of line (1 is default, >1 ticker)
#lty=x #type of line (solid or dashed)
#xlim/ylim=c(z,w) #x/y axis runs for z to w
# sample: (col="red",col="magenta",xlab="2",pch=17,xlim=c(-4,4),ylim=(c(0,8),lty=2,lwd=2,
index=4*c(0:13)+1
matplot(out$Deltadraw[,index],type=”l”,xlab=”Iterations/20”,ylab=” “,main=”Average Respondent Part-Worths”) # main is like title
#density diagram
par(mfrow=c(3,2),oma=(c,0,3,0) 
plot(density(out$betadraw[250,1,500:1000]),main=”Medium Fixed Interest”,xlab=” “,xlim=c(-15,15),ylim=c(0,.35))
plot(dropFirst(CAPMsmooth$s[,m+1:ml],
			lty=c(“13,”6413”,”431313”,”B4”),plot.type=”s”,xlab=” “, ylab=”Beta”)
legend(“bottomright”,legend=colnames(y),bty=”n”,lty=c(“13”,”6413”,”431313”,”B4”),inset=0.05)
lines(lower,lty=2,lwd=2) 	#confidence interval
lines(upper,lty=2,lwd=2) 	#confidence interval
plot(ergMean(sqrt(gibbsV[1,1,-burn])),type=”l”,main=””,cex.lab=1.5,ylab=expression(sigma[1]),xlab=”MCMC iteration”) # ergodic mean
at=pretty(c(0,use),n=3)
at=at[at>=from]
axis(1,at=at-from,label=format(at))
legend(“topright”,legend=c(“mortgate rate”,”federal fund rate”),col=c(1,”darkgray”,Itly=c(1,2),bty=”n”)
lty=”longdash”, lty=”dotdash”, lty=solid # we can also define vector
plot.ts(outSr$s[-1,c(1,3)])
plot(ts(out$batch))
pacf(lrtsm1,lag.max=20)
acf(lrtsm1,lag.max=20)
qqnorm(cr,ylab=”Crime rate”, xlab=”Normal Scores”, main=”Normal probability plot”)
qqline(cr)
boxplot(DV~IV,data=data.ex1)
plot(table(x))
x=recordPlot(); replayPlot(x)
pie(rep(1,16),col=rainbow(16))

 
 
Install package through
install.packages("doSNOW")
update.packages()  # to update

DLM functions
library (dlm)
investFilt =dlmFilter(invest,mod)	#filtering
sdef=residuals(investFilt)$sd	# standard deviation
lwr=investFilter$f+qnorm(0.25) * sdef  #confidence interval
upr=investFilter$f-qnorm(0.25) * sdef  #confidence interval
dlmModPoly(order=1,dV=parm[1], dW=parm[2])
dlmModReg(market)
dlmMLE(y,rep(0,2),build, lower=c(1e-6,0),hessian=TRUE)   # define lower bound L-BFGS-B only accepts (max likelihood)
fit$convergence
unlist(build(fit$par)[c(“V”,”W”)])
avarLog=solve(fit$hessian)
dlmFilterDF(6,mod,DF=0.9)		#0.9 is discount factor
tt=qt(0.95,df=2*alpha)
lower=dropFirst(modFilt$m)-tt*sqrt(Ctilde*beta/alpha) 	#confidence interval
upper=dropFirst(modFilt$m)+tt*sqrt(Ctilde*beta/alpha) 	#confidence interval
dlmSmooth(modfilt)		#smoothing
dlmBSample(filt)	              # sampling from dlm
MLE for variance of univDLM, type: “level” polynom, “trend” second order polynom, “BSM” second order polynom and seasonal component
dlmGibbsDIGt(y,mod=dlmPoly(2)+dlmModSeas(4),A_y=1000,B_y=10000,p=3,n.sample=MCMC,thin=2) #for t-distrib printed code, confidence interval not need to be constant width
dlmBSample(modfilt)
library(arms)
arms(mod$GG[3:4,3],ARfullCond,AR2support,1)     #non standard distribution of AR given precession
dlmLL(y,mod)+sum(dnorm(u,sd=c(2,1)*0.33,log=TRUE)
gdpGibbs(gdp,a.theta=1,b.theta=1000,n.sample=2050,thin=1,save.states=TRUE) 
dlmModARMA: Auto Regressive moving average package of R
MSBVAR: package in R for Bayesian VAR models (Vector autoregressive models)
dlmForecast(expFilt,nAhead=12,sampleNew=10)
HWout = HoltWinter(lakeSup,gamma=0,beta=0)	#holt winter filter
mod=dlmModSeas(frequency=4,dv=3.5,dw=c(4,2,0,0)) #DLM rep of seasonal component
mod1=dlmModTrig(s=12,dV=5.1118,dW=0)+dlmPoly(1,dV=0,dW=81307e-3) #specific periodic component
smoothTem1 = dlmSmooth(nottem,mod1)
 



Keywords
Sampler: Gibbs, marginal, hybrid to infer unobserved state
Conditional independance
Forward filtering backward sampling
Markov Kernel: invariant distribution
Thinning
Larger uncertainty
Posterior
Mean var
Precision independent
Bayes: random vector and not fixed like MLE => joint posterior
Sequential Monte Carlo: 91) One step ahead prediction density (2) Filtering density
Evolution of precision
Kalman Filter : New data comes in frequently, estimate error correction (recursion)
Independent inverse wishart prior: multivariate extension
Block diagonal : additive composition
Student t’s advantage: 2 degree of freedom: heavy tailed distribution, simple representation of scale mixture of normal distribution => still FFBS work conditionally
Structural break model over multiplicative model error structure
Proposal density
Factor model: extract common stochastic trend from multiple integrated time series
Basic idea: explain fluctuations of various markets or common latent factors that affect a set of economics or financial variables simultaneously
Common factor of two time variable: common stochastic trend, for identification set coefficient of first one to 1
Resampling methods: (1) multinomial (equal weight) (2) residual resampling
Filtering Recursion, particle Filter, up to date, online inference, problem is analytics
MCMC does not lend itself easily to sequential usage
Updating process: 91) draw conditional component (2) update its weight (3) normalize
Importance density, transition density, markovian
Std is less precise unless we take more particles, while accurate approximation of filtering mean
Summary: we build distribution empirically
Performance of particle filter depends on specific of the important transition densities (Liu and West)
Advantage of auxiliary particle filter: allows use of one step prior distribution without loosing efficiency
Solution: MCMC on weekend, particle filter ourly basis
Interested in filtering mean and variance
Series stationary

Models
Fit=glm(satellites~weight,family=poisson(link=log),data=crabs)
Coeff(fit)
Summary(fit)
Glm.nb(stell~weight,link=log)
Lm(d~vc)
Glm(d~vc,family=poisson())
MCMC=list(R=iter,keep=slice)Sim1=runiregGibbs(dt1,Prior1,MCMC)
glm(y~x,family=binomial())
Library(mcmc)
Arima(lrtsm,order=c(0,1,11)) #order P,D,Q
Chisq.test(data)
Glm(snoring~scores,family=binomial(link=logit))
Glm(y~~weight,family=binomial(link=probit),datacrabs)
Vgam(y~s9weight),family=binomialff(link=logit),data=crabs) #generalized additive
Vglm((formula=cbind(y2,y3,y4,y5,y1) ~size+factor(lake),family=multinomial,data=alligators)
Library(tree)
Fit=rpart(y~color+width,method=”class”)
Distance=dist(x,method”manhattan”)
Hclust(distances,”average”)
Postscript(file=”dendogram-election.ps”)
Plot(democlust,labels=states)
Graphics.off
Betabin(cbind(y,n-y)~group,random=~1,data=rats)
Kmeans(m3,k) # k=3 means 8 clusters 
Library(fpc)
Plotcluster(m3,kmeansResult$cluster)
Library(Rgraphviz) # use for cluster association matrix
Plot(myTdm, terms=findFreqTerms(myTdm,lowfreq=1)[1:20],corThreshold=0)
Library(ggplot2) # graphic package to draw plots
Qplot(names(termFrequency),termFrequency,geom=”bar”)+coord_flip() # draw horizontal bar plot)
Barplot(termFrequency,las=2) # draw vertical bar plot
Library(wordcloud)
wordFreq=sort(rowSums(m),decreasing=Ture)
greyLevels=gray((wordFreq+10)/(max(wordFreq)+10))
wordcloud(words=names(wordFreq),freq=WordFreq,min.freq=2,random.order=F,colors=grayLevels)
library(fpc) # clustering with partitioning around mediods
library(igraph)
gg=raph.adjacency(termMatrix,weighted=T,mode=”undirected”)
g=simplify(g)
V(g)$label = V(g)$name
V(g)$degree=degree(g)
Egam=(log(E(g)$weight)+.4)/max(log(E(g)$weight)+.4)
E(g)$color = rgb(.5,.5,0,egam)
Aov(x~y,data=datafile) # analysis of variance, also power.anova.test(…), and power.t.test(…)
t.test(x,g)
pairwise.t.test(x,g)


Save to Pdf
Pdf(‘BGOLSM.pdf’,width=11,height=8.5,pointsize=12,paper=’special’)

Slidify
library(slidify)
#setwd("~/sample/projects/")
author("Meisam Hejazi Nia")
slidify('index.Rmd')
library(knitr)
browseURL('index.html')
publish_github(user,repo)
#HTML5 Deck Frameworks: io2012, html5slides, deck.js, dzslide, landslides, Slidy
#YM widget [mathjax] $x^2$ # latex math formatting
# Another tool with the same capability: R presentation

Shiny
install.packages("shiny")
libray(shiny)
#ui.R
library(shiny)
shinyUI(pageWithSidebar(
headerPanel("Data science FTW!"),
sidebarPanel(
h3('Sidebar text')
),
mainPanel(
h3('Main Panel text')
)
))
# server.R
library(shiny)
shinyServer(
function(input, output) {
}
)
#ui.R
shinyUI(pageWithSidebar(
headerPanel("Illustrating markup"),
sidebarPanel(
h1('Sidebar panel'),
h1('H1 text'),
h2('H2 Text'),
h3('H3 Text'),
h4('H4 Text')
),
mainPanel(
h3('Main Panel text'),
code('some code'),
p('some ordinary text')
)
))
#another sample of Ui.R
shinyUI(pageWithSidebar(
headerPanel("Illustrating inputs"),
sidebarPanel(
numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
checkboxGroupInput("id2", "Checkbox",
c("Value 1" = "1",
"Value 2" = "2",
"Value 3" = "3")),
dateInput("date", "Date:")
),
mainPanel(
)
))
#another Ui.R
mainPanel(
h3('Illustrating outputs'),
h4('You entered'),
verbatimTextOutput("oid1"),
h4('You entered'),
verbatimTextOutput("oid2"),
h4('You entered'),
verbatimTextOutput("odate")
)
#sample of server.R
shinyServer(
function(input, output) {
output$oid1 <- renderPrint({input$id1})
output$oid2 <- renderPrint({input$id2})
output$odate <- renderPrint({input$date})
}
)
#another UI example
shinyUI(
pageWithSidebar(
# Application title
headerPanel("Diabetes prediction"),
sidebarPanel(
numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
submitButton('Submit')
),
mainPanel(
h3('Results of prediction'),
h4('You entered'),
verbatimTextOutput("inputValue"),
h4('Which resulted in a prediction of '),
verbatimTextOutput("prediction")
)
)
)
#another sample of server
diabetesRisk <- function(glucose) glucose / 200
shinyServer(
function(input, output) {
output$inputValue <- renderPrint({input$glucose})
output$prediction <- renderPrint({diabetesRisk(input$glucose)})
}
)
#another sample of Ui.R
shinyUI(pageWithSidebar(
headerPanel("Example plot"),
sidebarPanel(
sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05,)
),
mainPanel(
plotOutput('newHist')
)
))
#another sample of Ui.R
library(UsingR)
data(galton)
shinyServer(
function(input, output) {
output$newHist <- renderPlot({
hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
mu <- input$mu
lines(c(mu, mu), c(0, 200),col="red",lwd=5)
mse <- mean((galton$child - mu)^2)
text(63, 150, paste("mu = ", mu))
text(63, 140, paste("MSE = ", round(mse, 2)))
})
}
)
#sample of Ui.R
shinyUI(pageWithSidebar(
headerPanel("Hello Shiny!"),
sidebarPanel(
textInput(inputId="text1", label = "Input Text1"),
textInput(inputId="text2", label = "Input Text2")
),
mainPanel(
p('Output text1'),
textOutput('text1'),
p('Output text2'),
textOutput('text2'),
p('Output text3'),
textOutput('text3'),
p('Outside text'),
textOutput('text4'),
p('Inside text, but non-reactive'),
textOutput('text5')
)
))
#sample of server.R
library(shiny)
x <<- x + 1
y <<- 0
shinyServer(
function(input, output) {
y <<- y + 1
output$text1 <- renderText({input$text1})
output$text2 <- renderText({input$text2})
output$text3 <- renderText({as.numeric(input$text1)+1})
output$text4 <- renderText(y)
output$text5 <- renderText(x)
}
)
#another sample of server.R
shinyServer(
function(input, output) {
x <- reactive({as.numeric(input$text1)+100})
output$text1 <- renderText({x() })
output$text2 <- renderText({x() + as.numeric(input$text2)})
}
)
#sample of Ui.R
shinyUI(pageWithSidebar(
headerPanel("Hello Shiny!"),
sidebarPanel(
textInput(inputId="text1", label = "Input Text1"),
textInput(inputId="text2", label = "Input Text2"),
actionButton("goButton", "Go!")
),
mainPanel(
p('Output text1'),
textOutput('text1'),
p('Output text2'),
textOutput('text2'),
p('Output text3'),
textOutput('text3')
)
))
#sample of server.R
shinyServer(
function(input, output) {
output$text1 <- renderText({input$text1})
output$text2 <- renderText({input$text2})
output$text3 <- renderText({
input$goButton
isolate(paste(input$text1, input$text2))
})
}
)

# if (input$goButton == 1){ Conditional statements }
output$text3 <- renderText({
if (input$goButton == 0) "You have not pressed the button"
else if (input$goButton == 1) "you pressed it once"
else "OK quit pressing it"
})

rCharts
require(rCharts)
haireye = as.data.frame(HairEyeColor)
n1 <- nplot(Freq ~Hair, group = ‘Eye’, type = ‘multiBarChart’, data = subset (haireye, Sex == ‘Male’))
n1$save(‘fig/n1.html’, cdn=TRUE)
cat(‘<iframe src=”fig/n1.html” width= 100%, height = 600)</frame>’)
#Slidify interactive yaml ex_widgets: {rCharts: [“libraries/nvd3”]}
Yaml ext_widgets: {rCharts: [“libraries/highcharts”,”libraries/nvd3”,”libraries/morris”]}
# Example 1 facetted scatterplot
Names(iris)= gsub(\\.,””,names(iris))
R1<- rPlot(Sepa1Length~ SepWidth | Species, data = iris, color = ‘Species’, type =’point’)
R1$save(‘fig/r1.html’, cdn=TRUE)
Cat(‘iframe src=”fig/r1.html” width=100%, height= 600></iframe>’)








Google Visualization
suppressPackageStartupMessages(library(googleVis))
## Warning: package 'googleVis' was built under R version 3.0.3
M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400))
print(M, "chart")
Motion charts: gvisMotionChart
Interactive maps: gvisGeoChart
Interactive tables: gvisTable
Line charts: gvisLineChart
Bar charts: gvisColumnChart
Tree maps: gvisTreeMap
G <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width =
height = 400))
print(G, "chart")
G2 <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width =
height = 400, region = "150"))
print(G2, "chart")
df <- data.frame(label=c("US", "GB", "BR"), val1=c(1,3,4), val2=c(23,12,32))
Line <- gvisLineChart(df, xvar="label", yvar=c("val1","val2"),
options=list(title="Hello World", legend="bottom",
titleTextStyle="{color:'red', fontSize:18}",
vAxis="{gridlines:{color:'red', count:3}}",
hAxis="{title:'My Label', titleTextStyle:{color:'blue'}}",

series="[{color:'green', targetAxisIndex: 0},
{color: 'blue',targetAxisIndex:1}]",
vAxes="[{title:'Value 1 (%)', format:'##,######%'},
{title:'Value 2 (\U00A3)'}]",
curveType="function", width=500, height=300
))
print(Line, "chart")
G <- gvisGeoChart(Exports, "Country", "Profit",options=list(width=200, height=100))
T1 <- gvisTable(Exports,options=list(width=200, height=270))
M <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(width=400, height=370))
GT <- gvisMerge(G,T1, horizontal=FALSE)
GTM <- gvisMerge(GT, M, horizontal=TRUE,tableOptions="bgcolor=\"#CCCCCC\" cellspacing=10")
print(GTM, "chart")
M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400))
print(M)

Manipulate
library(manipulate)
myHist <- function(mu){
hist(galton$child,col="blue",breaks=100)
lines(c(mu, mu), c(0, 150),col="red",lwd=5)
mse <- mean((galton$child - mu)^2)
text(63, 150, paste("mu = ", mu))
text(63, 140, paste("MSE = ", round(mse, 2)))
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))

RPackage
# new R project in R studio and select package
# 1. Modify the Description file
# for header above each function:
#’ Bulding a Model with …
#’ this function develops a prediction ….
#’ @param x a n x p matrix of n observations and p predictors …
#’ @return  a vector of coefficients for …..
#’ @author Meisam …
#’ This function runs a univariate …
#’ @seealso \code{lm}
#’ @export
#’ @importFrom stats lm
# then build the package (we can config the Build output as well)
# it documents in the Rd file our headers
# we can run Check to make sure that everything is alright
Key directives
Also important
export("<function>")
import("<package>")
importFrom("<package>", "<function>")
exportClasses("<class>")
exportMethods("<generic>")
export("mvtsplot")
importFrom(graphics, "Axis")
import(splines)
export("read.polyfile", "write.polyfile")
importFrom(graphics, plot)
exportClasses("gpc.poly", "gpc.poly.nohole")
exportMethods("show", "get.bbox", "plot", "intersect”, "union”, "setdiff", "[", "append.poly", "scale.poly", "area.poly", "get.pts", "coerce", "tristrip", "triangulate")
\name{line}
\alias{line}
\alias{residuals.tukeyline}
\title{Robust Line Fitting}
\description{ Fit a line robustly as recommended in \emph{Exploratory Data Analysis}.}
\usage{
line(x, y)
}
\arguments{
\item{x, y}{the arguments can be any way of specifying x-y pairs. See
\code{\link{xy.coords}}.}
}
\details{
Cases with missing values are omitted.
Long vectors are not supported.
}
\value{
An object of class \code{"tukeyline"}.
Methods are available for the generic functions \code{coef},
\code{residuals}, \code{fitted}, and \code{print}.
}
\references{
Tukey, J. W. (1977).
\emph{Exploratory Data Analysis},
Reading Massachusetts: Addison-Wesley.
}
system("R CMD build newpackage")
system("R CMD check newpackage")

Classes
library(methods)
setClass()
new() # to create new class
# class and methods
?Classes
?Methods
?setClass
?setMethod, 
?setGeneric
class(1)
## [1] "numeric"
class(TRUE)
## [1] "logical"
class(rnorm(100))
## [1] "numeric"
class(NA)
## [1] "logical"
class("foo")
## [1] "character"
x <- rnorm(100)
y <- x + rnorm(100)
fit <- lm(y ~ x) ## linear regression model
class(fit)
## [1] "lm"
mean
## function (x, ...)
## UseMethod("mean")
## <bytecode: 0x7facdb660ad0>
## <environment: namespace:base>
print
## function (x, ...)
## UseMethod("print")
## <bytecode: 0x7facd9ccfd58>
## <environment: namespace:base>
methods("mean")
## [1] mean.Date mean.default mean.difftime mean.POSIXct mean.POSIXlt
show
## standardGeneric for "show" defined from package "methods"
##
## function (object)
## standardGeneric("show")
## <bytecode: 0x7facdb8034d8>
## <environment: 0x7facdb779868>
## Methods may be defined for arguments: object
## Use showMethods("show") for currently available ones.
## (This generic function excludes non-simple inheritance; see ?setIs)
showMethods("show")
## Function: show (package methods)
## object="ANY"
## object="classGeneratorFunction"
## object="classRepresentation"
## object="envRefClass"
## object="function"
## (inherited from: object="ANY")
## object="genericFunction"
## object="genericFunctionWithTrace"
## object="MethodDefinition"
## object="MethodDefinitionWithTrace"
## object="MethodSelectionReport"
## object="MethodWithNext"
## object="MethodWithNextWithTrace"
## object="namedList"
## object="ObjectsWithPackage"
## object="oldClass"
## object="refClassRepresentation"
## object="refMethodDef"
## object="refObjectGenerator"
set.seed(2)
x <- rnorm(100)
mean(x)
## [1] -0.0307
head(getS3method("mean", "default"), 10)
##
## 1 function (x, trim = 0, na.rm = FALSE, ...)
## 2 {
## 3 if (!is.numeric(x) && !is.complex(x) && !is.logical(x)) {
## 4 warning("argument is not numeric or logical: returning NA")
## 5 return(NA_real_)
## 6 }
## 7 if (na.rm)
## 8 x <- x[!is.na(x)]
## 9 if (!is.numeric(trim) || length(trim) != 1L)
## 10 stop("'trim' must be numeric of length one")
tail(getS3method("mean", "default"), 10)
##
## 15 if (any(is.na(x)))
## 16 return(NA_real_)
## 17 if (trim >= 0.5)
## 18 return(stats::median(x, na.rm = FALSE))
## 19 lo <- floor(n * trim) + 1
## 20 hi <- n + 1 - lo
## 21 x <- sort.int(x, partial = unique(c(lo, hi)))[lo:hi]
## 22 }
## 23 .Internal(mean(x))
## 24 }
set.seed(3)
df <- data.frame(x = rnorm(100), y = 1:100)
sapply(df, mean)
## x y
## 0.01104 50.50000
set.seed(10)
x <- rnorm(100)
plot(x)
set.seed(10)
x <- rnorm(100)
x <- as.ts(x) ## Convert to a time series object
plot(x)
library(methods)
setClass("polygon", representation(x = "numeric",y = "numeric"))
setMethod("plot", "polygon",
function(x, y, ...) {
plot(x@x, x@y, type = "n", ...)
xp <- c(x@x, x@x[1])
yp <- c(x@y, x@y[1])
lines(xp, yp)
})
library(methods)
showMethods("plot")
## Function: plot (package graphics)
## x="ANY"
## x="polygon"
p <- new("polygon", x = c(1, 2, 3, 4), y = c(1, 2, 3, 1))
plot(p)
getS3method(<generic>, <class>)
getMethod(<generic>, <signature>)

yhat
#Create back end computing engine and then deploy on web so that others use it
Install.packages(“yhatr”)
Library(yhatr)
Model.require <- function(){ # loads R dependencies
}
Model.transform <- function(){ # transform data before feeding to model
}
Model.predict <- function(){ # is your prediction
}
# create an account on yhat
Yhat.config <- c(username = …, apikey = …., env=….)
Yhat.deploy(“ “)
Yhat.predict(“pollutant”,df)
Curl –X Post –H “content-type: application/json” –user meisam….@gmail.com:90d2…. –data ‘{“lon”:-76.61, ….}’ http://sandbox.yhathq.com/....
CLC: Ctrl+L
�
Tobit:
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
�
#First models (frequentist)
#Gausian OLS
GOLSfit<-lm(d ~vc)
summary(GOLSfit)
�
#poisson regression
Poisfit <- glm(d ~ vc, family=poisson())
summary(Poisfit)
�
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
�
�
#binary probit (i number of starst at specific level)
fit<-glm( stari~x, family=binomial(link=probit))
summary(fit)
�
#binary logit
fit<-glm(stari~x,family=binomial())
summary(fit)
#models (Bayesian)
�
dc<-cbind(1,dc)
#Gausian linear regression
�
#Tobit
�
#ordinary probit
�
#Binary probit
�
#binary Logit
�
library(survival)
example(tobin)
summary(tfit)
tfit.mcmc <- MCMCtobit(durable ~ age + quant, data=tobin, mcmc=30000,
verbose=1000)
plot(tfit.mcmc)
raftery.diag(tfit.mcmc)
summary(tfit.mcmc)
�
Logit:
n=1000;
k=4;
rn<-runif(n*(k-1), min=0, max=1);
x<-matrix(rn,k-1,n);
xint=rbind(rep(1,n),x); # alternative: cbind(1,cov)
beta=c(1,-1,2);
s2=1;
y=rep(0,n);
zt=rep(0,n);
xint=t(xint);
x=t(x);
for (i in 1:n){
 u=runif(1,min=0,max=1);
 ei=sqrt(s2)*log(u/(1-u));
 zti=xint %*% beta + ei;
 zt[i]=zti;
 if (zti>0) y[i]=1;
}
library(mcmc)
out<-glm(y~x,family=binomial())
summary(out);
# intrcpt= 2.98 x1=NA x2=-0.2241 x3=-0.5037
x<-cbind(1,x);
lupost<-function(beta,x,y){
eta <- x%*%beta
p<-1/(1+exp(-eta))
logl<-sum(log(p[y==1]))+sum(log(1-p[y==0]))
return(logl+sum(dnorm(beta,0,2,log=TRUE)))
}
set.seed(42)
beta.init <- as.numeric(coefficients(out))
out <- metrop(lupost, beta.init, 1000, x=x, y=y)
names(out)
out$accept
out <-metrop(out, scale=0.1, x=x,y=y);
out$accept
out <- metrop(out, scale = 0.3, x = x, y = y)
out$accept
out <- metrop(out, scale = 0.5, x = x, y = y)
out$accept
out <- metrop(out, scale = 0.4, x = x, y = y)
out$accept
out <- metrop(out, nbatch = 10000, x = x, y = y)
out$accept
out$time
plot(ts(out$batch))
acf(out$batch)
�
�
�
�
# library code
library(mcmc)
data(logit)
out<-glm(y~x1+x2+x3+x4,data=logit, family=binomial());
summary(out);
x<-logit;
x$y<-NULL;
x<-as.matrix(x);
x<-cbind(1,x);
dimnames(x)<-NULL;
y<-logit$y;
lupost<-function(beta,x,y){
eta <- x%*%beta
p<-1/(1+exp(-eta))
logl<-sum(log(p[y==1]))+sum(log(1-p[y==0]))
return(logl+sum(dnorm(beta,0,2,log=TRUE)))
}
set.seed(42)
beta.init <- as.numeric(coefficients(out))
out <- metrop(lupost, beta.init, 1000, x=x, y=y)
names(out)
out$accept
�
#clear workspace
rm(list = ls());
rm(list = ls()[grep("^tmp", ls())])
rm(list=ls(pattern="^tmp"))
rm(list = grep("^paper", ls(), value = TRUE, invert = TRUE))
�
Pasted from <http://stackoverflow.com/questions/11761992/remove-data-from-workspace> 
�
Statistical inference Homework:
retailSales<-read.csv("d:/HW12TS.csv",header=T) # read whole data
# from Jan 1955 to Dec 1975 as a time series object
rsts <- ts(retailSales, start=c(1955, 1), end=c(1977, 12), frequency=12) 
#excluding last two years
rtsm <- window(rsts, start=c(1955,1), end=c(1975,12))
#plot time series
plot(rsts)
plot.ts(rtsm)
#convert to additive
lrtsm <- log(rtsm)
plot.ts(lrtsm)
# Decomposition
library("TTR")
lrtsm6 <- SMA(lrtsm,n=6)
plot.ts(lrtsm6)
lrtsm12 <- SMA(lrtsm,n=12)
plot.ts(lrtsm12)
#Decomposition
lrtsmcomp<- decompose(lrtsm)
# Holt winter exponential smoothing
lrtsmforecast<- HoltWinters(lrtsm, beta=FALSE, gamma=FALSE)
lrtsmforecast$SSE
# forecast without data
library("forecast")
hwfwd <- forecast.HoltWinters(lrtsmforecast, h=24)
plot(hwfwd)
accuracy(hwfwd ) # predictive accuracy
#plot predicted value versus real value
rtsmf <- window(rsts, start=c(1976,1), end=c(1977,12))
rtsmfl<-log(rtsmf)
confl95<-hwfwd$lower[,2]
plot(confl95, type="l" , col=2)
par(new=T)
confu95<-hwfwd$upper[,2]
plot(confu95, type="l" , col=2)
par(new=T)
plot(rtsmfl,type="b",axes=F,col=3)
par(new=F)
#check correlogram 
acf(hwfwd$residuals, lag.max=20)
#Ljung-Box test 
Box.test(hwfwd$residuals, lag=20, type="Ljung-Box")
plot.ts(hwfwd$residuals)
#Check normality of residuals
plotForecastErrors <- function(forecasterrors)
  {
     # make a histogram of the forecast errors:
     mybinsize <- IQR(forecasterrors)/4
     mysd   <- sd(forecasterrors)
     mymin  <- min(forecasterrors) - mysd*5
     mymax  <- max(forecasterrors) + mysd*3
     # generate normally distributed data with mean 0 and standard deviation mysd
     mynorm <- rnorm(10000, mean=0, sd=mysd)
     mymin2 <- min(mynorm)
     mymax2 <- max(mynorm)
     if (mymin2 < mymin) { mymin <- mymin2 }
     if (mymax2 > mymax) { mymax <- mymax2 }
     # make a red histogram of the forecast errors, with the normally distributed data overlaid:
     mybins <- seq(mymin, mymax, mybinsize)
     hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
     # freq=FALSE ensures the area under the histogram = 1
     # generate normally distributed data with mean 0 and standard deviation mysd
     myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
     # plot the normal curve as a blue line on top of the histogram of forecast errors:
     points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
  }
plotForecastErrors(hwfwd$residuals)
qqnorm(hwfwd$residuals, ylab="Holt Winter Multiplicative", xlab="Normal Scores", main="Notmsl pp Holt Winter Multiplicative") 
qqline(hwfwd$residuals)
# ARIMA
lrtsm1 <- diff(lrtsm , differences=1)
plot.ts(lrtsm1)
lrtsm2 <- diff(lrtsm , differences=2)
plot.ts(lrtsm2)
# determine degree of ARIMA
acf(lrtsm1 , lag.max=20)    #11 
pacf(lrtsm1, lag.max=20) #19
# fit an ARIMA model of order P, D, Q
fit <- arima(lrtsm, order=c(0, 1, 11))
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
# Automated forecasting using an ARIMA model
fit <- auto.arima(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
�
# Automated forecasting using an exponential model
fit <- ets(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
spectrum(rsts)
�
Statistical Inference, Matrix:
crime<-read.csv("d:/eleventh.csv",header=T) # read whole data
cr=crime[,1] # crime rate
cov=crime[,2:14] # covariates
summary(cov)# check summary of data
cor(cov) #check the correlation
pairs(cov) # check plot of correlations
plot(cov[,1], cr, main="Age and crime rate", xlab="Age", ylab="Crime rate", pch=19)
plot(cov[,2], cr, main="Southern states and crime rate", xlab="Southern states", ylab="Crime rate", pch=19)
plot(cov[,3], cr, main="Schooling and crime rate", xlab="Schooling", ylab="Crime rate", pch=19)
plot(cov[,4], cr, main="1960 plice expenditure", xlab="1960 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,5], cr, main="1959 plice expenditure", xlab="1959 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,6], cr, main="Labor force participation", xlab="Labor force participation", ylab="Crime rate", pch=19)
plot(cov[,7], cr, main="Male/Female rate", xlab="male/female rate", ylab="Crime rate", pch=19)
plot(cov[,8], cr, main="State population", xlab="State population", ylab="Crime rate", pch=19)
plot(cov[,9], cr, main="Non white", xlab="non white", ylab="Crime rate", pch=19)
plot(cov[,10], cr, main="Unemployment rate 14-24", xlab="unemployment rate 14-24", ylab="Crime rate", pch=19)
plot(cov[,11], cr, main="Unemployment rate 25-35", xlab="unemployment rate 25-35", ylab="Crime rate", pch=19)
plot(cov[,12], cr, main="Transferable goods and assets", xlab="Transferable goods and assets", ylab="Crime rate", pch=19)
plot(cov[,13], cr, main="Below median income", xlab="Families Below median income", ylab="Crime rate", pch=19)
qqnorm(cr, ylab="Crime rate", xlab="Normal Scores", main="Normal probability plot of crime rate") 
qqline(cr)
names(cov)
crd = d=as.matrix(cr)
covd = d=as.matrix(cov)
cdata=cbind(cr,cov)
model1 = lm(cr~Age+S+Ed+Ex0+Ex1+LF+M+N+NW+U1+U2+W+X,data=cdata)
step(model1, direction="backward")
step(model1, direction="forward")
step(model1, direction="both",trace=TRUE)
par(mfrow=c(2,2))    # visualize four graphs at once
plot(model1)
par(mfrow=c(1,1))  # reset the graphics defaults
�
Summary Stat: Summer Project
# first row contains variable names
# we will read in workSheet mysheet
�
library(RODBC)
channel <- odbcConnectExcel("C:/Users/MHE/Desktop/ActiveCourses/Projects/Noris/Data/DailyOf100AddOn.xlsx")
mydata <- sqlFetch(channel, "CrossSec")
dwnldDTA<-sqlFetch(channel, "Summary")
odbcClose(channel)
cbind(summary(mydata))
names(mydata)
newdata <- mydata[c(0,5:23)]
summary(newdata[c(0,19)])
�
#other method to get summery statistics
library(Hmisc)
describe(mydata) 
�
#btter method to get summery
library(pastecs)
stat.desc(mydata) 
�
#the best way to use the summery (like SAS)
library(psych)
describe(mydata)
describe(dwnldDTA)
�
cbind(table(newdata[c(0,10)]))
summary(dwnldDTA[c(0,11)])
library(MASS)                 # load the MASS package 
cbind(table(mydata$"2nd Category"))  # apply the table functionc
�
Summary Stat: Summer Project
mydata = read.csv("D:/FirFxPrl/sampletest.csv") 
library("TTR")
Downloads= log(EMA(mydata[2], 7));
St_AVG= EMA(mydata[16], 7);
St_Cnt= EMA(mydata[17], 7);
St_STD= EMA(mydata[18], 7);
Usage= log(EMA(mydata[9], 7));
English.Share= EMA(mydata[15], 7);
model1=lm(Downloads~St_AVG+St_Cnt+St_STD+Usage+English.Share)
summary(model1)
�
�
st=as.data.frame(mydata)
str(st)
cor(st)
pairs(st)
model1=lm(log(Downloads)~St_AVG+St_Cnt+St_STD+log(Usage)+English.Share,data=st)
summary(model1)
�
MCMC part of code of Bayesian BLP:
# ------------ (1) Gibbs Sampler for thetabar and taosq -------------------output=runiregG(y=mu,X=X,XpX=XpX,Xpy=crossprod(X,mu),sigmasq=taosq,
A=Athetabar,betabar=thetabar0,nu=nu0,ssq=s0sq) thetabar=output$betadraw
taosq=output$sigmasqdraw
# ------------ (2) Metropolis for r ---------------------------------------#
Random-Walk Chain
rN=r+mvrnorm(1,rep(0,(K*(K+1)/2)),varn
_r)_
ON=Loglhd(rN,mu,thetabar,taosq)
prior_old=sum(-r[1:K]^2/2/sigmasqR_DIAG)+sum(-r[(K+1):(K*(K+1)/2)]^2/2/sigmasqR_off)
prior_new=sum(-rN[1:K]^2/2/sigmasqR_DIAG)+sum(-rN[(K+1):(K*(K+1)/2)]^2/2/sigmasqR_off)
15
# Evaluate old r (mu) at new (thetabar,taosq)
eta=mu-X%*%thetabar
llhd_old=sum(log(dnorm(eta,sd=sqrt(taosq))))+OO$sumlogjacob
ratio=exp(ON$llhd+prior_new-llhd_old-prior_old)
alphaS=min(1,ratio) # S stands for Sigma
if (runif(1)<=alphaS) {
r=rN; OO=ON; ns=ns+1; mu=OO$mu
r=rN; OO=ON; ns=ns+1; mu=OO$mu 
}
�
Brute-Force log-likelihood code of Bayesian BLP:
# Purpose: Evaluate log likelihood. Sigma is reparameterized as r.
Loglhd slow = function(thetabar,r,taosq,mu){
# (1). Transform r to L, where Sigma=LL'
L=diag(exp(r[1:K]))
L[lower tri(L)]=r[(K+1):(K*(K+1)/2)]L[lower.tri(L)]=r[(K+1):(K (K+1)/2)]
# (2). At given L, do inversion to get mu. Then compute eta
temp=invert_slow(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH)
mu  = temp$mu; prob = temp$prob; niter = temp$niter
eta=mu-X%*%thetabar
�
eta=mu-X%*%thetabar
�
# (3). Jacobian
# Form J diagonal elements at each time t
diagonal=rowMeans(prob*(1-prob)) # TJ by 1 vector
# Form the off diagonal elements
dd=-prob%*%t(prob)/H # TJ by TJ
cc=aaa*dd+diag(diagonal)#TJ by TJ matrix: block diagonal 
for (t in 1:T){
�
for (t in 1:T){
cct=cc[((t-1)*J+1):(t*J),((t-1)*J+1):(t*J)] #(t)th block of cc
logjacob[t]=-log(abs(det(cct)))
 }
# (4). Form Log Likelihood
lj b (lj b)
�
sumlogjacob=sum(logjacob)
llhd=sum(log(dnorm(eta,sd=sqrt(taosq))))+sumlogjacob
list(llhd=llhd,mu=mu,niter=niter,sumlogjacob=sumlogjacob)
}
�
Slow inversion code  of Bayesian BLP
invert_slow =
function(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH){
# Purpose: Invert observed shares S at give L to get mean utility mu's.
niter=0 # number of iterations taken for the inversion
munew=mu # starting value
muold=munew/2
upart=X%*%L%*%v
hil ( (b(( ld )/ ))> it){
while (max(abs((muold-munew)/munew))>crit){
muold=munew
num=exp(upart+ muold) # JT by H numerator
den1=matrix(double(T*H),nrow=T)
for (t in 1:T){
den1[t,]=1+colSums(num[((t-1)*J+1):(t*J),]) #T by H
}
den=matrix(rep(den1,each=J),ncol=H) #replc each t J times,JT by H
prob=num/den # JT by H
sh=t(matrix(rowMeans(prob), nrow=J)) # T by J predicted share
munew=t(matrix(muold,nrow=J))+log(S)-log(sh) # T by J
munew=as.vector(t(munew)) # length JT vector
niter=niter+1
}
List(mu=munew,prob=prob,niter=niter)
}
�
Add new row to the object res each time it finds a row that has no NA
funAgg = function(x) {
# initialize res 
 res = NULL
 n = nrow(x)
for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
 }
 res
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Initialize res object to the correct size, replace the rwos one at a time as a row in the nput with no Nas is found
funLoop = function(x) {
# Initialize res with x
 res = x
 n = nrow(x)
 k = 1
for (i in 1:n) {
    if (!any(is.na(x[i,]))) {
       res[k, ] = x[i,]
       k = k + 1
    }
 }
 res[1:(k-1), ]
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Is.na function that returns a logical when given a data frame of data
funApply = function(x) {
 drop = apply(is.na(x), 1, any)
 x[!drop, ]
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Profiling:
funOmit = function(x) {
# The or operation is very fast, it is replacing the any function
# Also note that it doesn't require having another data frame as big as x
drop = F
 n = ncol(x)
 for (i in 1:n)
   drop = drop | is.na(x[, i])
 x[!drop, ]
}
#Make up large test case
 xx = matrix(rnorm(2000000),100000,20)
 xx[xx>2] = NA
 x = as.data.frame(xx)
# Call the R code profiler and give it an output file to hold results
  Rprof("exampleAgg.out")
# Call the function to be profiled
  y = funAgg(xx)
  Rprof(NULL)
Rprof("exampleLoop.out")
  y = funLoop(xx)
  Rprof(NULL)
Rprof("exampleApply.out")
  y = funApply(xx)
  Rprof(NULL)
Rprof("exampleOmit.out")
  y = funOmit(xx)
  Rprof(NULL)
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Vectorized invert: faster for BLP Bayesian
invert =invert
function(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH){
# Purpose: Invert observed shares S at give L to get mean utility mu's.
19
niter=0 # number of iterations taken
munew=mu # starting value
muold=munew/2
upart=X%*%L%*%v
while (max(abs((muold-munew)/munew))>crit){
muold=munew
num=exp(upart+ muold)  # num is JT x H
dim(num)=NULL       # convert num to JTH vector
nmnm[indTHJ] # con ert n m to THJ ectornum=num[indTHJ]     # convert num to THJ vector
dim(num)=c(T*H,J)   # convert num to TH * J matrix
den=1+rowSums(num) # TH vector
prob=num/den # TH * J matrix
dim(prob)=NULL      # convert prob to THJ vector
prob=prob[indJTH]   # convert prob to JTH vector
dim(prob)=c(J*T,H)  # convert prob to JT * H matrix
sh=rowMeans(prob)   # JT vector
munew=muold+lnactS-log(sh)# JT vector
niter=niter+1
}
niter=niter+1
list(mu=munew,prob=prob,niter=niter)
}
No loop!
Matrix divided 
by a vector
�
Global variable inside the function:
a <- "old"
test <- function () {
   assign("a", "new", envir = .GlobalEnv)
}
test()
a  # display the new value
�
Pasted from <http://stackoverflow.com/questions/1236620/global-variables-in-r> 
�
�
a <<- "new" 
�
Pasted from <http://stackoverflow.com/questions/1236620/global-variables-in-r> 
�
Reindiexting Function BLP Bayesian:
JTH THJ=function(J H T){JTH_THJ=function(J,H,T){
#
# function to convert and index a vector ordered j by t by h (i.e. j
# varies faster than t than h) into a vector ordered t by h by j
#
ind=double(J*H*T)
cnt=1
for (j in 1:J){
for (h in 1:H) {
for (t in 1:T) {for (t in 1:T) {
ind[cnt]=(t-1)*J+(h-1)*(T*J)+j
cnt=cnt+1
�
}
}
}
return(ind)
�
}
indTHJ JTH_THJ(J,H,T) indJTH=THJ_JTH(J,H,T)
indTHJ=JTH THJ(J,H,T)
New Code:
for (t in 1:T){
cct=cc[((t 1)*J+1):(t*J) ((t 1)*J+1):(t*J)] #(t)th block of cccct=cc[((t-1)*J+1):(t*J),((t-1)*J+1):(t*J)] #(t)th block of cc
logjacob[t]=-2*sum(log(diag(chol(cct))))
# old code:
# logjacob[t]=-log(abs(det(cct)))
}
�
Creating Matrix in R:
seq1 <- seq(1:6)
mat1 <- matrix(seq1, 2)
mat1
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    2    4    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#filling the matrix by rows
mat2 <- matrix(seq1, 2, byrow = T)
mat2
     [,1] [,2] [,3] 
[1,]    1    2    3
[2,]    4    5    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
# Number of columns without specifying rows
mat3 <- matrix(seq1, ncol = 2)
mat3
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#creating the same matrix using both dimension arguments
#by using them in order we do not have to name them
mat4 <- matrix(seq1, 3, 2)
mat4
     [,1] [,2] 
[1,]    1    4
[2,]    2    5
[3,]    3    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#creating a matrix of 20 numbers from a standard normal dist.
mat5 <- matrix(rnorm(20), 4)
mat5
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#appending v1 to mat5
v1 <- c(1, 1, 2, 2)
mat6 <- cbind(mat5, v1)
mat6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
v2 <- c(1:6)
mat7 <- rbind(mat6, v2)
mat7
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#determining the dimensions of a mat7
dim(mat7)
[1] 5 6
#removing names of rows and columns
#the first NULL refers to all row names, the second to all column names 
dimnames(mat7) <- list(NULL, NULL)
mat7
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Access element of a matrix:
matrix_name[row#, col#]
mat7[1, 6]
[1] 1
#to access an entire row leave the column number blank
mat7[1,  ]
[1] -0.1920780  0.0910308 -1.1044547 -1.1513583  1.3435247  1.0000000
#to access an entire column leave the row number blank
mat7[, 6]
[1] 1 1 2 2 6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#Creating mat8 and mat9
mat8 <- matrix(1:6, 2)
mat8
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    2    4    6
mat9 <- matrix(c(rep(1, 3), rep(2, 3)), 2, byrow = T)
mat9
     [,1] [,2] [,3] 
[1,]    1    1    1
[2,]    2    2    2
#addition
mat9 + mat8
     [,1] [,2] [,3] 
[1,]    2    4    6
[2,]    4    6    8
mat9 + 3
     [,1] [,2] [,3] 
[1,]    4    4    4
[2,]    5    5    5
#subtraction
mat8 - mat9
     [,1] [,2] [,3] 
[1,]    0    2    4
[2,]    0    2    4
#inverse
solve(mat8[, 2:3])
     [,1] [,2] 
[1,]   -3  2.5
[2,]    2 -1.5
#transpose
t(mat9)
     [,1] [,2] 
[1,]    1    2
[2,]    1    2
[3,]    1    2
#multiplication
#we transpose mat8 since the dimension of the matrices have to match
#dim(2, 3) times dim(3, 2)
mat8 %*% t(mat9)
     [,1] [,2] 
[1,]    9   18
[2,]   12   24
#element-wise multiplication
mat8 * mat9
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    4    8   12
mat8 * 4
     [,1] [,2] [,3] 
[1,]    4   12   20
[2,]    8   16   24
#division
mat8/mat9
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    1    2    3
mat9/2
     [,1] [,2] [,3] 
[1,]  0.5  0.5  0.5
[2,]  1.0  1.0  1.0
#using submatrices from the same matrix in computations
mat8[, 1:2]
     [,1] [,2] 
[1,]    1    3
[2,]    2    4
mat8[, 2:3]
     [,1] [,2] 
[1,]    3    5
[2,]    4    6
mat8[, 1:2]/mat8[, 2:3]
          [,1]      [,2] 
[1,] 0.3333333 0.6000000
[2,] 0.5000000 0.6666667
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Regression:
y <- matrix(hsb2$write, ncol = 1)
y[1:10, 1]
 [1] 52 59 33 44 52 52 59 46 57 55
x <- as.matrix(cbind(1, hsb2$math, hsb2$science, hsb2$socst, hsb2$female))
x[1:10,  ]
      [,1] [,2] [,3] [,4] [,5] 
 [1,]    1   41   47   57    0
 [2,]    1   53   63   61    1
 [3,]    1   54   58   31    0
 [4,]    1   47   53   56    0
 [5,]    1   57   53   61    0
 [6,]    1   51   63   61    0
 [7,]    1   42   53   61    0
 [8,]    1   45   39   36    0
 [9,]    1   54   58   51    0
[10,]    1   52   50   51    0
n <- nrow(x)
p <- ncol(x)
#parameter estimates
beta.hat <- solve(t(x) %*% x) %*% t(x) %*% y
beta.hat
          [,1] 
[1,] 6.5689235
[2,] 0.2801611
[3,] 0.2786543
[4,] 0.2681117
[5,] 5.4282152
#predicted values
y.hat <- x %*% beta.hat
y.hat[1:5, 1]
[1] 46.43465 60.75571 46.17103 49.51943 53.66160
y[1:5, 1]
[1] 52 59 33 44 52
#the variance, residual standard error and df's
sigma2 <- sum((y - y.hat)^2)/(n - p)
#residual standard error
sqrt(sigma2)
[1] 6.101191
#degrees of freedom
n - p
[1] 195
#the standard errors, t-values and p-values for estimates
#variance/covariance matrix
v <- solve(t(x) %*% x) * sigma2
#standard errors of the parameter estimates
sqrt(diag(v))
[1] 2.81907949 0.06393076 0.05804522 0.04919499 0.88088532
#t-values for the t-tests of the parameter estimates
t.values <- beta.hat/sqrt(diag(v))
t.values
         [,1] 
[1,] 2.330166
[2,] 4.382257
[3,] 4.800642
[4,] 5.449980
[5,] 6.162227
#p-values for the t-tests of the parameter estimates
2 * (1 - pt(abs(t.values), n - p))
[1] 2.082029e-002 1.917191e-005 3.142297e-006 1.510015e-007 4.033511e-009
#checking that we got the correct results
ex1 <- lm(write ~ math + science + socst + female, hsb2)
summary(ex1)
Call: lm(formula = write ~ math + science + socst + female, data = hsb2)
Coefficients:
             Value Std. Error t value Pr(>|t|) 
(Intercept) 6.5689 2.8191     2.3302  0.0208  
       math 0.2802 0.0639     4.3823  0.0000  
    science 0.2787 0.0580     4.8006  0.0000  
      socst 0.2681 0.0492     5.4500  0.0000  
     female 5.4282 0.8809     6.1622  0.0000  
Residual standard error: 6.101 on 195 degrees of freedom
Multiple R-Squared: 0.594 
F-statistic: 71.32 on 4 and 195 degrees of freedom, the p-value is 0 
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Single Dimension of a Matrix:
# simple versions of nrow and ncol could be defined as follows
nrow0 <- function(x) dim(x)[1]
ncol0 <- function(x) dim(x)[2]
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/dim.html> 
�
Vector of zeros or single value:
list(rep(0, 50))
�
Pasted from <http://stackoverflow.com/questions/4072388/how-do-you-create-a-list-with-a-single-value-in-r> 
as.list(rep(0, 50))
�
Pasted from <http://stackoverflow.com/questions/4072388/how-do-you-create-a-list-with-a-single-value-in-r> 
�
Display a variable with its name:
names(mydata)[3] <- "This is the label for variable 3"
mydata[3] # list the variable
�
library(Hmisc)
label(mydata$myvar) <- "Variable label for variable�myvar"�
describe(mydata)
�
Pasted from <http://www.statmethods.net/input/variablelables.html> 
�
�
Pasted from <http://www.statmethods.net/input/variablelables.html> 
�
Input and Display:
#read files with labels in first row
read.table(filename,header=TRUE)           #read a tab or space delimited file
read.table(filename,header=TRUE,sep=',')   #read csv files
x=c(1,2,4,8,16 )                           #create a data vector with specified elements
y=c(1:10)                                  #create a data vector with elements 1-10
n=10
x1=c(rnorm(n))                             #create a n item vector of random normal deviates
y1=c(runif(n))+n                           #create another n item vector that has n added to each random uniform distribution
z=rbinom(n,size,prob)                      #create n samples of size "size" with probability prob from the binomial
vect=c(x,y)                                #combine them into one vector of length 2n
mat=cbind(x,y)                             #combine them into a n x 2 matrix
mat[4,2]                                   #display the 4th row and the 2nd column
mat[3,]                                    #display the 3rd row
mat[,2]                                    #display the 2nd column
subset(dataset,logical)                    #those objects meeting a logical criterion
subset(data.df,select=variables,logical)   #get those objects from a data frame that meet a criterion
data.df[data.df=logical]                   #yet another way to get a subset
x[order(x$B),]                             #sort a dataframe by the order of the elements in B
x[rev(order(x$B)),]                        #sort the dataframe in reverse order 
browse.workspace                           #a menu command that creates a window with information about all variables in the workspace
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Moving Around in the workspace:
ls()                                      #list the variables in the workspace
rm(x)                                     #remove x from the workspace
rm(list=ls())                             #remove all the variables from the workspace
attach(mat)                               #make the names of the variables in the matrix or data frame available in the workspace
detach(mat)                               #releases the names
new=old[,-n]                              #drop the nth column
new=old[n,]                               #drop the nth row
new=subset(old,logical)                   #select those cases that meet the logical condition
complete = subset(data.df,complete.cases(data.df)) #find those cases with no missing values
new=old[n1:n2,n3:n4]                      #select the n1 through n2 rows of variables n3 through n4)
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Data Manipulation
replace(x, list, values)                 #remember to assign this to some object i.e., x <- replace(x,x==-9,NA) 
                                         #similar to the operation x[x==-9] <- NA
cut(x, breaks, labels = NULL,
    include.lowest = FALSE, right = TRUE, dig.lab = 3, ...)
x.df=data.frame(x1,x2,x3 ...)             #combine different kinds of data into a data frame
��������as.data.frame()
��������is.data.frame()
x=as.matrix()
scale()                                   #converts a data frame to standardized scores
round(x,n)                                #rounds the values of x to n decimal places
ceiling(x)                                #vector x of smallest integers > x
floor(x)                                  #vector x of largest interger < x
as.integer(x)                             #truncates real x to integers (compare to round(x,0)
as.integer(x < cutpoint)                  #vector x of 0 if less than cutpoint, 1 if greater than cutpoint)
factor(ifelse(a < cutpoint, "Neg", "Pos"))  #is another way to dichotomize and to make a factor for analysis 
transform(data.df,variable names = some operation) #can be part of a set up for a data set 
x%in%y                     #tests each element of x for membership in y
y%in%x                     #tests each element of y for membership in x
all(x%in%y)                #true if x is a proper subset of y
all(x)                     # for a vector of logical values, are they all true?
any(x)                     #for a vector of logical values, is at least one true?
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Distributions:
beta(a, b)
gamma(x)
choose(n, k)
factorial(x)
dnorm(x, mean=0, sd=1, log = FALSE)      #normal distribution
pnorm(q, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean=0, sd=1)
dunif(x, min=0, max=1, log = FALSE)      #uniform distribution
punif(q, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
qunif(p, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
runif(n, min=0, max=1)
rnorm(n,mean,sd)
rbinom(n,size,p)
sample(x, size, replace = FALSE, prob = NULL)      #samples with or without replacement
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
�
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Statistics and Transformations:
max()
min()
mean()
median()
sum()
var()     #produces the variance covariance matrix
sd()      #standard deviation
mad()    #(median absolute deviation)
fivenum() #Tukey fivenumbers min, lowerhinge, median, upper hinge, max
table()    #frequency counts of entries, ideally the entries are factors(although it works with integers or even reals)
scale(data,scale=T)   #centers around the mean and scales by the sd)
cumsum(x)     #cumulative sum, etc.
cumprod(x)
cummax(x)
cummin(x)
rev(x)      #reverse the order of values in x
 
cor(x,y,use="pair")   #correlation matrix for pairwise complete data, use="complete" for complete cases
 
aov(x~y,data=datafile)  #where x and y can be matrices
aov.ex1 = aov(DV~IV,data=data.ex1)  #do the analysis of variance or
aov.ex2 = aov(DV~IV1*IV21,data=data.ex2)         #do a two way analysis of variance
summary(aov.ex1)                                    #show the summary table
print(model.tables(aov.ex1,"means"),digits=3)       #report the means and the number of subjects/cell
boxplot(DV~IV,data=data.ex1)        #graphical summary appears in graphics window
lm(x~y,data=dataset)                      #basic linear model where x and y can be matrices  (see plot.lm for plotting options)
t.test(x,g)
pairwise.t.test(x,g)
power.anova.test(groups = NULL, n = NULL, between.var = NULL,
                 within.var = NULL, sig.level = 0.05, power = NULL)
power.t.test(n = NULL, delta = NULL, sd = 1, sig.level = 0.05,
             power = NULL, type = c("two.sample", "one.sample", "paired"),
             alternative = c("two.sided", "one.sided"),strict = FALSE)
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Regression and Linear Models:
matrices
lm(Y~X1+X2)
lm(Y~X|W)                              
solve(A,B)                               #inverse of A * B   - used for linear regression
solve(A)                                 #inverse of A
factanal()
princomp()
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Rowsum and columnsum and min and max:
colSums (x, na.rm = FALSE, dims = 1)
     rowSums (x, na.rm = FALSE, dims = 1)
     colMeans(x, na.rm = FALSE, dims = 1)
     rowMeans(x, na.rm = FALSE, dims = 1)
     rowsum(x, group, reorder = TRUE, ...)         #finds row sums for each level of a grouping variable
     apply(X, MARGIN, FUN, ...)                    #applies the function (FUN) to either rows (1) or columns (2) on object X
     ��������apply(x,1,min)                             #finds the minimum for each row
    ��������apply(x,2,max)                            #finds the maximum for each column
    col.max(x)                                   #another way to find which column has the maximum value for each row 
    which.min(x)
    which.max(x)
    ��������z=apply(big5r,1,which.min)               #tells the row with the minimum value for every column
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Working with Dates:
date <-strptime(as.character(date), "%m/%d/%y")   #change the date field to a internal form for time  
                                                  #see ?formats and ?POSIXlt  
 as.Date
 month= months(date)                #see also weekdays, Julian
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Graphics:
par(mfrow=c(nrow,mcol))                        #number of rows and columns to graph
par(ask=TRUE)                             #ask for user input before drawing a new graph
par(omi=c(0,0,1,0) )                      #set the size of the outer margins 
mtext("some global title",3,outer=TRUE,line=1,cex=1.5)    #note that we seem to need to add the global title last
                     #cex = character expansion factor 
boxplot(x,main="title")                  #boxplot (box and whiskers)
title( "some title")                          #add a title to the first graph
��������
hist()                                   #histogram
plot()
��������plot(x,y,xlim=range(-1,1),ylim=range(-1,1),main=title)
��������par(mfrow=c(1,1))     #change the graph window back to one figure
��������symb=c(19,25,3,23)
��������colors=c("black","red","green","blue")
��������charact=c("S","T","N","H")
��������plot(PA,NAF,pch=symb[group],col=colors[group],bg=colors[condit],cex=1.5,main="Postive vs. Negative Affect by Film condition")
��������points(mPA,mNA,pch=symb[condit],cex=4.5,col=colors[condit],bg=colors[condit])
��������
curve()
abline(a,b)
�������� abline(a, b, untf = FALSE, ...)
     abline(h=, untf = FALSE, ...)
     abline(v=, untf = FALSE, ...)
     abline(coef=, untf = FALSE, ...)
     abline(reg=, untf = FALSE, ...)
identify()
��������plot(eatar,eanta,xlim=range(-1,1),ylim=range(-1,1),main=title)
��������identify(eatar,eanta,labels=labels(energysR[,1])  )       #dynamically puts names on the plots
locate()
legend()
pairs()                                  #SPLOM (scatter plot Matrix)
pairs.panels ()    #SPLOM on lower off diagonal, histograms on diagonal, correlations on diagonal
                   #not standard R, but uses a function found in useful.r 
matplot ()
biplot ())
plot(table(x))                           #plot the frequencies of levels in x
x= recordPlot()                           #save the current plot device output in the object x
replayPlot(x)                            #replot object x
dev.control                              #various control functions for printing/saving graphic files
pdf(height=6, width=6)              #create a pdf file for output
dev.of()                            #close the pdf file created with pdf 
layout(mat)                         #specify where multiple graphs go on the page
                                    #experiment with the magic code from Paul Murrell to do fancy graphic location
layout(rbind(c(1, 1, 2, 2, 3, 3),
             c(0, 4, 4, 5, 5, 0)))   
for (i in 1:5) {
  plot(i, type="n")
  text(1, i, paste("Plot", i), cex=4)
}
�
pie(rep(1,16),col=rainbow(16))
> z <- seq(-3,3,.1)
> d <- dnorm(z)
> plot(z,d,type="l")
> title("The Standard Normal Density",col.main="cornflowerblue")
�
�
Pasted from <http://data.princeton.edu/R/gettingStarted.html> 
�
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Display a string  with variable inside:
cat(sprintf("<set name=\"%s\" value=\"%f\" ></set>\n", df$timeStamp, df$Price))
�
Pasted from <http://stackoverflow.com/questions/3516008/how-to-print-r-variables-in-middle-of-string> 
�
> x <- 'say "Hello!"'
> x
[1] "say \"Hello!\""
> cat(x)
say "Hello!"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
�
x <- "say \"Hello!\""
R> cat(x)
say "Hello!"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
# default is to use "fancy quotes"
text <- c("check")
message(dQuote(text))
## �check�
# switch to straight quotes by setting an option
options(useFancyQuotes = FALSE)
message(dQuote(text))
## "check"
# assign result to create a vector of quoted character strings
text.quoted <- dQuote(text)
message(text.quoted)
## "check"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
�
Create a Diary or Log from Execution:
con <- file("test.log")
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")
# This will echo all input and not truncate 150+ character lines...
source("script.R", echo=TRUE, max.deparse.length=10000)
# Restore output to console
sink() 
sink(type="message")
# And look at the log...
cat(readLines("test.log"), sep="\n")
�
Pasted from <http://stackoverflow.com/questions/7096989/how-to-save-all-console-output-to-file-in-r> 
�
Write into file:
write.matrix(x, file = "", sep = " ", blocksize)
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/MASS/html/write.matrix.html> 
�
write(x, file = "data",
      ncolumns = if(is.character(x)) 1 else 5,
      append = FALSE, sep = " ")
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/write.html> 
�
# create a 2 by 5 matrix
x <- matrix(1:10, ncol = 5)
# the file data contains x, two rows, five cols
# 1 3 5 7 9 will form the first row
write(t(x))
# Writing to the "console" 'tab-delimited'
# two rows, five cols but the first row is 1 2 3 4 5
write(x, "", sep = "\t")
unlink("data") # tidy up
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/write.html> 
�
m <- matrix(1:12, 4 , 3)
write.table(m,file="outfile,txt",sep="\t", col.names = F, row.names = F)
�
Pasted from <http://stackoverflow.com/questions/10608526/writing-a-matrix-to-a-file-without-a-header-and-row-numbers> 
�
write.table(mtcars, file = "mtcars.txt", sep = " ")
�
Pasted from <http://stackoverflow.com/questions/6957499/how-do-i-print-a-matrix-in-r> 
�
write.table(m, file = "m.txt", sep = " ", row.names = FALSE, col.names = FALSE)
�
Pasted from <http://stackoverflow.com/questions/6957499/how-do-i-print-a-matrix-in-r> 
�
Save Matrix into CSV file:
 write.matrix(format(moDat2, scientific=FALSE), 
               file = paste(targetPath, "dat2.csv", sep="/"), sep=",")
�
Pasted from <http://stackoverflow.com/questions/13785303/save-matrix-to-csv-file-in-r-without-losing-format> 
�
mat <- matrix(1:10,ncol=2)
rownames(mat) <- letters[1:5]
colnames(mat) <- LETTERS[1:2]
mat
write.table(mat,file="test.txt") # keeps the rownames
read.table("test.txt",header=TRUE,row.names=1) # says first column are rownames
unlink("test.txt")
write.table(mat,file="test2.txt",row.names=FALSE) # drops the rownames
read.table("test.txt",header=TRUE) 
unlink("test2.txt")
�
Pasted from <http://stackoverflow.com/questions/6844166/export-matrix-in-r> 
�
Sparce Matrix:
library('Matrix')
�
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- Matrix(0, nrow = 1000, ncol = 1000, sparse = TRUE)
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5632 bytes
�
m1[500, 500] <- 1
m2[500, 500] <- 1
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5648 bytes
�
m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)
�
m3 <- cBind(m2, m2)
nrow(m3)
ncol(m3)
�
m4 <- rBind(m2, m2)
nrow(m4)
ncol(m4)
�
�
#sSecond Package Solution
library('slam')
�
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- simple_triplet_zero_matrix(nrow = 1000, ncol = 1000)
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 1032 bytes
�
# BUG HERE
m1[500, 500] <- 1
m2[500, 500] <- 1
�
object.size(m1)
object.size(m2)
�
m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)
�
�
#Third Method:
library('Matrix')
library('glmnet')
�
n <- 10000
p <- 500
�
x <- matrix(rnorm(n * p), n, p)
iz <- sample(1:(n * p),
             size = n * p * 0.85,
             replace = FALSE)
x[iz] <- 0
�
object.size(x)
�
sx <- Matrix(x, sparse = TRUE)
�
object.size(sx)
�
beta <- rnorm(p)
�
y <- x %*% beta + rnorm(n)
�
glmnet.fit <- glmnet(x, y)
�
#Fourth way that is more efficient
library('Matrix')
library('glmnet')
�
set.seed(1)
performance <- data.frame()
�
for (sim in 1:10)
{
  n <- 10000
  p <- 500
�
  nzc <- trunc(p / 10)
�
  x <- matrix(rnorm(n * p), n, p)
  iz <- sample(1:(n * p),
               size = n * p * 0.85,
               replace = FALSE)
  x[iz] <- 0
  sx <- Matrix(x, sparse = TRUE)
�
  beta <- rnorm(nzc)
  fx <- x[, seq(nzc)] %*% beta
�
  eps <- rnorm(n)
  y <- fx + eps
�
  sparse.times <- system.time(fit1 <- glmnet(sx, y))
  full.times <- system.time(fit2 <- glmnet(x, y))
  sparse.size <- as.numeric(object.size(sx))
  full.size <- as.numeric(object.size(x))
�
  performance <- rbind(performance, data.frame(Format = 'Sparse',
                                               UserTime = sparse.times[1],
                                               SystemTime = sparse.times[2],
                                               ElapsedTime = sparse.times[3],
                                               Size = sparse.size))
  performance <- rbind(performance, data.frame(Format = 'Full',
                                               UserTime = full.times[1],
                                               SystemTime = full.times[2],
                                               ElapsedTime = full.times[3],
                                               Size = full.size))
}
�
ggplot(performance, aes(x = Format, y = UserTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('User Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_user_time.pdf')
�
ggplot(performance, aes(x = Format, y = SystemTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('System Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_system_time.pdf')
�
ggplot(performance, aes(x = Format, y = ElapsedTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Elapsed Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_elapsed_time.pdf')
�
ggplot(performance, aes(x = Format, y = Size / 1000000, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Matrix Size in MB') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_memory.pdf')
�
Pasted from <http://www.johnmyleswhite.com/notebook/2011/10/31/using-sparse-matrices-in-r/> 
�
Optimization Function:
�
ans <- optimx(fn = function(x) sum(x*x), par = 1:2)
coef(ans)
## Not run:
proj <- function(x) x/sum(x)
f <- function(x) -prod(proj(x))
ans <- optimx(1:2, f)
ans
coef(ans) <- apply(coef(ans), 1, proj)
ans
## End(Not run)
�
http://cran.r-project.org/web/packages/optimx/optimx.pdf
�
Description
Minimise a function subject to linear inequality constraints using an adaptive barrier algorithm.
Usage
constrOptim(theta, f, grad, ui, ci, mu = 1e-04, control = list(),
            method = if(is.null(grad)) "Nelder-Mead" else "BFGS",
            outer.iterations = 100, outer.eps = 1e-05, ...,
            hessian = FALSE)
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/stats/html/constrOptim.html> 
�
�
�
fr <- function(x) {      x1 <- x[1]
    x2 <- x[2]
    -(log(x1) + x1^2/x2^2)  # need negative since constrOptim is a minimization routine
}
�
# define constraint
rbind(c(-1,-1),c(1,0), c(0,1) ) %*% c(0.99,0.001) -c(-1,0, 0)
�
constrOptim(c(0.99,0.001), fr, NULL, ui=rbind(c(-1,-1),  # the -x-y > -1
                                              c(1,0),    # the x > 0
                                              c(0,1) ),  # the y > 0
                                           ci=c(-1,0, 0)) # the thresholds
�
�
#definegradiant for correct result
grr <- function(x) { ## Gradient of 'fr'
    x1 <- x[1]
    x2 <- x[2]
    c(-(1/x[1] + 2 * x[1]/x[2]^2),
       2 * x[1]^2 /x[2]^3 )
}
�
constrOptim(c(0.99,0.001), fr, grr, ui=rbind(c(-1,-1),  # the -x-y > -1
                                               c(1,0),    # the x > 0
                                               c(0,1) ),  # the y > 0
                                            ci=c(-1,0, 0) )
$par
[1]  9.900007e-01 -3.542673e-16
$value
[1] -7.80924e+30
$counts
function gradient 
    2001       37 
$convergence
[1] 11
$message
[1] "Objective function increased at outer iteration 2"
$outer.iterations
[1] 2
$barrier.value
[1] NaN
�
#another solution with better constraint
onstrOptim(c(0.25,0.25), fr, NULL, 
              ui=rbind( c(-1,-1), c(1,0),   c(0,1) ),  
              ci=c(-1, 0.0001, 0.0001)) 
$par
�
Pasted from <http://stackoverflow.com/questions/5436630/constrained-optimization-in-r> 
�
Another Example:
## from optim
fr <- function(x) {   ## Rosenbrock Banana function
    x1 <- x[1]
    x2 <- x[2]
    100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}
grr <- function(x) { ## Gradient of 'fr'
    x1 <- x[1]
    x2 <- x[2]
    c(-400 * x1 * (x2 - x1 * x1) - 2 * (1 - x1),
       200 *      (x2 - x1 * x1))
}
optim(c(-1.2,1), fr, grr)
#Box-constraint, optimum on the boundary
constrOptim(c(-1.2,0.9), fr, grr, ui = rbind(c(-1,0), c(0,-1)), ci = c(-1,-1))
#  x <= 0.9,  y - x > 0.1
constrOptim(c(.5,0), fr, grr, ui = rbind(c(-1,0), c(1,-1)), ci = c(-0.9,0.1))
## Solves linear and quadratic programming problems
## but needs a feasible starting value
#
# from example(solve.QP) in 'quadprog'
# no derivative
fQP <- function(b) {-sum(c(0,5,0)*b)+0.5*sum(b*b)}
Amat       <- matrix(c(-4,-3,0,2,1,0,0,-2,1), 3, 3)
bvec       <- c(-8, 2, 0)
constrOptim(c(2,-1,-1), fQP, NULL, ui = t(Amat), ci = bvec)
# derivative
gQP <- function(b) {-c(0, 5, 0) + b}
constrOptim(c(2,-1,-1), fQP, gQP, ui = t(Amat), ci = bvec)
## Now with maximisation instead of minimisation
hQP <- function(b) {sum(c(0,5,0)*b)-0.5*sum(b*b)}
constrOptim(c(2,-1,-1), hQP, NULL, ui = t(Amat), ci = bvec,
            control = list(fnscale = -1))
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/stats/html/constrOptim.html> 
�
�
BBML package:
start=list(mu=1,sigma=1)  #starting values
mle.results<-mle2(norm.fit,start=list(mu=1,sigma=1),data=list(x))�#x is the name of the variable containing the data to be fitted
�
Pasted from <http://www.pmc.ucsc.edu/~mclapham/Rtips/likelihood.htm> 
�
Parallel Processing:
library(parallel)
vignette(parallel)
�
Pasted from <http://stackoverflow.com/questions/1395309/how-to-make-r-use-all-processors> 
�
�
�
Asample method for for loops:
library("parallel")
library("foreach")
library("doParallel")
cl <- makeCluster(detectCores() - 1)
registerDoParallel(cl, cores = detectCores() - 1)
data = foreach(i = 1:length(filenames), .packages = c("ncdf","chron","stats"),
               .combine = rbind) %dopar% {
  try({
       # your operations; line 1...
       # your operations; line 2...
       # your output
     })
}
�
Pasted from <http://stackoverflow.com/questions/1395309/how-to-make-r-use-all-processors> 
�
> library(doMC)
> registerDoMC(cores = 5)
>
> ## All subsequent models are then run in parallel
> model <- train(y ~ ., data = training, method = "rf")
�
> gbmGrid <- expand.grid(.interaction.depth = c(1, 5, 9), 
> .n.trees = (1:15)*100, 
> .shrinkage = 0.1) 
In reality,�train�only created objects for 3 models and der
�
Pasted from <http://caret.r-forge.r-project.org/parallel.html> 
�
�
To be read:
http://cran.r-project.org/web/views/HighPerformanceComputing.html
http://caret.r-forge.r-project.org/parallel.html
http://www.r-bloggers.com/parallel-processing-when-does-it-worth/
�
Maximum Likelihood example:
print(x)  #print vector
hist(x)  #histogram
dgamma(x, shape = alpha) #gamma distribution
dgamma(x, shape = alpha, log = TRUE) # log probability density rather than density
logl <- function(alpha, x)
    return(sum(dgamma(x, shape = alpha, log = TRUE))) #calculate sum of likelihoods
logl <- function(alpha, x)
    return(sum(dgamma(x, shape = alpha, log = TRUE))) #sum of likelihood
�
logl <- function(alpha, x) {
    if (length(alpha) > 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(sum(dgamma(x, shape = alpha, log = TRUE)))
} #improved function
�
#function for doing log likelihood plot
logl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
npoint <- 101
alphas <- seq(min(x), max(x), length = npoint)
logls <- double(npoint)
for (i in 1:npoint)
   logls[i] <- logl(alphas[i], x)
plot(alphas, logls, type = "l",
    xlab = expression(alpha), ylab = expression(l(alpha)))
�
#maximum likelihood: nlm, sample mean a good parameter estimator
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
out <- nlm(mlogl, mean(x), x = x)
print(out)
�
* hessian�returns the second derivative (an approximation calculated by finite differences) of the objective function. This will be a�k�נk�matrix if the dimension of the parameter space is�k.
* fscale�helps�nlm�know when it has converged to the solution. It should give roughly the size of the objective function at the solution. Often�fscale = length(x)�is about right.
* print.level�tells�nlm�to blather about what is is doing.�print.level = 2�gives maximum verbosity.
�
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
out <- nlm(mlogl, mean(x), x = x, hessian = TRUE,
    fscale = length(x), print.level = 2)
print(out)
�
#asymptotic confidence interval: Fisher information and confidence interval
conf.level <- 0.95
�
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
n <- length(x)
out <- nlm(mlogl, mean(x), x = x, hessian = TRUE,
    fscale = n)
alpha.hat <- out$estimate
z <- qnorm((1 + conf.level) / 2)
# confidence interval using expected Fisher information
alpha.hat + c(-1, 1) * z / sqrt(n * trigamma(alpha.hat))
# confidence interval using observed Fisher information
alpha.hat + c(-1, 1) * z / sqrt(out$hessian)
�
�
#several parameters
mlogl <- function(theta, x) {
    if (length(theta) != 2) stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda, log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
�
mlogl <- function(theta, x) {
    if (length(theta) != 2)
        stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda,
        log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
theta.start <- c(alpha.start, lambda.start)
�
out <- nlm(mlogl, theta.start, x = x, hessian = TRUE,
    fscale = length(x))
print(out)
print(theta.start)
eigen(out$hessian, symmetric = TRUE, only.values = TRUE)
# theoretical Fisher information
n <- length(x)
alpha.hat <- out$estimate[1]
lambda.hat <- out$estimate[2]
fish <- n * matrix(c(trigamma(alpha.hat), - 1 / lambda.hat,
     - 1 / lambda.hat, alpha.hat / lambda.hat^2), nrow = 2)
fish
�
conf.level <- 0.95
�
mlogl <- function(theta, x) {
    if (length(theta) != 2)
        stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda,
        log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
theta.start <- c(alpha.start, lambda.start)
�
out <- nlm(mlogl, theta.start, x = x, hessian = TRUE,
    fscale = length(x))
�
crit.val <- qnorm((1 + conf.level) / 2)
inv.fish.info <- solve(out$hessian)
for (i in 1:2)
    print(out$estimate[i] + c(-1, 1) * crit.val *
        sqrt(inv.fish.info[i, i]))
�
#example of A five-parameter Normal Mixture Example
�
length(x)
summary(x)
hist(x) 
�
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
�
#Maximum Likelihood
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
n <- length(x)
p.start <- 1 / 2
mu1.start <- mean(sort(x)[seq(along = x) <= n / 2])
mu2.start <- mean(sort(x)[seq(along = x) > n / 2])
v1.start <- var(sort(x)[seq(along = x) <= n / 2])
v2.start <- var(sort(x)[seq(along = x) > n / 2])
theta.start <- c(mu1.start, mu2.start, v1.start,
    v2.start, p.start)
�
out <- nlm(mlogl, theta.start, print.level = 2,
    fscale = length(x))
out <- nlm(mlogl, out$estimate, print.level = 2,
    fscale = length(x), hessian = TRUE)
print(out)
print(theta.start)
�
mu1.hat <- out$estimate[1]
mu2.hat <- out$estimate[2]
sigma1.hat <- sqrt(out$estimate[3])
sigma2.hat <- sqrt(out$estimate[4])
p.hat <- out$estimate[5]
fred <- function(x) p.hat * dnorm(x, mu1.hat, sigma1.hat) +
    (1 - p.hat) * dnorm(x, mu2.hat, sigma2.hat)
hist(x, freq = FALSE)
curve(fred, add = TRUE)
hist(x, freq = FALSE,
    ylim = range(0, fred(mu1.hat), fred(mu2.hat)))
curve(fred, add = TRUE)
curve(p.hat * dnorm(x, mu1.hat, sigma1.hat),
    add = TRUE, col = "red")
curve((1 - p.hat) * dnorm(x, mu2.hat, sigma2.hat),
    add = TRUE, col = "red")
eigen(out$hessian, symmetric = TRUE)
�
#Confidence Interval
conf.level <- 0.95
�
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
n <- length(x)
p.start <- 1 / 2
mu1.start <- mean(sort(x)[seq(along = x) <= n / 2])
mu2.start <- mean(sort(x)[seq(along = x) > n / 2])
v1.start <- var(sort(x)[seq(along = x) <= n / 2])
v2.start <- var(sort(x)[seq(along = x) > n / 2])
theta.start <- c(mu1.start, mu2.start, v1.start,
    v2.start, p.start)
�
out <- nlm(mlogl, theta.start, fscale = length(x))
out <- nlm(mlogl, out$estimate,
    fscale = length(x), hessian = TRUE)
�
crit.val <- qnorm((1 + conf.level) / 2)
inv.fish.info <- solve(out$hessian)
for (i in 1:length(out$estimate))
    print(out$estimate[i] + c(-1, 1) * crit.val *
        sqrt(inv.fish.info[i, i]))
�
�
Pasted from <http://www.stat.umn.edu/geyer/5102/examp/like.html> 
�
There are a number of general-purpose optimization routines in base R that I'm aware of:�optim,nlminb,�nlm�and�constrOptim�(which handles linear inequality constraints, and calls�optim�under the hood). Here are some things that you might want to consider in choosing which one to use.
* optim�can use a number of different algorithms including conjugate gradient, Newton, quasi-Newton, Nelder-Mead and simulated annealing. The last two don't need gradient information and so can be useful if gradients aren't available or not feasible to calculate (but are likely to be slower and require more parameter fine-tuning, respectively). It also has an option to return the computed Hessian at the solution, which you would need if you want standard errors along with the solution itself. 
which is probably the most-used optimizer, provides a few different optimization routines; for example, BFGS, L-BFGS-B, and simulated annealing (via the SANN option),�
the latter of which might be handy if you have a difficult optimizing problem.�
�
* nlminb�uses a quasi-Newton algorithm that fills the same niche as the�"L-BFGS-B"�method inoptim. In my experience it seems a bit more robust than�optim�in that it's more likely to return a solution in marginal cases where�optim�will fail to converge, although that's likely problem-dependent. It has the nice feature, if you provide an explicit gradient function, of doing a numerical check of its values at the solution. If these values don't match those obtained from numerical differencing,�nlminb�will give a warning; this helps to ensure you haven't made a mistake in specifying the gradient (easy to do with complicated likelihoods). 
Provides a way to constrain parameter values to particular bounding boxes
�
* nlm�only uses a Newton algorithm. This can be faster than other algorithms in the sense of needing fewer iterations to reach convergence, but has its own drawbacks. It's more sensitive to the shape of the likelihood, so if it's strongly non-quadratic, it may be slower or you may get convergence to a false solution. The Newton algorithm also uses the Hessian, and computing that can be slow enough in practice that it more than cancels out any theoretical speedup.
will work just fine if the likelihood surface isn't particularly "rough" and is everywhere differentiable
* rgenoud, for instance, provides a genetic algorithm for optimization. Genetic algorithms can be slow to converge, but are usually guaranteed to converge (in time) even when there are discontinuities in the likelihood. �is set up to use�snow�for parallel processing, which helps somewhat.
http://sekhon.berkeley.edu/rgenoud/
* DEoptim�uses a different genetic optimization routine
�
�
�
Pasted from <http://stats.stackexchange.com/questions/9535/when-should-i-not-use-rs-nlm-function-for-mle> 
�
�
Very importance Source:
http://cran.r-project.org/web/views/Optimization.html
�
* Optimplex:  Provides a building block for optimization algorithms
based on a simplex. The optimsimplex package may be used in the
following optimization methods: the simplex method of Spendley
et al., the method of Nelder and Mead, Box�s algorithm for
constrained optimization, the multi-dimensional search by Torczon, etc�
�
http://cran.r-project.org/web/packages/optimsimplex/optimsimplex.pdf
http://cran.r-project.org/web/packages/optimsimplex/index.html
�
Other Optimization nonlinear Algorithms:
http://cran.r-project.org/web/packages/nloptr/nloptr.pdf
http://cran.r-project.org/web/packages/alabama/alabama.pdf
�
NLM Example:
Examples
f <- function(x) sum((x-1:length(x))^2)
nlm(f, c(10,10))
nlm(f, c(10,10), print.level = 2)
utils::str(nlm(f, c(5), hessian = TRUE))
f <- function(x, a) sum((x-a)^2)
nlm(f, c(10,10), a = c(3,5))
f <- function(x, a)
{
    res <- sum((x-a)^2)
    attr(res, "gradient") <- 2*(x-a)
    res
}
nlm(f, c(10,10), a = c(3,5))
## more examples, including the use of derivatives.
## Not run: demo(nlm)
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/stats/html/nlm.html> 
�
Univar ate Binomial and multinomial inference:
> x <- c(12, 8, 10)
> p <- c(0.4, 0.3, 0.3)
> chisq.test(x, p=p)
Chi-squared test for given probabilities
data: x
X-squared = 0.2222, df = 2, p-value = 0.8948
> chisq.test(x, p=p, simulate.p.value=TRUE, B=10000)
Chi-squared test for given probabilities with
simulated p-value (based on 10000 replicates)
data: x
X-squared = 0.2222, df = NA, p-value = 0.8763
�
Bayesian Inference:
library("TeachingDemos")
y <- 0; n <- 25
a1 <- 3.6; a2 <- 41.4
a <- a1 + y; b <- a2 + n
h <- hpd(qbeta, shape1=a, shape2=b)
�
Two way continuity table:
> x<- c(9,8,27,8,47,236,23,39,88,49,179,706,28,48,89,19,104,293)
> data <- matrix(x, nrow=3,ncol=6, byrow=TRUE)
> dimnames(data) = list(Degree=c("< HS","HS","College"),Belief=c("1","2","3","4","5","6"))
> install.packages("vcdExtra")
> library("vcdExtra")
> StdResid <- c(-0.4,-2.2,-1.4,-1.5,-1.3,3.6,-2.5,-2.6,-3.3,1.8,0.0,3.4,3.1,4.7,4.8,-0.8,1.1,-6.7)
> StdResid <- matrix(StdResid,nrow=3,ncol=6,byrow=TRUE)
> mosaic(data,residuals = StdResid, gp=shading_Friendly)
�
Chi-Square and Fisher's exact test; Residuals:
> data <- matrix(c(9,8,27,8,47,236,23,39,88,49,179,706,28,48,89,19,104,293),
ncol=6,byrow=TRUE)
> chisq.test(data)
Pearson�s Chi-squared test
data: data
X-squared = 76.1483, df = 10, p-value = 2.843e-12
> chisq.test(data)$stdres
[,1] [,2] [,3] [,4] [,5] [,6]
[1,] -0.368577 -2.227511 -1.418621 -1.481383 -1.3349600 3.590075
[2,] -2.504627 -2.635335 -3.346628 1.832792 0.0169276 3.382637
[3,] 3.051857 4.724326 4.839597 -0.792912 1.0794638 -6.665195
�
> yes <- c(54,25)
> n <- c(10379,51815)
> x <- c(1,0)
> fit <- glm(yes/n ~ x, weights=n, family=binomial(link=logit))
> summary(fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -7.6361 0.2000 -38.17 <2e-16 ***
x 2.3827 0.2421 9.84 <2e-16 ***
>
confint(fit)
Waiting for profiling to be done...
2.5 % 97.5 %
(Intercept) -8.055554 -7.268025
x 1.919634 2.873473
> exp(1.919634); exp(2.873473)
[1] 6.818462
[1] 17.69838
�
> tea <- matrix(c(3,1,1,3),ncol=2,byrow=TRUE)
> fisher.test(tea)
> fisher.test(table, simulate.p.value=TRUE, B=10000)
�
�
Generalized Linear Models:
> snoring <- matrix(c(24,1355,35,603,21,192,30,224), ncol=2, byrow=TRUE)
> scores <- c(0,2,4,5)
> snoring.fit <- glm(snoring ~ scores, family=binomial(link=logit))
> summary(snoring.fit)
Call:
glm(formula = snoring ~ scores, family = binomial(link = logit))
Deviance Residuals:
1 2 3 4
-0.8346 1.2521 0.2758 -0.6845
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.86625 0.16621 -23.261 < 2e-16 ***
scores 0.39734 0.05001 7.945 1.94e-15 ***
--Signif.
codes: 0 1
(Dispersion parameter for binomial family taken to be 1)
Null deviance: 65.9045 on 3 degrees of freedom
Residual deviance: 2.8089 on 2 degrees of freedom
AIC: 27.061
Number of Fisher Scoring iterations: 4
> pearson <- summary.lm(snoring.fit)$residuals # Pearson residuals
> hat <- lm.influence(snoring.fit)$hat # hat or leverage values
> stand.resid <- pearson/sqrt(1 - hat) # standardized residuals
> cbind(scores, snoring, fitted(snoring.fit), pearson, stand.resid)
scores pearson stand.resid
1 0 24 1355 0.02050742 -0.8131634 -1.6783847
2 2 35 603 0.04429511 1.2968557 1.5448873
3 4 21 192 0.09305411 0.2781891 0.3225535
4 5 30 224 0.13243885 -0.6736948 -1.1970179
> fit <- glm(y ~ x, family=quasi(variance="mu(1-mu)"),start=c(0.5, 0))
> summary(fit, dispersion=1)
> crabs <- read.table("crab.dat",header=T)
> crabs
color spine width satellites weight
1 3 3 28.3 8 3050
2 4 3 22.5 0 1550
3 2 1 26.0 9 2300
4 4 3 24.8 0 2100
5 4 3 26.0 4 2600
6 3 3 23.8 0 2100
....
173 3 2 24.5 0 2000
> weight <- weight/1000 # weight in kilograms rather than grams
> fit <- glm(satellites ~ weight, family=poisson(link=log), data=crabs)
> summary(fit)
> library(MASS)
> fit.nb <- glm.nb(satell ~ weight, link=log)
> summary(fit.nb)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -0.8647 0.4048 -2.136 0.0327 *
weight2 0.7603 0.1578 4.817 1.45e-06 ***
---
Null deviance: 216.43 on 172 degrees of freedom
Residual deviance: 196.16 on 171 degrees of freedom
AIC: 754.64
Theta: 0.931
Std. Err.: 0.168
2 x log-likelihood: -748.644
> fit <- glm(... model formula, family, data, etc ...)
> rstandard(fit, type="pearson")
# This borrows heavily from Laura Thompson�s manual at
# https://home.comcast.net/~lthompson221/Splusdiscrete2.pdf
�
> rats <- read.table("teratology.dat", header = T)
> rats # Full data set of 58 litters at course website
litter group n y
1 1 1 10 1
2 2 1 11 4
3 3 1 12 9
57 57 4 6 0
58 58 4 17 0
> rats$group <- as.factor(rats$group)
> fit.bin <- glm(y/n ~ group - 1, weights = n, data=rats, family=binomial)
> summary(fit.bin)
Coefficients: # these are the sample logits
Estimate Std. Error z value Pr(>|z|)
group1 1.1440 0.1292 8.855 < 2e-16 ***
group2 -2.1785 0.3046 -7.153 8.51e-13 ***
group3 -3.3322 0.7196 -4.630 3.65e-06 ***
group4 -2.9857 0.4584 -6.514 7.33e-11 ***
---
Null deviance: 518.23 on 58 degrees of freedom
Residual deviance: 173.45 on 54 degrees of freedom
AIC: 252.92
> (pred <- unique(predict(fit.bin, type="response")))
[1] 0.75840979 0.10169492 0.03448276 0.04807692 # sample proportions
> (SE <- sqrt(pred*(1-pred)/tapply(rats$n,rats$group,sum)))
1 2 3 4
0.02367106 0.02782406 0.02395891 0.02097744 # SE�s of proportions
> (X2 <- sum(resid(fit.bin, type="pearson")^2)) # Pearson stat.
[1] 154.707
> phi <- X2/(58 - 4) # estimate of phi for QL analysis
> phi
[1] 2.864945
> SE*sqrt(phi)
1 2 3 4
0.04006599 0.04709542 0.04055320 0.03550674 # adjusted SE�s for proportions
> fit.ql <- glm(y/n ~ group - 1, weights=n, data=rats, family=quasi(link=identity,
variance="mu(1-mu)"),start=unique(predict(fit.bin,type="response")))
> summary(fit.ql) # This shows another way to get the QL results
Coefficients:
Estimate Std. Error t value Pr(>|t|)
group1 0.75841 0.04007 18.929 <2e-16 ***
group2 0.10169 0.04710 2.159 0.0353 *
group3 0.03448 0.04055 0.850 0.3989
group4 0.04808 0.03551 1.354 0.1814
--(Dispersion
parameter for quasi family taken to be 2.864945)
�
�
Logistic Regression
> crabs <- read.table("crabs.dat",header=TRUE)
> crabs
color spine width satellites weight
1 3 3 28.3 8 3050
2 4 3 22.5 0 1550
3 2 1 26.0 9 2300
....
173 3 2 24.5 0 2000
> y <- ifelse(crabs$satellites > 0, 1, 0) # y = a binary indicator of satellites
> crabs$weight <- crabs$weight/1000 # weight in kilograms rather than grams
> fit <- glm(y ~ weight, family=binomial(link=logit), data=crabs)
> summary(fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.6947 0.8802 -4.198 2.70e-05 ***
weight 1.8151 0.3767 4.819 1.45e-06 ***
---
Null Deviance: 225.7585 on 172 degrees of freedom
Residual Deviance: 195.7371 on 171 degrees of freedom
AIC: 199.74
> crabs$color <- crabs$color - 1 # color now takes values 1,2,3,4
> crabs$color <- factor(crabs$color) # treat color as a factor
> fit2 <- glm(y ~ weight + color, family=binomial(link=logit), data=crabs)
> summary(fit2)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.2572 1.1985 -2.718 0.00657 **
weight 1.6928 0.3888 4.354 1.34e-05 ***
color2 0.1448 0.7365 0.197 0.84410
color3 -0.1861 0.7750 -0.240 0.81019
color4 -1.2694 0.8488 -1.495 0.13479
---
(Dispersion Parameter for Binomial family taken to be 1 )
Null Deviance: 225.7585 on 172 degrees of freedom
Residual Deviance: 188.5423 on 168 degrees of freedom
AIC: 198.54
> yes <- c(24,35,21,30)
> n <- c(1379,638,213,254)
> scores <- c(0,2,4,5)
> fit <- glm(yes/n ~ scores, weights=n, family=binomial(link=logit))
> fit
Coefficients:
(Intercept) scores
-3.8662 0.3973
Degrees of Freedom: 3 Total (i.e. Null); 2 Residual
Null Deviance: 65.9
Residual Deviance: 2.809 AIC: 27.06
�
ROC curves:
> dose <- c(rep(1.691,59),rep(1.724,60),rep(1.755,62),rep(1.784,56),
+ rep(1.811,63),rep(1.837,59),rep(1.861,62),rep(1.884,60))
> y <- c(rep(1,6),rep(0,53),rep(1,13),rep(0,47),rep(1,18),rep(0,44),
+ rep(1,28),rep(0,28),rep(1,52),rep(0,11),rep(1,53),rep(0,6),
+ rep(1,61),rep(0,1),rep(1,60))
> fit.probit <- glm(y ~ dose, family=binomial(link=probit))
> summary(fit.probit)
Estimate Std. Error z value Pr(>|z|)
(Intercept) -34.956 2.649 -13.20 <2e-16
dose 19.741 1.488 13.27 <2e-16
---
> library("ROCR") # to construct ROC curve
> pred <- prediction(fitted(fit.probit),y)
> perf <- performance(pred, "tpr", "fpr")
> plot(perf)
> performance(pred,"auc")
Slot "y.values":
[[1]]
[1] 0.9010852 # area under ROC curve
�
Cochran-Mantel-Haenszel test:
> beitler <- c(11,10,25,27,16,22,4,10,14,7,5,12,2,1,14,16,6,0,11,12,1,0,10,10,1,1,4,8,4,6,2,1)
> beitler <- array(beitler, dim=c(2,2,8))
> mantelhaen.test(beitler, correct=FALSE)
Mantel-Haenszel chi-squared test without continuity correction
data: beitler
Mantel-Haenszel X-squared = 6.3841, df = 1, p-value = 0.01151
alternative hypothesis: true common odds ratio is not equal to 1
95 percent confidence interval:
1.177590 3.869174
sample estimates:
common odds ratio
2.134549
> mantelhaen.test(beitler, correct=FALSE, exact=TRUE)
�
Other Binary Response Models:
> fit.probit <- glm(y ~ weight, family=binomial(link=probit), data=crabs)
> summary(fit.probit)
Coefficients:
Value Std. Error t value
(Intercept) -2.238245 0.5114850 -4.375974
weight 1.099017 0.2150722 5.109989
Residual Deviance: 195.4621 on 171 degrees of freedom
> beetles <- read.table("beetle.dat", header=T)
> beetles
dose number killed
1 1.691 59 6
2 1.724 60 13
3 1.755 62 18
4 1.784 56 28
5 1.811 63 52
6 1.837 59 53
7 1.861 62 61
8 1.884 60 60
> binom.dat <- matrix(append(killed,number-killed),ncol=2)
> fit.cloglog <- glm(binom.dat ~ dose, family=binomial(link=cloglog),
data=beetles)
> summary(fit.cloglog) # much better fit than logit
Value Std. Error t value
(Intercept) -39.52250 3.232269 -12.22748
dose 22.01488 1.795086 12.26397
Null Deviance: 284.2024 on 7 degrees of freedom
Residual Deviance: 3.514334 on 6 degrees of freedom
> pearson.resid <- resid(fit.cloglog, type="pearson")
> std.resid <- pearson.resid/sqrt(1-lm.influence(fit.cloglog)$hat)
> cbind(dose, killed/number, fitted(fit.cloglog), pearson.resid, std.resid)
dose pearson.resid std.resid
1 1.691 0.1016949 0.09582195 0.1532583 0.1772659
2 1.724 0.2166667 0.18802653 0.5677671 0.6694966
3 1.755 0.2903226 0.33777217 -0.7899738 -0.9217717
4 1.784 0.5000000 0.54177644 -0.6274464 -0.7041154
5 1.811 0.8253968 0.75683967 1.2684541 1.4855799
6 1.837 0.8983051 0.91843509 -0.5649292 -0.7021989
7 1.861 0.9838710 0.98575181 -0.1249636 -0.1489834
8 1.884 1.0000000 0.99913561 0.2278334 0.2368981
> confint(fit.cloglog)
2.5 % 97.5 %
(Intercept) -46.13984 -33.49923
dose 18.66945 25.68877
�
Penalized Likelihood
�
> x <- c(12, 15, 42, 52, 59, 73, 82, 91, 96, 105, 114, 120, 121, 128, 130,
139, 139, 157, 1, 1, 2, 8, 11, 18, 22, 31, 37, 61, 72, 81, 97,
112, 118, 127, 131, 140, 151, 159, 177, 206)
> y <- c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0)
> k1 <- ksmooth(x,y,"normal",bandwidth=25)
> k2 <- ksmooth(x,y,"normal",bandwidth=100)
> plot(x,y)
> lines(k1)
> lines(k2, lty=2)
�
Generalized Additive Model:
> library(vgam)
> gam.fit <- vgam(y ~ s(weight), family=binomialff(link=logit), data=crabs)
> plot(weight, fitted(gam.fit))
�
Mutlinomial Response Models
> alligators <- read.table("alligators.dat",header=TRUE)
> alligators
lake gender size y1 y2 y3 y4 y5
1 1 1 1 7 1 0 0 5
2 1 1 0 4 0 0 1 2
3 1 0 1 16 3 2 2 3
4 1 0 0 3 0 1 2 3
5 2 1 1 2 2 0 0 1
6 2 1 0 13 7 6 0 0
7 2 0 1 0 1 0 1 0
8 2 0 0 3 9 1 0 2
9 3 1 1 3 7 1 0 1
10 3 1 0 8 6 6 3 5
11 3 0 1 2 4 1 1 4
12 3 0 0 0 1 0 0 0
13 4 1 1 13 10 0 2 2
14 4 1 0 9 0 0 1 2
15 4 0 1 3 9 1 0 1
16 4 0 0 8 1 0 0 1
> library(VGAM)
> vglm(formula = cbind(y2,y3,y4,y5,y1) ~ size + factor(lake),
family=multinomial, data=alligators)
Coefficients:
(Intercept):1 (Intercept):2 (Intercept):3 (Intercept):4 size:1
-3.2073772 -2.0717560 -1.3979592 -1.0780754 1.4582046
size:2 size:3 size:4 factor(lake)2:1 factor(lake)2:2
-0.3512628 -0.6306597 0.3315503 2.5955779 1.2160953
factor(lake)2:3 factor(lake)2:4 factor(lake)3:1 factor(lake)3:2 factor(lake)3:3
-1.3483253 -0.8205431 2.7803434 1.6924767 0.3926492
factor(lake)3:4 factor(lake)4:1 factor(lake)4:2 factor(lake)4:3 factor(lake)4:4
0.6901725 1.6583586 -1.2427766 -0.6951176 -0.8261962
Degrees of Freedom: 64 Total; 44 Residual
Residual Deviance: 52.47849
Log-likelihood: -74.42948
> library(nnet)
> fit2 <- multinom(cbind(y1,y2,y3,y4,y5) ~ size + factor(lake), data=alligators)
> summary(fit2)
Call:
multinom(formula = cbind(y1, y2, y3, y4, y5) ~ size + factor(lake),
data = alligators)
Coefficients:
(Intercept) size factor(lake)2 factor(lake)3 factor(lake)4
y2 -3.207394 1.4582267 2.5955898 2.7803506 1.6583514
y3 -2.071811 -0.3512070 1.2161555 1.6925186 -1.2426769
y4 -1.397976 -0.6306179 -1.3482294 0.3926516 -0.6951107
y5 -1.078137 0.3315861 -0.8204767 0.6902170 -0.8261528
Std. Errors:
(Intercept) size factor(lake)2 factor(lake)3 factor(lake)4
y2 0.6387317 0.3959455 0.6597077 0.6712222 0.6128757
y3 0.7067258 0.5800273 0.7860141 0.7804482 1.1854024
y4 0.6085176 0.6424744 1.1634848 0.7817677 0.7812585
y5 0.4709212 0.4482539 0.7296253 0.5596752 0.5575414
Residual Deviance: 540.0803
AIC: 580.0803
�
�
VGLM for Ordinal Models
> happy <- read.table("happy.dat", header=TRUE)
> happy
race traumatic y1 y2 y3
1 0 0 1 0 0
2 0 0 1 0 0
3 0 0 1 0 0
4 0 0 1 0 0
5 0 0 1 0 0
6 0 0 1 0 0
7 0 0 1 0 0
8 0 0 0 1 0
...
94 1 2 0 0 1
95 1 3 0 1 0
96 1 3 0 1 0
97 1 3 0 0 1
> library(VGAM)
> fit <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cumulative(parallel=TRUE), data=happy)
> summary(fit)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.51812 0.33819 -1.5320
(Intercept):2 3.40060 0.56481 6.0208
race -2.03612 0.69113 -2.9461
traumatic -0.40558 0.18086 -2.2425
Names of linear predictors: logit(P[Y<=1]), logit(P[Y<=2])
Residual Deviance: 148.407 on 190 degrees of freedom
Log-likelihood: -74.2035 on 190 degrees of freedom
Number of Iterations: 5
> fit.inter <- vglm(cbind(y1,y2,y3) ~ race + traumatic + race*traumatic,
family=cumulative(parallel=TRUE), data=happy)
> summary(fit.inter)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.43927 0.34469 -1.2744
(Intercept):2 3.52745 0.58737 6.0055
race -3.05662 1.20459 -2.5375
traumatic -0.46905 0.19195 -2.4436
race:traumatic 0.60850 0.60077 1.0129
Residual Deviance: 147.3575 on 189 degrees of freedom
Log-likelihood: -73.67872 on 189 degrees of freedom
Number of Iterations: 5
> fit2 <- vglm(cbind(y1,y2,y3) ~ race + traumatic, family=cumulative,
data=happy)
> summary(fit2)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.56605 0.36618 -1.545821
(Intercept):2 3.48370 0.75950 4.586850
race:1 -14.01877 322.84309 -0.043423
race:2 -1.84673 0.76276 -2.421095
traumatic:1 -0.34091 0.21245 -1.604644
traumatic:2 -0.48356 0.27524 -1.756845
Residual Deviance: 146.9951 on 188 degrees of freedom
Log-likelihood: -73.49755 on 188 degrees of freedom
Number of Iterations: 14
> pchisq(deviance(fit)-deviance(fit2),df=df.residual(fit)-df.residual(fit2),lower.tail=FALSE)
[1] 0.4936429
fit.probit <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cumulative(link=probit, parallel=TRUE), data=happy)
> summary(fit.probit)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.34808 0.200147 -1.7391
(Intercept):2 1.91607 0.282872 6.7736
race -1.15712 0.378716 -3.0554
traumatic -0.22131 0.098973 -2.2361
Residual Deviance: 148.1066 on 190 degrees of freedom
Log-likelihood: -74.0533 on 190 degrees of freedom
Number of Iterations: 5
To ?t the adjacent-categories logit model to the same data, we use
> fit.acat <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=acat(reverse=TRUE, parallel=TRUE), data=happy)
> summary(fit.acat)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.49606 0.31805 -1.5597
(Intercept):2 3.02747 0.57392 5.2751
race -1.84230 0.64190 -2.8701
traumatic -0.35701 0.16396 -2.1775
Names of linear predictors: log(P[Y=1]/P[Y=2]), log(P[Y=2]/P[Y=3])
Residual Deviance: 148.1996 on 190 degrees of freedom
Log-likelihood: -74.09982 on 190 degrees of freedom
Number of Iterations: 5
> fit.cratio <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cratio(reverse=TRUE, parallel=TRUE), data=happy)
> summary(fit.cratio)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.45530 0.32975 -1.3808
(Intercept):2 3.34108 0.56309 5.9335
race -2.02555 0.67683 -2.9927
traumatic -0.38504 0.17368 -2.2170
Names of linear predictors: logit(P[Y<2|Y<=2]), logit(P[Y<3|Y<=3])
Residual Deviance: 148.1571 on 190 degrees of freedom
Log-likelihood: -74.07856 on 190 degrees of freedom
Number of Iterations: 5
�
Other Multinomial Functions:
> library(MASS)
> response <- matrix(0,nrow=97,ncol=1)
> response <- ifelse(y1==1,1,0)
> response <- ifelse(y2==1,2,resp)
> response <- ifelse(y3==1,3,resp)
> y <- factor(response)
> polr(y ~ race + traumatic, data=happy)
Call:
polr(formula = y ~ race + traumatic, data=happy)
Coefficients:
race traumatic
2.0361187 0.4055724
Intercepts:
1|2 2|3
-0.5181118 3.4005955
Residual Deviance: 148.407
AIC: 156.407
�
Loglinear Models:
�
> drugs <- read.table("drugs.dat",header=TRUE)
> drugs
a c m count
1 yes yes yes 911
2 yes yes no 538
3 yes no yes 44
4 yes no no 456
5 no yes yes 3
6 no yes no 43
7 no no yes 2
8 no no no 279
> alc <- factor(a); cig <- factor(c); mar <- factor(m)
> indep <- glm(count ~ alc + cig + mar, family=poisson(link=log), data=drugs)
> summary(indep) % loglinear model (A, C, M)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 6.29154 0.03667 171.558 < 2e-16 ***
alc2 -1.78511 0.05976 -29.872 < 2e-16 ***
cig2 -0.64931 0.04415 -14.707 < 2e-16 ***
mar2 0.31542 0.04244 7.431 1.08e-13 ***
---
Null deviance: 2851.5 on 7 degrees of freedom
Residual deviance: 1286.0 on 4 degrees of freedom
AIC: 1343.1
Number of Fisher Scoring iterations: 6
> homo.assoc <- update(indep, .~. + alc:cig + alc:mar + cig:mar)
> summary(homo.assoc) # loglinear model (AC, AM, CM)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 6.81387 0.03313 205.699 < 2e-16 ***
alc2 -5.52827 0.45221 -12.225 < 2e-16 ***
cig2 -3.01575 0.15162 -19.891 < 2e-16 ***
mar2 -0.52486 0.05428 -9.669 < 2e-16 ***
alc2:cig2 2.05453 0.17406 11.803 < 2e-16 ***
alc2:mar2 2.98601 0.46468 6.426 1.31e-10 ***
cig2:mar2 2.84789 0.16384 17.382 < 2e-16 ***
---
Null deviance: 2851.46098 on 7 degrees of freedom
Residual deviance: 0.37399 on 1 degrees of freedom
AIC: 63.417
Number of Fisher Scoring iterations: 4
> pearson <- summary.lm(homo.assoc)$residuals # Pearson residuals
> sum(pearson^2) # Pearson goodness-of-fit statistic
[1] 0.4011006
> leverage <- lm.influence(homo.assoc)$hat # leverage values
> std.resid <- pearson/sqrt(1 - leverage) # standardized residuals
> expected <- fitted(homo.assoc) # estimated expected frequencies
> cbind(count, expected, pearson, std.resid)
count expected pearson std.resid
1 911 910.383170 0.02044342 0.6333249
2 538 538.616830 -0.02657821 -0.6333249
3 44 44.616830 -0.09234564 -0.6333249
4 456 455.383170 0.02890528 0.6333249
5 3 3.616830 -0.32434090 -0.6333251
6 43 42.383170 0.09474777 0.6333249
7 2 1.383170 0.52447895 0.6333251
8 279 279.616830 -0.03688791 -0.6333249
�
Association Models:
> sexdata <- read.table("sex.dat", header=TRUE)
> attach(sexdata)
> uv <- premar*birth
> premar <- factor(premar); birth <- factor(birth)
> LL.fit <- glm(count ~ premar + birth + uv, family=poisson)
> summary(LL.fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 4.10684 0.08951 45.881 < 2e-16 ***
premar2 -1.64596 0.13473 -12.216 < 2e-16 ***
premar3 -1.77002 0.16464 -10.751 < 2e-16 ***
premar4 -1.75369 0.23432 -7.484 7.20e-14 ***
birth2 -0.46411 0.11952 -3.883 0.000103 ***
birth3 -0.72452 0.16201 -4.472 7.74e-06 ***
birth4 -1.87966 0.24910 -7.546 4.50e-14 ***
uv 0.28584 0.02824 10.122 < 2e-16 ***
Null deviance: 431.078 on 15 degrees of freedom
Residual deviance: 11.534 on 8 degrees of freedom
AIC: 118.21
Number of Fisher Scoring iterations: 4
> u <- c(1,1,1,1,2,2,2,2,4,4,4,4,5,5,5,5)
> v <- c(1,2,4,5,1,2,4,5,1,2,4,5,1,2,4,5)
> row.fit <- glm(count ~ premar + birth + u:birth, family=poisson)
> summary(row.fit)
Coefficients: (1 not defined because of singularities)
Estimate Std. Error z value Pr(>|z|)
(Intercept) 4.98722 0.14624 34.102 < 2e-16 ***
premar2 -0.65772 0.13124 -5.011 5.40e-07 ***
premar3 0.46664 0.16266 2.869 0.004120 **
premar4 1.50195 0.17952 8.366 < 2e-16 ***
birth2 -0.31939 0.19821 -1.611 0.107103
birth3 -0.72688 0.20016 -3.632 0.000282 ***
birth4 -1.49032 0.23745 -6.276 3.47e-10 ***
birth1:u -0.59533 0.06555 -9.082 < 2e-16 ***
birth2:u -0.40543 0.06068 -6.681 2.37e-11 ***
birth3:u -0.12975 0.05634 -2.303 0.021276 *
birth4:u NA NA NA NA
Null deviance: 431.078 on 15 degrees of freedom
Residual deviance: 8.263 on 6 degrees of freedom
AIC: 118.94
Number of Fisher Scoring iterations: 4
> column.fit <- glm(count ~ premar + birth + premar:v, family=poisson)
> summary(column.fit)
Coefficients: (1 not defined because of singularities)
Estimate Std. Error z value Pr(>|z|)
Estimate Std. Error z value Pr(>|z|)
(Intercept) 1.40792 0.26947 5.225 1.74e-07 ***
premar2 -0.68466 0.29053 -2.357 0.018444 *
premar3 0.78235 0.22246 3.517 0.000437 ***
premar4 2.11167 0.18958 11.138 < 2e-16 ***
birth2 0.54590 0.11723 4.656 3.22e-06 ***
birth3 1.59262 0.14787 10.770 < 2e-16 ***
birth4 1.51018 0.16420 9.197 < 2e-16 ***
premar1:v 0.58454 0.05930 9.858 < 2e-16 ***
premar2:v 0.49554 0.07990 6.202 5.57e-10 ***
premar3:v 0.20315 0.06538 3.107 0.001890 **
premar4:v NA NA NA NA
Null deviance: 431.0781 on 15 degrees of freedom
Residual deviance: 7.5861 on 6 degrees of freedom
AIC: 118.26
Number of Fisher Scoring iterations: 4
----------------------------------------------------------------
�
Models for Matched Pairs
�
ratings <- matrix(c(175, 16, 54, 188), ncol=2, byrow=TRUE,
+ dimnames = list("2004 Election" = c("Democrat", "Republican"),
+ "2008 Election" = c("Democrat", "Republican")))
> mcnemar.test(ratings, correct=FALSE)
�
Clustered Categorical Responses: Marginal Models:
> abortion
gender response question case
1 1 1 1 1
2 1 1 2 1
3 1 1 3 1
4 1 1 1 2
5 1 1 2 2
6 1 1 3 2
7 1 1 1 3
8 1 1 2 3
9 1 1 3 3
...
5545 0 0 1 1849
5546 0 0 2 1849
5547 0 0 3 1849
5548 0 0 1 1850
5549 0 0 2 1850
5550 0 0 3 1850
> z1 <- ifelse(abortion$question==1,1,0)
> z2 <- ifelse(abortion$question==2,1,0)
> z3 <- ifelse(abortion$question==3,1,0)
> library(gee)
> fit.gee <- gee(response ~ gender + z1 + z2, id=case, family=binomial,
+ corstr="exchangeable", data=abortion)
> summary(fit.gee)
GEE: GENERALIZED LINEAR MODELS FOR DEPENDENT DATA
gee S-function, version 4.13 modified 98/01/27 (1998)
Model:
Link
Variance to Mean Relation: Binomial
Correlation Structure: Exchangeable
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
(Intercept) -0.125325730 0.06782579 -1.84775925 0.06758212 -1.85442135
gender 0.003437873 0.08790630 0.03910838 0.08784072 0.03913758
z1 0.149347107 0.02814374 5.30658404 0.02973865 5.02198729
z2 0.052017986 0.02815145 1.84779075 0.02704703 1.92324179
Working Correlation
[,1] [,2] [,3]
[1,] 1.0000000 0.8173308 0.8173308
[2,] 0.8173308 1.0000000 0.8173308
[3,] 0.8173308 0.8173308 1.0000000
> fit.gee2 <- gee(response ~ gender + z1 + z2, id=case, family=binomial,
+ corstr="independence", data=abortion)
> summary(fit.gee2)
Link: Logit
Variance to Mean Relation: Binomial
Correlation Structure: Independent
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
(Intercept) -0.125407576 0.05562131 -2.25466795 0.06758236 -1.85562596
gender 0.003582051 0.05415761 0.06614123 0.08784012 0.04077921
z1 0.149347113 0.06584875 2.26803253 0.02973865 5.02198759
z2 0.052017989 0.06586692 0.78974374 0.02704704 1.92324166
Working Correlation
[,1] [,2] [,3]
[1,] 1 0 0
: Logit
[2,] 0 1 0
[3,] 0 0 1
> geeglm(y ~ x1 + x2, family=binomial, id=subject, corst=��exchangeable��)
> insomnia<-read.table("insomnia.dat",header=TRUE)
> insomnia<-as.data.frame(insomnia)
> insomnia
case treat occasion outcome
1 1 0 1
1 1 1 1
2 1 0 1
2 1 1 1
3 1 0 1
3 1 1 1
4 1 0 1
4 1 1 1
5 1 0 1
...
239 0 0 4
239 0 1 4
> library(repolr)
> fit <- repolr(formula = outcome ~ treat + occasion + treat * occasion,
+ subjects="case", data=insomnia, times=c(1,2), categories=4,
corstr = "independence")
> summary(fit$gee)
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
factor(cuts)1 -2.26708899 0.2027367 -11.1824294 0.2187606 -10.3633343
factor(cuts)2 -0.95146176 0.1784822 -5.3308499 0.1809172 -5.2591017
factor(cuts)3 0.35173977 0.1726860 2.0368745 0.1784232 1.9713794
treat 0.03361002 0.2368973 0.1418759 0.2384374 0.1409595
occasion 1.03807641 0.2375992 4.3690229 0.1675855 6.1943093
treat:occasion 0.70775891 0.3341759 2.1179234 0.2435197 2.9063728
�
Clustered Categorical Responses: Random Effects Models:
> abortion
gender response question case
1 1 1 1 1
2 1 1 2 1
3 1 1 3 1
4 1 1 1 2
5 1 1 2 2
6 1 1 3 2
...
5548 0 0 1 1850
5549 0 0 2 1850
5550 0 0 3 1850
> z1 <- ifelse(abortion$question==1,1,0)
> z2 <- ifelse(abortion$question==2,1,0)
> z3 <- ifelse(abortion$question==3,1,0)
> library(glmmML)
> fit.glmmML <- glmmML(response ~ gender + z1 + z2,
+ cluster=abortion$case, family=binomial, data=abortion,
+ method = �ghq�, n.points=50, start.sigma=9)
> summary(fit.glmmML)
Call: glmmML(formula = response ~ gender + z1 + z2, family = binomial,
data = abortion, cluster = abortion$case, start.sigma = 9,
method = "ghq", n.points = 50)
coef se(coef) z Pr(>|z|)
(Intercept) -0.62222 0.3811 -1.63253 1.03e-01
gender 0.01272 0.4936 0.02578 9.79e-01
z1 0.83587 0.1599 5.22649 1.73e-07
z2 0.29290 0.1568 1.86822 6.17e-02
Scale parameter in mixing distribution: 8.788 gaussian
Std. Error: 0.5282
LR p-value for H_0: sigma = 0: 0
Residual deviance: 4578 on 5545 degrees of freedom AIC: 4588
�
Beta-Binomial and Quasi-likelihood Analysis
> group <- rats$group
> library(VGAM) # We use Thomas Yee�s VGAM library
> fit.bb <- vglm(cbind(y,n-y) ~ group, betabinomial(zero=2,irho=.2),
data=rats)
# two parameters, mu and rho, and zero=2 specifies 0 covariates for 2nd
# parameter (rho); irho is the initial guess for rho in beta-bin variance.
> summary(fit.bb) # fit of beta-binomial model
Coefficients:
Value Std. Error t value
(Intercept):1 1.3458 0.24412 5.5130
(Intercept):2 -1.1458 0.32408 -3.5355 # This is logit(rho)
group2 -3.1144 0.51818 -6.0103
group3 -3.8681 0.86285 -4.4830
group4 -3.9225 0.68351 -5.7387
Names of linear predictors: logit(mu), logit(rho)
Log-likelihood: -93.45675 on 111 degrees of freedom
> logit(-1.1458, inverse=T) # This is a function in VGAM
[1] 0.2412571 # The estimate of rho in beta-bin variance
> install.packages("aod") # another way to fit beta-binomial models
> library(aod)
> betabin(cbind(y,n-y) ~ group, random=~1,data=rats)
Beta-binomial model
------------------betabin(formula
= cbind(y, n - y) ~ group, random = ~1, data = rats)
Fixed-effect coefficients:
Estimate Std. Error z value Pr(> |z|)
(Intercept) 1.346e+00 2.481e-01 5.425e+00 5.799e-08
group2 -3.115e+00 5.020e-01 -6.205e+00 5.485e-10
group3 -3.869e+00 8.088e-01 -4.784e+00 1.722e-06
group4 -3.924e+00 6.682e-01 -5.872e+00 4.293e-09
Overdispersion coefficients:
Estimate Std. Error z value Pr(> z)
phi.(Intercept) 2.412e-01 6.036e-02 3.996e+00 3.222e-05
> quasibin(cbind(y,n-y) ~ group, data=rats) # QL with beta-bin variance
Quasi-likelihood generalized linear model
-----------------------------------------
quasibin(formula = cbind(y, n - y) ~ group, data = rats)
Fixed-effect coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 1.2124 0.2233 5.4294 < 1e-4
group2 -3.3696 0.5626 -5.9893 < 1e-4
group3 -4.5853 1.3028 -3.5197 4e-04
group4 -4.2502 0.8484 -5.0097 < 1e-4
Overdispersion parameter:
phi
0.1923
Pearson�s chi-squared goodness-of-fit statistic = 54.0007
�
Non-Model Based Classification and Clustering
�
> library(tree)
> attach(crabs)
> fit <- rpart(y ~ color + width, method="class")
> plot(fit)
> text(fit)
> printcp(fit)
Classification tree:
rpart(formula = y ~ color + width, method = "class")
Variables actually used in tree construction:
[1] color width
Root node error: 62/173 = 0.35838
n= 173
CP nsplit rel error xerror xstd
1 0.161290 0 1.00000 1.00000 0.101728
2 0.080645 1 0.83871 1.03226 0.102421
3 0.064516 2 0.75806 0.96774 0.100972
4 0.048387 3 0.69355 0.93548 0.100149
5 0.016129 4 0.64516 0.85484 0.097794
6 0.010000 6 0.61290 0.82258 0.096728
> plotcp(fit)
> summary(fit)
> plot(fit, uniform=TRUE,
main="Classification Tree for Crabs")
> pfit2 <- prune(fit, cp= 0.02)
> plot(pfit2, uniform=TRUE,
main="Pruned Classification Tree for Crabs")
plot(pfit2, uniform=TRUE,
+ main="Pruned Classification Tree for Crabs")
> text(pfit2, use.n=TRUE, all=TRUE, cex=.8)
> post(pfit2, file = "ptree2.ps",
title = "Pruned Classification Tree for Crabs")
post(pfit2, file = "ptree2.ps",
+ title = "Pruned Classification Tree for Crabs")
�
Cluster Analysis
> x <- read.table("election.dat", header=F)
> x
V1 V2 V3 V4 V5 V6 V7 V8 V9
1 0 0 0 0 1 0 0 0
2 0 0 0 1 1 1 1 1
3 0 0 0 1 0 0 0 1
4 0 0 0 0 1 0 0 1
5 0 0 0 1 1 1 1 1
6 0 0 1 1 1 1 1 1
7 1 1 1 1 1 1 1 1
8 0 0 0 1 1 0 0 0
9 0 0 0 1 1 1 0 1
10 0 0 1 1 1 1 1 1
11 0 0 0 1 1 0 0 1
12 0 0 0 0 0 0 0 0
13 0 0 0 0 0 0 0 1
14 0 0 0 0 0 0 0 0
> distances <- dist(x,method="manhattan")
> states <- c("AZ", "CA", "CO", "FL", "IL", "MA", "MN",
"MO", "NM", "NY", "OH", "TX", "VA", "WY")
> democlust <- hclust(distances,"average")
> postscript(file="dendrogram-election.ps")
> plot(democlust, labels=states)
> graphics.off()
�
Read Excel file:
library(xlsx);
mydata<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
�
Repeat columns:
matrix(rep(x,each=n), ncol=n, byrow=TRUE)
�
Pasted from <http://www.r-bloggers.com/a-quick-way-to-do-row-repeat-and-col-repeat-rep-row-rep-col/> 
�
�
Repeat Rows
matrix(rep(x,each=n),nrow=n)
�
Pasted from <http://www.r-bloggers.com/a-quick-way-to-do-row-repeat-and-col-repeat-rep-row-rep-col/> 
�
Define identity matrix:
Diag(n)
Create a Diagonal matrix with diagonal of a vector:
diag(5)*c(1,2,3,4,5)
�
Matrix facilites
In the following examples,�A�and�B�are matrices and�x�and�b�are a vectors.
�
Operator or Function
Description
A * B
Element-wise multiplication
A %*% B
Matrix multiplication
A %o% B
Outer product.�AB'
crossprod(A,B)
crossprod(A)
A'B�and�A'A�respectively.
t(A)
Transpose
diag(x)
Creates diagonal matrix with elements of�x�in the principal diagonal
diag(A)
Returns a vector containing the elements of the principal diagonal
diag(k)
If k is a scalar, this creates a k x k identity matrix. Go figure.
solve(A, b)
Returns vector�x�in the equation�b = Ax�(i.e.,�A-1b)
solve(A)
Inverse of�A�where A is a square matrix.
ginv(A)
Moore-Penrose Generalized Inverse of�A.�
ginv(A) requires loading the�MASS�package.
y<-eigen(A)
y$val�are the eigenvalues of�A
y$vec�are the eigenvectors of�A
y<-svd(A)
Single value decomposition of�A.
y$d�= vector containing the singular values of�A
y$u�= matrix with columns contain the left singular vectors of�A�
y$v�= matrix with columns contain the right singular vectors of�A
R <- chol(A)
Choleski factorization of�A. Returns the upper triangular factor, such that�R'R = A.
y <- qr(A)
QR decomposition of�A.�
y$qr�has an upper triangle that contains the decomposition and a lower triangle that contains information on the Q decomposition.
y$rank�is the rank of A.�
y$qraux�a vector which contains additional information on Q.�
y$pivot�contains information on the pivoting strategy used.
cbind(A,B,...)
Combine matrices(vectors) horizontally. Returns a matrix.
rbind(A,B,...)
Combine matrices(vectors) vertically. Returns a matrix.
rowMeans(A)
Returns vector of row means.
rowSums(A)
Returns vector of row sums.
colMeans(A)
Returns vector of column means.
colSums(A)
Returns vector of coumn means.
�
Pasted from <http://www.statmethods.net/advstats/matrix.html> 
�
Convert matrix to vector:
As.vector(A)
http://stackoverflow.com/questions/3823211/how-to-convert-a-matrix-to-a-1-dimensional-array-in-r
�
Text Mining Using R:
# preprocessing of the document
library(tm)
firefox.csv<-read.csv("c:/CDBookSurvay/Comments.csv")
firefox <- Corpus(DataframeSource(firefox.csv)) # create corpus for analysis
firefoxcopy <- firefox # keep a copy of corpus to use later as a dictionary for stem completion
firefox <-tm_map(firefox, tolower) # convert to lower case
firefox <- tm_map(firefox, removeNumbers) # remove numbers
for (j in 1:length(firefox)) firefox[[j]] <- gsub("'", " ",firefox[[j]])# to remove special puncutation but not connect
firefox <- tm_map(firefox, removePunctuation)# remove punctuations
firefox <- tm_map(firefox, removeWords, stopwords("english")) #remove stop words
newstopwords <- c("and", "for", "the", "to", "in", "when", "then", "he", "she", "than", "a", "for", "it", "of", "on", "to","im")
firefox <- tm_map(firefox, removeWords, newstopwords)
�
firefox <- tm_map(firefox, stemDocument)# stem words
inspect(firefox[1:10])
firefox <- tm_map(firefox, stemCompletion, dictionary=firefoxcopy) #stem completion
�
inspect(firefoxcopy[1:10])
summary(firefox)
myTdm <- TermDocumentMatrix(firefox, control = list(wordLengths=c(1,Inf)))
myTdm # printing dtm summery
idx <- which(dimnames(myTdm)$Terms =="alexa")
�
inspect(myTdm[idx+(0:5),1:10]) # look at 5 keywords after the keyword alexa over 10 documents that used for dtm
inspect(myTdm[0:20,1:10]) # check items of dtm
rownames(myTdm) # write all the keywords you have used
findFreqTerms(myTdm, lowfreq=3) #find frequent terms 
�
# plot of more frequent words
termFrequency <- rowSums(as.matrix(myTdm)) # go over matrix and filtering for drawing a plot
termFrequency <- subset(termFrequency, termFrequency>=3) # go for terms that are in text more than 3 times
library(ggplot2) # use graphic package to draw plots
qplot(names(termFrequency), termFrequency, geom="bar") + coord_flip() # draw horizontal bar plot
barplot(termFrequency, las=2) # draw vertical bar plot
findAssocs(myTdm, "love", 0.25)# find words with highest asociation
 
library(wordcloud) # used for importance of the word check
m <- as.matrix(myTdm) # convert document term matrix to normal matrix
# calculate the frequency of words and sort it descendingly by frequency
wordFreq <- sort(rowSums(m), decreasing=TRUE)
# word cloud
set.seed(375) # to make it reproducible
grayLevels <- gray( (wordFreq+10) / (max(wordFreq)+10) )
# frequency below 1 is not ploted in the following
# random.order=F: frequent words plotted first in the center of the cloud
# set colour to: grayLevels or raingbow() to colorful or gray map
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=2, random.order=F,colors=grayLevels)
�
# clustering
# remove sparse terms
# you can remove sparce terms to avoid being flooded with words
myTdm2 <- removeSparseTerms(myTdm, sparse=0.95)
m2 <- as.matrix(myTdm2)
# cluster of terms/words (come together e.g. couple of twits on text mining analysis, and couple of twits on job vacancies in PhD in different clusters)
distMatrix <- dist(scale(m2)) # calculate distance between terms after scaling
fit <- hclust(distMatrix, method="ward") # clustering agglomeration method is set to ward: icreased variance when two clusters are merged; other options are:  single linkage, complete linkage, average linkage, median and centroid
plot(fit)
# cut tree into 10 clusters
rect.hclust(fit, k=10) # cut into 10 clusters
(groups <- cutree(fit, k=10))
�
# clustering using k-min of documents
# transpose the matrix to cluster documents (tweets)
m3 <- t(m2) # take value of matrix as numeric & transpose to document term
# set a fixed random seed
set.seed(122) # to produce the clustering result
# k-means clustering of tweets
k <- 3 # 8 clusters
kmeansResult <- kmeans(m3, k) 
# cluster centers
round(kmeansResult$centers, digits=3) # popular words in cluster and center
�
# check k mean cluster by top 3 words
for (i in 1:k) {
cat(paste("cluster ", i, ": ", sep=""))
s <- sort(kmeansResult$centers[i,], decreasing=T)
cat(names(s)[1:3], "\n")
# print the tweets of every cluster
# print(rdmTweets[which(kmeansResult$cluster==i)])
}
�
library(Rgraphviz)# to use for cluster assowciation matrix
plot(myTdm, terms = findFreqTerms(myTdm, lowfreq = 1)[1:20], corThreshold = 0)
�
library(fpc)#draw cluster based on matrix
plotcluster(m3, kmeansResult$cluster)
�
library(fpc) # clustering with Partitioning Around Medoids (PAM): (representative objects) more robust to noise and outliers than k-means clustering
# partitioning around medoids with estimation of number of clusters
pamResult <- pamk(m3, metric = "manhattan") # estimate number of optimal clusters
# number of clusters identified
(k <- pamResult$nc)
pamResult <- pamResult$pamobject
# print cluster medoids
for (i in 1:k) {
cat(paste("cluster", i, ": "))
cat(colnames(pamResult$medoids)[which(pamResult$medoids[i,]==1)], "\n")
#print tweets in cluster i
# print(rdmTweets[pamResult$clustering==i])
} 
�
# plot clustering result
layout(matrix(c(1,2),2,1)) # set to two graphs per page
plot(pamResult, color=F, labels=4, lines=0, cex=.8, col.clus=1,
col.p=pamResult$clustering)
layout(matrix(1)) # change back to one graph per page
�
#create social network of terms
termDocMatrix<-m2
termDocMatrix[1:5,1:5] # check Tdm
# change it to a Boolean matrix
termDocMatrix[termDocMatrix>=1] <- 1
# transform into a term-term adjacency matrix
termMatrix <- termDocMatrix %*% t(termDocMatrix) # %*% product of two matrices
# inspect terms numbered 5 to 7
termMatrix[5:7,5:7]
library(igraph)
# build a graph from the above matrix
g <- graph.adjacency(termMatrix, weighted=T, mode = "undirected")
# remove loops
g <- simplify(g)
# set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)
�
#dynamically rearranged layout get detail by running ?igraph::layout
plot(g, layout=layout.kamada.kawai)
tkplot(g, layout=layout.kamada.kawai)#extremely interesting graph creation
�
pdf("term-network.pdf") # put terms plot in a pdf file
plot(g, layout=layout.fruchterman.reingold)
dev.off()
�
# size of plot's term according to the degree: important terms stand out
# set the width and transparency of edges based on their weights
# vertices and edges are accessed with V() and E()
# rgb(red, green, blue,alpha) defines a color with an alpha transparency
V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color <- rgb(0, 0, .2, .8)
V(g)$frame.color <- NA
egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam
# plot the graph in layout1
plot(g, layout=layout1)
�
#build network of documents (tweets) first phase
# remove "r", "data" and "mining" most used if they make the document crowded
# idx <- which(dimnames(termDocMatrix)$Terms %in% c("r", "data", "mining"))
#M <- termDocMatrix[-idx,] # remove terms from matrix
M<-termDocMatrix # since I did not wanted to remove anything
# build a tweet-tweet adjacency matrix
tweetMatrix <- t(M) %*% M
library(igraph)
g <- graph.adjacency(tweetMatrix, weighted=T, mode = "undirected")
V(g)$degree <- degree(g)
g <- simplify(g)
# set labels of vertices to tweet IDs
V(g)$label <- V(g)$name
V(g)$label.cex <- 1
V(g)$label.color <- rgb(.4, 0, 0, .7)
V(g)$size <- 2
V(g)$frame.color <- NA
barplot(table(V(g)$degree)) # check degree distribution of vertices
�
#build network of documents (tweets) second phase
idx <- V(g)$degree == 0
V(g)$label.color[idx] <- rgb(0, 0, .3, .7) # set based on degree
# set labels to the IDs and the first 10 characters of tweets
# limit to the first 20 character of every tweet
# label of each set to tweet ID so that graph would not be overcrowded
# set color and width of edges based on their weights
#V(g)$label[idx] <- paste(V(g)$name[idx], substr(df$text[idx], 1, 20), sep=" ")
egam <- (log(E(g)$weight)+.2) / max(log(E(g)$weight)+.2)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam
set.seed(3152)
layout2 <- layout.fruchterman.reingold(g)
plot(g, layout=layout2)
�
# remove isolated vertices and draw again
g2 <- delete.vertices(g, V(g)[degree(g)==0]) 
plot(g, layout=layout2)
�
# remove edges with low degree and draw again
g3 <- delete.edges(g, E(g)[E(g)$weight <= 1])
g3 <- delete.vertices(g3, V(g3)[degree(g3) == 0])
plot(g3, layout=layout.fruchterman.reingold)
�
# look at specific clique: considerably connected {replacement for dftext
inspect(firefox[c(15,16)])
�
#graph g directly from termDocMatrix
# create a graph
g <- graph.incidence(termDocMatrix, mode=c("all"))
# get index for term vertices and tweet vertices
nTerms <- nrow(M)
nDocs <- ncol(M)
idx.terms <- 1:nTerms
idx.docs <- (nTerms+1):(nTerms+nDocs)
# set colors and sizes for vertices
V(g)$degree <- degree(g)
V(g)$color[idx.terms] <- rgb(0, 1, 0, .5)
V(g)$size[idx.terms] <- 6
V(g)$color[idx.docs] <- rgb(1, 0, 0, .4)
V(g)$size[idx.docs] <- 4
V(g)$frame.color <- NA
# set vertex labels and their colors and sizes
V(g)$label <- V(g)$name
V(g)$label.color <- rgb(0, 0, 0, 0.5)
V(g)$label.cex <- 1.4*V(g)$degree/max(V(g)$degree) + 1
# set edge width and color
E(g)$width <- .3
E(g)$color <- rgb(.5, .5, 0, .3)
set.seed(958)#5365, 227
plot(g, layout=layout.fruchterman.reingold)
�
# returns all vertices of "love" # if node does not exist returns "invalid vertex name"
V(g)[nei("love")]
V(g)[neighborhood(g, order=1, "love")[[1]]]# alternative way of geting vertices
�
#check which vertices include all three elements "thank", "perfect", "love"
(rdmVertices <- V(g)[nei("love") & nei("perfect") & nei("thank")])
inspect(firefox[as.numeric(rdmVertices$label)])# check content of the doc that includes these three terms
�
# remove three words to see the relationship with doc with other words
idx <- which(V(g)$name %in% c("love", "perfect", "thank"))
g2 <- delete.vertices(g, V(g)[idx-1])
g2 <- delete.vertices(g2, V(g2)[degree(g2)==0])
set.seed(209)
plot(g2, layout=layout.fruchterman.reingold)
�
Global Variable in R:
Variables declared inside a function are local to that function. For instance:
foo <- function() {
    bar <- 1
}
foo()
bar
gives the following error:�Error: object 'bar' not found.
If you want to make�bar�a global variable, you should do:
foo <- function() {
    bar <<- 1
}
foo()
bar
In this case�bar�is accessible from outside the function.
However, unlike C, C++ or many other languages, brackets do not determine the scope of variables. For instance, in the following code snippet:
if (x > 10) {
    y <- 0
}
else {
    y <- 1
}
y�remains accessible after the�if-else�statement.
As you well say, you can also create nested environments. You can have a look at these two links for understanding how to use them:
�
Pasted from <http://stackoverflow.com/questions/10904124/global-and-local-variables-in-r> 
�
�
To access a global variable in R you do not need to do anything you just use the name.
�
For example, from�?Sys.sleep
testit <- function(x)
{
    p1 <- proc.time()
    Sys.sleep(x)
    proc.time() - p1 # The cpu usage should be negligible
}
testit(3.7)
Yielding
> testit(3.7)
   user  system elapsed 
  0.000   0.000   3.704 
�
Pasted from <http://stackoverflow.com/questions/1174799/how-to-make-execution-pause-sleep-wait-for-x-seconds> 
�
Ways to pause the program:
�'par(ask = TRUE)'�
�
Pasted from <http://tolstoy.newcastle.edu.au/R/help/04/11/8084.html> 
�
Readline()
�
Elementwise comparison of two vectors:
Assuming that the vectors�x�and�y�are of the same length,�pmax�is your function.
z = pmax(x, y)
If the lengths differ, the�pmax�expression will return different values than your loop, due to recycling.
�
Pasted from <http://stackoverflow.com/questions/14092922/finding-maximum-of-two-vectors-without-a-loop> 
�
Break Program while executing keyboard shortcut: ESC
�
With Heterogeneity Model for Behavioral pricing (Regret Project):
rm(list = ls());
�
# model with heterogeneity without fixed effect on the data
#use Gradient Methods, Genetic Algorithim, and ...
# parameters to estimate are: [alpha c bp alphap betar] where alpha is
# not fixed effect here, but an intercept
# alpha_e c_e bp_e alphap_e betar_e*c
�
#defining functions
# function to conduct contraction mapping and over real data so include
# Durations as well, and this is for cost heterogeneity
FuncWithHetroWithRegrtRD = function(x){
#global P1 P2 Dur1 Dur2 lambda gamma shares  km cost; #outside_n
#global vcm se_est betas variance
#gamma: the discount factor
#P1: price for first period
#P2: price for 2nd period
#lambda: Availability of second period
#arranging matrixes
#J: number of products under study = 106 in hour example
#T: number of periods =2 in hour example
#heterogeneous beta includes beta_ip, beta_ir, alpha_ip
J = dim(shares)[1];
T = dim(shares)[2];
�
# parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x[1])/(1+exp(x[1])); #share of first segment (use transformation to make sure it is between zero and one)
# use transformation to make sure that it is lower
bp       =  -exp(x[2]); #price coefficient difference heterogeneity coeff
alphap   =  -exp(x[3]); #high price regret difference heterogeneity coeff
betar    =  -exp(x[4]); #stock out regret difference heterogeneity coeff
# cat('input parameters for function are for [pi1 bp alphap betar] are: \n')
# cbind(pi1,bp,alphap,betar);
# pause
dd       =  matrix(rep(0,(J*T)),nrow=J,ncol=T); #since I have three periods and 
uij1     =  matrix(rep(0,J),nrow=J,ncol=2);
uij2     =  matrix(rep(0,J),nrow=J,ncol=2);
k        =  100;
de1      =  dd;
i        =  0; # track contraction mapping
#contraction mapping
cat(k,'k','\n')
cat(km,'km','\n')
while(k>km){
    i    =   i+1;
    if (ceiling(i/1000) == (i/1000)){
        cat(i,'\n');
        #median(as.vector(de1)-as.vector(de))
    ��������if (ceiling(i/1000)>80){
    ����������������stop("too many iterations");
    ��������}
    }
    de   =   de1;
    # calculate utility
    uij1[,1] =      de[,1];
    uij2[,1] =      de[,2];
    uij1[,2] =      de[,1]+bp*P1+ alphap*lambda*(P1-P2);
    uij2[,2] =      de[,2]+gamma*(lambda*(bp*P2)+ betar*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
    e1=exp(uij1); e2=exp(uij2);                                                                     #*cost
    shares_e=cbind((e1/(1+e1+e2))%*%matrix(c(pi1,1-pi1),nrow=2,ncol=1),(e2/(1+e1+e2))%*%matrix(c(pi1,1-pi1),nrow=2,ncol=1));
    shares_e=pmax(shares_e,0.00000001);   #As a precaution
    de1    =  de  + log(shares)-  log(shares_e) ;  
    k      =  max(abs(as.vector(de1)-as.vector(de)));
    #cat(k,'\n');
}
dd                       =    de1; # first segment utility portion
# run regression to find linear parameters
shares_n = matrix(t(dd),nrow=J*2,ncol=1); #stack shares on top of eachother
#cat(shares_n)
#pause
# with fixed effect models
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
#  heterogeneity in consumption utility explained by cost
p = 5;
X1 = cbind(rep(1,J),(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
X2= cbind(gamma*lambda,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
�
X = t(cbind(X1,X2));
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn= shares_n;
#log(shares_n./outside_n);
�
#OLS global setting
betas<<-solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors<<-Yn-Xn%*%betas;
vcm<<-as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est<<-sqrt(diag(vcm));
#OLS Local setting
betas=solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors=Yn-Xn%*%betas;
vcm=as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est=sqrt(diag(vcm));
# calculate variance
variance                 <<-    colMeans(errors^2)*2*J/(2*J-1); 
�
# to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
s1    =     e1/(1+e1+e2);
s11   =     1-s1;
s1=pmax(s1,0.00000001); #As a precaution
s11=pmax(s11,0.00000001); #As a precaution
s2    =     e2/(1+e1+e2);
s21   =     1-s2;
s2=pmax(s2,0.00000001);   #As a precaution
s21=pmax(s21,0.00000001); #As a precaution
Jacobian                 =    cbind((s1*s11)%*%matrix(c(pi1,1-pi1)),(s2*s21)%*%matrix(c(pi1,1-pi1)));
LogJacobian              =    -sum(log(as.vector(Jacobian)));
�
LogDemandShockLikelihood =    - T*J*log(sqrt(2*pi*variance)) -   .5*colSums(errors^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood ;
#cat ('set of (Jacobian, likelihood, Log demand shock Likelihood) is:\n');
#cat (cbind(LogJacobian,likelihood,LogDemandShockLikelihood),'\n');
#readline()
return(y);
}
�
�
#data
#global P1 P2 Dur1 Dur2 lambda gamma shares km cost #outside_n
#global vcm se_est betas variance
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
�
# test for cut off of second period
# P3=num[,13];
# P4=num[,16];
# Dur3=num[,14];
# S3=num[,15];
# S2=S3;
# P2=P4;
#Dur2=Dur3;
�
# test for average of second period availability, and normalized S2
lambda  = Av2;
# use normalize availability
#lambda      =   Av2/Av1; #availability
#lambda  = Av3; # availability at the beggining of second period
�
# test for normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/lambda;
MKTSz = MKTSz + (cf*S2); 
�
# tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711
�
#gamma =.975; #discount factor
gamma=1/(1+.0025)^Dur1;
# create shares
shares=cbind(S1/MKTSz,S2/MKTSz);
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
shares_n=matrix(shares,nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
# parameters of heterogeneity [pi1 bp alphap betar*c] difference with main
# cat('main parameters for [pi1 bp alphap betar] are:\n')
#cbind(pi1,bpd,alphapd,betard*c)
#readline()
km   =    0.001;
shares=pmax(shares,0.00000001);   #As a precaution
Rprof("AggregLogitWHeterogen.out")
#X0 =  c(0.5,0.2,0.3,0.4);
#X0 =  c(0.1,0.1,0.1,0.1);
X0=  c(0.5,0.5,0.5,0.5);
#X0= matrix(c(0.5,0.5,0.5,0.8),nrow=1,ncol=4);
#X0= rep(0,4);
#X0= c(0.8,0.8,1,0.8);
#c(log(pi1/(1-pi1)),log(-bpd),log(-alphapd),log(-betard*c));
#options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
# no fixed effect
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRD',X0,options);
#fixed effect heterogeneity
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDFE',X0,options);
�
# heterogeneity by cost
#first optimization method
out <- nlm(FuncWithHetroWithRegrtRD , X0, hessian = TRUE,
     print.level = 2)
print(out)
fval=out$minimum;
x=out$estimate;
exitflag=out$code;
grad=out$gradient;
hessian=out$hessian;
�
#second optimization method
library(numDeriv)
out <- nlminb(X0, FuncWithHetroWithRegrtRD)
print(out);
x=out$par;
hessian <- hessian(func=FuncWithHetroWithRegrtRD, x=out$par)
�
#third Optimization Method
# method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"
#method that worked well: L-BFGS-B
#Method "L-BFGS-B" is that of Byrd et. al. (1995) which allows box constraints, that is each variable can be given a lower and/or upper bound. The initial value must satisfy the constraints. This uses a limited-memory modification of the BFGS quasi-Newton method. If non-trivial bounds are supplied, this method will be selected, with a warning.
out <- optim(X0, FuncWithHetroWithRegrtRD, method="L-BFGS-B",
             control = list(maxit = 30000, temp = 2000, trace = TRUE,
                                          REPORT = 500), hessian=T) #, fnscale=-1
x = out$par;
hessian = out$hessian;
fval = out$value;
#Fourth optimization Method: Genetic Algorithm
library(rgenoud)
out <- genoud(FuncWithHetroWithRegrtRD,  nvars=4,max=FALSE) #didn't work
�
library(DEoptim)
lower <- c(-10,-10)
upper <- -lower
�
## run DEoptim and set a seed first for replicability
#set.seed(1234)
#DEoptim(FuncWithHetroWithRegrtRD, lower, upper)
�
x = out$par;
hessian = out$hessian;
fval = out$value;
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDCH',X0,options);
cat('estimation time is:\n');
Rprof(NULL);
#params=cbind(alpha,c,bp(1,1),alpha(1,1),betar(1,1));
�
# no fixed effect simple intercept
p = 5;
betas   =  t(betas);
se_est  =  t(se_est);
a_e     =  t(betas[1,1:(p-4)]);
c_e     =  betas[1,(p-3)];
bp_e    =  betas[1,(p-2)];
alphap_e=  betas[1,(p-1)];
tt1_e   =  betas[1,p];
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*J;
ParamCovar =vcm[c(p-3,p),c(p-3,p)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
�
cat('threshold parameter for contraction mapping is:\n');
cat(km,'\n');
#cat('Seed for random generation is:\n');
#cat(SEED1);
# c bp alphap betar 
# cat('parameters estimation for: a c bp alphap betar are:\n');
# cat(cbind(t(betas[1,1:4]),betar_e),'\n');
#cat(cbind(t(betas[1,1:4]/se_est[1,1:4]),betar_e/betarSTE]),'\n');
cat('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:\n');
cat(cbind(t(betas[1,(p-3):(p-1)]),betar_e), '\n');
cat(cbind(t(se_est[1,(p-3):(p-1)]),betarSTE),'\n');
cat(cbind(t(betas[1,(p-3):(p-1)]/se_est[1,(p-3):(p-1)]),betar_e/betarSTE),'\n');
# intercept, single intercept
cat('Intercept is: \n');
cat(betas[1,(p-4)],'\n');
cat(se_est[1,(p-4)],'\n');
cat(betas[1,(p-4)]/se_est[1,(p-4)],'\n');
�
# parameters of heterogeneity [pi betap alphap betar]
ste = diag(solve(hessian));
ste = sqrt(ste);
trat = cbind(exp(x[1])/(1+exp(x[1])),t(-exp(x[2:3])/ste[2:3]));
tth1_e=-exp(x[4]);
betarh_e =tth1_e/c_e;
STEFOCh=cbind(1/c_e,-tth1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*2*J;
ParamCovarh =diag(2)*c(vcm[p-3,p-3],ste[4]^2)*(2*J);
betarSTEh=sqrt(STEFOCh%*%ParamCovarh%*%t(STEFOCh)/(2*J));
cat('parm estimates for heterogeneity (pi,bp,alphap,betar) are:\n');
cat(cbind(exp(x[1])/(1+exp(x[1])),t(-exp(x[2:3])), betarh_e),'\n');
cat(cbind(t(ste[1:3]),betarSTEh));
cat(cbind(t(trat[1:3]),betarh_e/betarSTEh));
cat('log likelihood value is:\n');
cat(-fval);
LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n'); 
�
�
# regret coefficient
#[betar; betas(1,5)/(alpha+c+gamma*c); betas(1,6)/betas(1,3);betarmean]
�
�
#se_est';
�
GMM code of Regret pricing Project:
�
rm(list = ls());
# GMM Function of full model analysis
MeisamGMMfunc = function(p){
#global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
# parameters: (bp,ah,a, c, tt)
bp = -exp(p[1]);
ah = -exp(p[2]);
a  = exp(p[3]);
c  = exp(p[4]);
tt = p[5];
v  = p[6]^2; # to make sure that variance is positive
rho = exp(p[7])/(1+exp(p[7])); # assuming autocorrelation
#rp = exp(p[7]);
�
# F.O.C is summarized to:
  # F.O.C is summarized to:
  # 1. E(D1*bp+D2*ah+C1)=0
# 2. E(D3*bp+D4*ah+C2)=0
# 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
# 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
# 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
#.*cost
�
y1 = D1*bp+C1+D2*ah; #
y2 = D3*bp+C2+D4*ah; #
y3 = -D5+a+D6*c*cost+bp*P1+D7*ah; #
y4 = -D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost;#
y5 = (-D5+a+D6*c*cost+bp*P1+D7*ah)^2-v; #
y6 = (-D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost)^2-v; #
y7 = (-D5+a+D6*c*cost+bp*P1+D7*ah)*(-D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost)-rho*v;#
sig = cbind(y1,y2,y3,y4,y5,y6,y7);
cat(dim(sig),'sigma dim\n');
sig = (t(sig)%*%sig)/J;
sig <<- (t(sig)%*%sig)/J;
cat(dim(sig),'sigma dim\n');
psi = t(cbind(mean(y1),mean(y2),mean(y3),
mean(y4),mean(y5),mean(y6),
mean(y7)));
cat(dim(psi),'dim of psi \n')
cat(dim(ginv(sig)),'dim of siginv \n')
llh = t(psi)%*%ginv(sig)%*%psi*J;
return (llh);
}
�
#global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
A  = Av2;
# normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/A;
MKTSz = MKTSz + (cf*S2); 
r=1./(1+.0025)^Dur1;
shares=cbind(S1/MKTSz,S2/MKTSz);
#normalize Market size
MKTSz=MKTSz/10000;
# put back shares so that it is used in calculation of F.O.C components
S1=shares[,1];
S2=shares[,2];
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
d=rep(1,J)-P2/P1; # (1-d)P1=P2
# F.O.C is summarized to:
# 1. E(D1*bp+D2*ah+C1)=0
# 2. E(D3*bp+D4*ah+C2)=0
# 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
# 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
# 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
# tt1=br*c
#parameters are: (bp,ah,a, c, tt1,v)
D1=S1*(P1-cost)-S1^2*(P1-cost)-r*A*(1-d)*S1*S2*(P1-cost)+r^2*A*(1-d)^2*S2*(P1-cost)-S1*S2*(1-d)*(P1-cost)*r-r^2.*A*(1-d)^2.*S2^2*(P1-cost);
D2=P1*d*S1-A*d*S1^2*P1-A*d*S1*S2*(1-d)*P1^r;
C1=S1+r*(1-d)*S2;
D3=r*A*P1*(P1-cost)*S1*S2-r^2*A*P1*(P1-cost)*(1-d)*S2+r^2*A*P1*(P1-cost)*(1-d)*S2^2;
D4=A*P1^2*S1*P1-A*S1^2*P1^2-r*A*S1*S2*(1-d)*P1^2;
C2=-r*S2*P1;
D5=shares[,1]-outside[,1];
D6=(0.5*Dur1+r*Dur2); #consider duration effect on consumption
D7=A*(P1-P2);
D8=shares[,2]-outside[,2];
D9=A*r;
D11 = A*r*Dur2*.5; #include duration of usage into the model
D10=r*(1-A)*(.5*Dur1+r*Dur2); #include duration of usage in the model
D12 =r*A*(P1-P2);#.*cost
# parameters: (bp,ah,a, c, tt, v, kt)
init_p =   c(-0.018,-0.1,0.1,0.6,-0.08,1,.5);
# c(-0.3,-3,.5,1,-0.8,20,.2);
# c(-0.018,-0.04,0.1,0.5,-0.018,10,.01);
# c(-2,-1,1,1,1,-1,1);
# c(-0.2,-0.3,0.3,0.5,0.1,1);
# rep(0,6);
# c(-0.01,-.3,0.1,0.5,0.1,1);
Rprof("GMM.out");
�
# heterogeneity by cost
#first optimization method
library(MASS)
out <- nlm(MeisamGMMfunc, init_p, hessian = TRUE,
     print.level = 2)
print(out);
fval=out$minimum;
param=out$estimate;
exitflag=out$code;
grad1=out$gradient;
hess1=out$hessian;
�
#second optimization method
library(numDeriv)
out <- nlminb(init_p, MeisamGMMfunc)
print(out);
param=out$par;
hess1<- hessian(func=MeisamGMMfunc, x=out$par)
�
#third Optimization Method
# method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"
#method that worked well: L-BFGS-B
#Method "L-BFGS-B" is that of Byrd et. al. (1995) which allows box constraints, that is each variable can be given a lower and/or upper bound. The initial value must satisfy the constraints. This uses a limited-memory modification of the BFGS quasi-Newton method. If non-trivial bounds are supplied, this method will be selected, with a warning.
out <- optim(init_p, MeisamGMMfunc, method="L-BFGS-B",
             control = list(maxit = 30000, temp = 2000, trace = TRUE,
                                          REPORT = 500), hessian=T) #, fnscale=-1
param = out$par;
hess1= out$hessian;
fval = out$value;
�
#Fourth optimization Method: Genetic Algorithm
library(rgenoud)
out <- genoud(MeisamGMMfunc,  nvars=7,max=FALSE) #didn't work
�
library(DEoptim)
lower <- c(-10,-10)
upper <- -lower
�
## run DEoptim and set a seed first for replicability
#set.seed(1234)
DEoptim(MeisamGMMfunc, lower, upper)
�
param = out$par;
hess1= out$hessian;
fval = out$value;
�
�
Rprof(NULL);
std = diag(ginv(hess1));
std = sqrt(std);
trat = cbind(t(-exp(param[1:2])),t(exp(param[3:4])))/t(std[1:4]);
cat('parm estimates and t-stat for (bp,ah,a, c, v) are: \n');
cat(cbind(t(-exp(param[1:2])),t(exp(param[3:4])),param[6]^2),'\n')
cat(cbind(t(trat[1:4]),(param(6)^2)/std[6]));
bp_e = -exp(param[1]);
ah_e = -exp(param[2]);
a_e  = exp(param[3]);
c_e  = exp(param[4]);
tt1_e = param[5];
v_e = param[6]^2;
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
ParamCovar =hess1[c(4,5),c(4,5)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
cat('stock out regret coefficient and tstat is is: \n');
cat(betar_e,'\n');
cat((betar_e/betarSTE),'\n')
cat('Auto correlation coefficient is:\n');
cat(exp(param[7]),'\n')
cat((exp(param[7])/std[7]),'\n')
LL=-fval;
p=7;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n');
�
Without heterogeneity code of Regret pricing Project:
#modified code only high price regret and stock out regret, with modified
# specification of the stock out regret
#clear workspace
rm(list = ls());
Rprof("AggregLogitNoHeterogen.out")
�
J  = 10000;
T  =  3;
P1          =   sample(1:20, J, replace=T);  #generate random integer number
discount    =   runif(J, 0, 1); #generate uniform random number
P2          =   ceiling(P1*discount);
lambda      =   runif(J, 0, 1); #availability
xi          =   matrix(rnorm(20), J,2);
�
# alpha = 2;
# c     = 0.5; 
# bp    = -0.2;
alpha   = 2*runif(1,0,1);
c       = runif(1,0,1);
bp      = runif(1,0,1);
�
gamma =.975; #discount factor
�
P  = cbind(P1, P2);
Pn = matrix(P,nrow=J*2);
# high price regret coefficient
alphap = 3*runif(1,0,1);
# stock out regret coefficient
betar = 5*runif(1,0,1);
# calculate utility
uij1 =      alpha+(c+gamma*c)+bp*P1+ alphap*lambda*(P1-P2)+ xi[,1];
uij2 =      gamma*(lambda*(alpha+c+bp*P2)+ betar*(rep(1,J)-lambda)*(c+gamma*c))+ xi[,2];
e1=exp(uij1); e2=exp(uij2);
shares=cbind(e1/(1+e1+e2),e2/(1+e1+e2));
outside=cbind(1./(1+e1+e2),1./(1+e1+e2));
�
shares_n=matrix(t(shares),nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
#data
rm(list = ls());
#global P1 P2 Dur1 Dur2 lambda gamma shares km cost %outside_n
#global vcm se_est betas variance
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
�
# test for cut off of second period
# P3=num[,13];
# P4=num[,16];
# Dur3=num[,14];
# S3=num[,15];
# S2=S3;
# P2=P4;
#Dur2=Dur3;
�
# test for average of second period availability, and normalized S2
lambda  = Av2;
# use normalize availability
#lambda      =   Av2/Av1; #availability
#lambda  = Av3; # availability at the beggining of second period
�
# test for normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/lambda;
MKTSz = MKTSz + (cf*S2); 
�
# tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711
�
#gamma =.975; #discount factor
gamma=1/(1+.0025)^Dur1;
# create shares
shares=cbind(S1/MKTSz,S2/MKTSz);
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
shares_n=matrix(shares,nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
�
#beta=cbind(alpha,c,bp);
# X1= cbind(rep(1,J),(1+gamma)*rep(1,J),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(1+gamma));
# no fixed effect and heterogeneity
# p=5;
# X1= cbind(rep(1,J),(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
#no fixed effect, but heterogeneity with market size and cost
# p=5;
# X1= cbind(rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
#no fixed effect, but heterogeneity with market size and cost (include
#cherry picking and fixed it to negative of regret coefficient)
# p=5;
# X1= cbind(rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,-gamma*lambda*(P1-P2),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
#no fixed effect, but heterogeneity only in ownership through MKTSz (include %cherry picking as separate coefficient)
#p  = 6;
#X1 = cbind(rep(0,J),rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
#X2 = cbind(gamma*lambda*(P1-P2),gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
#no fixed effect, but heterogeneity with market size and cost (include
#cherry picking as separate coefficient)
# p=6;
# X1= cbind(rep(0,J),rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*(P1-P2),gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# no fixed effect but capture effect of consumption heterogeneity value with cost
# capture hterogeneity in consumption utility using cost data
# p = 5;
# X1 = cbind(rep(1,J),(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# include heterogeneity using cost both in consumption utility and
# ownership utility
# p=5;
# X1= cbind(rep(1,J)*cost,(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*cost,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# inclusion of heterogeneity using cost only in stock out regret and
# ownership utility
# p=5;
# X1= cbind(rep(1,J)*cost,(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*cost,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# fixed effect (duration 0.5 because it is average duration of usage)
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
# fixed effect with consumption utility heterogeneity inclusion
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# fixed effect with heterogeneity of consumption in regret, but not in
# consumption utility directly 
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda, 0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# fixed effect with markdown dummy
# p=J+5;
# X1= cbind(diag(J),rep(1,J),(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,gamma*lambda,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
# including cost rather than fixed effect
#  p=6;
#  X1= cbind(rep(1,J),cost,(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
#  X2= cbind(gamma*lambda,gamma*lambda*cost,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
# fixed effect, introducing availability in the first period
# p=J+4;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(diag(J)*lambda1,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda2,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma.*Dur2));
# heterogeneity with cost, introducing availability in the first period
# p=6;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(lambda1,lambda*cost,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda2,gamma*lambda2*cost,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma*Dur2));
# no fixed effect, introducing availability in the first period
# p=5;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(lambda1,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda2,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma*Dur2));
�
X = t(cbind(X1,X2));
#Xn=matrix(X,ncol=J*2,nrow=5);
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn=log(shares_n/outside_n);
�
#OLS
betas=solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors=Yn-Xn%*%betas;
vcm=as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est=sqrt(diag(vcm));
�
#params=[alpha c bp alphap betar];
�
betas   =  t(betas);
se_est  =  t(se_est);
a_e     =  t(betas[1,1:(p-4)]);
c_e     =  betas[1,(p-3)];
bp_e    =  betas[1,(p-2)];
alphap_e=  betas[1,(p-1)];
tt1_e   =  betas[1,p];
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*J;
ParamCovar =vcm[c(p-3,p),c(p-3,p)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
#rbind(cbind(params,betas[1,1:4],betar_e),cbind(betas[1,1:4]/se_est[1,1:4],betar_e/betarSTE));
#rbind(cbind(betas[1,1:4],betar_e),cbind(betas[1,1:4]/se_est[1,1:4],betar_e/betarSTE));
# c bp alphap betar 
variance                 =    colMeans(errors^2)*2*J/(2*J-1); 
LL =    - 2*J*log(sqrt(2*pi*variance)) -   .5*sum(errors^2/variance);
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n'); 
cat('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:\n');
cat(cbind(t(betas[1,(p-3):(p-1)]),betar_e), '\n');
cat(cbind(t(se_est[1,(p-3):(p-1)]),betarSTE),'\n');
cat(cbind(t(betas[1,(p-3):(p-1)]/se_est[1,(p-3):(p-1)]),betar_e/betarSTE),'\n');
# intercept, single intercept
cat('Intercept is: \n');
cat(betas[1,(p-4)],'\n');
cat(se_est[1,(p-4)],'\n');
cat(betas[1,(p-4)]/se_est[1,(p-4)],'\n');
Rprof(NULL);
�
# for fixed effects
cat('Fixed Effects are: \n');
cat(betas[1,1:(p-4)], '\n');
cat(se_est[1,1:(p-4)],'\n');
cat(betas[1,1:(p-4)]/se_est[1,1:(p-4)],'\n');

#==============================================================
# Doc: conversion between R and MATLAB code
# List created by Meisam Hejazi Nia
# Date: 12/30/2014
#===============================================================
MATLAB,					R
===========================
gammaln(),				lgamma				
repmat(x,p,1),			t(matrix(t(rep(x,p)),ncol=p))
repmat([1:p]',1,K),		matrix(rep(c(1:p),K),ncol=K)
sum(gammaln_val,1),		colSums(gammaln_val)
return,					return(val)
psi,					psigamma
permute,				aperm
gammaln,				lngamma
find((Nc>threshold_for_N)), 		which((Nc>threshold_for_N)!=0,arr.ind = T)
sort(hp_posterior[["Nc"]], 2, 'descend'),		
			sortOutput = apply(hp_posterior[["Nc"]],sort(method = "qu", index.return = TRUE, decreasing=TRUE));      dummy=sortOutput$x;      I = sortOutput$ix
[free_energy, c] = min(new_free_energy),			
							  free_energy = min(new_free_energy);   c = which.min(new_free_energy)
fliplr,					rev
~ isfield(opts, 'collapsed_means'),		(!("collapsed_means" %in% opts))

#==============================================================
# Doc: conversion between R and MATLAB code
# List created by Meisam Hejazi Nia
# Date: 12/30/2014
#===============================================================
MATLAB,					R
===========================
gammaln(),				lgamma				
repmat(x,p,1),			t(matrix(t(rep(x,p)),ncol=p))
repmat([1:p]',1,K),		matrix(rep(c(1:p),K),ncol=K)
sum(gammaln_val,1),		colSums(gammaln_val)
return,					return(val)
psi,					psigamma
permute,				aperm
gammaln,				lngamma
find((Nc>threshold_for_N)), 		which((Nc>threshold_for_N)!=0,arr.ind = T)
sort(hp_posterior[["Nc"]], 2, 'descend'),		
			sortOutput = apply(hp_posterior[["Nc"]],sort(method = "qu", index.return = TRUE, decreasing=TRUE));      dummy=sortOutput$x;      I = sortOutput$ix
[free_energy, c] = min(new_free_energy),			
							  free_energy = min(new_free_energy);   c = which.min(new_free_energy)
fliplr,					rev
~ isfield(opts, 'collapsed_means'),		(!("collapsed_means" %in% opts))

Parallel R Loops for Windows and Linux
January 17, 2012
By�Vik Paruchuri
Parallel computation may seem difficult to implement and a pain to use, but it is actually quite simple to use. The foreach package provides the basic loop structure, which can utilize various parallel backends to execute the loop in parallel. First, let's go over the basic structure of a foreach loop. To get the foreach package, run the following command:�

install.packages("foreach")
Then, initialize the library:�

library(foreach)
A basic, nonparallel, foreach loop looks like this:�

foreach(i=1:10) %do% {

#loop contents here

}
To execute the loop in parallel, the %do% command must be replaced with %dopar%:�

foreach(i=1:10) %dopar% {

#loop contents here

}
To capture the return values of the loop:�

list<-foreach(i=1:10) %do% {
i
}
Note that the foreach loop returns a list of values by default. The foreach package will always return a result with the items in the same order as the counter, even when running in parallel. For example, the above loop will return a list with indices 1 through 10, each containing the same value as their index(1 to 10).

In order to return the results as a matrix, you will need to alter the .combine behavior of the foreach loop. This is done in the following code:�

matrix<-foreach(i=1:10,.combine=cbind) %do% {
i
}
This will return a matrix with 10 columns, with values in order from 1 to 10.

Likewise, this will return a matrix with 10 rows:�

matrix<-foreach(i=1:10,.combine=rbind) %do% {
i
}
This can be done with multiple return values to create n x k matrices. For example, this will return a 10 x 2 matrix:�

matrix<-foreach(i=1:10,.combine=rbind) %do% {
c(i,i)
}

Parallel Backends

In order to run the foreach loop in parallel(using the %dopar% command), you will need to install and register a parallel backend. Because windows does not support forking, the same backend that works a linux or an OS X environment will not work for windows. Under linux, the doMC package provides a convenient parallel backend.

Here is how to use the package(of course, you need to install doMC first):�

library(foreach)
library(doMC)
registerDoMC(2)  #change the 2 to your number of CPU cores  

foreach(i=1:10) %dopar% {

#loop contents here

}
Under windows, the doSNOW package is very convenient, although it has some issues. I do not recommend the doSMP package, as it has significant issues.�

library(doSNOW)
library(foreach)
cl<-makeCluster(2) #change the 2 to your number of CPU cores
registerDoSNOW(cl)

foreach(i=1:10) %dopar% {

#loop contents here

} 

Edit:� Thanks to an alert reader, I noticed that I neglected to add in the code to stop the clusters.� This will need to be run after you finish executing all of your parallel code if you are using doSNOW.

stopCluster(cl)
Also please note that you will need to set the parameter in the makeCluster and registerDoMC functions to the number of CPU cores that your computer possesses, or less if you do not want to use all of your CPU cores.�

I hope that this has been a good introduction to parallel loops in R. The new version of R(2.14), also includes the parallel package, which I will discuss further in a later post. You can find more information on the packages mentioned in this article on CRAN.�Foreach,�doSNOW, and�doMC�can all be found there.

Principal Components and Factor Analysis
This section covers principal components and factor analysis. The later includes both exploratory and confirmatory methods.
Principal Components
The�princomp( )�function produces an unrotated principal component analysis.
# Pricipal Components Analysis
# entering raw data and extracting PCs�
# from the correlation matrix�
fit <- princomp(mydata, cor=TRUE)
summary(fit) # print variance accounted for�
loadings(fit) # pc loadings�
plot(fit,type="lines") # scree plot�
fit$scores # the principal components
biplot(fit)
��click to view
Use�cor=FALSE�to base the principal components on the covariance matrix. Use the�covmat=�option to enter a correlation or covariance matrix directly. If entering a covariance matrix, include the optionn.obs=.
The�principal( )�function in the�psych�package can be used to extract and rotate principal components.
# Varimax Rotated Principal Components
# retaining 5 components�
library(psych)
fit <- principal(mydata, nfactors=5, rotate="varimax")
fit # print results
mydata�can be a raw data matrix or a covariance matrix. Pairwise deletion of missing data is used.rotate�can "none", "varimax", "quatimax", "promax", "oblimin", "simplimax", or "cluster" .
Exploratory Factor Analysis
The�factanal( )�function produces maximum likelihood factor analysis.
# Maximum Likelihood Factor Analysis
# entering raw data and extracting 3 factors,�
# with varimax rotation�
fit <- factanal(mydata, 3, rotation="varimax")
print(fit, digits=2, cutoff=.3, sort=TRUE)
# plot factor 1 by factor 2�
load <- fit$loadings[,1:2]�
plot(load,type="n") # set up plot�
text(load,labels=names(mydata),cex=.7) # add variable names
�click to view
The�rotation=�options include "varimax", "promax", and "none". Add the option�scores="regression" or "Bartlett" to produce factor scores. Use the�covmat=�option to enter a correlation or covariance matrix directly. If entering a covariance matrix, include the option�n.obs=.
The�factor.pa( ) function in the�psych�package offers a number of factor analysis related functions, including principal axis factoring.
# Principal Axis Factor Analysis
library(psych)
fit <- factor.pa(mydata, nfactors=3, rotation="varimax")
fit # print results
mydata�can be a raw data matrix or a covariance matrix. Pairwise deletion of missing data is used. Rotation can be "varimax" or "promax".
Determining the Number of Factors to Extract
A crucial decision in exploratory factor analysis is how many factors to extract. The�nFactors�package offer a suite of functions to aid in this decision. Details on this methodology can be found in aPowerPoint presentation�by Raiche, Riopel, and Blais. Of course, any factor solution must be interpretable to be useful.
# Determine Number of Factors to Extract
library(nFactors)
ev <- eigen(cor(mydata)) # get eigenvalues
ap <- parallel(subject=nrow(mydata),var=ncol(mydata),
��rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
�click to view
Going Further
The�FactoMineR�package offers a large number of additional functions for exploratory factor analysis. This includes the use of both quantitative and qualitative variables, as well as the inclusion of supplimentary variables and observations. Here is an example of the types of graphs that you can create with this package.
# PCA Variable Factor Map�
library(FactoMineR)
result <- PCA(mydata) # graphs generated automatically
��click to view
Thye�GPARotation�package offers a wealth of rotation options beyond varimax and promax.
Structual Equation Modeling
Confirmatory Factor Analysis�(CFA)�is a subset of the much wider�Structural Equation Modeling�(SEM)methodology. SEM is provided in�R�via the�sem�package. Models are entered via RAM specification (similar to PROC CALIS in SAS). While�sem�is a comprehensive package, my recommendation is that if you are doing significant SEM work, you spring for a copy of�AMOS. It can be much more user-friendly and creates more attractive and publication ready output. Having said that, here is a CFA example usingsem.
Assume that we have six observered variables (X1, X2, ..., X6). We hypothesize that there are two unobserved latent factors (F1, F2) that underly the observed variables as described in this diagram. X1, X2, and X3 load on F1 (with loadings lam1, lam2, and lam3). X4, X5, and X6 load on F2 (with loadings lam4, lam5, and lam6). The double headed arrow indicates the covariance between the two latent factors (F1F2). e1 thru e6 represent the residual variances (variance in the observed variables not accounted for by the two latent factors). We set the variances of F1 and F2 equal to one so that the parameters will have a scale. This will result in F1F2 representing the correlation between the two latent factors.
For�sem, we need the covariance matrix of the observed variables - thus the�cov( )�statement in the code below. The CFA model is specified using the�specify.model( )�function. The format is�arrow specification,�parameter name,�start value. Choosing a start value of NA tells the program to choose a start value rather than supplying one yourself. Note that the variance of F1 and F2 are fixed at 1 (NA in the second column). The blank line is required to end the RAM specification.
# Simple CFA Model
library(sem)
mydata.cov <- cov(mydata)
model.mydata <- specify.model()�
F1 -> �X1, lam1, NA
F1 -> �X2, lam2, NA�
F1 -> �X3, lam3, NA�
F2 -> �X4, lam4, NA�
F2 -> �X5, lam5, NA�
F2 -> �X6, lam6, NA�
X1 <-> X1, e1, ��NA�
X2 <-> X2, e2, ��NA�
X3 <-> X3, e3, ��NA�
X4 <-> X4, e4, ��NA�
X5 <-> X5, e5, ��NA�
X6 <-> X6, e6, ��NA�
F1 <-> F1, NA, ���1�
F2 <-> F2, NA, ���1�
F1 <-> F2, F1F2, NA

mydata.sem <- sem(model.mydata, mydata.cov, nrow(mydata))
# print results (fit indices, paramters, hypothesis tests)�
summary(mydata.sem)
# print standardized coefficients (loadings)�
std.coef(mydata.sem)
You can use the�boot.sem( )�function to bootstrap the structual equation model. See�help(boot.sem)�for details. Additionally, the function�mod.indices(�)�will produce modification indices. Using modification indices to improve model fit by respecifying the parameters moves you from a confirmatory to an exploratory analysis.
For more information on�sem, see�Structural Equation Modeling with the sem Package in R, by John Fox.
R FOR OCTAVE USERS
version 0.4
Copyright (C) 2001 Robin Hankin

================================
Permission is granted to make and distribute verbatim copies of this
manual provided this permission notice is preserved on all copies.

Permission is granted to copy and distribute modified versions of this
manual under the conditions for verbatim copying, provided that the entire
resulting derived work is distributed under the terms of a permission
notice identical to this one.

Permission is granted to copy and distribute translations of this manual
into another language, under the above conditions for modified versions,
except that this permission notice may be stated in a translation approved
by the Free Software Foundation.
================================


This whole thing started when I couldn't figure out the equivalent of
the octave command "plot(sort(randn(100,10)))"---which I do quite
frequently---in R.  This document shows you how to do it.

The idea is to scan down until you see an octave command you wish to
emulate in R.  The equivalent R command is given on the right hand
side (I tend to think of octave and matlab interchangeably).

I have been deliberately using octave stuff with little in the way of
explanation because I'm writing for octave experts learning R, not R
experts learning octave; so I'll assume that the octave commands will
be understood with no further explanation.

In the lines below, the octave stuff is on the left and the equivalent
R commands on the right.  If the commands are too long for that,
octave comes first then R.  Some of the examples aren't exact matches;
and where something doesn't have a vectorized equivalent I've written
"nve".

It goes without saying that I would welcome comments, suggestions,
improvements, etc.  I *think* everything works (octave 2.1.72;
R-2.2.0).

kia ora





HELP:

help -i                      help.start()
help                         help(help)
help sort                    help(sort)
                             demo()
<matlab>
lookfor plot		     apropros('plot')
			     help.search('plot')


COMPLEX NUMBERS:

3+4i			     3+4i
i			     1i		  %R treats "i" as a variable name
abs(3+4i)		     Mod(3+4i)    %but put a numeral in front
arg(3+4i)		     Arg(3+4i)			     
conj(3+4i)		     Conj(3+4i)   %get these from help(Mod)
real(3+4i)		     Re(3+4i)
imag(3+4i)		     Im(3+4i)

VECTORS; SEQUENCES:

1:10                         1:10  _or_ seq(10)
1:3:10                       seq(1,10,by=3)
10:-1:1                      10:1
10:-3:1			     seq(from=10,to=1,by= -3)
linspace(1,10,7)             seq(1,10,length=7)

(1:10)+i		     1:10+1i

VECTORS; CONCATENATION:

a=[2 3 4 5];                 a <- c(2,3,4,5)      % R output not echoed
                                                  % to the screen if assigned

a=[2 3 4 5]                  (a <- c(2,3,4,5))    % round brackets
                                                  % force echo.

adash=[2 3 4 5]' ;           adash <- t(c(2,3,4,5))

[a a]                        c(a,a)
[a a*3]                      c(a,a*3)

a.*a                         a*a
a.^3                         a^3

[1:4 a]                      c(1:4,a)


VECTORS; CONCATENATING AND REPEATING:

[1:4 1:4]                    rep(1:4,2)
[1:4 1:4 1:4]                rep(1:4,3)
<nve>                        rep(1:4,1:4)
<nve>			     rep(1:4,each=3)


VECTORS; NEGATIVE INDICES MEAN MISS THOSE ELEMENTS OUT:

a=1:100;                     a <- 1:100
a(2:100)                     a[-1]      %ie miss the first element.
a([1:9 11:100])              a[-10]     %ie miss the tenth element.
nve                          a[-seq(1,50,3)] %ie miss 1,4,7,...


VECTORS; ASSIGNMENT:

a(a>90)= -44;                a[a>90] <- -44


VECTORS; MAX AND MIN:

a=randn(1,4);		     a <- rnorm(4)
b=randn(1,4);		     b <- rnorm(4)
max(a,b)		     pmax(a,b)      %mnemonic: pairwise max.
max([a' b'])		     cbind(max(a),max(b))
max([a b])		     max(a,b)
[m i] = max(a)		     m <- max(a) ; i <- which.max(a)

"min" is analogous in R and octave.


VECTORS: RANKS

ranks(rnorm(8,1))	     rank(rnorm(8))
ranks(rnorm(randn(5,6)))     apply(matrix(rnorm(30),6),2,rank)


MATRICES:

MATRICES: RBIND AND CBIND:

[1:4 ; 1:4]               rbind(1:4,1:4)  
[1:4 ; 1:4]'              cbind(1:4,1:4)  _or_   t(rbind(1:4,1:4))

[2 3 4 5]                 c(2,3,4,5)
[2 3;4 5]                 rbind(c(2,3),c(4,5))  % rbind() binds rows;
                                                % cbind() binds cols.

[2 3;4 5]'                cbind(c(2,3),c(4,5))  _or_ matrix(2:5,2,2)
                            

a=[5 6];                  a <- c(5,6)
b=[a a;a a];              b <- rbind(c(a,a),c(a,a))   %see repmat below

[1:3 1:3 1:3 ; 1:9]       rbind(1:3, 1:9)
[1:3 1:3 1:3 ; 1:9]'      cbind(1:3, 1:9)
nve                       rbind(1:3, 1:8)


MATRICES; MATRIX AND ARRAY:

ones(4,7)                 matrix(1,4,7)  _or_  array(1,c(4,7))
ones(4,7)*9               matrix(9,4,7)  _or_  array(9,c(4,7))


MATRICES; DIAGONAL 
eye(3)			  diag(1,3)
diag([4 5 6])             diag(c(4,5,6))
diag(1:10,3)              %I don't think there is a drop-in
                          %replacement but it's easy to
                          %write a little function:

di <- function(vec,n=0) {
  l <- length(vec)
  if (n >=0) {
    return (cbind(matrix(0,l+n,n),diag(vec,l+n,l)))
  } else {
    return (t(Recall(vec, -n)))
  }
}

then di(1:10,3) works as per Octave's diag().


MATRICES; MATRIX AND ARRAY FUNCTIONS

reshape(1:6,2,3)          matrix(1:6,nrow=2)  _or_  array(1:6,c(2,3))
reshape(1:6,3,2)          matrix(1:6,ncol=2)  _or_  array(1:6,c(3,2))

reshape(1:6,3,2)'         matrix(1:6,nrow=2,byrow=T)

[reshape(1:6,3,2) reshape(1:6,3,2)]

(also see multidimensional use below)

cbind( matrix(1:6,ncol=2), matrix(1:6,ncol=2))   

a=reshape(1:36,6,6);      a <- matrix(1:36,c(6,6))
rem(a,5)                  a %% 5
a(rem(a,5)==1)= -999      a[a%%5==1] <- -999

a(:)			 as.vector(a)


MATRICES; ACCESSING ELEMENTS:

a=reshape(1:12,3,4);    a <- matrix(1:12,nrow=3)
a(2,3)                  a[2,3]
a(2,:)                  a[2, ]       %spaces optional---just miss out
                                     %the colon!
a(2:3,:)                a[-1,]       %In R, negative indices mean
a(:,[1 3 4])            a[,-2]       %leave them out.

a(:,1)                  a[ ,1]
a(:,2:4)                a[ ,-1]

a([1 3],[1 2 4]);nve    a[-2,-3]     %Negative indices still work in pairs

ASSIGNMENT:

a(:,1) = 99             a[ ,1] <- 99
a(:,1) = [99 98 97]'    a[ ,1] <- c(99,98,97)


MATRICES:  TRANSPOSE AND CONJ: 

a'                      Conj(t(a))   % Care!  Octave uses the
                                     % single quote to mean Hermitian
                                     % conjugate.
a.'			t(a)


MATRICES:  R EQUIVALENTS TO "SUM" AND "CUMSUM" ETC

a=ones(6,7)             a <- matrix(1,6,7)
sum(a)                  apply(a,2,sum)
sum(a')                 apply(a,1,sum)
sum(sum(a))             sum(a)            % In R, sum() consistently gives 
                                          % the sum of the elements of a vector

cumsum(a)               apply(a,2,cumsum) 
cumsum(a')              apply(a,1,cumsum)

a=rand(3,4);            a <- matrix(runif(12),c(3,4))
sort(a(:))              sort(a)
sort(a)                 apply(a,2,sort)
sort(a')                apply(a,1,sort)
cummax(a)               apply(a,2,cummax)



MATRICES; MAX AND MIN:

a=randn(100,4)		     a <- matrix(rnorm(400),4)
max(a)			     apply(a,1,max)
[v i] = max(a)		     v <- apply(a,1,max) ; i <- apply(a,1,which.max)

b=randn(4,4);		     b <-matrix(rnorm(16),4)
c=randn(4,4);		     c <-matrix(rnorm(16),4)
max(b,c)		     pmax(b,c)    %NB cf max(b,c) ~ max(rnorm(32))


OTHER MATRIX MANIPULATION

a=rand(3,4);            a <- matrix(runif(12),c(3,4))
fliplr(a)               a[,4:1]   (improvements anyone?)
flipud(a)               a[3:1,]

rot90(a)                %no builtin but it's easy to write a little function:
rot90 <- function(a,n=1) {
  n <- n %% 4
  if (n > 0) {
    return (Recall( t(a)[nrow(a):1,],n-1) )
  } else {
    return (a)
  }
}

a=reshape(1:9,3,3)               a <- matrix(1:9,3)
vec(a)                           as.vector(a)
vech(a)                          a[row(a) <= col(a)]


tril(a)     % no builtin but it's easy to write a little function:
tril <- function(a,i=0){a[row(a)+i<col(a)] <- 0;a}
triu <- function(a,i=0){a[row(a)+i>col(a)] <- 0;a}



EQUIVALENTS TO "SIZE" ETC

size(a)                 dim(a)


MATRICES: MATRIX- AND ELEMENTWISE- MULTIPLICATION

a=reshape(1:6,2,3);      a <- matrix(1:6,2,3)
b=reshape(1:6,3,2);      b <- matrix(1:6,3,2)
c=reshape(1:4,2,2);      c <- matrix(1:4,2,2)
v=[10 11];               v <- c(10,11)
w=[100 101 102];         w <- c(100,101,102)
x=[4 5]' ;               x <- t(c(4,5))

a*b                      a %*% b
v*a                      v %*% a
a*w'                     a %*% w 
b*v'                     b %*% v
v*x                      x %*% v  _or_  v %*% t(x)
x*v                      t(x) %*% v

v*a*w'                   v %*% a %*% w

v .* x'                  v*x  _or_  x*v
a .* [w ;w]              w * a
a .* [x x x]             a * t(rbind(x,x,x))   _or_  a*as.vector(x)


%NB:  R treats v and w as _column_ vectors by default (if there is a
choice), eg

v*c                     v %*% c
c*v'                    c %*% v


MESHGRID:

[x y]=meshgrid(1:5,10:12);

R has no builtin meshgrid() function but you can write one:

meshgrid <- function(a,b) {
  list(
       x=outer(b*0,a,FUN="+"),
       y=outer(b,a*0,FUN="+")
       )
} 

R> meshgrid(1:5,10:12)  


octave:
meshgrid(1:3,1:8)' .^ meshgrid(1:8,1:3)
_or_ [x y]=meshgrid(1:8,1:3); x.^y

R:
outer(1:3,1:8,"^")  _or_ t(meshgrid(1:3,1:8)$x^(1:8))  <cringe>


REPMAT

I don't think octave has an equivalent to matlab's repmat; and neither
does R.  Instead, R uses the much more flexible and wonderful
kronecker().  With this, repmat could be:

repmat <- function(a,n,m) {kronecker(matrix(1,n,m),a)}

then

<Matlab>
a=[1 2 ; 3 4];
repmat(a,2,3)

<R>
a <- matrix(1:4,2,byrow=T)
repmat(a,2,3)


FIND:

find(1:10 > 5.5)           which(1:10 > 5.5)

a=diag([4 5 6])            a <- diag(c(4,5,6))
find(a)                    which(a != 0)    %which() needs a Boolean argument.
[i j]=  find(a)            which(a != 0,arr.ind=T)
[i j k]=find(a)            ij <- which(a != 0,arr.ind=T); k <- a[ij]



READING FROM A FILE:

localhost:~% cat foo.txt
1 2
3 4

load foo.txt                f <- read.table("~/foo.txt")
                            f <- as.matrix(f)


WRITING TO A FILE:

save -ascii bar.txt f       write(f,file="bar.txt")


POSTSCRIPT OUTPUT

plot(1:10)
print -deps foo.eps           <matlab>

gset output "foo.eps"
gset terminal postscript eps
plot(1:10)                    <octave>                     

postscript(file="foo.eps")
plot(1:10)
dev.off ()                    <R>

EVAL

string="a=234";	              string <- "a <- 234"
eval(string)                  eval(parse(text=string))


GENERATE RANDOM NUMBERS FROM DIFFERENT DISTRIBUTIONS:

UNIFORM:

rand(10,1)                runif(10)
2+5*rand(10,1)            runif(10,min=2,max=7)  _or_   runif(10,2,7)
rand(10)                  matrix(runif(100),10)


NORMAL:

randn(10,1)               rnorm(10)
2+5*randn(10,1)           rnorm(10,2,5)
rand(10)                  matrix(rnorm(100),10)


BETA:

hist(beta_rnd(4,2,1000,1) 
hist(rbeta(1000,shape1=4,shape2=10))  _or_   hist(rbeta(1000,4,10))


PLOTTING IID RANDOM  VARIABLES:

hist(mean(binomial_rnd(10,0.4,100,500)))
hist(apply(matrix(rbinom(50000,10,0.4),nr=100),2,mean))

a=randn(100,10);          a <- matrix(rnorm(1000),nr=10)
plot(sort(a))             matplot(apply(a,1,sort),type="l")
plot(sort(mean(a)))       plot(sort(apply(a,1,mean))) 


LOOPS;   FOR:

for  i=1:5 ; disp(i) ; endfor         
for(i in 1:5) {print(i)}     %braces optional for single line statements


MULTILINE FOR STATEMENTS:

for  i=1:5
  disp(i)
  disp(i+100)
endfor                        

for(i in 1:5)
   {
    print(i)
    print(i+100)
   }


LOOPS;   WHILE:

i=0;
while i < 10
  disp(i*i)
  i++ ;
endwhile

 i <- 0
 while (i < 10) {
   print(i*i)
   i <- i+1
 }


CONDITIONALS;  IF:

if 1>0 a=100;  endif      if (1>0) a <- 100

SWITCH:

switch i                  a <- switch(as.character(i),"1"=66, "5"=77, -99)
  case 1                  
    a=66;
  case 5
    a=77;
  otherwise
    a=-99;
endswitch


POLYNOMIALS

ROOT FINDING:
roots([1 2 1])		polyroot(c(1,2,1))

polyval([1 2 1 2],1:10)

there's no direct equivalent of this in R but it's quite simple
to write one:

polyval <- function(c,x) {
   n <- length(c)
   y <- x*0+c[1];
   for (i in 2:n) {
     y <- c[i] +x*y
   }
   y
 }

so then
R> polyval(c(1,2,1,2),1:10)   should work.


SET THEORY

I'm not sure whether this lot works in Matlab or just Octave.

a = create_set([1 2 2 99 2 ])
b = create_set([2 3 4 ])
intersection(a,b)
union(a,b)
complement(a,b)
any(a == 2)

a <- sort(unique(c(1,2,2,99,2)))   
b <- sort(unique(c(2,3,4)))        
intersect(a,b)                     %note that intersect() etc call
union(a,b)                         %unique() directly.  So the four
setdiff(b,a)    %SIC               %examples here would work with
is.element(2,a)                    %a <- c(1,2,2,99,2).


DEBUGGING

keyboard                 browser() ; debug("function_name")
ans                      .Last.value        
disp(44)                 print(44)


DEFINITION OF FUNCTIONS:

matlab:
function out=h(n); out=1./(meshgrid(1:n)+ meshgrid(1:n)' -1) ;endfunction   

R:
h  <- function (n) 1/(col(diag(n))+row(diag(n))-1)
_or_ 
h <- function (n) { 1/outer(1:n,0:(n-1),"+") }



MISC PLOTTING:

a=rand(10);                    a <- array(runif(100),c(10,10))
help plot                      help (plot) _and_ methods(plot)

plot(a)                        matplot(a,type="l",lty=1)

plot(a,'r')                    matplot(a,type="l",lty=1,col="red")
plot(a,'x')                    matplot(a,pch=4)
plot(a,'--')                   matplot(a,type="l",lty=2)

plot(a,'x-')                   matplot(a,pch=4,type="b",lty=1)
plot(a,'x--')                  matplot(a,pch=4,type="b",lty=2)

semilogy(a)                    matplot(a,type="l",lty=1,log="y")
semilogx(a)                    matplot(a,type="l",lty=1,log="x")
  loglog(a)                    matplot(a,type="l",lty=1,log="xy")

plot(1:10,'r')                 plot(1:10,col="red",type="l")
hold on                        matplot(10:1,col="blue",type="l",add=T)
plot(10:-1:1,'b')

grid                           grid()


<Matlab>
plot([1:10 10:-1:1])
axis equal

<Octave>
plot([1:10 10:-1:1])
axis('equal')
replot

<R>
plot(c(1:10,10:1),asp=1)


REORDERING VECTORS:

octave:
x=randn(1,10); y=randn(1,10);
plot(x,y)
[x_sort index]=sort(x);
plot(x_sort,y(index))

R:
x <- rnorm(10) ; y <- rnorm(10)
plot(x,y,type="l")
plot(sort(x),y[order(x)],type="l")


STRAIGHT LINE FITTING:

octave:
a=randn(1,10); x=1:10;
plot(x,a,'o',x,polyval(polyfit(x,a,1),x) , '-')  

R:
a <- rnorm(10)   # generate the data
x <- 1:10        # create the x-axis 
z <- lm(a~x)     # z becomes a linear model of "a" depending on "x"
z                # see that z is just an intercept and slope
plot(a)          # er, plot(a)
abline(z)        # plot the best-fit line above.


AXES AND TITLES:

plot(1:10);xlabel("foo");ylabel("bar");title("FooBar")
matplot(1:10,type="l",xlab="foo",ylab="bar",main="FooBar",lty=1)

hist(randn(1000,1))            hist(rnorm(1000))
hist(randn(1000,1), -4:4)      hist(rnorm(1000), breaks= -4:4)
nve                            hist(rnorm(1000), breaks=  c(seq(-5,0,0.25),seq(0.5,5,0.5)),freq=F)


CONTOUR PLOTS:

a=randn(10);                  a <- matrix(rnorm(100),nr=10)

contour(a)                    contour(a)
contour(a,77)                 contour(a,nlevels=77) ; filled.contour(a)


MESH PLOTS:

mesh(rand(10))
persp(matrix(runif(100),10),theta=30,phi=30,d=1e9)



FILES AND OS

system("ls")			system("ls")
pwd				getwd()
cd				setwd()


MULTIDIMENSIONAL ARRAYS

Many of the multidimensional array manipulation functions below are
part of packages magic and abind.  At the R prompt, type
"library(magic)" to load these.

NB: many of the equivalences below are not strict: R tends to discard
singleton dimensions and octave tends to retain them.  squeeze() the
octave commands to get an exact match; the R equivalent is "drop()".
Note that many R commands return a drop()ped value by default.



a = reshape(1:24,2:4);
a <- array(1:24,2:4)   *or*  a <- 1:24 ; dim(a) <- 2:4


flipdim(a)                   arev(a,1)   % footnote 1; NB arev(a) swaps
                                         % all dimensions, not just
                                         % the first; note greater
flipdim(a,2)                 arev(a,2)   % flexibility of arev() 

rotdim(a)                    arot(a)                      
rotdim(a,1,2:3)              arot(a,1,2:3)                

vertcat(a,a,a)               abind(a,a,a,along=1)         
horzcat(a,a,a)               abind(a,a,a,along=2)         
cat(3,a,a,a)                 abind(a,a,a,along=3)         

permute(a,[2 1 3])           aperm(a,c(2,1,3))

ipermute(a,[1 3 2])          % no builtin, but it's easy
                             % to write a little function:

iperm <- function(a,p){p[p] <- 1:length(dim(a)); aperm(a,p)}
iperm(a,c(1,3,2))

any(a,1)            apply(a,2:3,any)     % octave command needs "squeeze"
any(a,3)            apply(a,1:2,any)     % for these to match exactly.


diff(a,1,1)         apply(a,2:3,diff)    % octave commands need squeeze
diff(a,1,2)         apply(a,c(1,3),diff)
diff(a,2,2)         apply(a,c(1,3),diff,differences=2)

circshift(a,1:2)    ashift(a,1:2)

shiftdim(a,1)       array(a,shift(dim(a), -1))
shiftdim(a,2)       array(a,shift(dim(a), -2))
shiftdim(a,3)       array(a,shift(dim(a), -3))

shift(a,1,1)        ashift(a,c(1,0,0))
shift(a,2,3)        ashift(a,c(0,0,2))  % note greater flexibility
                                        % of ashift()


%Sort is a bit of a problem, due to the behaviour of apply():

sort(a,1)           aperm(apply(a,c(2,3),sort),c(1,2,3))
sort(a,2)           aperm(apply(a,c(1,3),sort),c(2,1,3))
sort(a,3)           aperm(apply(a,c(1,2),sort),c(2,3,1))


It's possible to get round this by defining a little function:
asort <- function(a,i){
  j <- 1:length(dim(a))
  aperm(apply(a,j[-i],sort),append(j[-1],1,i-1))
}

Then R's asort(a,1) will return the same as Octave's sort(a,1).


<octave>
prepad(a,3,99,1)        adiag(array(0,c(1,0,0)),pad=99,a)  
postpad(a,3,99,1)       adiag(a,array(0,c(1,0,0)),pad=99)


<matlab>

# First some matrices for an easy example:
x = reshape(1:30,5,6);
x <- matrix(1:30,5,6)

padarray(x,[2 3],0)                       adiag(matrix(0,2,3),x,matrix(0,2,3))
padarray(x,[2 3],'replicate','post')      apad(x,2:3)
padarray(x,[2 3],'replicate','pre')       apad(x,2:3,post=FALSE)
padarray(x,[2 3],'replicate')             apad(apad(x,2:3),2:3,post=FALSE)


# Now back to arrays:

padarray(a,[0 3 0],'post','replicate')    apad(a,2,3)  
padarray(a,[0 3 0],'post','circular')     apad(a,2,3,method="mirror")
padarray(a,1:3,'post')                    adiag(a,array(0,1:3))

I don't see a neat way to use apad() to reproduce matlab's padarray()
when called with direction = 'both', and either padval = "circular" or
padval = "symmetric".  Nested calls to apad() don't work because the
apad()-ed array is repeated, not the original array.  If anyone needs
such functionality, let me know and I'll investigate adding it to
apad() at the cost of more compliated documentation.


footnote

(1)  Octave's flipdim() with one argument finds the first
     non-singleton dimension, and flips that.  R needs a little help
     here:  arev(a,fnsd(a)) should be formally identical to flipdim(a).

     The same applies to Octave's rotdim().   In R, use
     arot(a,fnsd(a,2)). 


READING OCTAVE FILES IN R

The "foreign" package on CRAN includes a function read.octave() which
will read octave files.  See the help page in the package for more
information.


Efficient calculation of matrix inverse in R
Have you tried what cardinal suggested and explored some of the alternative methods for computing the inverse? Let's consider a specific example:
library(MASS)

k   <- 2000
rho <- .3

S       <- matrix(rep(rho, k*k), nrow=k)
diag(S) <- 1

dat <- mvrnorm(10000, mu=rep(0,k), Sigma=S) ### be patient!

R <- cor(dat)

system.time(RI1 <- solve(R))
system.time(RI2 <- chol2inv(chol(R)))
system.time(RI3 <- qr.solve(R))

all.equal(RI1, RI2)
all.equal(RI1, RI3)
So, this is an example of a�2000�2000�correlation matrix for which we want the inverse. On my laptop (Core-i5 2.50Ghz),�solve�takes 8-9 seconds,�chol2inv(chol())�takes a bit over 4 seconds, and�qr.solve()�takes 17-18 seconds (multiple runs of the code are suggested to get stable results).
So the inverse via the Choleski decomposition is about twice as fast as�solve. There may of course be even faster ways of doing that. I just explored some of the most obvious ones here. And as already mentioned in the comments, if the matrix has a special structure, then this probably can be exploited for more speed.
Matrix element division in R

What you actually have there is a data frame. It's essentially a matrix, you're right, but you access the columns by using the column's names.
Accessing each column of the data frame can be done through a command like this:
Matrix$close
This should give you the desired data frame, if I understood your question correctly.
New_DataFrame <- data.frame(close = Matrix$close / (Matrix$close.1 * Matrix$close.2), close.1 = Matrix$close.1 / Matrix$close.2)
These operations are all done in respect to each individual row.
If you want your answer in the form of a matrix instead of a data frame, use this:
New_Matrix <- data.matrix(New_DataFrame)
And switching back to a data frame from a matrix is as easy as:
New_DataFrame <- data.frame(New_Matrix)
Hope that helps!

f�mat�is your matrix, then�mat[,1]/mat[,2]�gives you the element-wise division of each row. If�matis actually a data.frame not a matrix, then the above works, as does�mat$close/mat$close.1.
share|improve this answer

R for MATLAB users
Help
R/S-Plus
MATLAB/Octave
Description
help.start()
doc
help -i % browse with Info
Browse help interactively
help()
help help�or�doc doc
Help on using help
help(plot)�or�?plot
help plot
Help for a function
help(package='splines')
help splines�or�doc splines
Help for a toolbox/library package
demo()
demo
Demonstration examples
example(plot)

Example using a function
Searching available documentation
R/S-Plus
MATLAB/Octave
Description
help.search('plot')
lookfor plot
Search help files
apropos('plot')

Find objects by partial name
library()
help
List available packages
find(plot)
which plot
Locate functions
methods(plot)

List available methods for a function
Using interactively
R/S-Plus
MATLAB/Octave
Description
Rgui
octave -q
Start session
source('foo.R')
foo(.m)
Run code from file
history()
history
Command history
savehistory(file=".Rhistory")
diary on [..] diary off
Save command history
q(save='no')
exit�or�quit
End session
Operators
R/S-Plus
MATLAB/Octave
Description
help(Syntax)
help -
Help on operator syntax
Arithmetic operators
R/S-Plus
MATLAB/Octave
Description
a<-1; b<-2
a=1; b=2;
Assignment; defining a number
a + b
a + b
Addition
a - b
a - b
Subtraction
a * b
a * b
Multiplication
a / b
a / b
Division
a ^ b
a .^ b
Power, $a^b$
a %% b
rem(a,b)
Remainder
a %/% b

Integer division
factorial(a)
factorial(a)
Factorial, $n!$
Relational operators
R/S-Plus
MATLAB/Octave
Description
a == b
a == b
Equal
a < b
a < b
Less than
a > b
a > b
Greater than
a <= b
a <= b
Less than or equal
a >= b
a >= b
Greater than or equal
a != b
a ~= b
Not Equal
Logical operators
R/S-Plus
MATLAB/Octave
Description
a && b
a && b
Short-circuit logical AND
a || b
a || b
Short-circuit logical OR
a & b
a & b�or�and(a,b)
Element-wise logical AND
a | b
a | b�or�or(a,b)
Element-wise logical OR
xor(a, b)
xor(a, b)
Logical EXCLUSIVE OR
!a
~a�or�not(a)
~a�or�!a
Logical NOT

any(a)
True if any element is nonzero

all(a)
True if all elements are nonzero
root and logarithm
R/S-Plus
MATLAB/Octave
Description
sqrt(a)
sqrt(a)
Square root
log(a)
log(a)
Logarithm, base $e$ (natural)
log10(a)
log10(a)
Logarithm, base 10
log2(a)
log2(a)
Logarithm, base 2 (binary)
exp(a)
exp(a)
Exponential function
Round off
R/S-Plus
MATLAB/Octave
Description
round(a)
round(a)
Round
ceil(a)
ceil(a)
Round up
floor(a)
floor(a)
Round down

fix(a)
Round towards zero
Mathematical constants
R/S-Plus
MATLAB/Octave
Description
pi
pi
$\pi=3.141592$
exp(1)
exp(1)
$e=2.718281$
Missing values; IEEE-754 floating point status flags
R/S-Plus
MATLAB/Octave
Description

NaN
Not a Number

Inf
Infinity, $\infty$
Complex numbers
R/S-Plus
MATLAB/Octave
Description
1i
i
Imaginary unit
z <- 3+4i
z = 3+4i
A complex number, $3+4i$
abs(3+4i)�or�Mod(3+4i)
abs(z)
Absolute value (modulus)
Re(3+4i)
real(z)
Real part
Im(3+4i)
imag(z)
Imaginary part
Arg(3+4i)
arg(z)
Argument
Conj(3+4i)
conj(z)
Complex conjugate
Trigonometry
R/S-Plus
MATLAB/Octave
Description
atan2(b,a)
atan(a,b)
Arctangent, $\arctan(b/a)$
Generate random numbers
R/S-Plus
MATLAB/Octave
Description
runif(10)
rand(1,10)
Uniform distribution
runif(10, min=2, max=7)
2+5*rand(1,10)
Uniform: Numbers between 2 and 7
matrix(runif(36),6)
rand(6)
Uniform: 6,6 array
rnorm(10)
randn(1,10)
Normal distribution
Vectors
R/S-Plus
MATLAB/Octave
Description
a <- c(2,3,4,5)
a=[2 3 4 5];
Row vector, $1 \times n$-matrix
adash <- t(c(2,3,4,5))
adash=[2 3 4 5]';
Column vector, $m \times 1$-matrix
Sequences
R/S-Plus
MATLAB/Octave
Description
seq(10)�or�1:10
1:10
1,2,3, ... ,10
seq(0,length=10)
0:9
0.0,1.0,2.0, ... ,9.0
seq(1,10,by=3)
1:3:10
1,4,7,10
seq(10,1)�or�10:1
10:-1:1
10,9,8, ... ,1
seq(from=10,to=1,by=-3)
10:-3:1
10,7,4,1
seq(1,10,length=7)
linspace(1,10,7)
Linearly spaced vector of n=7 points
rev(a)
reverse(a)
Reverse

a(:) = 3
Set all values to same scalar value
Concatenation (vectors)
R/S-Plus
MATLAB/Octave
Description
c(a,a)
[a a]
Concatenate two vectors
c(1:4,a)
[1:4 a]

Repeating
R/S-Plus
MATLAB/Octave
Description
rep(a,times=2)
[a a]
1 2 3, 1 2 3
rep(a,each=3)

1 1 1, 2 2 2, 3 3 3
rep(a,a)

1, 2 2, 3 3 3
Miss those elements out
R/S-Plus
MATLAB/Octave
Description
a[-1]
a(2:end)
miss the first element
a[-10]
a([1:9])
miss the tenth element
a[-seq(1,50,3)]

miss 1,4,7, ...

a(end)
last element

a(end-1:end)
last two elements
Maximum and minimum
R/S-Plus
MATLAB/Octave
Description
pmax(a,b)
max(a,b)
pairwise max
max(a,b)
max([a b])
max of all values in two vectors
v <- max(a) ; i <- which.max(a)
[v,i] = max(a)

Vector multiplication
R/S-Plus
MATLAB/Octave
Description
a*a
a.*a
Multiply two vectors

dot(u,v)
Vector dot product, $u \cdot v$
Matrices
R/S-Plus
MATLAB/Octave
Description
rbind(c(2,3),c(4,5))
array(c(2,3,4,5), dim=c(2,2))
a = [2 3;4 5]
Define a matrix
Concatenation (matrices); rbind and cbind
R/S-Plus
MATLAB/Octave
Description
rbind(a,b)
[a ; b]
Bind rows
cbind(a,b)
[a , b]
Bind columns

[a(:), b(:)]
Concatenate matrices into one vector
rbind(1:4,1:4)
[1:4 ; 1:4]
Bind rows (from vectors)
cbind(1:4,1:4)
[1:4 ; 1:4]'
Bind columns (from vectors)
Array creation
R/S-Plus
MATLAB/Octave
Description
matrix(0,3,5)�or�array(0,c(3,5))
zeros(3,5)
0 filled array
matrix(1,3,5)�or�array(1,c(3,5))
ones(3,5)
1 filled array
matrix(9,3,5)�or�array(9,c(3,5))
ones(3,5)*9
Any number filled array
diag(1,3)
eye(3)
Identity matrix
diag(c(4,5,6))
diag([4 5 6])
Diagonal

magic(3)
Magic squares; Lo Shu
Reshape and flatten matrices
R/S-Plus
MATLAB/Octave
Description
matrix(1:6,nrow=3,byrow=T)
reshape(1:6,3,2)';
Reshaping (rows first)
matrix(1:6,nrow=2)
array(1:6,c(2,3))
reshape(1:6,2,3);
Reshaping (columns first)
as.vector(t(a))
a'(:)
Flatten to vector (by rows, like comics)
as.vector(a)
a(:)
Flatten to vector (by columns)
a[row(a) <= col(a)]
vech(a)
Flatten upper triangle (by columns)
Shared data (slicing)
R/S-Plus
MATLAB/Octave
Description
b = a
b = a
Copy of a
Indexing and accessing elements (Python: slicing)
R/S-Plus
MATLAB/Octave
Description
a <- rbind(c(11, 12, 13, 14),
c(21, 22, 23, 24),
c(31, 32, 33, 34))
a = [ 11 12 13 14 ...
21 22 23 24 ...
31 32 33 34 ]
Input is a 3,4 array
a[2,3]
a(2,3)
Element 2,3 (row,col)
a[1,]
a(1,:)
First row
a[,1]
a(:,1)
First column

a([1 3],[1 4]);
Array as indices
a[-1,]
a(2:end,:)
All, except first row

a(end-1:end,:)
Last two rows

a(1:2:end,:)
Strides: Every other row
a[-2,-3]

All, except row,column (2,3)
a[,-2]
a(:,[1 3 4])
Remove one column
Assignment
R/S-Plus
MATLAB/Octave
Description
a[,1] <- 99
a(:,1) = 99

a[,1] <- c(99,98,97)
a(:,1) = [99 98 97]'

a[a>90] <- 90
a(a>90) = 90;
Clipping: Replace all elements over 90
Transpose and inverse
R/S-Plus
MATLAB/Octave
Description
t(a)
a'
Transpose

a.'�or�transpose(a)
Non-conjugate transpose
det(a)
det(a)
Determinant
solve(a)
inv(a)
Inverse
ginv(a)
pinv(a)
Pseudo-inverse

norm(a)
Norms
eigen(a)$values
eig(a)
Eigenvalues
svd(a)$d
svd(a)
Singular values

chol(a)
Cholesky factorization
eigen(a)$vectors
[v,l] = eig(a)
Eigenvectors
rank(a)
rank(a)
Rank
Sum
R/S-Plus
MATLAB/Octave
Description
apply(a,2,sum)
sum(a)
Sum of each column
apply(a,1,sum)
sum(a')
Sum of each row
sum(a)
sum(sum(a))
Sum of all elements
apply(a,2,cumsum)
cumsum(a)
Cumulative sum (columns)
Sorting
R/S-Plus
MATLAB/Octave
Description

a = [ 4 3 2 ; 2 8 6 ; 1 4 7 ]
Example data
t(sort(a))
sort(a(:))
Flat and sorted
apply(a,2,sort)
sort(a)
Sort each column
t(apply(a,1,sort))
sort(a')'
Sort each row

sortrows(a,1)
Sort rows (by first row)
order(a)

Sort, return indices
Maximum and minimum
R/S-Plus
MATLAB/Octave
Description
apply(a,2,max)
max(a)
max in each column
apply(a,1,max)
max(a')
max in each row
max(a)
max(max(a))
max in array
i <- apply(a,1,which.max)
[v i] = max(a)
return indices, i
pmax(b,c)
max(b,c)
pairwise max
apply(a,2,cummax)
cummax(a)

Matrix manipulation
R/S-Plus
MATLAB/Octave
Description
a[,4:1]
fliplr(a)
Flip left-right
a[3:1,]
flipud(a)
Flip up-down

rot90(a)
Rotate 90 degrees
kronecker(matrix(1,2,3),a)
repmat(a,2,3)
kron(ones(2,3),a)
Repeat matrix: [ a a a ; a a a ]
a[lower.tri(a)] <- 0
triu(a)
Triangular, upper
a[upper.tri(a)] <- 0
tril(a)
Triangular, lower
Equivalents to "size"
R/S-Plus
MATLAB/Octave
Description
dim(a)
size(a)
Matrix dimensions
ncol(a)
size(a,2)�or�length(a)
Number of columns
prod(dim(a))
length(a(:))
Number of elements

ndims(a)
Number of dimensions
object.size(a)

Number of bytes used in memory
Matrix- and elementwise- multiplication
R/S-Plus
MATLAB/Octave
Description
a * b
a .* b
Elementwise operations
a %*% b
a * b
Matrix product (dot product)
outer(a,b)�or�a %o% b

Outer product
crossprod(a,b)�or�t(a) %*% b

Cross product
kronecker(a,b)
kron(a,b)
Kronecker product

a / b
Matrix division, $b{\cdot}a^{-1}$
solve(a,b)
a \ b
Left matrix division, $b^{-1}{\cdot}a$ \newline (solve linear equations)
Find; conditional indexing
R/S-Plus
MATLAB/Octave
Description
which(a != 0)
find(a)
Non-zero elements, indices
which(a != 0, arr.ind=T)
[i j] = find(a)
Non-zero elements, array indices
ij <- which(a != 0, arr.ind=T); v <- a[ij]
[i j v] = find(a)
Vector of non-zero values
which(a>5.5)
find(a>5.5)
Condition, indices
ij <- which(a>5.5, arr.ind=T); v <- a[ij]

Return values

a .* (a>5.5)
Zero out elements above 5.5
Multi-way arrays
R/S-Plus
MATLAB/Octave
Description

a = cat(3, [1 2; 1 2],[3 4; 3 4]);
Define a 3-way array

a(1,:,:)

File input and output
R/S-Plus
MATLAB/Octave
Description
f <- read.table("data.txt")
f = load('data.txt')
Reading from a file (2d)
f <- read.table("data.txt")
f = load('data.txt')
Reading from a file (2d)
f <- read.table(file="data.csv", sep=";")
x = dlmread('data.csv', ';')
Reading fram a CSV file (2d)
write(f,file="data.txt")
save -ascii data.txt f
Writing to a file (2d)
Plotting
Basic x-y plots
R/S-Plus
MATLAB/Octave
Description
plot(a, type="l")
plot(a)
1d line plot
plot(x[,1],x[,2])
plot(x(:,1),x(:,2),'o')
2d scatter plot

plot(x1,y1, x2,y2)
Two graphs in one plot
plot(x1,y1)
matplot(x2,y2,add=T)
plot(x1,y1)
hold on
plot(x2,y2)
Overplotting: Add new plots to current

subplot(211)
subplots
plot(x,y,type="b",col="red")
plot(x,y,'ro-')
Plotting symbols and color
Axes and titles
R/S-Plus
MATLAB/Octave
Description
grid()
grid on
Turn on grid lines
plot(c(1:10,10:1), asp=1)
axis equal
axis('equal')
replot
1:1 aspect ratio
plot(x,y, xlim=c(0,10), ylim=c(0,5))
axis([ 0 10 0 5 ])
Set axes manually
plot(1:10, main="title",
xlab="x-axis", ylab="y-axis")
title('title')
xlabel('x-axis')
ylabel('y-axis')
Axis labels and titles
Log plots
R/S-Plus
MATLAB/Octave
Description
plot(x,y, log="y")
semilogy(a)
logarithmic y-axis
plot(x,y, log="x")
semilogx(a)
logarithmic x-axis
plot(x,y, log="xy")
loglog(a)
logarithmic x and y axes
Filled plots and bar plots
R/S-Plus
MATLAB/Octave
Description
plot(t,s, type="n", xlab="", ylab="")
polygon(t,s, col="lightblue")
polygon(t,c, col="lightgreen")
fill(t,s,'b', t,c,'g')
% fill has a bug?
Filled plot
stem(x[,3])

Stem-and-Leaf plot
Functions
R/S-Plus
MATLAB/Octave
Description
f <- function(x) sin(x/3) - cos(x/5)
f = inline('sin(x/3) - cos(x/5)')
Defining functions
plot(f, xlim=c(0,40), type='p')
ezplot(f,[0,40])
fplot('sin(x/3) - cos(x/5)',[0,40])
% no ezplot
Plot a function for given range
Polar plots
R/S-Plus
MATLAB/Octave
Description

theta = 0:.001:2*pi;
r = sin(2*theta);


polar(theta, rho)

Histogram plots
R/S-Plus
MATLAB/Octave
Description
hist(rnorm(1000))
hist(randn(1000,1))

hist(rnorm(1000), breaks= -4:4)
hist(randn(1000,1), -4:4)

hist(rnorm(1000), breaks=c(seq(-5,0,0.25), seq(0.5,5,0.5)), freq=F)


plot(apply(a,1,sort),type="l")
plot(sort(a))

3d data
Contour and image plots
R/S-Plus
MATLAB/Octave
Description
contour(z)
contour(z)
Contour plot
filled.contour(x,y,z,
nlevels=7, color=gray.colors)
contourf(z); colormap(gray)
Filled contour plot
image(z, col=gray.colors(256))
image(z)
colormap(gray)
Plot image data

quiver()
Direction field vectors
Perspective plots of surfaces over the x-y plane
R/S-Plus
MATLAB/Octave
Description
f <- function(x,y) x*exp(-x^2-y^2)
n <- seq(-2,2, length=40)
z <- outer(n,n,f)
n=-2:.1:2;
[x,y] = meshgrid(n,n);
z=x.*exp(-x.^2-y.^2);

persp(x,y,z,
theta=30, phi=30, expand=0.6,
ticktype='detailed')
mesh(z)
Mesh plot
persp(x,y,z,
theta=30, phi=30, expand=0.6,
col='lightblue', shade=0.75, ltheta=120,
ticktype='detailed')
surf(x,y,z)�or�surfl(x,y,z)
% no surfl()
Surface plot
Scatter (cloud) plots
R/S-Plus
MATLAB/Octave
Description
cloud(z~x*y)
plot3(x,y,z,'k+')
3d scatter plot
Save plot to a graphics file
R/S-Plus
MATLAB/Octave
Description
postscript(file="foo.eps")
plot(1:10)
dev.off()
plot(1:10)
print -depsc2 foo.eps
gset output "foo.eps"
gset terminal postscript eps
plot(1:10)
PostScript
pdf(file='foo.pdf')

PDF
devSVG(file='foo.svg')

SVG (vector graphics for www)
png(filename = "Rplot%03d.png"
print -dpng foo.png
PNG (raster graphics)
Data analysis
Set membership operators
R/S-Plus
MATLAB/Octave
Description
a <- c(1,2,2,5,2)
b <- c(2,3,4)
a = [ 1 2 2 5 2 ];
b = [ 2 3 4 ];
Create sets
unique(a)
unique(a)
Set unique
union(a,b)
union(a,b)
Set union
intersect(a,b)
intersect(a,b)
Set intersection
setdiff(a,b)
setdiff(a,b)
Set difference
setdiff(union(a,b),intersect(a,b))
setxor(a,b)
Set exclusion
is.element(2,a)�or�2 %in% a
ismember(2,a)
True for set member
Statistics
R/S-Plus
MATLAB/Octave
Description
apply(a,2,mean)
mean(a)
Average
apply(a,2,median)
median(a)
Median
apply(a,2,sd)
std(a)
Standard deviation
apply(a,2,var)
var(a)
Variance
cor(x,y)
corr(x,y)
Correlation coefficient
cov(x,y)
cov(x,y)
Covariance
Interpolation and regression
R/S-Plus
MATLAB/Octave
Description
z <- lm(y~x)
plot(x,y)
abline(z)
z = polyval(polyfit(x,y,1),x)
plot(x,y,'o', x,z ,'-')
Straight line fit
solve(a,b)
a = x\y
Linear least squares $y = ax + b$

polyfit(x,y,3)
Polynomial fit
Non-linear methods
Polynomials, root finding
R/S-Plus
MATLAB/Octave
Description
polyroot(c(1,-1,-1))
roots([1 -1 -1])
Find zeros of polynomial

f = inline('1/x - (x-1)')
fzero(f,1)
Find a zero near $x = 1$

solve('1/x = x-1')
Solve symbolic equations

polyval([1 2 1 2],1:10)
Evaluate polynomial
Differential equations
R/S-Plus
MATLAB/Octave
Description

diff(a)
Discrete difference function and approximate derivative


Solve differential equations
Fourier analysis
R/S-Plus
MATLAB/Octave
Description
fft(a)
fft(a)
Fast fourier transform
fft(a, inverse=TRUE)
ifft(a)
Inverse fourier transform
Symbolic algebra; calculus
R/S-Plus
MATLAB/Octave
Description

factor()
Factorization
Programming
R/S-Plus
MATLAB/Octave
Description
.R
.m
Script file extension
#
%
%�or�#
Comment symbol (rest of line)
library(RSvgDevice)
% must be in MATLABPATH
% must be in LOADPATH
Import library functions
string <- "a <- 234"
eval(parse(text=string))
string='a=234';
eval(string)
Eval
Loops
R/S-Plus
MATLAB/Octave
Description
for(i in 1:5) print(i)
for i=1:5; disp(i); end
for-statement
for(i in 1:5) {
print(i)
print(i*2)
}
for i=1:5
disp(i)
disp(i*2)
end
Multiline for statements
Conditionals
R/S-Plus
MATLAB/Octave
Description
if (1>0) a <- 100
if 1>0 a=100; end
if-statement

if 1>0 a=100; else a=0; end
if-else-statement
ifelse(a>0,a,0)

Ternary operator (if?true:false)
Debugging
R/S-Plus
MATLAB/Octave
Description
.Last.value
ans
Most recent evaluated expression
objects()
whos�or�who
List variables loaded into memory
rm(x)
clear x�or�clear [all]
Clear variable $x$ from memory
print(a)
disp(a)
Print
Working directory and OS
R/S-Plus
MATLAB/Octave
Description
list.files()�or�dir()
dir�or�ls
List files in directory
list.files(pattern="\.r$")
what
List script files in directory
getwd()
pwd
Displays the current working directory
setwd('foo')
cd foo
Change working directory
system("notepad")
!notepad
system("notepad")
Invoke a System Command
Time-stamp: "2007-11-09T16:46:36 vidar"
�2006 Vidar Bronken Gundersen, /mathesaurus.sf.net
Permission is granted to copy, distribute and/or modify this document as long as the above attribution is retained.
Optimization:
Method�"SANN"�is by default a variant of simulated annealing given in Belisle (1992). Simulated-annealing belongs to the class of stochastic global optimization methods. It uses only function values but is relatively slow. It will also work for non-differentiable functions. This implementation uses the Metropolis function for the acceptance probability. By default the next candidate point is generated from a Gaussian Markov kernel with scale proportional to the actual temperature. If a function to generate a new candidate point is given, method�"SANN"�can also be used to solve combinatorial optimization problems. Temperatures are decreased according to the logarithmic cooling schedule as given in Belisle (1992, p. 890); specifically, the temperature is set to�temp / log(((t-1) %/% tmax)*tmax + exp(1)), where�t�is the current iteration step and�temp�and�tmax�are specifiable via�control, see below. Note that the�"SANN"�method depends critically on the settings of the control parameters. It is not a general-purpose method but can be very useful in getting to a good value on a very rough surface.

The default method is an implementation of that of Nelder and Mead (1965), that uses only function values and is robust but relatively slow. It will work reasonably well for non-differentiable functions.
Method�"BFGS"�is a quasi-Newton method (also known as a variable metric algorithm), specifically that published simultaneously in 1970 by Broyden, Fletcher, Goldfarb and Shanno. This uses function values and gradients to build up a picture of the surface to be optimized.
Method�"CG"�is a conjugate gradients method based on that by Fletcher and Reeves (1964) (but with the option of Polak�Ribiere or Beale�Sorenson updates). Conjugate gradient methods will generally be more fragile than the BFGS method, but as they do not store a matrix they may be successful in much larger optimization problems.
Method�"L-BFGS-B"�is that of Byrd�et. al.�(1995) which allows�box constraints, that is each variable can be given a lower and/or upper bound. The initial value must satisfy the constraints. This uses a limited-memory modification of the BFGS quasi-Newton method. If non-trivial bounds are supplied, this method will be selected, with a warning.
Nocedal and Wright (1999) is a comprehensive reference for the previous three methods.
Moving beyond R's optim function
Tried with the nlm() function already? Don't know if it's much faster, but it does improve speed. Also check the options. optim uses a slow algorithm as the default. You can gain a > 5-fold speedup by using the Quasi-Newton algorithm (method="BFGS") instead of the default. If you're not concerned too much about the last digits, you can also set the tolerance levels higher of nlm() to gain extra speed.
f <- function(x) sum((x-1:length(x))^2)

a <- 1:5

system.time(replicate(500,
     optim(a,f)
))
   user  system elapsed 
   0.78    0.00    0.79 

system.time(replicate(500,
     optim(a,f,method="BFGS")
))
   user  system elapsed 
   0.11    0.00    0.11 

system.time(replicate(500,
     nlm(f,a)
))
   user  system elapsed 
   0.10    0.00    0.09 

system.time(replicate(500,
      nlm(f,a,steptol=1e-4,gradtol=1e-4)
))
   user  system elapsed 
   0.03    0.00    0.03 
constrOptim {stats}
R Documentation
Linearly Constrained Optimization
Description
Minimise a function subject to linear inequality constraints using an adaptive barrier algorithm.
Usage
constrOptim(theta, f, grad, ui, ci, mu = 1e-04, control = list(),
            method = if(is.null(grad)) "Nelder-Mead" else "BFGS",
            outer.iterations = 100, outer.eps = 1e-05, ...,
            hessian = FALSE)
Arguments
theta
numeric (vector) starting value (of length�p): must be in the feasible region.
f
function to minimise (see below).
grad
gradient of�f�(a�function�as well), or�NULL�(see below).
ui
constraint matrix (k x p), see below.
ci
constraint vector of length�k�(see below).
mu
(Small) tuning parameter.
control, method, hessian
passed to�optim.
outer.iterations
iterations of the barrier algorithm.
outer.eps
non-negative number; the relative convergence tolerance of the barrier algorithm.
...
Other named arguments to be passed to�f�and�grad: needs to be passed through�optim�so should not match its argument names.
Details
The feasible region is defined by�ui %*% theta - ci >= 0. The starting value must be in the interior of the feasible region, but the minimum may be on the boundary.
A logarithmic barrier is added to enforce the constraints and then�optim�is called. The barrier function is chosen so that the objective function should decrease at each outer iteration. Minima in the interior of the feasible region are typically found quite quickly, but a substantial number of outer iterations may be needed for a minimum on the boundary.
The tuning parameter�mu�multiplies the barrier term. Its precise value is often relatively unimportant. As�mu�increases the augmented objective function becomes closer to the original objective function but also less smooth near the boundary of the feasible region.
Any�optim�method that permits infinite values for the objective function may be used (currently all but "L-BFGS-B").
The objective function�f�takes as first argument the vector of parameters over which minimisation is to take place. It should return a scalar result. Optional arguments�...�will be passed to�optim�and then (if not used byoptim) to�f. As with�optim, the default is to minimise, but maximisation can be performed by setting�control$fnscale�to a negative value.
The gradient function�grad�must be supplied except with�method = "Nelder-Mead". It should take arguments matching those of�f�and return a vector containing the gradient.
Value
As for�optim, but with two extra components:�barrier.value�giving the value of the barrier function at the optimum and�outer.iterations�gives the number of outer iterations (calls to�optim). The�countscomponent contains the�sum�of all�optim()$counts.
Examples
## from optim
fr <- function(x) {   ## Rosenbrock Banana function
    x1 <- x[1]
    x2 <- x[2]
    100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}
grr <- function(x) { ## Gradient of 'fr'
    x1 <- x[1]
    x2 <- x[2]
    c(-400 * x1 * (x2 - x1 * x1) - 2 * (1 - x1),
       200 *      (x2 - x1 * x1))
}

optim(c(-1.2,1), fr, grr)
#Box-constraint, optimum on the boundary
constrOptim(c(-1.2,0.9), fr, grr, ui = rbind(c(-1,0), c(0,-1)), ci = c(-1,-1))
#  x <= 0.9,  y - x > 0.1
constrOptim(c(.5,0), fr, grr, ui = rbind(c(-1,0), c(1,-1)), ci = c(-0.9,0.1))


## Solves linear and quadratic programming problems
## but needs a feasible starting value
#
# from example(solve.QP) in 'quadprog'
# no derivative
fQP <- function(b) {-sum(c(0,5,0)*b)+0.5*sum(b*b)}
Amat       <- matrix(c(-4,-3,0,2,1,0,0,-2,1), 3, 3)
bvec       <- c(-8, 2, 0)
constrOptim(c(2,-1,-1), fQP, NULL, ui = t(Amat), ci = bvec)
# derivative
gQP <- function(b) {-c(0, 5, 0) + b}
constrOptim(c(2,-1,-1), fQP, gQP, ui = t(Amat), ci = bvec)

## Now with maximisation instead of minimisation
hQP <- function(b) {sum(c(0,5,0)*b)-0.5*sum(b*b)}
constrOptim(c(2,-1,-1), hQP, NULL, ui = t(Amat), ci = bvec,
            control = list(fnscale = -1))
How to set limits using constrOptim in R?
Your constraints are of two types, either�?i?ai, or�?i?bi. The first ones are already in the right form (and the matrix�ui�is just the identity matrix), while the others can be written as�??i??bi:�ui�is then�?In�and�ci�is�?b.
# Constraints
bounds <- matrix(c(
  0,5,
  0,Inf,
  0,Inf,
  0,1
), nc=2, byrow=TRUE)
colnames(bounds) <- c("lower", "upper")

# Convert the constraints to the ui and ci matrices
n <- nrow(bounds)
ui <- rbind( diag(n), -diag(n) )
ci <- c( bounds[,1], - bounds[,2] )

# Remove the infinite values
i <- as.vector(is.finite(bounds))
ui <- ui[i,]
ci <- ci[i]

# Constrained minimization
f <- function(u) sum((u+1)^2)
constrOptim(c(1,1,.01,.1), f, grad=NULL, ui=ui, ci=ci)
We can check how the constraint matrices�ci�and�ui�are interpreted:
# Print the constraints
k <- length(ci)
n <- dim(ui)[2]
for(i in seq_len(k)) {
  j <- which( ui[i,] != 0 )
  cat(paste( ui[i,j], " * ", "x[", (1:n)[j], "]", sep="", collapse=" + " ))
  cat(" >= " )
  cat( ci[i], "\n" )
}
# 1 * x[1] >= 0 
# 1 * x[2] >= 0 
# 1 * x[3] >= 0 
# 1 * x[4] >= 0 
# -1 * x[1] >= -5 
# -1 * x[4] >= -1 
Some of the algorithms in�optim�allow you to specify the lower and upper bounds directly: that is probably easier to use.
Apply function to xts object
When you call apply with�MARGIN=1, it's like passing each row to�FUN. Your function is already vectorized, so you don't need to use�apply. However, your function does not return anything. Try this:
library(quantmod)
getSymbols("SPY", src='yahoo', from='2010-01-01', to='2012-01-01')
dat <- cbind(Ad(SPY), SMA=SMA(Ad(SPY)))
signal<-function(x,y,z)
{
     z$signals<-ifelse(x>y,1,0)
     z
}

tail(signal(dat[, 1], dat[, 2], dat))
#           SPY.Adjusted     SMA signals
#2011-12-22       124.08 121.693       1
#2011-12-23       125.19 121.805       1
#2011-12-27       125.29 122.108       1
#2011-12-28       123.64 122.361       1
#2011-12-29       124.92 122.871       1
#2011-12-30       124.31 123.276       1
Actually, I try to avoid�ifelse�in situations like these because it is slower than doing this
signal<-function(x,y,z)
{
  z$signals <- 0
  z$signals[x > y] <- 1
  z
}
DEoptim.control {DEoptim}
Control various aspects of the DEoptim implementation
Package:�
�DEoptim
Version:�
�2.2-2
Description
Allow the user to set some characteristics of the Differential Evolution optimization algorithm implemented inDEoptim.
Usage
DEoptim.control(VTR = -Inf, strategy = 2, bs = FALSE, NP = NA,
  itermax = 200, CR = 0.5, F = 0.8, trace = TRUE, initialpop = NULL,
  storepopfrom = itermax + 1, storepopfreq = 1, p = 0.2, c = 0, reltol,
  steptol, parallelType = 0, packages = c(), parVar = c(),
  foreachArgs = list())
Arguments
VTR
the value to be reached. The optimization process will stop if either the maximum number of iterationsitermax�is reached or the best parameter vector�bestmem�has found a value�fn(bestmem)�<=�VTR. Default to�-Inf.
strategy
defines the Differential Evolution strategy used in the optimization procedure:
1: DE / rand / 1 / bin (classical strategy)
2: DE / local-to-best / 1 / bin (default)
3: DE / best / 1 / bin with jitter
4: DE / rand / 1 / bin with per-vector-dither
5: DE / rand / 1 / bin with per-generation-dither
6: DE / current-to-p-best / 1
any value not above: variation to DE / rand / 1 / bin: either-or-algorithm. Default strategy is currently�2. See *Details*.
bs
if�FALSE�then every mutant will be tested against a member in the previous generation, and the best value will proceed into the next generation (this is standard trial vs. target selection). If�TRUE�then the old generation and�NP�mutants will be sorted by their associated objective function values, and the best�NPvectors will proceed into the next generation (best of parent and child selection). Default is�FALSE.
NP
number of population members. Defaults to�NA; if the user does not change the value of�NP�from�NA�or specifies a value less than 4 it is reset when�DEoptim�is called as�10*length(lower). For many problems it is best to set�NP�to be at least 10 times the length of the parameter vector.
itermax
the maximum iteration (population generation) allowed. Default is�200.
CR
crossover probability from interval [0,1]. Default to�0.5.
F
differential weighting factor from interval [0,2]. Default to�0.8.
trace
Positive integer or logical value indicating whether printing of progress occurs at each iteration. The default value is�TRUE. If a positive integer is specified, printing occurs every�trace�iterations.
initialpop
an initial population used as a starting population in the optimization procedure. May be useful to speed up the convergence. Default to�NULL. If given, each member of the initial population should be given as a row of a numeric matrix, so that�initialpop�is a matrix with�NP�rows and a number of columns equal to the length of the parameter vector to be optimized.
storepopfrom
from which generation should the following intermediate populations be stored in memory. Default toitermax�+�1, i.e., no intermediate population is stored.
storepopfreq
the frequency with which populations are stored. Default to�1, i.e., every intermediate population is stored.
p
when�strategy =�6, the top (100 * p)% best solutions are used in the mutation.�p�must be defined in (0,1].
c
c�controls the speed of the crossover adaptation. Higher values of�c�give more weight to the current successful mutations.�c�must be defined in (0,1].
reltol
relative convergence tolerance. The algorithm stops if it is unable to reduce the value by a factor ofreltol�*�(abs(val)�+�� �reltol)�after�steptol�steps. Defaults tosqrt(.Machine$double.eps), typically about�1e-8.
steptol
see�reltol. Defaults to�itermax.
parallelType
Defines the type of parallelization to employ, if any.��: The default, this uses�DEoptim�one only one core.1: This uses all available cores, via the�parallel�package, to run�DEoptim. If�parallelType=1, then thepackages�argument and the�parVar�argument need to specify the packages required by the objective function and the variables required in the environment, respectively.�2: This uses the�foreach�package for parallelism; see the�sandbox�directory in the source code for examples. If�parallelType=1, then theforeachArgs�argument can pass the options to be called with�foreach.
packages
Used if�parallelType=1; a list of package names (as strings) that need to be loaded for use by the objective function.
parVar
Used if�parallelType=1; a list of variable names (as strings) that need to exist in the environment for use by the objective function or are used as arguments by the objective function.
foreachArgs
A list of named arguments for the�foreach�function from the package�foreach. The arguments�i,.combine�and�.export�are not possible to set here; they are set internally.
Details
This defines the Differential Evolution strategy used in the optimization procedure, described below in the terms used by Price et al. (2006); see also Mullen et al. (2009) for details.
* strategy =�1: DE / rand / 1 / bin.�
This strategy is the classical approach for DE, and is described in�DEoptim.
* strategy =�2: DE / local-to-best / 1 / bin.�
In place of the classical DE mutation the expression is used, where old_i,g and best_g are the i-th member and best member, respectively, of the previous population. This strategy is currently used by default.
* strategy =�3: DE / best / 1 / bin with jitter.
In place of the classical DE mutation the expression is used, where jitter is defined as 0.0001 *�rand�+ F.
* strategy =�4: DE / rand / 1 / bin with per vector dither.
In place of the classical DE mutation the expression is used, where dither is calculated as F + \code{rand} * (1 - F).
* strategy =�5: DE / rand / 1 / bin with per generation dither.
The strategy described for�4�is used, but dither is only determined once per-generation.
* strategy =�6: DE / current-to-p-best / 1.
The top (100*p) percent best solutions are used in the mutation, where p is defined in (0,1].
* any value not above: variation to DE / rand / 1 / bin: either-or algorithm.
In the case that�rand�< 0.5, the classical strategy�strategy =�1�is used. Otherwise, the expression is used.
Several conditions can cause the optimization process to stop:
* if the best parameter vector (bestmem) produces a value less than or equal to�VTR�(i.e.�fn(bestmem)<=�VTR), or
* if the maximum number of iterations is reached (itermax), or
* if a number (steptol) of consecutive iterations are unable to reduce the best function value by a certain amount (reltol�*�� � ��(abs(val)�+�reltol)).�100*reltol�is approximately the percent change of the objective value required to consider the parameter set an improvement over the current best member.
Zhang and Sanderson (2009) define several extensions to the DE algorithm, including strategy 6, DE/current-to-p-best/1. They also define a self-adaptive mechanism for the other control parameters. This self-adaptation will speed convergence on many problems, and is defined by the control parameter�c. If�c�is non-zero, crossover and mutation will be adapted by the algorithm. Values in the range of�c=.05�to�c=.5appear to work best for most problems, though the adaptive algorithm is robust to a wide range of�c.
Values
The default value of�control�is the return value of�DEoptim.control(), which is a list (and a member of the�S3�class�DEoptim.control) with the above elements.
References
Ardia, D., Boudt, K., Carl, P., Mullen, K.M., Peterson, B.G. (2011) Differential Evolution with�DEoptim. An Application to Non-Convex Portfolio Optimization. URL�The R Journal, 3(1), 27-34. URL�http://journal.r-project.org/2011-1/.
Ardia, D., Ospina Arango, J.D., Giraldo Gomez, N.D. (2011) Jump-Diffusion Calibration using Differential Evolution. Wilmott Magazine, 55 (September), 76-79. URL�http://www.wilmott.com. Mullen, K.M, Ardia, D., Gil, D., Windover, D., Cline, J. (2011).�DEoptim:�An R Package for Global Optimization by Differential Evolution.Journal of Statistical Software, 40(6), 1-26. URL�http://www.jstatsoft.org/v40/i06/. Price, K.V., Storn, R.M., Lampinen J.A. (2006)�Differential Evolution - A Practical Approach to Global Optimization. Berlin Heidelberg: Springer-Verlag. ISBN 3540209506. Zhang, J. and Sanderson, A. (2009)�Adaptive Differential EvolutionSpringer-Verlag. ISBN 978-3-642-01526-7
Note
Further details and examples of the�R�package�DEoptim�can be found in Mullen et al. (2011) and Ardia et al. (2011a, 2011b) or look at the package's vignette by typing�vignette("DEoptim"). Also, an illustration of the package usage for a high-dimensional non-linear portfolio optimization problem is available by typingvignette("DEoptimPortfolioOptimization").
Please cite the package in publications. Use�citation("DEoptim").
See Also
DEoptim�and�DEoptim-methods.
Examples
## set the population size to 20
DEoptim.control(NP = 20)
�
## set the population size, the number of iterations and don't
## display the iterations during optimization
DEoptim.control(NP = 20, itermax = 100, trace = FALSE)
Author(s)
David Ardia, Katharine Mullen�mullenkate@gmail.com, Brian Peterson and Joshua Ulrich.
Documentation reproduced from package DEoptim, version 2.2-2. License: GPL (>= 2)
DEoptim {DEoptim}
Differential Evolution Optimization
Package:�
�DEoptim
Version:�
�2.2-2
Description
Performs evolutionary global optimization via the Differential Evolution algorithm.
Usage
DEoptim(fn, lower, upper, control = DEoptim.control(), ..., fnMap=NULL)
Arguments
fn
the function to be optimized (minimized). The function should have as its first argument the vector of real-valued parameters to optimize, and return a scalar real result.�NA�and�NaN�values are not allowed.
lower, upper
two vectors specifying scalar real lower and upper bounds on each parameter to be optimized, so that the i-th element of�lower�and�upper�applies to the i-th parameter. The implementation searches between�lower�and�upper�for the global optimum (minimum) of�fn.
control
a list of control parameters; see�DEoptim.control.
fnMap
an optional function that will be run after each population is created, but before the population is passed to the objective function. This allows the user to impose integer/cardinality constriants.
...
further arguments to be passed to�fn.
Details
DEoptim�performs optimization (minimization) of�fn.
The�control�argument is a list; see the help file for�DEoptim.control�for details.
The�R�implementation of Differential Evolution (DE),�DEoptim, was first published on the Comprehensive�RArchive Network (CRAN) in 2005 by David Ardia. Early versions were written in pure�R. Since version 2.0-0 (published to CRAN in 2009) the package has relied on an interface to a C implementation of DE, which is significantly faster on most problems as compared to the implementation in pure�R. The C interface is in many respects similar to the MS Visual C++ v5.0 implementation of the Differential Evolution algorithm distributed with the book�Differential Evolution -- A Practical Approach to Global Optimization�by Price, K.V., Storn, R.M., Lampinen J.A, Springer-Verlag, 2006, and found on-line at�http://www.icsi.berkeley.edu/~storn/. Since version 2.0-3 the C implementation dynamically allocates the memory required to store the population, removing limitations on the number of members in the population and length of the parameter vectors that may be optimized. Since version 2.2-0, the package allows for parallel operation, so that the evaluations of the objective function may be performed using all available cores. This is accomplished using either the built-in�parallel�package or the�foreach�package. If parallel operation is desired, the user should set�parallelType�and make sure that the arguments and packages needed by the objective function are available; see�DEoptim.control, the example below and examples in the sandbox directory for details. Since becoming publicly available, the package�DEoptim�has been used by several authors to solve optimization problems arising in diverse domains; see Mullen et al. (2011) for a review. To perform a maximization (instead of minimization) of a given function, simply define a new function which is the opposite of the function to maximize and apply�DEoptim�to it. To integrate additional constraints (other than box constraints) on the parameters�x�of�fn(x), for instance�x[1]�+�x[2]^2�<�2, integrate the constraint within the function to optimize, for instance:
     fn <- function(x){       if (x[1] + x[2]^2 >= 2){         r <- Inf       else{         ...       }       return(r)     }   
This simplistic strategy usually does not work all that well for gradient-based or Newton-type methods. It is likely to be alright when the solution is in the interior of the feasible region, but when the solution is on the boundary, optimization algorithm would have a difficult time converging. Furthermore, when the solution is on the boundary, this strategy would make the algorithm converge to an inferior solution in the interior. However, for methods such as DE which are not gradient based, this strategy might not be that bad.
Note that�DEoptim�stops if any�NA�or�NaN�value is obtained. You have to redefine your function to handle these values (for instance, set�NA�to�Inf�in your objective function).
It is important to emphasize that the result of�DEoptim�is a random variable, i.e., different results may be obtained when the algorithm is run repeatedly with the same settings. Hence, the user should set the random seed if they want to reproduce the results, e.g., by setting�set.seed(1234)�before the call ofDEoptim.
DEoptim�relies on repeated evaluation of the objective function in order to move the population toward a global minimum. Users interested in making�DEoptim�run as fast as possible should consider using the package in parallel mode (so that all CPU's available are used), and also ensure that evaluation of the objective function is as efficient as possible (e.g. by using vectorization in pure�R�code, or writing parts of the objective function in a lower-level language like C or Fortran). Further details and examples of the�Rpackage�DEoptim�can be found in Mullen et al. (2011) and Ardia et al. (2011a, 2011b) or look at the package's vignette by typing�vignette("DEoptim"). Also, an illustration of the package usage for a high-dimensional non-linear portfolio optimization problem is available by typingvignette("DEoptimPortfolioOptimization"). Please cite the package in publications. Usecitation("DEoptim").
Values
The output of the function�DEoptim�is a member of the�S3�class�DEoptim. More precisely, this is a list (of length 2) containing the following elements:
optim, a list containing the following elements:
* bestmem: the best set of parameters found.
* bestval: the value of�fn�corresponding to�bestmem.
* nfeval: number of function evaluations.
* iter: number of procedure iterations.
member, a list containing the following elements:
* lower: the lower boundary.
* upper: the upper boundary.
* bestvalit: the best value of�fn�at each iteration.
* bestmemit: the best member at each iteration.
* pop: the population generated at the last iteration.
* storepop: a list containing the intermediate populations.
Members of the class�DEoptim�have a�plot�method that accepts the argument�plot.type.
plot.type =�"bestmemit"�results in a plot of the parameter values that represent the lowest value of the objective function each generation.�plot.type =�"bestvalit"�plots the best value of the objective function each generation. Finally,�plot.type =�"storepop"�results in a plot of stored populations (which are only available if these have been saved by setting the�control�argument of�DEoptim�appropriately). Storing intermediate populations allows us to examine the progress of the optimization in detail. A summary method also exists and returns the best parameter vector, the best value of the objective function, the number of generations optimization ran, and the number of times the objective function was evaluated.
References
Differential Evolution homepage: URL�http://www.icsi.berkeley.edu/~storn/code.html.
Ardia, D., Boudt, K., Carl, P., Mullen, K.M., Peterson, B.G. (2011) Differential Evolution with�DEoptim. An Application to Non-Convex Portfolio Optimization.�The R Journal, 3(1), 27-34. URL�http://journal.r-project.org/2011-1/.
Ardia, D., Ospina Arango, J.D., Giraldo Gomez, N.D. (2011) Jump-Diffusion Calibration using Differential Evolution.�Wilmott Magazine, 55 (September), 76-79. URL�http://www.wilmott.com. Mitchell, M. (1998)�An Introduction to Genetic Algorithms. The MIT Press. ISBN 0262631857.
Mullen, K.M, Ardia, D., Gil, D., Windover, D., Cline, J. (2011).�DEoptim:�An R Package for Global Optimization by Differential Evolution.�Journal of Statistical Software, 40(6), 1-26. URLhttp://www.jstatsoft.org/v40/i06/.
Price, K.V., Storn, R.M., Lampinen J.A. (2006)�Differential Evolution - A Practical Approach to Global Optimization. Berlin Heidelberg: Springer-Verlag. ISBN 3540209506.
Storn, R. and Price, K. (1997) Differential Evolution -- A Simple and Efficient Heuristic for Global Optimization over Continuous Spaces,�Journal of Global Optimization, 11:4, 341--359.
Note
Differential Evolution�(DE) is a search heuristic introduced by Storn and Price (1997). Its remarkable performance as a global optimization algorithm on continuous numerical minimization problems has been extensively explored; see Price et al. (2006). DE belongs to the class of genetic algorithms which use biology-inspired operations of crossover, mutation, and selection on a population in order to minimize an objective function over the course of successive generations (see Mitchell, 1998). As with other evolutionary algorithms, DE solves optimization problems by evolving a population of candidate solutions using alteration and selection operators. DE uses floating-point instead of bit-string encoding of population members, and arithmetic operations instead of logical operations in mutation. DE is particularly well-suited to find the global optimum of a real-valued function of real-valued parameters, and does not require that the function be either continuous or differentiable.
Let NP denote the number of parameter vectors (members) x in R^d in the population. In order to create the initial generation, NP guesses for the optimal value of the parameter vector are made, either using random values between lower and upper bounds (defined by the user) or using values given by the user. Each generation involves creation of a new population from the current population members {x_i | i=1,...,NP}, where i indexes the vectors that make up the population. This is accomplished using�differential mutation�of the population members. An initial mutant parameter vector v_i is created by choosing three members of the population, x_{r_0}, x_{r_1} and x_{r_2}, at random. Then v_i is generated as
v_i := x_{r_0} + F * (x_{r_1} - x_{r_2})
where F is the differential weighting factor, effective values for which are typically between 0 and 1. After the first mutation operation, mutation is continued until d mutations have been made, with a crossover probability CR in [0,1]. The crossover probability CR controls the fraction of the parameter values that are copied from the mutant. If an element of the trial parameter vector is found to violate the bounds after mutation and crossover, it is reset in such a way that the bounds are respected (with the specific protocol depending on the implementation). Then, the objective function values associated with the children are determined. If a trial vector has equal or lower objective function value than the previous vector it replaces the previous vector in the population; otherwise the previous vector remains. Variations of this scheme have also been proposed; see Price et al. (2006) and�DEoptim.control.
Intuitively, the effect of the scheme is that the shape of the distribution of the population in the search space is converging with respect to size and direction towards areas with high fitness. The closer the population gets to the global optimum, the more the distribution will shrink and therefore reinforce the generation of smaller difference vectors.
As a general advice regarding the choice of NP, F and CR, Storn et al. (2006) state the following: Set the number of parents NP to 10 times the number of parameters, select differential weighting factor F = 0.8 and crossover constant CR = 0.9. Make sure that you initialize your parameter vectors by exploiting their full numerical range, i.e., if a parameter is allowed to exhibit values in the range [-100, 100] it is a good idea to pick the initial values from this range instead of unnecessarily restricting diversity. If you experience misconvergence in the optimization process you usually have to increase the value for NP, but often you only have to adjust F to be a little lower or higher than 0.8. If you increase NP and simultaneously lower F a little, convergence is more likely to occur but generally takes longer, i.e., DE is getting more robust (there is always a convergence speed/robustness trade-off).
DE is much more sensitive to the choice of F than it is to the choice of CR. CR is more like a fine tuning element. High values of CR like CR = 1 give faster convergence if convergence occurs. Sometimes, however, you have to go down as much as CR = 0 to make DE robust enough for a particular problem. For more details on the DE strategy, we refer the reader to Storn and Price (1997) and Price et al. (2006).
See Also
DEoptim.control�for control arguments,�DEoptim-methods�for methods on�DEoptim�objects, including some examples in plotting the results;�optim�or�constrOptim�for alternative optimization algorithms.
Examples
## Rosenbrock Banana function
  ## The function has a global minimum f(x) = 0 at the point (1,1).  
  ## Note that the vector of parameters to be optimized must be the first 
  ## argument of the objective function passed to DEoptim.
  Rosenbrock <- function(x){
    x1 <- x[1]
    x2 <- x[2]
    100 * (x2 - x1 * x1)^2 + (1 - x1)^2
  }
�
  ## DEoptim searches for minima of the objective function between
  ## lower and upper bounds on each parameter to be optimized. Therefore
  ## in the call to DEoptim we specify vectors that comprise the
  ## lower and upper bounds; these vectors are the same length as the
  ## parameter vector.
  lower <- c(-10,-10)
  upper <- -lower
�
  ## run DEoptim and set a seed first for replicability
  set.seed(1234)
  DEoptim(Rosenbrock, lower, upper)
�
  ## increase the population size
  DEoptim(Rosenbrock, lower, upper, DEoptim.control(NP = 100))
�
  ## change other settings and store the output
  outDEoptim <- DEoptim(Rosenbrock, lower, upper, DEoptim.control(NP = 80,
                        itermax = 400, F = 1.2, CR = 0.7))
�
  ## plot the output
  plot(outDEoptim)
�
  ## 'Wild' function, global minimum at about -15.81515
  Wild <- function(x)
    10 * sin(0.3 * x) * sin(1.3 * x^2) +
       0.00001 * x^4 + 0.2 * x + 80
�
  plot(Wild, -50, 50, n = 1000, main = "'Wild function'")
�
  outDEoptim <- DEoptim(Wild, lower = -50, upper = 50,
                        control = DEoptim.control(trace = FALSE))
�
  plot(outDEoptim)
�
  DEoptim(Wild, lower = -50, upper = 50,
          control = DEoptim.control(NP = 50))
�
  ## The below examples shows how the call to DEoptim can be
  ## parallelized; see the sandbox directory in the source
  ## code for additional examples.
  ## Note that if your objective function requires packages to be
  ## loaded or has arguments supplied via \code{...}, these should be
  ## specified using the \code{packages} and \code{parVar} arguments
  ## in control.  
�
## Not run: 
�
  Genrose <- function(x) {
     ## One generalization of the Rosenbrock banana valley function (n parameters)
     n <- length(x)
     ## make it take some time ... 
     Sys.sleep(.001) 
     1.0 + sum (100 * (x[-n]^2 - x[-1])^2 + (x[-1] - 1)^2)
  }
�
  # get some run-time on simple problems
  maxIt <- 250                     
  n <- 5
�
  oneCore <- system.time( DEoptim(fn=Genrose, lower=rep(-25, n), upper=rep(25, n),
                   control=list(NP=10*n, itermax=maxIt)))
�
  withParallel <-  system.time( DEoptim(fn=Genrose, lower=rep(-25, n), upper=rep(25, n),
                   control=list(NP=10*n, itermax=maxIt, parallelType=1)))
�
  ## Compare timings 
  (oneCore)
  (withParallel)
 ## End(Not run)
Author(s)
David Ardia, Katharine Mullen�mullenkate@gmail.com, Brian Peterson and Joshua Ulrich.
nlm {stats}
R Documentation
Non-Linear Minimization
Description
This function carries out a minimization of the function�f�using a Newton-type algorithm. See the references for details.
Usage
nlm(f, p, hessian = FALSE, typsize=rep(1, length(p)), fscale=1,
    print.level = 0, ndigit=12, gradtol = 1e-6,
    stepmax = max(1000 * sqrt(sum((p/typsize)^2)), 1000),
    steptol = 1e-6, iterlim = 100, check.analyticals = TRUE, ...)
Arguments
f
the function to be minimized. If the function value has an attribute called�gradient�or both�gradient�and�hessian�attributes, these will be used in the calculation of updated parameter values. Otherwise, numerical derivatives are used.�deriv�returns a function with suitable�gradient�attribute. This should be a function of a vector of the length of�p�followed by any other arguments specified by the�...�argument.
p
starting parameter values for the minimization.
hessian
if�TRUE, the hessian of�f�at the minimum is returned.
typsize
an estimate of the size of each parameter at the minimum.
fscale
an estimate of the size of�f�at the minimum.
print.level
this argument determines the level of printing which is done during the minimization process. The default value of�0�means that no printing occurs, a value of�1�means that initial and final details are printed and a value of 2 means that full tracing information is printed.
ndigit
the number of significant digits in the function�f.
gradtol
a positive scalar giving the tolerance at which the scaled gradient is considered close enough to zero to terminate the algorithm. The scaled gradient is a measure of the relative change in�f�in each direction�p[i]�divided by the relative change in�p[i].
stepmax
a positive scalar which gives the maximum allowable scaled step length.�stepmax�is used to prevent steps which would cause the optimization function to overflow, to prevent the algorithm from leaving the area of interest in parameter space, or to detect divergence in the algorithm.�stepmax�would be chosen small enough to prevent the first two of these occurrences, but should be larger than any anticipated reasonable step.
steptol
A positive scalar providing the minimum allowable relative step length.
iterlim
a positive integer specifying the maximum number of iterations to be performed before the program is terminated.
check.analyticals
a logical scalar specifying whether the analytic gradients and Hessians, if they are supplied, should be checked against numerical derivatives at the initial parameter values. This can help detect incorrectly formulated gradients or Hessians.
...
additional arguments to�f.
Details
If a gradient or hessian is supplied but evaluates to the wrong mode or length, it will be ignored if�check.analyticals = TRUE�(the default) with a warning. The hessian is not even checked unless the gradient is present and passes the sanity checks.
From the three methods available in the original source, we always use method �1� which is line search.
Value
A list containing the following components:
minimum
the value of the estimated minimum of�f.
estimate
the point at which the minimum value of�f�is obtained.
gradient
the gradient at the estimated minimum of�f.
hessian
the hessian at the estimated minimum of�f�(if requested).
code
an integer indicating why the optimization process terminated.
1:
relative gradient is close to zero, current iterate is probably solution.
2:
successive iterates within tolerance, current iterate is probably solution.
3:
last global step failed to locate a point lower than�estimate. Either�estimate�is an approximate local minimum of the function or�steptol�is too small.
4:
iteration limit exceeded.
5:
maximum step size�stepmax�exceeded five consecutive times. Either the function is unbounded below, becomes asymptotic to a finite value from above in some direction or�stepmax�is too small.
iterations
the number of iterations performed.
References
Dennis, J. E. and Schnabel, R. B. (1983)�Numerical Methods for Unconstrained Optimization and Nonlinear Equations.�Prentice-Hall, Englewood Cliffs, NJ.
Schnabel, R. B., Koontz, J. E. and Weiss, B. E. (1985) A modular system of algorithms for unconstrained minimization.�ACM Trans. Math. Software,�11, 419�440.
See Also
optim�and�nlminb.
constrOptim�for constrained optimization,�optimize�for one-dimensional minimization and�uniroot�for root finding.�deriv�to calculate analytical derivatives.
For nonlinear regression,�nls�may be better.
Examples
f <- function(x) sum((x-1:length(x))^2)
nlm(f, c(10,10))
nlm(f, c(10,10), print.level = 2)
str(nlm(f, c(5), hessian = TRUE))

f <- function(x, a) sum((x-a)^2)
nlm(f, c(10,10), a=c(3,5))
f <- function(x, a)
{
    res <- sum((x-a)^2)
    attr(res, "gradient") <- 2*(x-a)
    res
}
nlm(f, c(10,10), a=c(3,5))

## more examples, including the use of derivatives.
## Not run: demo(nlm)
A comparison of some heuristic optimization methods
Posted on�2012/07/23�by�Pat
A simple�portfolio optimization�problem is used to look at several R functions that use randomness in various ways to do optimization.
Orientation
Some optimization problems are really hard. In these cases sometimes the best approach is to use randomness to get an approximate answer.
Once you decide to go down this route, you need to decide on two things:
* how to formulate the problem you want to solve
* what algorithm to use
These decisions should seldom be taken independently. The best algorithm may well depend on the formulation, and how you formulate the problem may well depend on the algorithm you use.
The heuristic algorithms we will look at mostly fall into three broad categories:
* simulated annealing
* traditional genetic algorithm
* evolutionary algorithms
Genetic algorithms and evolutionary algorithms are really the same thing, but have different ideas about specifics.
The�Portfolio Probe optimization algorithm�is a blend of these traditions plus additional techniques.
The test case
The problem is to maximize a mean-variance utility where the universe is 10 assets and we have the constraints that the portfolio is long-only (weights must be non-negative), the weights must sum to 1, and there can be at most 5 assets in the portfolio.
In terms of portfolio optimization this is a tiny and overly trivial problem.� Portfolio Probe solves this problem consistently to 6 decimal places in about the same time as the algorithms tested here.
Actually there are two problems.� The variance matrix is the same in both but there are two expected return vectors. In one the optimal answer contains only 3 assets so the integer constraint of at most 5 is non-binding.� In the other case the integer constraint is binding.
Formulation
What we really want is a vector of length 10 with non-negative numbers that sum to 1 and at most 5 positive numbers. The tricky part is how to specify which five of the ten are to be allowed to be positive.
The solution used here is to optimize a vector that is twice as long as the weight vector � 20 in this case.� The second half of the vector holds the weights (which are not normalized to sum to 1).� The first half of the vector holds numbers that order the assets by their desirability to be in the portfolio.� So the assets with the five largest numbers in this first half are allowed to have positive weights.
The first half of the solution vector tells us which assets are to be included in the portfolio.� Then the weight vector is prepared: it is extracted from the solution vector, the weights for assets outside the portfolio are set to zero, and the weights are normalized to sum to 1.
The original intention was that all the numbers in the solution vector should be between 0 and 1.� However, not all of the optimizers support such constraints.� The constraint of being less than 1 is purely arbitrary anyway.� We�ll see an interesting result related to this.
The optimizers
Here are the R packages or functions that appear. If you are looking for optimization routines in R, then have a look at the�optimization task view.
Rmalschains package
The�Rmalschains package�has the�malschains�function.� The name stands for �memetic algorithm with local search chains�.� I haven�t looked but I suspect it has substantial similarities with�genopt.
GenSA package
The�GenSA package�implements a generalized simulating annealing.
genopt function
The�genopt�function is the horse that I have in the race. It is not in a package, but you can source the�genopt.R�file to use it. You can get a sense of how to use it from�S Poetry. The line of thinking that went into it can be found in��An Introduction to Genetic Algorithms�.
DEoptim package
The�DEoptim package�implements a differential evolutionary algorithm.
soma package
The�soma package�gives us a self-organizing migrating algorithm.
rgenoud package
The�rgenoud package�implements an algorithm that combines a genetic algorithm and derivative-based optimization.
GA package
The�GA package�is a reasonably complete implementation in the realm of genetic algorithms.
NMOF package
The�NMOF package�contains a set of functions that are introductory examples of various algorithms. This package is support for the book�Numerical Methods and Optimization in Finance.
The optimizers that this package contributes to the race are:
* DEopt � another implementation of the differential evolutionary algorithm
* LSopt � local stochastic search, which is very much like simulated annealing
* TAopt � threshold accepting algorithm, another relative of simulated annealing
SANN method of optim function
optim(method="SANN", ...)�does a simulated annealing optimization.
The results
Each optimizer was run 100 times on each of the two problems.� The computational time and the utility achieved was recorded for each run.� One or more control parameters were adjusted so that the typical run took about a second on my machine (which is about 3 years old and running Windows 7).
The figures show the difference in utilities between the runs and the optimal solution as found by Portfolio Probe.� The optimizers are sorted by the median deficiency.
Figure 1: Difference in utility from optimal for all optimizers on the non-binding problem.
Figure 2: Difference in utility from optimal for all optimizers on the binding problem.We can characterize the results as: evolutionary better than genetic better than simulated annealing.� With one big exception.��GenSA�� which hails from simulated annealing land � does very well.
I�m guessing that�genoud�would have done better if the differentiation were applied only to the weights and not the first part of the solution vector.
The other thing of note is that�DEoptim�is a more robustly developed version of differential evolution than is�DEopt.� However,�DEopt�outperforms�DEoptim.��DEoptdoes not have box constraints, so its solution vectors grow in size as the algorithm progresses.� This seems to make the problem easier. A weakness of�DEopt�turned out to be a strength.
Figures 3 and 4 show the results for the six best optimizers � same picture, different scale.
Figure 3: Difference in utility from optimal for the best optimizers on the non-binding problem.
Figure 4: Difference in utility from optimal for the best optimizers on the binding problem.
Update 2012/07/26
This update shows an advantage of heuristic algorithms that I was hoping I wouldn�t teach.
Randomization, for better or worse, often compensates for bugs.
� Jon Bentley�More Programming Pearls�(page 32)
Even though the code was not doing anything close to its intended behavior, the algorithms still managed to move towards the optimum.
Luca� Scrucca spotted that I used�order�when I meant�rank.� I have re-run the race with the new version.� There are two changes in the new race:
* the right code makes it easier for the optimizers
* the new code is slower, so the optimizers get fewer evalations
I adjusted control arguments so that about a second on my machine would be used for each run.� Since�rank�is significantly slower than�order�in this case (see��R Inferno-ism: order is not rank�), only about one-quarter to one-third as many evaluations were allowed.
(By the way, I�m rather suspicious of the timings � they seem to jump around a bit too much.� It is a Windows machine.)
The new pictures are in Figures 5 and 6.
Figure 5: Difference in utility from optimal for all optimizers on the non-binding problem with the revised code.�
Figure 6: Difference in utility from optimal for all optimizers on the binding problem with the revised code.�
The results that look good in Figures 5 and 6 generally look good under a microscope as well � there are a lot of results that are essentially perfect.
The revised functions are in�heuristicfuns_rev.R�while the results from the second race are�testresults10rev.R�and the original results are�testresults10.R.
Caveat
You should never (ever) think that you understand the merits of optimizers from one example.
I have no doubt that very different results could be obtained by modifying the control parameters of the optimizers.� In particular the results are highly dependent on the time allowed.� Some optimizers will be good at getting approximately right but not good at homing in on the exact solution � these will look good when little time is allowed.� Other algorithms will be slow to start but precise once they are in the neighborhood � these will look good when a lot of time is allowed.
For genetic and evolutionary algorithms there is a big interaction between time allowed and population size.� A small population will get a rough approximation fast.� A large population will optimize much slower but (generally) achieve a better answer in the end.
Exact circumstances are quite important regarding which optimizer is best.
Summary
If your problem is anything like this problem, then the�Rmalschains�and�GenSApackages are worth test driving.
See also
* (update 2012 August 20)�Another comparison of heuristic optimizers
Appendix R
The functions that ran the optimizers plus the code and data for the problems are in�heuristic_objs.R.� (The 10a problem is non-binding and 10s is binding.)
The objective achieved by Portfolio for the non-binding problem is -0.38146061845033 and for the binding problem it is -1.389656885372.
In case you want to test routines on these problems outside R: the variance is invariance10.csv�and the two expected return vectors are in�expectedreturns10.csv.


CLC: Ctrl+L
�
Tobit:
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
�
#First models (frequentist)
#Gausian OLS
GOLSfit<-lm(d ~vc)
summary(GOLSfit)
�
#poisson regression
Poisfit <- glm(d ~ vc, family=poisson())
summary(Poisfit)
�
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
�
�
#binary probit (i number of starst at specific level)
fit<-glm( stari~x, family=binomial(link=probit))
summary(fit)
�
#binary logit
fit<-glm(stari~x,family=binomial())
summary(fit)
#models (Bayesian)
�
dc<-cbind(1,dc)
#Gausian linear regression
�
#Tobit
�
#ordinary probit
�
#Binary probit
�
#binary Logit
�
library(survival)
example(tobin)
summary(tfit)
tfit.mcmc <- MCMCtobit(durable ~ age + quant, data=tobin, mcmc=30000,
verbose=1000)
plot(tfit.mcmc)
raftery.diag(tfit.mcmc)
summary(tfit.mcmc)
�
Logit:
n=1000;
k=4;
rn<-runif(n*(k-1), min=0, max=1);
x<-matrix(rn,k-1,n);
xint=rbind(rep(1,n),x); # alternative: cbind(1,cov)
beta=c(1,-1,2);
s2=1;
y=rep(0,n);
zt=rep(0,n);
xint=t(xint);
x=t(x);
for (i in 1:n){
 u=runif(1,min=0,max=1);
 ei=sqrt(s2)*log(u/(1-u));
 zti=xint %*% beta + ei;
 zt[i]=zti;
 if (zti>0) y[i]=1;
}
library(mcmc)
out<-glm(y~x,family=binomial())
summary(out);
# intrcpt= 2.98 x1=NA x2=-0.2241 x3=-0.5037
x<-cbind(1,x);
lupost<-function(beta,x,y){
eta <- x%*%beta
p<-1/(1+exp(-eta))
logl<-sum(log(p[y==1]))+sum(log(1-p[y==0]))
return(logl+sum(dnorm(beta,0,2,log=TRUE)))
}
set.seed(42)
beta.init <- as.numeric(coefficients(out))
out <- metrop(lupost, beta.init, 1000, x=x, y=y)
names(out)
out$accept
out <-metrop(out, scale=0.1, x=x,y=y);
out$accept
out <- metrop(out, scale = 0.3, x = x, y = y)
out$accept
out <- metrop(out, scale = 0.5, x = x, y = y)
out$accept
out <- metrop(out, scale = 0.4, x = x, y = y)
out$accept
out <- metrop(out, nbatch = 10000, x = x, y = y)
out$accept
out$time
plot(ts(out$batch))
acf(out$batch)
�
�
�
�
# library code
library(mcmc)
data(logit)
out<-glm(y~x1+x2+x3+x4,data=logit, family=binomial());
summary(out);
x<-logit;
x$y<-NULL;
x<-as.matrix(x);
x<-cbind(1,x);
dimnames(x)<-NULL;
y<-logit$y;
lupost<-function(beta,x,y){
eta <- x%*%beta
p<-1/(1+exp(-eta))
logl<-sum(log(p[y==1]))+sum(log(1-p[y==0]))
return(logl+sum(dnorm(beta,0,2,log=TRUE)))
}
set.seed(42)
beta.init <- as.numeric(coefficients(out))
out <- metrop(lupost, beta.init, 1000, x=x, y=y)
names(out)
out$accept
�
#clear workspace
rm(list = ls());
rm(list = ls()[grep("^tmp", ls())])
rm(list=ls(pattern="^tmp"))
rm(list = grep("^paper", ls(), value = TRUE, invert = TRUE))
�
Pasted from <http://stackoverflow.com/questions/11761992/remove-data-from-workspace> 
�
Statistical inference Homework:
retailSales<-read.csv("d:/HW12TS.csv",header=T) # read whole data
# from Jan 1955 to Dec 1975 as a time series object
rsts <- ts(retailSales, start=c(1955, 1), end=c(1977, 12), frequency=12) 
#excluding last two years
rtsm <- window(rsts, start=c(1955,1), end=c(1975,12))
#plot time series
plot(rsts)
plot.ts(rtsm)
#convert to additive
lrtsm <- log(rtsm)
plot.ts(lrtsm)
# Decomposition
library("TTR")
lrtsm6 <- SMA(lrtsm,n=6)
plot.ts(lrtsm6)
lrtsm12 <- SMA(lrtsm,n=12)
plot.ts(lrtsm12)
#Decomposition
lrtsmcomp<- decompose(lrtsm)
# Holt winter exponential smoothing
lrtsmforecast<- HoltWinters(lrtsm, beta=FALSE, gamma=FALSE)
lrtsmforecast$SSE
# forecast without data
library("forecast")
hwfwd <- forecast.HoltWinters(lrtsmforecast, h=24)
plot(hwfwd)
accuracy(hwfwd ) # predictive accuracy
#plot predicted value versus real value
rtsmf <- window(rsts, start=c(1976,1), end=c(1977,12))
rtsmfl<-log(rtsmf)
confl95<-hwfwd$lower[,2]
plot(confl95, type="l" , col=2)
par(new=T)
confu95<-hwfwd$upper[,2]
plot(confu95, type="l" , col=2)
par(new=T)
plot(rtsmfl,type="b",axes=F,col=3)
par(new=F)
#check correlogram 
acf(hwfwd$residuals, lag.max=20)
#Ljung-Box test 
Box.test(hwfwd$residuals, lag=20, type="Ljung-Box")
plot.ts(hwfwd$residuals)
#Check normality of residuals
plotForecastErrors <- function(forecasterrors)
  {
     # make a histogram of the forecast errors:
     mybinsize <- IQR(forecasterrors)/4
     mysd   <- sd(forecasterrors)
     mymin  <- min(forecasterrors) - mysd*5
     mymax  <- max(forecasterrors) + mysd*3
     # generate normally distributed data with mean 0 and standard deviation mysd
     mynorm <- rnorm(10000, mean=0, sd=mysd)
     mymin2 <- min(mynorm)
     mymax2 <- max(mynorm)
     if (mymin2 < mymin) { mymin <- mymin2 }
     if (mymax2 > mymax) { mymax <- mymax2 }
     # make a red histogram of the forecast errors, with the normally distributed data overlaid:
     mybins <- seq(mymin, mymax, mybinsize)
     hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
     # freq=FALSE ensures the area under the histogram = 1
     # generate normally distributed data with mean 0 and standard deviation mysd
     myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
     # plot the normal curve as a blue line on top of the histogram of forecast errors:
     points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
  }
plotForecastErrors(hwfwd$residuals)
qqnorm(hwfwd$residuals, ylab="Holt Winter Multiplicative", xlab="Normal Scores", main="Notmsl pp Holt Winter Multiplicative") 
qqline(hwfwd$residuals)
# ARIMA
lrtsm1 <- diff(lrtsm , differences=1)
plot.ts(lrtsm1)
lrtsm2 <- diff(lrtsm , differences=2)
plot.ts(lrtsm2)
# determine degree of ARIMA
acf(lrtsm1 , lag.max=20)    #11 
pacf(lrtsm1, lag.max=20) #19
# fit an ARIMA model of order P, D, Q
fit <- arima(lrtsm, order=c(0, 1, 11))
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
# Automated forecasting using an ARIMA model
fit <- auto.arima(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
�
# Automated forecasting using an exponential model
fit <- ets(lrtsm)
accuracy(fit) # predictive accuracy
forecast(fit, 24)
plot(forecast(fit, 24))
spectrum(rsts)
�
Statistical Inference, Matrix:
crime<-read.csv("d:/eleventh.csv",header=T) # read whole data
cr=crime[,1] # crime rate
cov=crime[,2:14] # covariates
summary(cov)# check summary of data
cor(cov) #check the correlation
pairs(cov) # check plot of correlations
plot(cov[,1], cr, main="Age and crime rate", xlab="Age", ylab="Crime rate", pch=19)
plot(cov[,2], cr, main="Southern states and crime rate", xlab="Southern states", ylab="Crime rate", pch=19)
plot(cov[,3], cr, main="Schooling and crime rate", xlab="Schooling", ylab="Crime rate", pch=19)
plot(cov[,4], cr, main="1960 plice expenditure", xlab="1960 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,5], cr, main="1959 plice expenditure", xlab="1959 police expenditure", ylab="Crime rate", pch=19)
plot(cov[,6], cr, main="Labor force participation", xlab="Labor force participation", ylab="Crime rate", pch=19)
plot(cov[,7], cr, main="Male/Female rate", xlab="male/female rate", ylab="Crime rate", pch=19)
plot(cov[,8], cr, main="State population", xlab="State population", ylab="Crime rate", pch=19)
plot(cov[,9], cr, main="Non white", xlab="non white", ylab="Crime rate", pch=19)
plot(cov[,10], cr, main="Unemployment rate 14-24", xlab="unemployment rate 14-24", ylab="Crime rate", pch=19)
plot(cov[,11], cr, main="Unemployment rate 25-35", xlab="unemployment rate 25-35", ylab="Crime rate", pch=19)
plot(cov[,12], cr, main="Transferable goods and assets", xlab="Transferable goods and assets", ylab="Crime rate", pch=19)
plot(cov[,13], cr, main="Below median income", xlab="Families Below median income", ylab="Crime rate", pch=19)
qqnorm(cr, ylab="Crime rate", xlab="Normal Scores", main="Normal probability plot of crime rate") 
qqline(cr)
names(cov)
crd = d=as.matrix(cr)
covd = d=as.matrix(cov)
cdata=cbind(cr,cov)
model1 = lm(cr~Age+S+Ed+Ex0+Ex1+LF+M+N+NW+U1+U2+W+X,data=cdata)
step(model1, direction="backward")
step(model1, direction="forward")
step(model1, direction="both",trace=TRUE)
par(mfrow=c(2,2))    # visualize four graphs at once
plot(model1)
par(mfrow=c(1,1))  # reset the graphics defaults
�
Summary Stat: Summer Project
# first row contains variable names
# we will read in workSheet mysheet
�
library(RODBC)
channel <- odbcConnectExcel("C:/Users/MHE/Desktop/ActiveCourses/Projects/Noris/Data/DailyOf100AddOn.xlsx")
mydata <- sqlFetch(channel, "CrossSec")
dwnldDTA<-sqlFetch(channel, "Summary")
odbcClose(channel)
cbind(summary(mydata))
names(mydata)
newdata <- mydata[c(0,5:23)]
summary(newdata[c(0,19)])
�
#other method to get summery statistics
library(Hmisc)
describe(mydata) 
�
#btter method to get summery
library(pastecs)
stat.desc(mydata) 
�
#the best way to use the summery (like SAS)
library(psych)
describe(mydata)
describe(dwnldDTA)
�
cbind(table(newdata[c(0,10)]))
summary(dwnldDTA[c(0,11)])
library(MASS)                 # load the MASS package 
cbind(table(mydata$"2nd Category"))  # apply the table functionc
�
Summary Stat: Summer Project
mydata = read.csv("D:/FirFxPrl/sampletest.csv") 
library("TTR")
Downloads= log(EMA(mydata[2], 7));
St_AVG= EMA(mydata[16], 7);
St_Cnt= EMA(mydata[17], 7);
St_STD= EMA(mydata[18], 7);
Usage= log(EMA(mydata[9], 7));
English.Share= EMA(mydata[15], 7);
model1=lm(Downloads~St_AVG+St_Cnt+St_STD+Usage+English.Share)
summary(model1)
�
�
st=as.data.frame(mydata)
str(st)
cor(st)
pairs(st)
model1=lm(log(Downloads)~St_AVG+St_Cnt+St_STD+log(Usage)+English.Share,data=st)
summary(model1)
�
MCMC part of code of Bayesian BLP:
# ------------ (1) Gibbs Sampler for thetabar and taosq -------------------output=runiregG(y=mu,X=X,XpX=XpX,Xpy=crossprod(X,mu),sigmasq=taosq,
A=Athetabar,betabar=thetabar0,nu=nu0,ssq=s0sq) thetabar=output$betadraw
taosq=output$sigmasqdraw
# ------------ (2) Metropolis for r ---------------------------------------#
Random-Walk Chain
rN=r+mvrnorm(1,rep(0,(K*(K+1)/2)),varn
_r)_
ON=Loglhd(rN,mu,thetabar,taosq)
prior_old=sum(-r[1:K]^2/2/sigmasqR_DIAG)+sum(-r[(K+1):(K*(K+1)/2)]^2/2/sigmasqR_off)
prior_new=sum(-rN[1:K]^2/2/sigmasqR_DIAG)+sum(-rN[(K+1):(K*(K+1)/2)]^2/2/sigmasqR_off)
15
# Evaluate old r (mu) at new (thetabar,taosq)
eta=mu-X%*%thetabar
llhd_old=sum(log(dnorm(eta,sd=sqrt(taosq))))+OO$sumlogjacob
ratio=exp(ON$llhd+prior_new-llhd_old-prior_old)
alphaS=min(1,ratio) # S stands for Sigma
if (runif(1)<=alphaS) {
r=rN; OO=ON; ns=ns+1; mu=OO$mu
r=rN; OO=ON; ns=ns+1; mu=OO$mu 
}
�
Brute-Force log-likelihood code of Bayesian BLP:
# Purpose: Evaluate log likelihood. Sigma is reparameterized as r.
Loglhd slow = function(thetabar,r,taosq,mu){
# (1). Transform r to L, where Sigma=LL'
L=diag(exp(r[1:K]))
L[lower tri(L)]=r[(K+1):(K*(K+1)/2)]L[lower.tri(L)]=r[(K+1):(K (K+1)/2)]
# (2). At given L, do inversion to get mu. Then compute eta
temp=invert_slow(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH)
mu  = temp$mu; prob = temp$prob; niter = temp$niter
eta=mu-X%*%thetabar
�
eta=mu-X%*%thetabar
�
# (3). Jacobian
# Form J diagonal elements at each time t
diagonal=rowMeans(prob*(1-prob)) # TJ by 1 vector
# Form the off diagonal elements
dd=-prob%*%t(prob)/H # TJ by TJ
cc=aaa*dd+diag(diagonal)#TJ by TJ matrix: block diagonal 
for (t in 1:T){
�
for (t in 1:T){
cct=cc[((t-1)*J+1):(t*J),((t-1)*J+1):(t*J)] #(t)th block of cc
logjacob[t]=-log(abs(det(cct)))
 }
# (4). Form Log Likelihood
lj b (lj b)
�
sumlogjacob=sum(logjacob)
llhd=sum(log(dnorm(eta,sd=sqrt(taosq))))+sumlogjacob
list(llhd=llhd,mu=mu,niter=niter,sumlogjacob=sumlogjacob)
}
�
Slow inversion code  of Bayesian BLP
invert_slow =
function(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH){
# Purpose: Invert observed shares S at give L to get mean utility mu's.
niter=0 # number of iterations taken for the inversion
munew=mu # starting value
muold=munew/2
upart=X%*%L%*%v
hil ( (b(( ld )/ ))> it){
while (max(abs((muold-munew)/munew))>crit){
muold=munew
num=exp(upart+ muold) # JT by H numerator
den1=matrix(double(T*H),nrow=T)
for (t in 1:T){
den1[t,]=1+colSums(num[((t-1)*J+1):(t*J),]) #T by H
}
den=matrix(rep(den1,each=J),ncol=H) #replc each t J times,JT by H
prob=num/den # JT by H
sh=t(matrix(rowMeans(prob), nrow=J)) # T by J predicted share
munew=t(matrix(muold,nrow=J))+log(S)-log(sh) # T by J
munew=as.vector(t(munew)) # length JT vector
niter=niter+1
}
List(mu=munew,prob=prob,niter=niter)
}
�
Add new row to the object res each time it finds a row that has no NA
funAgg = function(x) {
# initialize res 
 res = NULL
 n = nrow(x)
for (i in 1:n) {
    if (!any(is.na(x[i,]))) res = rbind(res, x[i,])
 }
 res
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Initialize res object to the correct size, replace the rwos one at a time as a row in the nput with no Nas is found
funLoop = function(x) {
# Initialize res with x
 res = x
 n = nrow(x)
 k = 1
for (i in 1:n) {
    if (!any(is.na(x[i,]))) {
       res[k, ] = x[i,]
       k = k + 1
    }
 }
 res[1:(k-1), ]
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Is.na function that returns a logical when given a data frame of data
funApply = function(x) {
 drop = apply(is.na(x), 1, any)
 x[!drop, ]
}
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Profiling:
funOmit = function(x) {
# The or operation is very fast, it is replacing the any function
# Also note that it doesn't require having another data frame as big as x
drop = F
 n = ncol(x)
 for (i in 1:n)
   drop = drop | is.na(x[, i])
 x[!drop, ]
}
#Make up large test case
 xx = matrix(rnorm(2000000),100000,20)
 xx[xx>2] = NA
 x = as.data.frame(xx)
# Call the R code profiler and give it an output file to hold results
  Rprof("exampleAgg.out")
# Call the function to be profiled
  y = funAgg(xx)
  Rprof(NULL)
Rprof("exampleLoop.out")
  y = funLoop(xx)
  Rprof(NULL)
Rprof("exampleApply.out")
  y = funApply(xx)
  Rprof(NULL)
Rprof("exampleOmit.out")
  y = funOmit(xx)
  Rprof(NULL)
�
Pasted from <http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html> 
�
Vectorized invert: faster for BLP Bayesian
invert =invert
function(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH){
# Purpose: Invert observed shares S at give L to get mean utility mu's.
19
niter=0 # number of iterations taken
munew=mu # starting value
muold=munew/2
upart=X%*%L%*%v
while (max(abs((muold-munew)/munew))>crit){
muold=munew
num=exp(upart+ muold)  # num is JT x H
dim(num)=NULL       # convert num to JTH vector
nmnm[indTHJ] # con ert n m to THJ ectornum=num[indTHJ]     # convert num to THJ vector
dim(num)=c(T*H,J)   # convert num to TH * J matrix
den=1+rowSums(num) # TH vector
prob=num/den # TH * J matrix
dim(prob)=NULL      # convert prob to THJ vector
prob=prob[indJTH]   # convert prob to JTH vector
dim(prob)=c(J*T,H)  # convert prob to JT * H matrix
sh=rowMeans(prob)   # JT vector
munew=muold+lnactS-log(sh)# JT vector
niter=niter+1
}
niter=niter+1
list(mu=munew,prob=prob,niter=niter)
}
No loop!
Matrix divided 
by a vector
�
Global variable inside the function:
a <- "old"
test <- function () {
   assign("a", "new", envir = .GlobalEnv)
}
test()
a  # display the new value
�
Pasted from <http://stackoverflow.com/questions/1236620/global-variables-in-r> 
�
�
a <<- "new" 
�
Pasted from <http://stackoverflow.com/questions/1236620/global-variables-in-r> 
�
Reindiexting Function BLP Bayesian:
JTH THJ=function(J H T){JTH_THJ=function(J,H,T){
#
# function to convert and index a vector ordered j by t by h (i.e. j
# varies faster than t than h) into a vector ordered t by h by j
#
ind=double(J*H*T)
cnt=1
for (j in 1:J){
for (h in 1:H) {
for (t in 1:T) {for (t in 1:T) {
ind[cnt]=(t-1)*J+(h-1)*(T*J)+j
cnt=cnt+1
�
}
}
}
return(ind)
�
}
indTHJ JTH_THJ(J,H,T) indJTH=THJ_JTH(J,H,T)
indTHJ=JTH THJ(J,H,T)
New Code:
for (t in 1:T){
cct=cc[((t 1)*J+1):(t*J) ((t 1)*J+1):(t*J)] #(t)th block of cccct=cc[((t-1)*J+1):(t*J),((t-1)*J+1):(t*J)] #(t)th block of cc
logjacob[t]=-2*sum(log(diag(chol(cct))))
# old code:
# logjacob[t]=-log(abs(det(cct)))
}
�
Creating Matrix in R:
seq1 <- seq(1:6)
mat1 <- matrix(seq1, 2)
mat1
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    2    4    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#filling the matrix by rows
mat2 <- matrix(seq1, 2, byrow = T)
mat2
     [,1] [,2] [,3] 
[1,]    1    2    3
[2,]    4    5    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
# Number of columns without specifying rows
mat3 <- matrix(seq1, ncol = 2)
mat3
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#creating the same matrix using both dimension arguments
#by using them in order we do not have to name them
mat4 <- matrix(seq1, 3, 2)
mat4
     [,1] [,2] 
[1,]    1    4
[2,]    2    5
[3,]    3    6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#creating a matrix of 20 numbers from a standard normal dist.
mat5 <- matrix(rnorm(20), 4)
mat5
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#appending v1 to mat5
v1 <- c(1, 1, 2, 2)
mat6 <- cbind(mat5, v1)
mat6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
v2 <- c(1:6)
mat7 <- rbind(mat6, v2)
mat7
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#determining the dimensions of a mat7
dim(mat7)
[1] 5 6
#removing names of rows and columns
#the first NULL refers to all row names, the second to all column names 
dimnames(mat7) <- list(NULL, NULL)
mat7
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Access element of a matrix:
matrix_name[row#, col#]
mat7[1, 6]
[1] 1
#to access an entire row leave the column number blank
mat7[1,  ]
[1] -0.1920780  0.0910308 -1.1044547 -1.1513583  1.3435247  1.0000000
#to access an entire column leave the row number blank
mat7[, 6]
[1] 1 1 2 2 6
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
#Creating mat8 and mat9
mat8 <- matrix(1:6, 2)
mat8
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    2    4    6
mat9 <- matrix(c(rep(1, 3), rep(2, 3)), 2, byrow = T)
mat9
     [,1] [,2] [,3] 
[1,]    1    1    1
[2,]    2    2    2
#addition
mat9 + mat8
     [,1] [,2] [,3] 
[1,]    2    4    6
[2,]    4    6    8
mat9 + 3
     [,1] [,2] [,3] 
[1,]    4    4    4
[2,]    5    5    5
#subtraction
mat8 - mat9
     [,1] [,2] [,3] 
[1,]    0    2    4
[2,]    0    2    4
#inverse
solve(mat8[, 2:3])
     [,1] [,2] 
[1,]   -3  2.5
[2,]    2 -1.5
#transpose
t(mat9)
     [,1] [,2] 
[1,]    1    2
[2,]    1    2
[3,]    1    2
#multiplication
#we transpose mat8 since the dimension of the matrices have to match
#dim(2, 3) times dim(3, 2)
mat8 %*% t(mat9)
     [,1] [,2] 
[1,]    9   18
[2,]   12   24
#element-wise multiplication
mat8 * mat9
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    4    8   12
mat8 * 4
     [,1] [,2] [,3] 
[1,]    4   12   20
[2,]    8   16   24
#division
mat8/mat9
     [,1] [,2] [,3] 
[1,]    1    3    5
[2,]    1    2    3
mat9/2
     [,1] [,2] [,3] 
[1,]  0.5  0.5  0.5
[2,]  1.0  1.0  1.0
#using submatrices from the same matrix in computations
mat8[, 1:2]
     [,1] [,2] 
[1,]    1    3
[2,]    2    4
mat8[, 2:3]
     [,1] [,2] 
[1,]    3    5
[2,]    4    6
mat8[, 1:2]/mat8[, 2:3]
          [,1]      [,2] 
[1,] 0.3333333 0.6000000
[2,] 0.5000000 0.6666667
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Regression:
y <- matrix(hsb2$write, ncol = 1)
y[1:10, 1]
 [1] 52 59 33 44 52 52 59 46 57 55
x <- as.matrix(cbind(1, hsb2$math, hsb2$science, hsb2$socst, hsb2$female))
x[1:10,  ]
      [,1] [,2] [,3] [,4] [,5] 
 [1,]    1   41   47   57    0
 [2,]    1   53   63   61    1
 [3,]    1   54   58   31    0
 [4,]    1   47   53   56    0
 [5,]    1   57   53   61    0
 [6,]    1   51   63   61    0
 [7,]    1   42   53   61    0
 [8,]    1   45   39   36    0
 [9,]    1   54   58   51    0
[10,]    1   52   50   51    0
n <- nrow(x)
p <- ncol(x)
#parameter estimates
beta.hat <- solve(t(x) %*% x) %*% t(x) %*% y
beta.hat
          [,1] 
[1,] 6.5689235
[2,] 0.2801611
[3,] 0.2786543
[4,] 0.2681117
[5,] 5.4282152
#predicted values
y.hat <- x %*% beta.hat
y.hat[1:5, 1]
[1] 46.43465 60.75571 46.17103 49.51943 53.66160
y[1:5, 1]
[1] 52 59 33 44 52
#the variance, residual standard error and df's
sigma2 <- sum((y - y.hat)^2)/(n - p)
#residual standard error
sqrt(sigma2)
[1] 6.101191
#degrees of freedom
n - p
[1] 195
#the standard errors, t-values and p-values for estimates
#variance/covariance matrix
v <- solve(t(x) %*% x) * sigma2
#standard errors of the parameter estimates
sqrt(diag(v))
[1] 2.81907949 0.06393076 0.05804522 0.04919499 0.88088532
#t-values for the t-tests of the parameter estimates
t.values <- beta.hat/sqrt(diag(v))
t.values
         [,1] 
[1,] 2.330166
[2,] 4.382257
[3,] 4.800642
[4,] 5.449980
[5,] 6.162227
#p-values for the t-tests of the parameter estimates
2 * (1 - pt(abs(t.values), n - p))
[1] 2.082029e-002 1.917191e-005 3.142297e-006 1.510015e-007 4.033511e-009
#checking that we got the correct results
ex1 <- lm(write ~ math + science + socst + female, hsb2)
summary(ex1)
Call: lm(formula = write ~ math + science + socst + female, data = hsb2)
Coefficients:
             Value Std. Error t value Pr(>|t|) 
(Intercept) 6.5689 2.8191     2.3302  0.0208  
       math 0.2802 0.0639     4.3823  0.0000  
    science 0.2787 0.0580     4.8006  0.0000  
      socst 0.2681 0.0492     5.4500  0.0000  
     female 5.4282 0.8809     6.1622  0.0000  
Residual standard error: 6.101 on 195 degrees of freedom
Multiple R-Squared: 0.594 
F-statistic: 71.32 on 4 and 195 degrees of freedom, the p-value is 0 
�
Pasted from <http://www.ats.ucla.edu/stat/r/library/matrix_alg.htm> 
�
Single Dimension of a Matrix:
# simple versions of nrow and ncol could be defined as follows
nrow0 <- function(x) dim(x)[1]
ncol0 <- function(x) dim(x)[2]
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/dim.html> 
�
Vector of zeros or single value:
list(rep(0, 50))
�
Pasted from <http://stackoverflow.com/questions/4072388/how-do-you-create-a-list-with-a-single-value-in-r> 
as.list(rep(0, 50))
�
Pasted from <http://stackoverflow.com/questions/4072388/how-do-you-create-a-list-with-a-single-value-in-r> 
�
Display a variable with its name:
names(mydata)[3] <- "This is the label for variable 3"
mydata[3] # list the variable
�
library(Hmisc)
label(mydata$myvar) <- "Variable label for variable�myvar"�
describe(mydata)
�
Pasted from <http://www.statmethods.net/input/variablelables.html> 
�
�
Pasted from <http://www.statmethods.net/input/variablelables.html> 
�
Input and Display:
#read files with labels in first row
read.table(filename,header=TRUE)           #read a tab or space delimited file
read.table(filename,header=TRUE,sep=',')   #read csv files
x=c(1,2,4,8,16 )                           #create a data vector with specified elements
y=c(1:10)                                  #create a data vector with elements 1-10
n=10
x1=c(rnorm(n))                             #create a n item vector of random normal deviates
y1=c(runif(n))+n                           #create another n item vector that has n added to each random uniform distribution
z=rbinom(n,size,prob)                      #create n samples of size "size" with probability prob from the binomial
vect=c(x,y)                                #combine them into one vector of length 2n
mat=cbind(x,y)                             #combine them into a n x 2 matrix
mat[4,2]                                   #display the 4th row and the 2nd column
mat[3,]                                    #display the 3rd row
mat[,2]                                    #display the 2nd column
subset(dataset,logical)                    #those objects meeting a logical criterion
subset(data.df,select=variables,logical)   #get those objects from a data frame that meet a criterion
data.df[data.df=logical]                   #yet another way to get a subset
x[order(x$B),]                             #sort a dataframe by the order of the elements in B
x[rev(order(x$B)),]                        #sort the dataframe in reverse order 
browse.workspace                           #a menu command that creates a window with information about all variables in the workspace
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Moving Around in the workspace:
ls()                                      #list the variables in the workspace
rm(x)                                     #remove x from the workspace
rm(list=ls())                             #remove all the variables from the workspace
attach(mat)                               #make the names of the variables in the matrix or data frame available in the workspace
detach(mat)                               #releases the names
new=old[,-n]                              #drop the nth column
new=old[n,]                               #drop the nth row
new=subset(old,logical)                   #select those cases that meet the logical condition
complete = subset(data.df,complete.cases(data.df)) #find those cases with no missing values
new=old[n1:n2,n3:n4]                      #select the n1 through n2 rows of variables n3 through n4)
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Data Manipulation
replace(x, list, values)                 #remember to assign this to some object i.e., x <- replace(x,x==-9,NA) 
                                         #similar to the operation x[x==-9] <- NA
cut(x, breaks, labels = NULL,
    include.lowest = FALSE, right = TRUE, dig.lab = 3, ...)
x.df=data.frame(x1,x2,x3 ...)             #combine different kinds of data into a data frame
��������as.data.frame()
��������is.data.frame()
x=as.matrix()
scale()                                   #converts a data frame to standardized scores
round(x,n)                                #rounds the values of x to n decimal places
ceiling(x)                                #vector x of smallest integers > x
floor(x)                                  #vector x of largest interger < x
as.integer(x)                             #truncates real x to integers (compare to round(x,0)
as.integer(x < cutpoint)                  #vector x of 0 if less than cutpoint, 1 if greater than cutpoint)
factor(ifelse(a < cutpoint, "Neg", "Pos"))  #is another way to dichotomize and to make a factor for analysis 
transform(data.df,variable names = some operation) #can be part of a set up for a data set 
x%in%y                     #tests each element of x for membership in y
y%in%x                     #tests each element of y for membership in x
all(x%in%y)                #true if x is a proper subset of y
all(x)                     # for a vector of logical values, are they all true?
any(x)                     #for a vector of logical values, is at least one true?
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Distributions:
beta(a, b)
gamma(x)
choose(n, k)
factorial(x)
dnorm(x, mean=0, sd=1, log = FALSE)      #normal distribution
pnorm(q, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean=0, sd=1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean=0, sd=1)
dunif(x, min=0, max=1, log = FALSE)      #uniform distribution
punif(q, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
qunif(p, min=0, max=1, lower.tail = TRUE, log.p = FALSE)
runif(n, min=0, max=1)
rnorm(n,mean,sd)
rbinom(n,size,p)
sample(x, size, replace = FALSE, prob = NULL)      #samples with or without replacement
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
�
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Statistics and Transformations:
max()
min()
mean()
median()
sum()
var()     #produces the variance covariance matrix
sd()      #standard deviation
mad()    #(median absolute deviation)
fivenum() #Tukey fivenumbers min, lowerhinge, median, upper hinge, max
table()    #frequency counts of entries, ideally the entries are factors(although it works with integers or even reals)
scale(data,scale=T)   #centers around the mean and scales by the sd)
cumsum(x)     #cumulative sum, etc.
cumprod(x)
cummax(x)
cummin(x)
rev(x)      #reverse the order of values in x
 
cor(x,y,use="pair")   #correlation matrix for pairwise complete data, use="complete" for complete cases
 
aov(x~y,data=datafile)  #where x and y can be matrices
aov.ex1 = aov(DV~IV,data=data.ex1)  #do the analysis of variance or
aov.ex2 = aov(DV~IV1*IV21,data=data.ex2)         #do a two way analysis of variance
summary(aov.ex1)                                    #show the summary table
print(model.tables(aov.ex1,"means"),digits=3)       #report the means and the number of subjects/cell
boxplot(DV~IV,data=data.ex1)        #graphical summary appears in graphics window
lm(x~y,data=dataset)                      #basic linear model where x and y can be matrices  (see plot.lm for plotting options)
t.test(x,g)
pairwise.t.test(x,g)
power.anova.test(groups = NULL, n = NULL, between.var = NULL,
                 within.var = NULL, sig.level = 0.05, power = NULL)
power.t.test(n = NULL, delta = NULL, sd = 1, sig.level = 0.05,
             power = NULL, type = c("two.sample", "one.sample", "paired"),
             alternative = c("two.sided", "one.sided"),strict = FALSE)
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Regression and Linear Models:
matrices
lm(Y~X1+X2)
lm(Y~X|W)                              
solve(A,B)                               #inverse of A * B   - used for linear regression
solve(A)                                 #inverse of A
factanal()
princomp()
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Rowsum and columnsum and min and max:
colSums (x, na.rm = FALSE, dims = 1)
     rowSums (x, na.rm = FALSE, dims = 1)
     colMeans(x, na.rm = FALSE, dims = 1)
     rowMeans(x, na.rm = FALSE, dims = 1)
     rowsum(x, group, reorder = TRUE, ...)         #finds row sums for each level of a grouping variable
     apply(X, MARGIN, FUN, ...)                    #applies the function (FUN) to either rows (1) or columns (2) on object X
     ��������apply(x,1,min)                             #finds the minimum for each row
    ��������apply(x,2,max)                            #finds the maximum for each column
    col.max(x)                                   #another way to find which column has the maximum value for each row 
    which.min(x)
    which.max(x)
    ��������z=apply(big5r,1,which.min)               #tells the row with the minimum value for every column
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Working with Dates:
date <-strptime(as.character(date), "%m/%d/%y")   #change the date field to a internal form for time  
                                                  #see ?formats and ?POSIXlt  
 as.Date
 month= months(date)                #see also weekdays, Julian
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Graphics:
par(mfrow=c(nrow,mcol))                        #number of rows and columns to graph
par(ask=TRUE)                             #ask for user input before drawing a new graph
par(omi=c(0,0,1,0) )                      #set the size of the outer margins 
mtext("some global title",3,outer=TRUE,line=1,cex=1.5)    #note that we seem to need to add the global title last
                     #cex = character expansion factor 
boxplot(x,main="title")                  #boxplot (box and whiskers)
title( "some title")                          #add a title to the first graph
��������
hist()                                   #histogram
plot()
��������plot(x,y,xlim=range(-1,1),ylim=range(-1,1),main=title)
��������par(mfrow=c(1,1))     #change the graph window back to one figure
��������symb=c(19,25,3,23)
��������colors=c("black","red","green","blue")
��������charact=c("S","T","N","H")
��������plot(PA,NAF,pch=symb[group],col=colors[group],bg=colors[condit],cex=1.5,main="Postive vs. Negative Affect by Film condition")
��������points(mPA,mNA,pch=symb[condit],cex=4.5,col=colors[condit],bg=colors[condit])
��������
curve()
abline(a,b)
�������� abline(a, b, untf = FALSE, ...)
     abline(h=, untf = FALSE, ...)
     abline(v=, untf = FALSE, ...)
     abline(coef=, untf = FALSE, ...)
     abline(reg=, untf = FALSE, ...)
identify()
��������plot(eatar,eanta,xlim=range(-1,1),ylim=range(-1,1),main=title)
��������identify(eatar,eanta,labels=labels(energysR[,1])  )       #dynamically puts names on the plots
locate()
legend()
pairs()                                  #SPLOM (scatter plot Matrix)
pairs.panels ()    #SPLOM on lower off diagonal, histograms on diagonal, correlations on diagonal
                   #not standard R, but uses a function found in useful.r 
matplot ()
biplot ())
plot(table(x))                           #plot the frequencies of levels in x
x= recordPlot()                           #save the current plot device output in the object x
replayPlot(x)                            #replot object x
dev.control                              #various control functions for printing/saving graphic files
pdf(height=6, width=6)              #create a pdf file for output
dev.of()                            #close the pdf file created with pdf 
layout(mat)                         #specify where multiple graphs go on the page
                                    #experiment with the magic code from Paul Murrell to do fancy graphic location
layout(rbind(c(1, 1, 2, 2, 3, 3),
             c(0, 4, 4, 5, 5, 0)))   
for (i in 1:5) {
  plot(i, type="n")
  text(1, i, paste("Plot", i), cex=4)
}
�
pie(rep(1,16),col=rainbow(16))
> z <- seq(-3,3,.1)
> d <- dnorm(z)
> plot(z,d,type="l")
> title("The Standard Normal Density",col.main="cornflowerblue")
�
�
Pasted from <http://data.princeton.edu/R/gettingStarted.html> 
�
�
Pasted from <https://personality-project.org/r/r.commands.html> 
�
Display a string  with variable inside:
cat(sprintf("<set name=\"%s\" value=\"%f\" ></set>\n", df$timeStamp, df$Price))
�
Pasted from <http://stackoverflow.com/questions/3516008/how-to-print-r-variables-in-middle-of-string> 
�
> x <- 'say "Hello!"'
> x
[1] "say \"Hello!\""
> cat(x)
say "Hello!"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
�
x <- "say \"Hello!\""
R> cat(x)
say "Hello!"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
# default is to use "fancy quotes"
text <- c("check")
message(dQuote(text))
## �check�
# switch to straight quotes by setting an option
options(useFancyQuotes = FALSE)
message(dQuote(text))
## "check"
# assign result to create a vector of quoted character strings
text.quoted <- dQuote(text)
message(text.quoted)
## "check"
�
Pasted from <http://stackoverflow.com/questions/15204442/how-to-display-text-with-quotes-in-r> 
�
Create a Diary or Log from Execution:
con <- file("test.log")
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")
# This will echo all input and not truncate 150+ character lines...
source("script.R", echo=TRUE, max.deparse.length=10000)
# Restore output to console
sink() 
sink(type="message")
# And look at the log...
cat(readLines("test.log"), sep="\n")
�
Pasted from <http://stackoverflow.com/questions/7096989/how-to-save-all-console-output-to-file-in-r> 
�
Write into file:
write.matrix(x, file = "", sep = " ", blocksize)
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/MASS/html/write.matrix.html> 
�
write(x, file = "data",
      ncolumns = if(is.character(x)) 1 else 5,
      append = FALSE, sep = " ")
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/write.html> 
�
# create a 2 by 5 matrix
x <- matrix(1:10, ncol = 5)
# the file data contains x, two rows, five cols
# 1 3 5 7 9 will form the first row
write(t(x))
# Writing to the "console" 'tab-delimited'
# two rows, five cols but the first row is 1 2 3 4 5
write(x, "", sep = "\t")
unlink("data") # tidy up
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/base/html/write.html> 
�
m <- matrix(1:12, 4 , 3)
write.table(m,file="outfile,txt",sep="\t", col.names = F, row.names = F)
�
Pasted from <http://stackoverflow.com/questions/10608526/writing-a-matrix-to-a-file-without-a-header-and-row-numbers> 
�
write.table(mtcars, file = "mtcars.txt", sep = " ")
�
Pasted from <http://stackoverflow.com/questions/6957499/how-do-i-print-a-matrix-in-r> 
�
write.table(m, file = "m.txt", sep = " ", row.names = FALSE, col.names = FALSE)
�
Pasted from <http://stackoverflow.com/questions/6957499/how-do-i-print-a-matrix-in-r> 
�
Save Matrix into CSV file:
 write.matrix(format(moDat2, scientific=FALSE), 
               file = paste(targetPath, "dat2.csv", sep="/"), sep=",")
�
Pasted from <http://stackoverflow.com/questions/13785303/save-matrix-to-csv-file-in-r-without-losing-format> 
�
mat <- matrix(1:10,ncol=2)
rownames(mat) <- letters[1:5]
colnames(mat) <- LETTERS[1:2]
mat
write.table(mat,file="test.txt") # keeps the rownames
read.table("test.txt",header=TRUE,row.names=1) # says first column are rownames
unlink("test.txt")
write.table(mat,file="test2.txt",row.names=FALSE) # drops the rownames
read.table("test.txt",header=TRUE) 
unlink("test2.txt")
�
Pasted from <http://stackoverflow.com/questions/6844166/export-matrix-in-r> 
�
Sparce Matrix:
library('Matrix')
�
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- Matrix(0, nrow = 1000, ncol = 1000, sparse = TRUE)
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5632 bytes
�
m1[500, 500] <- 1
m2[500, 500] <- 1
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 5648 bytes
�
m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)
�
m3 <- cBind(m2, m2)
nrow(m3)
ncol(m3)
�
m4 <- rBind(m2, m2)
nrow(m4)
ncol(m4)
�
�
#sSecond Package Solution
library('slam')
�
m1 <- matrix(0, nrow = 1000, ncol = 1000)
m2 <- simple_triplet_zero_matrix(nrow = 1000, ncol = 1000)
�
object.size(m1)
# 8000200 bytes
object.size(m2)
# 1032 bytes
�
# BUG HERE
m1[500, 500] <- 1
m2[500, 500] <- 1
�
object.size(m1)
object.size(m2)
�
m2 %*% rnorm(1000)
m2 + m2
m2 - m2
t(m2)
�
�
#Third Method:
library('Matrix')
library('glmnet')
�
n <- 10000
p <- 500
�
x <- matrix(rnorm(n * p), n, p)
iz <- sample(1:(n * p),
             size = n * p * 0.85,
             replace = FALSE)
x[iz] <- 0
�
object.size(x)
�
sx <- Matrix(x, sparse = TRUE)
�
object.size(sx)
�
beta <- rnorm(p)
�
y <- x %*% beta + rnorm(n)
�
glmnet.fit <- glmnet(x, y)
�
#Fourth way that is more efficient
library('Matrix')
library('glmnet')
�
set.seed(1)
performance <- data.frame()
�
for (sim in 1:10)
{
  n <- 10000
  p <- 500
�
  nzc <- trunc(p / 10)
�
  x <- matrix(rnorm(n * p), n, p)
  iz <- sample(1:(n * p),
               size = n * p * 0.85,
               replace = FALSE)
  x[iz] <- 0
  sx <- Matrix(x, sparse = TRUE)
�
  beta <- rnorm(nzc)
  fx <- x[, seq(nzc)] %*% beta
�
  eps <- rnorm(n)
  y <- fx + eps
�
  sparse.times <- system.time(fit1 <- glmnet(sx, y))
  full.times <- system.time(fit2 <- glmnet(x, y))
  sparse.size <- as.numeric(object.size(sx))
  full.size <- as.numeric(object.size(x))
�
  performance <- rbind(performance, data.frame(Format = 'Sparse',
                                               UserTime = sparse.times[1],
                                               SystemTime = sparse.times[2],
                                               ElapsedTime = sparse.times[3],
                                               Size = sparse.size))
  performance <- rbind(performance, data.frame(Format = 'Full',
                                               UserTime = full.times[1],
                                               SystemTime = full.times[2],
                                               ElapsedTime = full.times[3],
                                               Size = full.size))
}
�
ggplot(performance, aes(x = Format, y = UserTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('User Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_user_time.pdf')
�
ggplot(performance, aes(x = Format, y = SystemTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('System Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_system_time.pdf')
�
ggplot(performance, aes(x = Format, y = ElapsedTime, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Elapsed Time in Seconds') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_elapsed_time.pdf')
�
ggplot(performance, aes(x = Format, y = Size / 1000000, fill = Format)) +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'bar') +
  stat_summary(fun.data = 'mean_cl_boot', geom = 'errorbar') +
  ylab('Matrix Size in MB') +
  opts(legend.position = 'none')
ggsave('sparse_vs_full_memory.pdf')
�
Pasted from <http://www.johnmyleswhite.com/notebook/2011/10/31/using-sparse-matrices-in-r/> 
�
Optimization Function:
�
ans <- optimx(fn = function(x) sum(x*x), par = 1:2)
coef(ans)
## Not run:
proj <- function(x) x/sum(x)
f <- function(x) -prod(proj(x))
ans <- optimx(1:2, f)
ans
coef(ans) <- apply(coef(ans), 1, proj)
ans
## End(Not run)
�
http://cran.r-project.org/web/packages/optimx/optimx.pdf
�
Description
Minimise a function subject to linear inequality constraints using an adaptive barrier algorithm.
Usage
constrOptim(theta, f, grad, ui, ci, mu = 1e-04, control = list(),
            method = if(is.null(grad)) "Nelder-Mead" else "BFGS",
            outer.iterations = 100, outer.eps = 1e-05, ...,
            hessian = FALSE)
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/stats/html/constrOptim.html> 
�
�
�
fr <- function(x) {      x1 <- x[1]
    x2 <- x[2]
    -(log(x1) + x1^2/x2^2)  # need negative since constrOptim is a minimization routine
}
�
# define constraint
rbind(c(-1,-1),c(1,0), c(0,1) ) %*% c(0.99,0.001) -c(-1,0, 0)
�
constrOptim(c(0.99,0.001), fr, NULL, ui=rbind(c(-1,-1),  # the -x-y > -1
                                              c(1,0),    # the x > 0
                                              c(0,1) ),  # the y > 0
                                           ci=c(-1,0, 0)) # the thresholds
�
�
#definegradiant for correct result
grr <- function(x) { ## Gradient of 'fr'
    x1 <- x[1]
    x2 <- x[2]
    c(-(1/x[1] + 2 * x[1]/x[2]^2),
       2 * x[1]^2 /x[2]^3 )
}
�
constrOptim(c(0.99,0.001), fr, grr, ui=rbind(c(-1,-1),  # the -x-y > -1
                                               c(1,0),    # the x > 0
                                               c(0,1) ),  # the y > 0
                                            ci=c(-1,0, 0) )
$par
[1]  9.900007e-01 -3.542673e-16
$value
[1] -7.80924e+30
$counts
function gradient 
    2001       37 
$convergence
[1] 11
$message
[1] "Objective function increased at outer iteration 2"
$outer.iterations
[1] 2
$barrier.value
[1] NaN
�
#another solution with better constraint
onstrOptim(c(0.25,0.25), fr, NULL, 
              ui=rbind( c(-1,-1), c(1,0),   c(0,1) ),  
              ci=c(-1, 0.0001, 0.0001)) 
$par
�
Pasted from <http://stackoverflow.com/questions/5436630/constrained-optimization-in-r> 
�
Another Example:
## from optim
fr <- function(x) {   ## Rosenbrock Banana function
    x1 <- x[1]
    x2 <- x[2]
    100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}
grr <- function(x) { ## Gradient of 'fr'
    x1 <- x[1]
    x2 <- x[2]
    c(-400 * x1 * (x2 - x1 * x1) - 2 * (1 - x1),
       200 *      (x2 - x1 * x1))
}
optim(c(-1.2,1), fr, grr)
#Box-constraint, optimum on the boundary
constrOptim(c(-1.2,0.9), fr, grr, ui = rbind(c(-1,0), c(0,-1)), ci = c(-1,-1))
#  x <= 0.9,  y - x > 0.1
constrOptim(c(.5,0), fr, grr, ui = rbind(c(-1,0), c(1,-1)), ci = c(-0.9,0.1))
## Solves linear and quadratic programming problems
## but needs a feasible starting value
#
# from example(solve.QP) in 'quadprog'
# no derivative
fQP <- function(b) {-sum(c(0,5,0)*b)+0.5*sum(b*b)}
Amat       <- matrix(c(-4,-3,0,2,1,0,0,-2,1), 3, 3)
bvec       <- c(-8, 2, 0)
constrOptim(c(2,-1,-1), fQP, NULL, ui = t(Amat), ci = bvec)
# derivative
gQP <- function(b) {-c(0, 5, 0) + b}
constrOptim(c(2,-1,-1), fQP, gQP, ui = t(Amat), ci = bvec)
## Now with maximisation instead of minimisation
hQP <- function(b) {sum(c(0,5,0)*b)-0.5*sum(b*b)}
constrOptim(c(2,-1,-1), hQP, NULL, ui = t(Amat), ci = bvec,
            control = list(fnscale = -1))
�
Pasted from <http://stat.ethz.ch/R-manual/R-patched/library/stats/html/constrOptim.html> 
�
�
BBML package:
start=list(mu=1,sigma=1)  #starting values
mle.results<-mle2(norm.fit,start=list(mu=1,sigma=1),data=list(x))�#x is the name of the variable containing the data to be fitted
�
Pasted from <http://www.pmc.ucsc.edu/~mclapham/Rtips/likelihood.htm> 
�
Parallel Processing:
library(parallel)
vignette(parallel)
�
Pasted from <http://stackoverflow.com/questions/1395309/how-to-make-r-use-all-processors> 
�
�
�
Asample method for for loops:
library("parallel")
library("foreach")
library("doParallel")
cl <- makeCluster(detectCores() - 1)
registerDoParallel(cl, cores = detectCores() - 1)
data = foreach(i = 1:length(filenames), .packages = c("ncdf","chron","stats"),
               .combine = rbind) %dopar% {
  try({
       # your operations; line 1...
       # your operations; line 2...
       # your output
     })
}
�
Pasted from <http://stackoverflow.com/questions/1395309/how-to-make-r-use-all-processors> 
�
> library(doMC)
> registerDoMC(cores = 5)
>
> ## All subsequent models are then run in parallel
> model <- train(y ~ ., data = training, method = "rf")
�
> gbmGrid <- expand.grid(.interaction.depth = c(1, 5, 9), 
> .n.trees = (1:15)*100, 
> .shrinkage = 0.1) 
In reality,�train�only created objects for 3 models and der
�
Pasted from <http://caret.r-forge.r-project.org/parallel.html> 
�
�
To be read:
http://cran.r-project.org/web/views/HighPerformanceComputing.html
http://caret.r-forge.r-project.org/parallel.html
http://www.r-bloggers.com/parallel-processing-when-does-it-worth/
�
Maximum Likelihood example:
print(x)  #print vector
hist(x)  #histogram
dgamma(x, shape = alpha) #gamma distribution
dgamma(x, shape = alpha, log = TRUE) # log probability density rather than density
logl <- function(alpha, x)
    return(sum(dgamma(x, shape = alpha, log = TRUE))) #calculate sum of likelihoods
logl <- function(alpha, x)
    return(sum(dgamma(x, shape = alpha, log = TRUE))) #sum of likelihood
�
logl <- function(alpha, x) {
    if (length(alpha) > 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(sum(dgamma(x, shape = alpha, log = TRUE)))
} #improved function
�
#function for doing log likelihood plot
logl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
npoint <- 101
alphas <- seq(min(x), max(x), length = npoint)
logls <- double(npoint)
for (i in 1:npoint)
   logls[i] <- logl(alphas[i], x)
plot(alphas, logls, type = "l",
    xlab = expression(alpha), ylab = expression(l(alpha)))
�
#maximum likelihood: nlm, sample mean a good parameter estimator
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
out <- nlm(mlogl, mean(x), x = x)
print(out)
�
* hessian�returns the second derivative (an approximation calculated by finite differences) of the objective function. This will be a�k�נk�matrix if the dimension of the parameter space is�k.
* fscale�helps�nlm�know when it has converged to the solution. It should give roughly the size of the objective function at the solution. Often�fscale = length(x)�is about right.
* print.level�tells�nlm�to blather about what is is doing.�print.level = 2�gives maximum verbosity.
�
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
out <- nlm(mlogl, mean(x), x = x, hessian = TRUE,
    fscale = length(x), print.level = 2)
print(out)
�
#asymptotic confidence interval: Fisher information and confidence interval
conf.level <- 0.95
�
mlogl <- function(alpha, x) {
    if (length(alpha) < 1) stop("alpha must be scalar")
    if (alpha <= 0) stop("alpha must be positive")
    return(- sum(dgamma(x, shape = alpha, log = TRUE)))
}
�
n <- length(x)
out <- nlm(mlogl, mean(x), x = x, hessian = TRUE,
    fscale = n)
alpha.hat <- out$estimate
z <- qnorm((1 + conf.level) / 2)
# confidence interval using expected Fisher information
alpha.hat + c(-1, 1) * z / sqrt(n * trigamma(alpha.hat))
# confidence interval using observed Fisher information
alpha.hat + c(-1, 1) * z / sqrt(out$hessian)
�
�
#several parameters
mlogl <- function(theta, x) {
    if (length(theta) != 2) stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda, log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
�
mlogl <- function(theta, x) {
    if (length(theta) != 2)
        stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda,
        log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
theta.start <- c(alpha.start, lambda.start)
�
out <- nlm(mlogl, theta.start, x = x, hessian = TRUE,
    fscale = length(x))
print(out)
print(theta.start)
eigen(out$hessian, symmetric = TRUE, only.values = TRUE)
# theoretical Fisher information
n <- length(x)
alpha.hat <- out$estimate[1]
lambda.hat <- out$estimate[2]
fish <- n * matrix(c(trigamma(alpha.hat), - 1 / lambda.hat,
     - 1 / lambda.hat, alpha.hat / lambda.hat^2), nrow = 2)
fish
�
conf.level <- 0.95
�
mlogl <- function(theta, x) {
    if (length(theta) != 2)
        stop("theta must be vector of length 2")
    alpha <- theta[1]
    lambda <- theta[2]
    if (alpha <= 0) stop("theta[1] must be positive")
    if (lambda <= 0) stop("theta[2] must be positive")
    return(- sum(dgamma(x, shape = alpha, rate = lambda,
        log = TRUE)))
}
�
alpha.start <- mean(x)^2 / var(x)
lambda.start <- mean(x) / var(x)
theta.start <- c(alpha.start, lambda.start)
�
out <- nlm(mlogl, theta.start, x = x, hessian = TRUE,
    fscale = length(x))
�
crit.val <- qnorm((1 + conf.level) / 2)
inv.fish.info <- solve(out$hessian)
for (i in 1:2)
    print(out$estimate[i] + c(-1, 1) * crit.val *
        sqrt(inv.fish.info[i, i]))
�
#example of A five-parameter Normal Mixture Example
�
length(x)
summary(x)
hist(x) 
�
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
�
#Maximum Likelihood
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
n <- length(x)
p.start <- 1 / 2
mu1.start <- mean(sort(x)[seq(along = x) <= n / 2])
mu2.start <- mean(sort(x)[seq(along = x) > n / 2])
v1.start <- var(sort(x)[seq(along = x) <= n / 2])
v2.start <- var(sort(x)[seq(along = x) > n / 2])
theta.start <- c(mu1.start, mu2.start, v1.start,
    v2.start, p.start)
�
out <- nlm(mlogl, theta.start, print.level = 2,
    fscale = length(x))
out <- nlm(mlogl, out$estimate, print.level = 2,
    fscale = length(x), hessian = TRUE)
print(out)
print(theta.start)
�
mu1.hat <- out$estimate[1]
mu2.hat <- out$estimate[2]
sigma1.hat <- sqrt(out$estimate[3])
sigma2.hat <- sqrt(out$estimate[4])
p.hat <- out$estimate[5]
fred <- function(x) p.hat * dnorm(x, mu1.hat, sigma1.hat) +
    (1 - p.hat) * dnorm(x, mu2.hat, sigma2.hat)
hist(x, freq = FALSE)
curve(fred, add = TRUE)
hist(x, freq = FALSE,
    ylim = range(0, fred(mu1.hat), fred(mu2.hat)))
curve(fred, add = TRUE)
curve(p.hat * dnorm(x, mu1.hat, sigma1.hat),
    add = TRUE, col = "red")
curve((1 - p.hat) * dnorm(x, mu2.hat, sigma2.hat),
    add = TRUE, col = "red")
eigen(out$hessian, symmetric = TRUE)
�
#Confidence Interval
conf.level <- 0.95
�
mlogl <- function(theta) {
    stopifnot(is.numeric(theta))
    stopifnot(length(theta) == 5)
    mu1 <- theta[1]
    mu2 <- theta[2]
    v1 <- theta[3]
    v2 <- theta[4]
    p <- theta[5]
    logl <- sum(log(p * dnorm(x, mu1, sqrt(v1)) +
        (1 - p) * dnorm(x, mu2, sqrt(v2))))
    return(- logl)
}
�
n <- length(x)
p.start <- 1 / 2
mu1.start <- mean(sort(x)[seq(along = x) <= n / 2])
mu2.start <- mean(sort(x)[seq(along = x) > n / 2])
v1.start <- var(sort(x)[seq(along = x) <= n / 2])
v2.start <- var(sort(x)[seq(along = x) > n / 2])
theta.start <- c(mu1.start, mu2.start, v1.start,
    v2.start, p.start)
�
out <- nlm(mlogl, theta.start, fscale = length(x))
out <- nlm(mlogl, out$estimate,
    fscale = length(x), hessian = TRUE)
�
crit.val <- qnorm((1 + conf.level) / 2)
inv.fish.info <- solve(out$hessian)
for (i in 1:length(out$estimate))
    print(out$estimate[i] + c(-1, 1) * crit.val *
        sqrt(inv.fish.info[i, i]))
�
�
Pasted from <http://www.stat.umn.edu/geyer/5102/examp/like.html> 
�
There are a number of general-purpose optimization routines in base R that I'm aware of:�optim,nlminb,�nlm�and�constrOptim�(which handles linear inequality constraints, and calls�optim�under the hood). Here are some things that you might want to consider in choosing which one to use.
* optim�can use a number of different algorithms including conjugate gradient, Newton, quasi-Newton, Nelder-Mead and simulated annealing. The last two don't need gradient information and so can be useful if gradients aren't available or not feasible to calculate (but are likely to be slower and require more parameter fine-tuning, respectively). It also has an option to return the computed Hessian at the solution, which you would need if you want standard errors along with the solution itself. 
which is probably the most-used optimizer, provides a few different optimization routines; for example, BFGS, L-BFGS-B, and simulated annealing (via the SANN option),�
the latter of which might be handy if you have a difficult optimizing problem.�
�
* nlminb�uses a quasi-Newton algorithm that fills the same niche as the�"L-BFGS-B"�method inoptim. In my experience it seems a bit more robust than�optim�in that it's more likely to return a solution in marginal cases where�optim�will fail to converge, although that's likely problem-dependent. It has the nice feature, if you provide an explicit gradient function, of doing a numerical check of its values at the solution. If these values don't match those obtained from numerical differencing,�nlminb�will give a warning; this helps to ensure you haven't made a mistake in specifying the gradient (easy to do with complicated likelihoods). 
Provides a way to constrain parameter values to particular bounding boxes
�
* nlm�only uses a Newton algorithm. This can be faster than other algorithms in the sense of needing fewer iterations to reach convergence, but has its own drawbacks. It's more sensitive to the shape of the likelihood, so if it's strongly non-quadratic, it may be slower or you may get convergence to a false solution. The Newton algorithm also uses the Hessian, and computing that can be slow enough in practice that it more than cancels out any theoretical speedup.
will work just fine if the likelihood surface isn't particularly "rough" and is everywhere differentiable
* rgenoud, for instance, provides a genetic algorithm for optimization. Genetic algorithms can be slow to converge, but are usually guaranteed to converge (in time) even when there are discontinuities in the likelihood. �is set up to use�snow�for parallel processing, which helps somewhat.
http://sekhon.berkeley.edu/rgenoud/
* DEoptim�uses a different genetic optimization routine
�
�
�
Pasted from <http://stats.stackexchange.com/questions/9535/when-should-i-not-use-rs-nlm-function-for-mle> 
�
�
Very importance Source:
http://cran.r-project.org/web/views/Optimization.html
�
* Optimplex:  Provides a building block for optimization algorithms
based on a simplex. The optimsimplex package may be used in the
following optimization methods: the simplex method of Spendley
et al., the method of Nelder and Mead, Box�s algorithm for
constrained optimization, the multi-dimensional search by Torczon, etc�
�
http://cran.r-project.org/web/packages/optimsimplex/optimsimplex.pdf
http://cran.r-project.org/web/packages/optimsimplex/index.html
�
Other Optimization nonlinear Algorithms:
http://cran.r-project.org/web/packages/nloptr/nloptr.pdf
http://cran.r-project.org/web/packages/alabama/alabama.pdf
�
NLM Example:
Examples
f <- function(x) sum((x-1:length(x))^2)
nlm(f, c(10,10))
nlm(f, c(10,10), print.level = 2)
utils::str(nlm(f, c(5), hessian = TRUE))
f <- function(x, a) sum((x-a)^2)
nlm(f, c(10,10), a = c(3,5))
f <- function(x, a)
{
    res <- sum((x-a)^2)
    attr(res, "gradient") <- 2*(x-a)
    res
}
nlm(f, c(10,10), a = c(3,5))
## more examples, including the use of derivatives.
## Not run: demo(nlm)
�
Pasted from <http://stat.ethz.ch/R-manual/R-devel/library/stats/html/nlm.html> 
�
Univar ate Binomial and multinomial inference:
> x <- c(12, 8, 10)
> p <- c(0.4, 0.3, 0.3)
> chisq.test(x, p=p)
Chi-squared test for given probabilities
data: x
X-squared = 0.2222, df = 2, p-value = 0.8948
> chisq.test(x, p=p, simulate.p.value=TRUE, B=10000)
Chi-squared test for given probabilities with
simulated p-value (based on 10000 replicates)
data: x
X-squared = 0.2222, df = NA, p-value = 0.8763
�
Bayesian Inference:
library("TeachingDemos")
y <- 0; n <- 25
a1 <- 3.6; a2 <- 41.4
a <- a1 + y; b <- a2 + n
h <- hpd(qbeta, shape1=a, shape2=b)
�
Two way continuity table:
> x<- c(9,8,27,8,47,236,23,39,88,49,179,706,28,48,89,19,104,293)
> data <- matrix(x, nrow=3,ncol=6, byrow=TRUE)
> dimnames(data) = list(Degree=c("< HS","HS","College"),Belief=c("1","2","3","4","5","6"))
> install.packages("vcdExtra")
> library("vcdExtra")
> StdResid <- c(-0.4,-2.2,-1.4,-1.5,-1.3,3.6,-2.5,-2.6,-3.3,1.8,0.0,3.4,3.1,4.7,4.8,-0.8,1.1,-6.7)
> StdResid <- matrix(StdResid,nrow=3,ncol=6,byrow=TRUE)
> mosaic(data,residuals = StdResid, gp=shading_Friendly)
�
Chi-Square and Fisher's exact test; Residuals:
> data <- matrix(c(9,8,27,8,47,236,23,39,88,49,179,706,28,48,89,19,104,293),
ncol=6,byrow=TRUE)
> chisq.test(data)
Pearson�s Chi-squared test
data: data
X-squared = 76.1483, df = 10, p-value = 2.843e-12
> chisq.test(data)$stdres
[,1] [,2] [,3] [,4] [,5] [,6]
[1,] -0.368577 -2.227511 -1.418621 -1.481383 -1.3349600 3.590075
[2,] -2.504627 -2.635335 -3.346628 1.832792 0.0169276 3.382637
[3,] 3.051857 4.724326 4.839597 -0.792912 1.0794638 -6.665195
�
> yes <- c(54,25)
> n <- c(10379,51815)
> x <- c(1,0)
> fit <- glm(yes/n ~ x, weights=n, family=binomial(link=logit))
> summary(fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -7.6361 0.2000 -38.17 <2e-16 ***
x 2.3827 0.2421 9.84 <2e-16 ***
>
confint(fit)
Waiting for profiling to be done...
2.5 % 97.5 %
(Intercept) -8.055554 -7.268025
x 1.919634 2.873473
> exp(1.919634); exp(2.873473)
[1] 6.818462
[1] 17.69838
�
> tea <- matrix(c(3,1,1,3),ncol=2,byrow=TRUE)
> fisher.test(tea)
> fisher.test(table, simulate.p.value=TRUE, B=10000)
�
�
Generalized Linear Models:
> snoring <- matrix(c(24,1355,35,603,21,192,30,224), ncol=2, byrow=TRUE)
> scores <- c(0,2,4,5)
> snoring.fit <- glm(snoring ~ scores, family=binomial(link=logit))
> summary(snoring.fit)
Call:
glm(formula = snoring ~ scores, family = binomial(link = logit))
Deviance Residuals:
1 2 3 4
-0.8346 1.2521 0.2758 -0.6845
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.86625 0.16621 -23.261 < 2e-16 ***
scores 0.39734 0.05001 7.945 1.94e-15 ***
--Signif.
codes: 0 1
(Dispersion parameter for binomial family taken to be 1)
Null deviance: 65.9045 on 3 degrees of freedom
Residual deviance: 2.8089 on 2 degrees of freedom
AIC: 27.061
Number of Fisher Scoring iterations: 4
> pearson <- summary.lm(snoring.fit)$residuals # Pearson residuals
> hat <- lm.influence(snoring.fit)$hat # hat or leverage values
> stand.resid <- pearson/sqrt(1 - hat) # standardized residuals
> cbind(scores, snoring, fitted(snoring.fit), pearson, stand.resid)
scores pearson stand.resid
1 0 24 1355 0.02050742 -0.8131634 -1.6783847
2 2 35 603 0.04429511 1.2968557 1.5448873
3 4 21 192 0.09305411 0.2781891 0.3225535
4 5 30 224 0.13243885 -0.6736948 -1.1970179
> fit <- glm(y ~ x, family=quasi(variance="mu(1-mu)"),start=c(0.5, 0))
> summary(fit, dispersion=1)
> crabs <- read.table("crab.dat",header=T)
> crabs
color spine width satellites weight
1 3 3 28.3 8 3050
2 4 3 22.5 0 1550
3 2 1 26.0 9 2300
4 4 3 24.8 0 2100
5 4 3 26.0 4 2600
6 3 3 23.8 0 2100
....
173 3 2 24.5 0 2000
> weight <- weight/1000 # weight in kilograms rather than grams
> fit <- glm(satellites ~ weight, family=poisson(link=log), data=crabs)
> summary(fit)
> library(MASS)
> fit.nb <- glm.nb(satell ~ weight, link=log)
> summary(fit.nb)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -0.8647 0.4048 -2.136 0.0327 *
weight2 0.7603 0.1578 4.817 1.45e-06 ***
---
Null deviance: 216.43 on 172 degrees of freedom
Residual deviance: 196.16 on 171 degrees of freedom
AIC: 754.64
Theta: 0.931
Std. Err.: 0.168
2 x log-likelihood: -748.644
> fit <- glm(... model formula, family, data, etc ...)
> rstandard(fit, type="pearson")
# This borrows heavily from Laura Thompson�s manual at
# https://home.comcast.net/~lthompson221/Splusdiscrete2.pdf
�
> rats <- read.table("teratology.dat", header = T)
> rats # Full data set of 58 litters at course website
litter group n y
1 1 1 10 1
2 2 1 11 4
3 3 1 12 9
57 57 4 6 0
58 58 4 17 0
> rats$group <- as.factor(rats$group)
> fit.bin <- glm(y/n ~ group - 1, weights = n, data=rats, family=binomial)
> summary(fit.bin)
Coefficients: # these are the sample logits
Estimate Std. Error z value Pr(>|z|)
group1 1.1440 0.1292 8.855 < 2e-16 ***
group2 -2.1785 0.3046 -7.153 8.51e-13 ***
group3 -3.3322 0.7196 -4.630 3.65e-06 ***
group4 -2.9857 0.4584 -6.514 7.33e-11 ***
---
Null deviance: 518.23 on 58 degrees of freedom
Residual deviance: 173.45 on 54 degrees of freedom
AIC: 252.92
> (pred <- unique(predict(fit.bin, type="response")))
[1] 0.75840979 0.10169492 0.03448276 0.04807692 # sample proportions
> (SE <- sqrt(pred*(1-pred)/tapply(rats$n,rats$group,sum)))
1 2 3 4
0.02367106 0.02782406 0.02395891 0.02097744 # SE�s of proportions
> (X2 <- sum(resid(fit.bin, type="pearson")^2)) # Pearson stat.
[1] 154.707
> phi <- X2/(58 - 4) # estimate of phi for QL analysis
> phi
[1] 2.864945
> SE*sqrt(phi)
1 2 3 4
0.04006599 0.04709542 0.04055320 0.03550674 # adjusted SE�s for proportions
> fit.ql <- glm(y/n ~ group - 1, weights=n, data=rats, family=quasi(link=identity,
variance="mu(1-mu)"),start=unique(predict(fit.bin,type="response")))
> summary(fit.ql) # This shows another way to get the QL results
Coefficients:
Estimate Std. Error t value Pr(>|t|)
group1 0.75841 0.04007 18.929 <2e-16 ***
group2 0.10169 0.04710 2.159 0.0353 *
group3 0.03448 0.04055 0.850 0.3989
group4 0.04808 0.03551 1.354 0.1814
--(Dispersion
parameter for quasi family taken to be 2.864945)
�
�
Logistic Regression
> crabs <- read.table("crabs.dat",header=TRUE)
> crabs
color spine width satellites weight
1 3 3 28.3 8 3050
2 4 3 22.5 0 1550
3 2 1 26.0 9 2300
....
173 3 2 24.5 0 2000
> y <- ifelse(crabs$satellites > 0, 1, 0) # y = a binary indicator of satellites
> crabs$weight <- crabs$weight/1000 # weight in kilograms rather than grams
> fit <- glm(y ~ weight, family=binomial(link=logit), data=crabs)
> summary(fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.6947 0.8802 -4.198 2.70e-05 ***
weight 1.8151 0.3767 4.819 1.45e-06 ***
---
Null Deviance: 225.7585 on 172 degrees of freedom
Residual Deviance: 195.7371 on 171 degrees of freedom
AIC: 199.74
> crabs$color <- crabs$color - 1 # color now takes values 1,2,3,4
> crabs$color <- factor(crabs$color) # treat color as a factor
> fit2 <- glm(y ~ weight + color, family=binomial(link=logit), data=crabs)
> summary(fit2)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) -3.2572 1.1985 -2.718 0.00657 **
weight 1.6928 0.3888 4.354 1.34e-05 ***
color2 0.1448 0.7365 0.197 0.84410
color3 -0.1861 0.7750 -0.240 0.81019
color4 -1.2694 0.8488 -1.495 0.13479
---
(Dispersion Parameter for Binomial family taken to be 1 )
Null Deviance: 225.7585 on 172 degrees of freedom
Residual Deviance: 188.5423 on 168 degrees of freedom
AIC: 198.54
> yes <- c(24,35,21,30)
> n <- c(1379,638,213,254)
> scores <- c(0,2,4,5)
> fit <- glm(yes/n ~ scores, weights=n, family=binomial(link=logit))
> fit
Coefficients:
(Intercept) scores
-3.8662 0.3973
Degrees of Freedom: 3 Total (i.e. Null); 2 Residual
Null Deviance: 65.9
Residual Deviance: 2.809 AIC: 27.06
�
ROC curves:
> dose <- c(rep(1.691,59),rep(1.724,60),rep(1.755,62),rep(1.784,56),
+ rep(1.811,63),rep(1.837,59),rep(1.861,62),rep(1.884,60))
> y <- c(rep(1,6),rep(0,53),rep(1,13),rep(0,47),rep(1,18),rep(0,44),
+ rep(1,28),rep(0,28),rep(1,52),rep(0,11),rep(1,53),rep(0,6),
+ rep(1,61),rep(0,1),rep(1,60))
> fit.probit <- glm(y ~ dose, family=binomial(link=probit))
> summary(fit.probit)
Estimate Std. Error z value Pr(>|z|)
(Intercept) -34.956 2.649 -13.20 <2e-16
dose 19.741 1.488 13.27 <2e-16
---
> library("ROCR") # to construct ROC curve
> pred <- prediction(fitted(fit.probit),y)
> perf <- performance(pred, "tpr", "fpr")
> plot(perf)
> performance(pred,"auc")
Slot "y.values":
[[1]]
[1] 0.9010852 # area under ROC curve
�
Cochran-Mantel-Haenszel test:
> beitler <- c(11,10,25,27,16,22,4,10,14,7,5,12,2,1,14,16,6,0,11,12,1,0,10,10,1,1,4,8,4,6,2,1)
> beitler <- array(beitler, dim=c(2,2,8))
> mantelhaen.test(beitler, correct=FALSE)
Mantel-Haenszel chi-squared test without continuity correction
data: beitler
Mantel-Haenszel X-squared = 6.3841, df = 1, p-value = 0.01151
alternative hypothesis: true common odds ratio is not equal to 1
95 percent confidence interval:
1.177590 3.869174
sample estimates:
common odds ratio
2.134549
> mantelhaen.test(beitler, correct=FALSE, exact=TRUE)
�
Other Binary Response Models:
> fit.probit <- glm(y ~ weight, family=binomial(link=probit), data=crabs)
> summary(fit.probit)
Coefficients:
Value Std. Error t value
(Intercept) -2.238245 0.5114850 -4.375974
weight 1.099017 0.2150722 5.109989
Residual Deviance: 195.4621 on 171 degrees of freedom
> beetles <- read.table("beetle.dat", header=T)
> beetles
dose number killed
1 1.691 59 6
2 1.724 60 13
3 1.755 62 18
4 1.784 56 28
5 1.811 63 52
6 1.837 59 53
7 1.861 62 61
8 1.884 60 60
> binom.dat <- matrix(append(killed,number-killed),ncol=2)
> fit.cloglog <- glm(binom.dat ~ dose, family=binomial(link=cloglog),
data=beetles)
> summary(fit.cloglog) # much better fit than logit
Value Std. Error t value
(Intercept) -39.52250 3.232269 -12.22748
dose 22.01488 1.795086 12.26397
Null Deviance: 284.2024 on 7 degrees of freedom
Residual Deviance: 3.514334 on 6 degrees of freedom
> pearson.resid <- resid(fit.cloglog, type="pearson")
> std.resid <- pearson.resid/sqrt(1-lm.influence(fit.cloglog)$hat)
> cbind(dose, killed/number, fitted(fit.cloglog), pearson.resid, std.resid)
dose pearson.resid std.resid
1 1.691 0.1016949 0.09582195 0.1532583 0.1772659
2 1.724 0.2166667 0.18802653 0.5677671 0.6694966
3 1.755 0.2903226 0.33777217 -0.7899738 -0.9217717
4 1.784 0.5000000 0.54177644 -0.6274464 -0.7041154
5 1.811 0.8253968 0.75683967 1.2684541 1.4855799
6 1.837 0.8983051 0.91843509 -0.5649292 -0.7021989
7 1.861 0.9838710 0.98575181 -0.1249636 -0.1489834
8 1.884 1.0000000 0.99913561 0.2278334 0.2368981
> confint(fit.cloglog)
2.5 % 97.5 %
(Intercept) -46.13984 -33.49923
dose 18.66945 25.68877
�
Penalized Likelihood
�
> x <- c(12, 15, 42, 52, 59, 73, 82, 91, 96, 105, 114, 120, 121, 128, 130,
139, 139, 157, 1, 1, 2, 8, 11, 18, 22, 31, 37, 61, 72, 81, 97,
112, 118, 127, 131, 140, 151, 159, 177, 206)
> y <- c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0)
> k1 <- ksmooth(x,y,"normal",bandwidth=25)
> k2 <- ksmooth(x,y,"normal",bandwidth=100)
> plot(x,y)
> lines(k1)
> lines(k2, lty=2)
�
Generalized Additive Model:
> library(vgam)
> gam.fit <- vgam(y ~ s(weight), family=binomialff(link=logit), data=crabs)
> plot(weight, fitted(gam.fit))
�
Mutlinomial Response Models
> alligators <- read.table("alligators.dat",header=TRUE)
> alligators
lake gender size y1 y2 y3 y4 y5
1 1 1 1 7 1 0 0 5
2 1 1 0 4 0 0 1 2
3 1 0 1 16 3 2 2 3
4 1 0 0 3 0 1 2 3
5 2 1 1 2 2 0 0 1
6 2 1 0 13 7 6 0 0
7 2 0 1 0 1 0 1 0
8 2 0 0 3 9 1 0 2
9 3 1 1 3 7 1 0 1
10 3 1 0 8 6 6 3 5
11 3 0 1 2 4 1 1 4
12 3 0 0 0 1 0 0 0
13 4 1 1 13 10 0 2 2
14 4 1 0 9 0 0 1 2
15 4 0 1 3 9 1 0 1
16 4 0 0 8 1 0 0 1
> library(VGAM)
> vglm(formula = cbind(y2,y3,y4,y5,y1) ~ size + factor(lake),
family=multinomial, data=alligators)
Coefficients:
(Intercept):1 (Intercept):2 (Intercept):3 (Intercept):4 size:1
-3.2073772 -2.0717560 -1.3979592 -1.0780754 1.4582046
size:2 size:3 size:4 factor(lake)2:1 factor(lake)2:2
-0.3512628 -0.6306597 0.3315503 2.5955779 1.2160953
factor(lake)2:3 factor(lake)2:4 factor(lake)3:1 factor(lake)3:2 factor(lake)3:3
-1.3483253 -0.8205431 2.7803434 1.6924767 0.3926492
factor(lake)3:4 factor(lake)4:1 factor(lake)4:2 factor(lake)4:3 factor(lake)4:4
0.6901725 1.6583586 -1.2427766 -0.6951176 -0.8261962
Degrees of Freedom: 64 Total; 44 Residual
Residual Deviance: 52.47849
Log-likelihood: -74.42948
> library(nnet)
> fit2 <- multinom(cbind(y1,y2,y3,y4,y5) ~ size + factor(lake), data=alligators)
> summary(fit2)
Call:
multinom(formula = cbind(y1, y2, y3, y4, y5) ~ size + factor(lake),
data = alligators)
Coefficients:
(Intercept) size factor(lake)2 factor(lake)3 factor(lake)4
y2 -3.207394 1.4582267 2.5955898 2.7803506 1.6583514
y3 -2.071811 -0.3512070 1.2161555 1.6925186 -1.2426769
y4 -1.397976 -0.6306179 -1.3482294 0.3926516 -0.6951107
y5 -1.078137 0.3315861 -0.8204767 0.6902170 -0.8261528
Std. Errors:
(Intercept) size factor(lake)2 factor(lake)3 factor(lake)4
y2 0.6387317 0.3959455 0.6597077 0.6712222 0.6128757
y3 0.7067258 0.5800273 0.7860141 0.7804482 1.1854024
y4 0.6085176 0.6424744 1.1634848 0.7817677 0.7812585
y5 0.4709212 0.4482539 0.7296253 0.5596752 0.5575414
Residual Deviance: 540.0803
AIC: 580.0803
�
�
VGLM for Ordinal Models
> happy <- read.table("happy.dat", header=TRUE)
> happy
race traumatic y1 y2 y3
1 0 0 1 0 0
2 0 0 1 0 0
3 0 0 1 0 0
4 0 0 1 0 0
5 0 0 1 0 0
6 0 0 1 0 0
7 0 0 1 0 0
8 0 0 0 1 0
...
94 1 2 0 0 1
95 1 3 0 1 0
96 1 3 0 1 0
97 1 3 0 0 1
> library(VGAM)
> fit <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cumulative(parallel=TRUE), data=happy)
> summary(fit)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.51812 0.33819 -1.5320
(Intercept):2 3.40060 0.56481 6.0208
race -2.03612 0.69113 -2.9461
traumatic -0.40558 0.18086 -2.2425
Names of linear predictors: logit(P[Y<=1]), logit(P[Y<=2])
Residual Deviance: 148.407 on 190 degrees of freedom
Log-likelihood: -74.2035 on 190 degrees of freedom
Number of Iterations: 5
> fit.inter <- vglm(cbind(y1,y2,y3) ~ race + traumatic + race*traumatic,
family=cumulative(parallel=TRUE), data=happy)
> summary(fit.inter)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.43927 0.34469 -1.2744
(Intercept):2 3.52745 0.58737 6.0055
race -3.05662 1.20459 -2.5375
traumatic -0.46905 0.19195 -2.4436
race:traumatic 0.60850 0.60077 1.0129
Residual Deviance: 147.3575 on 189 degrees of freedom
Log-likelihood: -73.67872 on 189 degrees of freedom
Number of Iterations: 5
> fit2 <- vglm(cbind(y1,y2,y3) ~ race + traumatic, family=cumulative,
data=happy)
> summary(fit2)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.56605 0.36618 -1.545821
(Intercept):2 3.48370 0.75950 4.586850
race:1 -14.01877 322.84309 -0.043423
race:2 -1.84673 0.76276 -2.421095
traumatic:1 -0.34091 0.21245 -1.604644
traumatic:2 -0.48356 0.27524 -1.756845
Residual Deviance: 146.9951 on 188 degrees of freedom
Log-likelihood: -73.49755 on 188 degrees of freedom
Number of Iterations: 14
> pchisq(deviance(fit)-deviance(fit2),df=df.residual(fit)-df.residual(fit2),lower.tail=FALSE)
[1] 0.4936429
fit.probit <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cumulative(link=probit, parallel=TRUE), data=happy)
> summary(fit.probit)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.34808 0.200147 -1.7391
(Intercept):2 1.91607 0.282872 6.7736
race -1.15712 0.378716 -3.0554
traumatic -0.22131 0.098973 -2.2361
Residual Deviance: 148.1066 on 190 degrees of freedom
Log-likelihood: -74.0533 on 190 degrees of freedom
Number of Iterations: 5
To ?t the adjacent-categories logit model to the same data, we use
> fit.acat <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=acat(reverse=TRUE, parallel=TRUE), data=happy)
> summary(fit.acat)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.49606 0.31805 -1.5597
(Intercept):2 3.02747 0.57392 5.2751
race -1.84230 0.64190 -2.8701
traumatic -0.35701 0.16396 -2.1775
Names of linear predictors: log(P[Y=1]/P[Y=2]), log(P[Y=2]/P[Y=3])
Residual Deviance: 148.1996 on 190 degrees of freedom
Log-likelihood: -74.09982 on 190 degrees of freedom
Number of Iterations: 5
> fit.cratio <- vglm(cbind(y1,y2,y3) ~ race + traumatic,
family=cratio(reverse=TRUE, parallel=TRUE), data=happy)
> summary(fit.cratio)
Coefficients:
Value Std. Error t value
(Intercept):1 -0.45530 0.32975 -1.3808
(Intercept):2 3.34108 0.56309 5.9335
race -2.02555 0.67683 -2.9927
traumatic -0.38504 0.17368 -2.2170
Names of linear predictors: logit(P[Y<2|Y<=2]), logit(P[Y<3|Y<=3])
Residual Deviance: 148.1571 on 190 degrees of freedom
Log-likelihood: -74.07856 on 190 degrees of freedom
Number of Iterations: 5
�
Other Multinomial Functions:
> library(MASS)
> response <- matrix(0,nrow=97,ncol=1)
> response <- ifelse(y1==1,1,0)
> response <- ifelse(y2==1,2,resp)
> response <- ifelse(y3==1,3,resp)
> y <- factor(response)
> polr(y ~ race + traumatic, data=happy)
Call:
polr(formula = y ~ race + traumatic, data=happy)
Coefficients:
race traumatic
2.0361187 0.4055724
Intercepts:
1|2 2|3
-0.5181118 3.4005955
Residual Deviance: 148.407
AIC: 156.407
�
Loglinear Models:
�
> drugs <- read.table("drugs.dat",header=TRUE)
> drugs
a c m count
1 yes yes yes 911
2 yes yes no 538
3 yes no yes 44
4 yes no no 456
5 no yes yes 3
6 no yes no 43
7 no no yes 2
8 no no no 279
> alc <- factor(a); cig <- factor(c); mar <- factor(m)
> indep <- glm(count ~ alc + cig + mar, family=poisson(link=log), data=drugs)
> summary(indep) % loglinear model (A, C, M)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 6.29154 0.03667 171.558 < 2e-16 ***
alc2 -1.78511 0.05976 -29.872 < 2e-16 ***
cig2 -0.64931 0.04415 -14.707 < 2e-16 ***
mar2 0.31542 0.04244 7.431 1.08e-13 ***
---
Null deviance: 2851.5 on 7 degrees of freedom
Residual deviance: 1286.0 on 4 degrees of freedom
AIC: 1343.1
Number of Fisher Scoring iterations: 6
> homo.assoc <- update(indep, .~. + alc:cig + alc:mar + cig:mar)
> summary(homo.assoc) # loglinear model (AC, AM, CM)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 6.81387 0.03313 205.699 < 2e-16 ***
alc2 -5.52827 0.45221 -12.225 < 2e-16 ***
cig2 -3.01575 0.15162 -19.891 < 2e-16 ***
mar2 -0.52486 0.05428 -9.669 < 2e-16 ***
alc2:cig2 2.05453 0.17406 11.803 < 2e-16 ***
alc2:mar2 2.98601 0.46468 6.426 1.31e-10 ***
cig2:mar2 2.84789 0.16384 17.382 < 2e-16 ***
---
Null deviance: 2851.46098 on 7 degrees of freedom
Residual deviance: 0.37399 on 1 degrees of freedom
AIC: 63.417
Number of Fisher Scoring iterations: 4
> pearson <- summary.lm(homo.assoc)$residuals # Pearson residuals
> sum(pearson^2) # Pearson goodness-of-fit statistic
[1] 0.4011006
> leverage <- lm.influence(homo.assoc)$hat # leverage values
> std.resid <- pearson/sqrt(1 - leverage) # standardized residuals
> expected <- fitted(homo.assoc) # estimated expected frequencies
> cbind(count, expected, pearson, std.resid)
count expected pearson std.resid
1 911 910.383170 0.02044342 0.6333249
2 538 538.616830 -0.02657821 -0.6333249
3 44 44.616830 -0.09234564 -0.6333249
4 456 455.383170 0.02890528 0.6333249
5 3 3.616830 -0.32434090 -0.6333251
6 43 42.383170 0.09474777 0.6333249
7 2 1.383170 0.52447895 0.6333251
8 279 279.616830 -0.03688791 -0.6333249
�
Association Models:
> sexdata <- read.table("sex.dat", header=TRUE)
> attach(sexdata)
> uv <- premar*birth
> premar <- factor(premar); birth <- factor(birth)
> LL.fit <- glm(count ~ premar + birth + uv, family=poisson)
> summary(LL.fit)
Coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 4.10684 0.08951 45.881 < 2e-16 ***
premar2 -1.64596 0.13473 -12.216 < 2e-16 ***
premar3 -1.77002 0.16464 -10.751 < 2e-16 ***
premar4 -1.75369 0.23432 -7.484 7.20e-14 ***
birth2 -0.46411 0.11952 -3.883 0.000103 ***
birth3 -0.72452 0.16201 -4.472 7.74e-06 ***
birth4 -1.87966 0.24910 -7.546 4.50e-14 ***
uv 0.28584 0.02824 10.122 < 2e-16 ***
Null deviance: 431.078 on 15 degrees of freedom
Residual deviance: 11.534 on 8 degrees of freedom
AIC: 118.21
Number of Fisher Scoring iterations: 4
> u <- c(1,1,1,1,2,2,2,2,4,4,4,4,5,5,5,5)
> v <- c(1,2,4,5,1,2,4,5,1,2,4,5,1,2,4,5)
> row.fit <- glm(count ~ premar + birth + u:birth, family=poisson)
> summary(row.fit)
Coefficients: (1 not defined because of singularities)
Estimate Std. Error z value Pr(>|z|)
(Intercept) 4.98722 0.14624 34.102 < 2e-16 ***
premar2 -0.65772 0.13124 -5.011 5.40e-07 ***
premar3 0.46664 0.16266 2.869 0.004120 **
premar4 1.50195 0.17952 8.366 < 2e-16 ***
birth2 -0.31939 0.19821 -1.611 0.107103
birth3 -0.72688 0.20016 -3.632 0.000282 ***
birth4 -1.49032 0.23745 -6.276 3.47e-10 ***
birth1:u -0.59533 0.06555 -9.082 < 2e-16 ***
birth2:u -0.40543 0.06068 -6.681 2.37e-11 ***
birth3:u -0.12975 0.05634 -2.303 0.021276 *
birth4:u NA NA NA NA
Null deviance: 431.078 on 15 degrees of freedom
Residual deviance: 8.263 on 6 degrees of freedom
AIC: 118.94
Number of Fisher Scoring iterations: 4
> column.fit <- glm(count ~ premar + birth + premar:v, family=poisson)
> summary(column.fit)
Coefficients: (1 not defined because of singularities)
Estimate Std. Error z value Pr(>|z|)
Estimate Std. Error z value Pr(>|z|)
(Intercept) 1.40792 0.26947 5.225 1.74e-07 ***
premar2 -0.68466 0.29053 -2.357 0.018444 *
premar3 0.78235 0.22246 3.517 0.000437 ***
premar4 2.11167 0.18958 11.138 < 2e-16 ***
birth2 0.54590 0.11723 4.656 3.22e-06 ***
birth3 1.59262 0.14787 10.770 < 2e-16 ***
birth4 1.51018 0.16420 9.197 < 2e-16 ***
premar1:v 0.58454 0.05930 9.858 < 2e-16 ***
premar2:v 0.49554 0.07990 6.202 5.57e-10 ***
premar3:v 0.20315 0.06538 3.107 0.001890 **
premar4:v NA NA NA NA
Null deviance: 431.0781 on 15 degrees of freedom
Residual deviance: 7.5861 on 6 degrees of freedom
AIC: 118.26
Number of Fisher Scoring iterations: 4
----------------------------------------------------------------
�
Models for Matched Pairs
�
ratings <- matrix(c(175, 16, 54, 188), ncol=2, byrow=TRUE,
+ dimnames = list("2004 Election" = c("Democrat", "Republican"),
+ "2008 Election" = c("Democrat", "Republican")))
> mcnemar.test(ratings, correct=FALSE)
�
Clustered Categorical Responses: Marginal Models:
> abortion
gender response question case
1 1 1 1 1
2 1 1 2 1
3 1 1 3 1
4 1 1 1 2
5 1 1 2 2
6 1 1 3 2
7 1 1 1 3
8 1 1 2 3
9 1 1 3 3
...
5545 0 0 1 1849
5546 0 0 2 1849
5547 0 0 3 1849
5548 0 0 1 1850
5549 0 0 2 1850
5550 0 0 3 1850
> z1 <- ifelse(abortion$question==1,1,0)
> z2 <- ifelse(abortion$question==2,1,0)
> z3 <- ifelse(abortion$question==3,1,0)
> library(gee)
> fit.gee <- gee(response ~ gender + z1 + z2, id=case, family=binomial,
+ corstr="exchangeable", data=abortion)
> summary(fit.gee)
GEE: GENERALIZED LINEAR MODELS FOR DEPENDENT DATA
gee S-function, version 4.13 modified 98/01/27 (1998)
Model:
Link
Variance to Mean Relation: Binomial
Correlation Structure: Exchangeable
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
(Intercept) -0.125325730 0.06782579 -1.84775925 0.06758212 -1.85442135
gender 0.003437873 0.08790630 0.03910838 0.08784072 0.03913758
z1 0.149347107 0.02814374 5.30658404 0.02973865 5.02198729
z2 0.052017986 0.02815145 1.84779075 0.02704703 1.92324179
Working Correlation
[,1] [,2] [,3]
[1,] 1.0000000 0.8173308 0.8173308
[2,] 0.8173308 1.0000000 0.8173308
[3,] 0.8173308 0.8173308 1.0000000
> fit.gee2 <- gee(response ~ gender + z1 + z2, id=case, family=binomial,
+ corstr="independence", data=abortion)
> summary(fit.gee2)
Link: Logit
Variance to Mean Relation: Binomial
Correlation Structure: Independent
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
(Intercept) -0.125407576 0.05562131 -2.25466795 0.06758236 -1.85562596
gender 0.003582051 0.05415761 0.06614123 0.08784012 0.04077921
z1 0.149347113 0.06584875 2.26803253 0.02973865 5.02198759
z2 0.052017989 0.06586692 0.78974374 0.02704704 1.92324166
Working Correlation
[,1] [,2] [,3]
[1,] 1 0 0
: Logit
[2,] 0 1 0
[3,] 0 0 1
> geeglm(y ~ x1 + x2, family=binomial, id=subject, corst=��exchangeable��)
> insomnia<-read.table("insomnia.dat",header=TRUE)
> insomnia<-as.data.frame(insomnia)
> insomnia
case treat occasion outcome
1 1 0 1
1 1 1 1
2 1 0 1
2 1 1 1
3 1 0 1
3 1 1 1
4 1 0 1
4 1 1 1
5 1 0 1
...
239 0 0 4
239 0 1 4
> library(repolr)
> fit <- repolr(formula = outcome ~ treat + occasion + treat * occasion,
+ subjects="case", data=insomnia, times=c(1,2), categories=4,
corstr = "independence")
> summary(fit$gee)
Coefficients:
Estimate Naive S.E. Naive z Robust S.E. Robust z
factor(cuts)1 -2.26708899 0.2027367 -11.1824294 0.2187606 -10.3633343
factor(cuts)2 -0.95146176 0.1784822 -5.3308499 0.1809172 -5.2591017
factor(cuts)3 0.35173977 0.1726860 2.0368745 0.1784232 1.9713794
treat 0.03361002 0.2368973 0.1418759 0.2384374 0.1409595
occasion 1.03807641 0.2375992 4.3690229 0.1675855 6.1943093
treat:occasion 0.70775891 0.3341759 2.1179234 0.2435197 2.9063728
�
Clustered Categorical Responses: Random Effects Models:
> abortion
gender response question case
1 1 1 1 1
2 1 1 2 1
3 1 1 3 1
4 1 1 1 2
5 1 1 2 2
6 1 1 3 2
...
5548 0 0 1 1850
5549 0 0 2 1850
5550 0 0 3 1850
> z1 <- ifelse(abortion$question==1,1,0)
> z2 <- ifelse(abortion$question==2,1,0)
> z3 <- ifelse(abortion$question==3,1,0)
> library(glmmML)
> fit.glmmML <- glmmML(response ~ gender + z1 + z2,
+ cluster=abortion$case, family=binomial, data=abortion,
+ method = �ghq�, n.points=50, start.sigma=9)
> summary(fit.glmmML)
Call: glmmML(formula = response ~ gender + z1 + z2, family = binomial,
data = abortion, cluster = abortion$case, start.sigma = 9,
method = "ghq", n.points = 50)
coef se(coef) z Pr(>|z|)
(Intercept) -0.62222 0.3811 -1.63253 1.03e-01
gender 0.01272 0.4936 0.02578 9.79e-01
z1 0.83587 0.1599 5.22649 1.73e-07
z2 0.29290 0.1568 1.86822 6.17e-02
Scale parameter in mixing distribution: 8.788 gaussian
Std. Error: 0.5282
LR p-value for H_0: sigma = 0: 0
Residual deviance: 4578 on 5545 degrees of freedom AIC: 4588
�
Beta-Binomial and Quasi-likelihood Analysis
> group <- rats$group
> library(VGAM) # We use Thomas Yee�s VGAM library
> fit.bb <- vglm(cbind(y,n-y) ~ group, betabinomial(zero=2,irho=.2),
data=rats)
# two parameters, mu and rho, and zero=2 specifies 0 covariates for 2nd
# parameter (rho); irho is the initial guess for rho in beta-bin variance.
> summary(fit.bb) # fit of beta-binomial model
Coefficients:
Value Std. Error t value
(Intercept):1 1.3458 0.24412 5.5130
(Intercept):2 -1.1458 0.32408 -3.5355 # This is logit(rho)
group2 -3.1144 0.51818 -6.0103
group3 -3.8681 0.86285 -4.4830
group4 -3.9225 0.68351 -5.7387
Names of linear predictors: logit(mu), logit(rho)
Log-likelihood: -93.45675 on 111 degrees of freedom
> logit(-1.1458, inverse=T) # This is a function in VGAM
[1] 0.2412571 # The estimate of rho in beta-bin variance
> install.packages("aod") # another way to fit beta-binomial models
> library(aod)
> betabin(cbind(y,n-y) ~ group, random=~1,data=rats)
Beta-binomial model
------------------betabin(formula
= cbind(y, n - y) ~ group, random = ~1, data = rats)
Fixed-effect coefficients:
Estimate Std. Error z value Pr(> |z|)
(Intercept) 1.346e+00 2.481e-01 5.425e+00 5.799e-08
group2 -3.115e+00 5.020e-01 -6.205e+00 5.485e-10
group3 -3.869e+00 8.088e-01 -4.784e+00 1.722e-06
group4 -3.924e+00 6.682e-01 -5.872e+00 4.293e-09
Overdispersion coefficients:
Estimate Std. Error z value Pr(> z)
phi.(Intercept) 2.412e-01 6.036e-02 3.996e+00 3.222e-05
> quasibin(cbind(y,n-y) ~ group, data=rats) # QL with beta-bin variance
Quasi-likelihood generalized linear model
-----------------------------------------
quasibin(formula = cbind(y, n - y) ~ group, data = rats)
Fixed-effect coefficients:
Estimate Std. Error z value Pr(>|z|)
(Intercept) 1.2124 0.2233 5.4294 < 1e-4
group2 -3.3696 0.5626 -5.9893 < 1e-4
group3 -4.5853 1.3028 -3.5197 4e-04
group4 -4.2502 0.8484 -5.0097 < 1e-4
Overdispersion parameter:
phi
0.1923
Pearson�s chi-squared goodness-of-fit statistic = 54.0007
�
Non-Model Based Classification and Clustering
�
> library(tree)
> attach(crabs)
> fit <- rpart(y ~ color + width, method="class")
> plot(fit)
> text(fit)
> printcp(fit)
Classification tree:
rpart(formula = y ~ color + width, method = "class")
Variables actually used in tree construction:
[1] color width
Root node error: 62/173 = 0.35838
n= 173
CP nsplit rel error xerror xstd
1 0.161290 0 1.00000 1.00000 0.101728
2 0.080645 1 0.83871 1.03226 0.102421
3 0.064516 2 0.75806 0.96774 0.100972
4 0.048387 3 0.69355 0.93548 0.100149
5 0.016129 4 0.64516 0.85484 0.097794
6 0.010000 6 0.61290 0.82258 0.096728
> plotcp(fit)
> summary(fit)
> plot(fit, uniform=TRUE,
main="Classification Tree for Crabs")
> pfit2 <- prune(fit, cp= 0.02)
> plot(pfit2, uniform=TRUE,
main="Pruned Classification Tree for Crabs")
plot(pfit2, uniform=TRUE,
+ main="Pruned Classification Tree for Crabs")
> text(pfit2, use.n=TRUE, all=TRUE, cex=.8)
> post(pfit2, file = "ptree2.ps",
title = "Pruned Classification Tree for Crabs")
post(pfit2, file = "ptree2.ps",
+ title = "Pruned Classification Tree for Crabs")
�
Cluster Analysis
> x <- read.table("election.dat", header=F)
> x
V1 V2 V3 V4 V5 V6 V7 V8 V9
1 0 0 0 0 1 0 0 0
2 0 0 0 1 1 1 1 1
3 0 0 0 1 0 0 0 1
4 0 0 0 0 1 0 0 1
5 0 0 0 1 1 1 1 1
6 0 0 1 1 1 1 1 1
7 1 1 1 1 1 1 1 1
8 0 0 0 1 1 0 0 0
9 0 0 0 1 1 1 0 1
10 0 0 1 1 1 1 1 1
11 0 0 0 1 1 0 0 1
12 0 0 0 0 0 0 0 0
13 0 0 0 0 0 0 0 1
14 0 0 0 0 0 0 0 0
> distances <- dist(x,method="manhattan")
> states <- c("AZ", "CA", "CO", "FL", "IL", "MA", "MN",
"MO", "NM", "NY", "OH", "TX", "VA", "WY")
> democlust <- hclust(distances,"average")
> postscript(file="dendrogram-election.ps")
> plot(democlust, labels=states)
> graphics.off()
�
Read Excel file:
library(xlsx);
mydata<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
�
Repeat columns:
matrix(rep(x,each=n), ncol=n, byrow=TRUE)
�
Pasted from <http://www.r-bloggers.com/a-quick-way-to-do-row-repeat-and-col-repeat-rep-row-rep-col/> 
�
�
Repeat Rows
matrix(rep(x,each=n),nrow=n)
�
Pasted from <http://www.r-bloggers.com/a-quick-way-to-do-row-repeat-and-col-repeat-rep-row-rep-col/> 
�
Define identity matrix:
Diag(n)
Create a Diagonal matrix with diagonal of a vector:
diag(5)*c(1,2,3,4,5)
�
Matrix facilites
In the following examples,�A�and�B�are matrices and�x�and�b�are a vectors.
�
Operator or Function
Description
A * B
Element-wise multiplication
A %*% B
Matrix multiplication
A %o% B
Outer product.�AB'
crossprod(A,B)
crossprod(A)
A'B�and�A'A�respectively.
t(A)
Transpose
diag(x)
Creates diagonal matrix with elements of�x�in the principal diagonal
diag(A)
Returns a vector containing the elements of the principal diagonal
diag(k)
If k is a scalar, this creates a k x k identity matrix. Go figure.
solve(A, b)
Returns vector�x�in the equation�b = Ax�(i.e.,�A-1b)
solve(A)
Inverse of�A�where A is a square matrix.
ginv(A)
Moore-Penrose Generalized Inverse of�A.�
ginv(A) requires loading the�MASS�package.
y<-eigen(A)
y$val�are the eigenvalues of�A
y$vec�are the eigenvectors of�A
y<-svd(A)
Single value decomposition of�A.
y$d�= vector containing the singular values of�A
y$u�= matrix with columns contain the left singular vectors of�A�
y$v�= matrix with columns contain the right singular vectors of�A
R <- chol(A)
Choleski factorization of�A. Returns the upper triangular factor, such that�R'R = A.
y <- qr(A)
QR decomposition of�A.�
y$qr�has an upper triangle that contains the decomposition and a lower triangle that contains information on the Q decomposition.
y$rank�is the rank of A.�
y$qraux�a vector which contains additional information on Q.�
y$pivot�contains information on the pivoting strategy used.
cbind(A,B,...)
Combine matrices(vectors) horizontally. Returns a matrix.
rbind(A,B,...)
Combine matrices(vectors) vertically. Returns a matrix.
rowMeans(A)
Returns vector of row means.
rowSums(A)
Returns vector of row sums.
colMeans(A)
Returns vector of column means.
colSums(A)
Returns vector of coumn means.
�
Pasted from <http://www.statmethods.net/advstats/matrix.html> 
�
Convert matrix to vector:
As.vector(A)
http://stackoverflow.com/questions/3823211/how-to-convert-a-matrix-to-a-1-dimensional-array-in-r
�
Text Mining Using R:
# preprocessing of the document
library(tm)
firefox.csv<-read.csv("c:/CDBookSurvay/Comments.csv")
firefox <- Corpus(DataframeSource(firefox.csv)) # create corpus for analysis
firefoxcopy <- firefox # keep a copy of corpus to use later as a dictionary for stem completion
firefox <-tm_map(firefox, tolower) # convert to lower case
firefox <- tm_map(firefox, removeNumbers) # remove numbers
for (j in 1:length(firefox)) firefox[[j]] <- gsub("'", " ",firefox[[j]])# to remove special puncutation but not connect
firefox <- tm_map(firefox, removePunctuation)# remove punctuations
firefox <- tm_map(firefox, removeWords, stopwords("english")) #remove stop words
newstopwords <- c("and", "for", "the", "to", "in", "when", "then", "he", "she", "than", "a", "for", "it", "of", "on", "to","im")
firefox <- tm_map(firefox, removeWords, newstopwords)
�
firefox <- tm_map(firefox, stemDocument)# stem words
inspect(firefox[1:10])
firefox <- tm_map(firefox, stemCompletion, dictionary=firefoxcopy) #stem completion
�
inspect(firefoxcopy[1:10])
summary(firefox)
myTdm <- TermDocumentMatrix(firefox, control = list(wordLengths=c(1,Inf)))
myTdm # printing dtm summery
idx <- which(dimnames(myTdm)$Terms =="alexa")
�
inspect(myTdm[idx+(0:5),1:10]) # look at 5 keywords after the keyword alexa over 10 documents that used for dtm
inspect(myTdm[0:20,1:10]) # check items of dtm
rownames(myTdm) # write all the keywords you have used
findFreqTerms(myTdm, lowfreq=3) #find frequent terms 
�
# plot of more frequent words
termFrequency <- rowSums(as.matrix(myTdm)) # go over matrix and filtering for drawing a plot
termFrequency <- subset(termFrequency, termFrequency>=3) # go for terms that are in text more than 3 times
library(ggplot2) # use graphic package to draw plots
qplot(names(termFrequency), termFrequency, geom="bar") + coord_flip() # draw horizontal bar plot
barplot(termFrequency, las=2) # draw vertical bar plot
findAssocs(myTdm, "love", 0.25)# find words with highest asociation
 
library(wordcloud) # used for importance of the word check
m <- as.matrix(myTdm) # convert document term matrix to normal matrix
# calculate the frequency of words and sort it descendingly by frequency
wordFreq <- sort(rowSums(m), decreasing=TRUE)
# word cloud
set.seed(375) # to make it reproducible
grayLevels <- gray( (wordFreq+10) / (max(wordFreq)+10) )
# frequency below 1 is not ploted in the following
# random.order=F: frequent words plotted first in the center of the cloud
# set colour to: grayLevels or raingbow() to colorful or gray map
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=2, random.order=F,colors=grayLevels)
�
# clustering
# remove sparse terms
# you can remove sparce terms to avoid being flooded with words
myTdm2 <- removeSparseTerms(myTdm, sparse=0.95)
m2 <- as.matrix(myTdm2)
# cluster of terms/words (come together e.g. couple of twits on text mining analysis, and couple of twits on job vacancies in PhD in different clusters)
distMatrix <- dist(scale(m2)) # calculate distance between terms after scaling
fit <- hclust(distMatrix, method="ward") # clustering agglomeration method is set to ward: icreased variance when two clusters are merged; other options are:  single linkage, complete linkage, average linkage, median and centroid
plot(fit)
# cut tree into 10 clusters
rect.hclust(fit, k=10) # cut into 10 clusters
(groups <- cutree(fit, k=10))
�
# clustering using k-min of documents
# transpose the matrix to cluster documents (tweets)
m3 <- t(m2) # take value of matrix as numeric & transpose to document term
# set a fixed random seed
set.seed(122) # to produce the clustering result
# k-means clustering of tweets
k <- 3 # 8 clusters
kmeansResult <- kmeans(m3, k) 
# cluster centers
round(kmeansResult$centers, digits=3) # popular words in cluster and center
�
# check k mean cluster by top 3 words
for (i in 1:k) {
cat(paste("cluster ", i, ": ", sep=""))
s <- sort(kmeansResult$centers[i,], decreasing=T)
cat(names(s)[1:3], "\n")
# print the tweets of every cluster
# print(rdmTweets[which(kmeansResult$cluster==i)])
}
�
library(Rgraphviz)# to use for cluster assowciation matrix
plot(myTdm, terms = findFreqTerms(myTdm, lowfreq = 1)[1:20], corThreshold = 0)
�
library(fpc)#draw cluster based on matrix
plotcluster(m3, kmeansResult$cluster)
�
library(fpc) # clustering with Partitioning Around Medoids (PAM): (representative objects) more robust to noise and outliers than k-means clustering
# partitioning around medoids with estimation of number of clusters
pamResult <- pamk(m3, metric = "manhattan") # estimate number of optimal clusters
# number of clusters identified
(k <- pamResult$nc)
pamResult <- pamResult$pamobject
# print cluster medoids
for (i in 1:k) {
cat(paste("cluster", i, ": "))
cat(colnames(pamResult$medoids)[which(pamResult$medoids[i,]==1)], "\n")
#print tweets in cluster i
# print(rdmTweets[pamResult$clustering==i])
} 
�
# plot clustering result
layout(matrix(c(1,2),2,1)) # set to two graphs per page
plot(pamResult, color=F, labels=4, lines=0, cex=.8, col.clus=1,
col.p=pamResult$clustering)
layout(matrix(1)) # change back to one graph per page
�
#create social network of terms
termDocMatrix<-m2
termDocMatrix[1:5,1:5] # check Tdm
# change it to a Boolean matrix
termDocMatrix[termDocMatrix>=1] <- 1
# transform into a term-term adjacency matrix
termMatrix <- termDocMatrix %*% t(termDocMatrix) # %*% product of two matrices
# inspect terms numbered 5 to 7
termMatrix[5:7,5:7]
library(igraph)
# build a graph from the above matrix
g <- graph.adjacency(termMatrix, weighted=T, mode = "undirected")
# remove loops
g <- simplify(g)
# set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)
�
#dynamically rearranged layout get detail by running ?igraph::layout
plot(g, layout=layout.kamada.kawai)
tkplot(g, layout=layout.kamada.kawai)#extremely interesting graph creation
�
pdf("term-network.pdf") # put terms plot in a pdf file
plot(g, layout=layout.fruchterman.reingold)
dev.off()
�
# size of plot's term according to the degree: important terms stand out
# set the width and transparency of edges based on their weights
# vertices and edges are accessed with V() and E()
# rgb(red, green, blue,alpha) defines a color with an alpha transparency
V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color <- rgb(0, 0, .2, .8)
V(g)$frame.color <- NA
egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam
# plot the graph in layout1
plot(g, layout=layout1)
�
#build network of documents (tweets) first phase
# remove "r", "data" and "mining" most used if they make the document crowded
# idx <- which(dimnames(termDocMatrix)$Terms %in% c("r", "data", "mining"))
#M <- termDocMatrix[-idx,] # remove terms from matrix
M<-termDocMatrix # since I did not wanted to remove anything
# build a tweet-tweet adjacency matrix
tweetMatrix <- t(M) %*% M
library(igraph)
g <- graph.adjacency(tweetMatrix, weighted=T, mode = "undirected")
V(g)$degree <- degree(g)
g <- simplify(g)
# set labels of vertices to tweet IDs
V(g)$label <- V(g)$name
V(g)$label.cex <- 1
V(g)$label.color <- rgb(.4, 0, 0, .7)
V(g)$size <- 2
V(g)$frame.color <- NA
barplot(table(V(g)$degree)) # check degree distribution of vertices
�
#build network of documents (tweets) second phase
idx <- V(g)$degree == 0
V(g)$label.color[idx] <- rgb(0, 0, .3, .7) # set based on degree
# set labels to the IDs and the first 10 characters of tweets
# limit to the first 20 character of every tweet
# label of each set to tweet ID so that graph would not be overcrowded
# set color and width of edges based on their weights
#V(g)$label[idx] <- paste(V(g)$name[idx], substr(df$text[idx], 1, 20), sep=" ")
egam <- (log(E(g)$weight)+.2) / max(log(E(g)$weight)+.2)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam
set.seed(3152)
layout2 <- layout.fruchterman.reingold(g)
plot(g, layout=layout2)
�
# remove isolated vertices and draw again
g2 <- delete.vertices(g, V(g)[degree(g)==0]) 
plot(g, layout=layout2)
�
# remove edges with low degree and draw again
g3 <- delete.edges(g, E(g)[E(g)$weight <= 1])
g3 <- delete.vertices(g3, V(g3)[degree(g3) == 0])
plot(g3, layout=layout.fruchterman.reingold)
�
# look at specific clique: considerably connected {replacement for dftext
inspect(firefox[c(15,16)])
�
#graph g directly from termDocMatrix
# create a graph
g <- graph.incidence(termDocMatrix, mode=c("all"))
# get index for term vertices and tweet vertices
nTerms <- nrow(M)
nDocs <- ncol(M)
idx.terms <- 1:nTerms
idx.docs <- (nTerms+1):(nTerms+nDocs)
# set colors and sizes for vertices
V(g)$degree <- degree(g)
V(g)$color[idx.terms] <- rgb(0, 1, 0, .5)
V(g)$size[idx.terms] <- 6
V(g)$color[idx.docs] <- rgb(1, 0, 0, .4)
V(g)$size[idx.docs] <- 4
V(g)$frame.color <- NA
# set vertex labels and their colors and sizes
V(g)$label <- V(g)$name
V(g)$label.color <- rgb(0, 0, 0, 0.5)
V(g)$label.cex <- 1.4*V(g)$degree/max(V(g)$degree) + 1
# set edge width and color
E(g)$width <- .3
E(g)$color <- rgb(.5, .5, 0, .3)
set.seed(958)#5365, 227
plot(g, layout=layout.fruchterman.reingold)
�
# returns all vertices of "love" # if node does not exist returns "invalid vertex name"
V(g)[nei("love")]
V(g)[neighborhood(g, order=1, "love")[[1]]]# alternative way of geting vertices
�
#check which vertices include all three elements "thank", "perfect", "love"
(rdmVertices <- V(g)[nei("love") & nei("perfect") & nei("thank")])
inspect(firefox[as.numeric(rdmVertices$label)])# check content of the doc that includes these three terms
�
# remove three words to see the relationship with doc with other words
idx <- which(V(g)$name %in% c("love", "perfect", "thank"))
g2 <- delete.vertices(g, V(g)[idx-1])
g2 <- delete.vertices(g2, V(g2)[degree(g2)==0])
set.seed(209)
plot(g2, layout=layout.fruchterman.reingold)
�
Global Variable in R:
Variables declared inside a function are local to that function. For instance:
foo <- function() {
    bar <- 1
}
foo()
bar
gives the following error:�Error: object 'bar' not found.
If you want to make�bar�a global variable, you should do:
foo <- function() {
    bar <<- 1
}
foo()
bar
In this case�bar�is accessible from outside the function.
However, unlike C, C++ or many other languages, brackets do not determine the scope of variables. For instance, in the following code snippet:
if (x > 10) {
    y <- 0
}
else {
    y <- 1
}
y�remains accessible after the�if-else�statement.
As you well say, you can also create nested environments. You can have a look at these two links for understanding how to use them:
�
Pasted from <http://stackoverflow.com/questions/10904124/global-and-local-variables-in-r> 
�
�
To access a global variable in R you do not need to do anything you just use the name.
�
For example, from�?Sys.sleep
testit <- function(x)
{
    p1 <- proc.time()
    Sys.sleep(x)
    proc.time() - p1 # The cpu usage should be negligible
}
testit(3.7)
Yielding
> testit(3.7)
   user  system elapsed 
  0.000   0.000   3.704 
�
Pasted from <http://stackoverflow.com/questions/1174799/how-to-make-execution-pause-sleep-wait-for-x-seconds> 
�
Ways to pause the program:
�'par(ask = TRUE)'�
�
Pasted from <http://tolstoy.newcastle.edu.au/R/help/04/11/8084.html> 
�
Readline()
�
Elementwise comparison of two vectors:
Assuming that the vectors�x�and�y�are of the same length,�pmax�is your function.
z = pmax(x, y)
If the lengths differ, the�pmax�expression will return different values than your loop, due to recycling.
�
Pasted from <http://stackoverflow.com/questions/14092922/finding-maximum-of-two-vectors-without-a-loop> 
�
Break Program while executing keyboard shortcut: ESC
�
With Heterogeneity Model for Behavioral pricing (Regret Project):
rm(list = ls());
�
# model with heterogeneity without fixed effect on the data
#use Gradient Methods, Genetic Algorithim, and ...
# parameters to estimate are: [alpha c bp alphap betar] where alpha is
# not fixed effect here, but an intercept
# alpha_e c_e bp_e alphap_e betar_e*c
�
#defining functions
# function to conduct contraction mapping and over real data so include
# Durations as well, and this is for cost heterogeneity
FuncWithHetroWithRegrtRD = function(x){
#global P1 P2 Dur1 Dur2 lambda gamma shares  km cost; #outside_n
#global vcm se_est betas variance
#gamma: the discount factor
#P1: price for first period
#P2: price for 2nd period
#lambda: Availability of second period
#arranging matrixes
#J: number of products under study = 106 in hour example
#T: number of periods =2 in hour example
#heterogeneous beta includes beta_ip, beta_ir, alpha_ip
J = dim(shares)[1];
T = dim(shares)[2];
�
# parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x[1])/(1+exp(x[1])); #share of first segment (use transformation to make sure it is between zero and one)
# use transformation to make sure that it is lower
bp       =  -exp(x[2]); #price coefficient difference heterogeneity coeff
alphap   =  -exp(x[3]); #high price regret difference heterogeneity coeff
betar    =  -exp(x[4]); #stock out regret difference heterogeneity coeff
# cat('input parameters for function are for [pi1 bp alphap betar] are: \n')
# cbind(pi1,bp,alphap,betar);
# pause
dd       =  matrix(rep(0,(J*T)),nrow=J,ncol=T); #since I have three periods and 
uij1     =  matrix(rep(0,J),nrow=J,ncol=2);
uij2     =  matrix(rep(0,J),nrow=J,ncol=2);
k        =  100;
de1      =  dd;
i        =  0; # track contraction mapping
#contraction mapping
cat(k,'k','\n')
cat(km,'km','\n')
while(k>km){
    i    =   i+1;
    if (ceiling(i/1000) == (i/1000)){
        cat(i,'\n');
        #median(as.vector(de1)-as.vector(de))
    ��������if (ceiling(i/1000)>80){
    ����������������stop("too many iterations");
    ��������}
    }
    de   =   de1;
    # calculate utility
    uij1[,1] =      de[,1];
    uij2[,1] =      de[,2];
    uij1[,2] =      de[,1]+bp*P1+ alphap*lambda*(P1-P2);
    uij2[,2] =      de[,2]+gamma*(lambda*(bp*P2)+ betar*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
    e1=exp(uij1); e2=exp(uij2);                                                                     #*cost
    shares_e=cbind((e1/(1+e1+e2))%*%matrix(c(pi1,1-pi1),nrow=2,ncol=1),(e2/(1+e1+e2))%*%matrix(c(pi1,1-pi1),nrow=2,ncol=1));
    shares_e=pmax(shares_e,0.00000001);   #As a precaution
    de1    =  de  + log(shares)-  log(shares_e) ;  
    k      =  max(abs(as.vector(de1)-as.vector(de)));
    #cat(k,'\n');
}
dd                       =    de1; # first segment utility portion
# run regression to find linear parameters
shares_n = matrix(t(dd),nrow=J*2,ncol=1); #stack shares on top of eachother
#cat(shares_n)
#pause
# with fixed effect models
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
#  heterogeneity in consumption utility explained by cost
p = 5;
X1 = cbind(rep(1,J),(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
X2= cbind(gamma*lambda,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
�
X = t(cbind(X1,X2));
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn= shares_n;
#log(shares_n./outside_n);
�
#OLS global setting
betas<<-solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors<<-Yn-Xn%*%betas;
vcm<<-as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est<<-sqrt(diag(vcm));
#OLS Local setting
betas=solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors=Yn-Xn%*%betas;
vcm=as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est=sqrt(diag(vcm));
# calculate variance
variance                 <<-    colMeans(errors^2)*2*J/(2*J-1); 
�
# to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
s1    =     e1/(1+e1+e2);
s11   =     1-s1;
s1=pmax(s1,0.00000001); #As a precaution
s11=pmax(s11,0.00000001); #As a precaution
s2    =     e2/(1+e1+e2);
s21   =     1-s2;
s2=pmax(s2,0.00000001);   #As a precaution
s21=pmax(s21,0.00000001); #As a precaution
Jacobian                 =    cbind((s1*s11)%*%matrix(c(pi1,1-pi1)),(s2*s21)%*%matrix(c(pi1,1-pi1)));
LogJacobian              =    -sum(log(as.vector(Jacobian)));
�
LogDemandShockLikelihood =    - T*J*log(sqrt(2*pi*variance)) -   .5*colSums(errors^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood ;
#cat ('set of (Jacobian, likelihood, Log demand shock Likelihood) is:\n');
#cat (cbind(LogJacobian,likelihood,LogDemandShockLikelihood),'\n');
#readline()
return(y);
}
�
�
#data
#global P1 P2 Dur1 Dur2 lambda gamma shares km cost #outside_n
#global vcm se_est betas variance
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
�
# test for cut off of second period
# P3=num[,13];
# P4=num[,16];
# Dur3=num[,14];
# S3=num[,15];
# S2=S3;
# P2=P4;
#Dur2=Dur3;
�
# test for average of second period availability, and normalized S2
lambda  = Av2;
# use normalize availability
#lambda      =   Av2/Av1; #availability
#lambda  = Av3; # availability at the beggining of second period
�
# test for normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/lambda;
MKTSz = MKTSz + (cf*S2); 
�
# tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711
�
#gamma =.975; #discount factor
gamma=1/(1+.0025)^Dur1;
# create shares
shares=cbind(S1/MKTSz,S2/MKTSz);
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
shares_n=matrix(shares,nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
# parameters of heterogeneity [pi1 bp alphap betar*c] difference with main
# cat('main parameters for [pi1 bp alphap betar] are:\n')
#cbind(pi1,bpd,alphapd,betard*c)
#readline()
km   =    0.001;
shares=pmax(shares,0.00000001);   #As a precaution
Rprof("AggregLogitWHeterogen.out")
#X0 =  c(0.5,0.2,0.3,0.4);
#X0 =  c(0.1,0.1,0.1,0.1);
X0=  c(0.5,0.5,0.5,0.5);
#X0= matrix(c(0.5,0.5,0.5,0.8),nrow=1,ncol=4);
#X0= rep(0,4);
#X0= c(0.8,0.8,1,0.8);
#c(log(pi1/(1-pi1)),log(-bpd),log(-alphapd),log(-betard*c));
#options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
# no fixed effect
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRD',X0,options);
#fixed effect heterogeneity
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDFE',X0,options);
�
# heterogeneity by cost
#first optimization method
out <- nlm(FuncWithHetroWithRegrtRD , X0, hessian = TRUE,
     print.level = 2)
print(out)
fval=out$minimum;
x=out$estimate;
exitflag=out$code;
grad=out$gradient;
hessian=out$hessian;
�
#second optimization method
library(numDeriv)
out <- nlminb(X0, FuncWithHetroWithRegrtRD)
print(out);
x=out$par;
hessian <- hessian(func=FuncWithHetroWithRegrtRD, x=out$par)
�
#third Optimization Method
# method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"
#method that worked well: L-BFGS-B
#Method "L-BFGS-B" is that of Byrd et. al. (1995) which allows box constraints, that is each variable can be given a lower and/or upper bound. The initial value must satisfy the constraints. This uses a limited-memory modification of the BFGS quasi-Newton method. If non-trivial bounds are supplied, this method will be selected, with a warning.
out <- optim(X0, FuncWithHetroWithRegrtRD, method="L-BFGS-B",
             control = list(maxit = 30000, temp = 2000, trace = TRUE,
                                          REPORT = 500), hessian=T) #, fnscale=-1
x = out$par;
hessian = out$hessian;
fval = out$value;
#Fourth optimization Method: Genetic Algorithm
library(rgenoud)
out <- genoud(FuncWithHetroWithRegrtRD,  nvars=4,max=FALSE) #didn't work
�
library(DEoptim)
lower <- c(-10,-10)
upper <- -lower
�
## run DEoptim and set a seed first for replicability
#set.seed(1234)
#DEoptim(FuncWithHetroWithRegrtRD, lower, upper)
�
x = out$par;
hessian = out$hessian;
fval = out$value;
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDCH',X0,options);
cat('estimation time is:\n');
Rprof(NULL);
#params=cbind(alpha,c,bp(1,1),alpha(1,1),betar(1,1));
�
# no fixed effect simple intercept
p = 5;
betas   =  t(betas);
se_est  =  t(se_est);
a_e     =  t(betas[1,1:(p-4)]);
c_e     =  betas[1,(p-3)];
bp_e    =  betas[1,(p-2)];
alphap_e=  betas[1,(p-1)];
tt1_e   =  betas[1,p];
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*J;
ParamCovar =vcm[c(p-3,p),c(p-3,p)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
�
cat('threshold parameter for contraction mapping is:\n');
cat(km,'\n');
#cat('Seed for random generation is:\n');
#cat(SEED1);
# c bp alphap betar 
# cat('parameters estimation for: a c bp alphap betar are:\n');
# cat(cbind(t(betas[1,1:4]),betar_e),'\n');
#cat(cbind(t(betas[1,1:4]/se_est[1,1:4]),betar_e/betarSTE]),'\n');
cat('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:\n');
cat(cbind(t(betas[1,(p-3):(p-1)]),betar_e), '\n');
cat(cbind(t(se_est[1,(p-3):(p-1)]),betarSTE),'\n');
cat(cbind(t(betas[1,(p-3):(p-1)]/se_est[1,(p-3):(p-1)]),betar_e/betarSTE),'\n');
# intercept, single intercept
cat('Intercept is: \n');
cat(betas[1,(p-4)],'\n');
cat(se_est[1,(p-4)],'\n');
cat(betas[1,(p-4)]/se_est[1,(p-4)],'\n');
�
# parameters of heterogeneity [pi betap alphap betar]
ste = diag(solve(hessian));
ste = sqrt(ste);
trat = cbind(exp(x[1])/(1+exp(x[1])),t(-exp(x[2:3])/ste[2:3]));
tth1_e=-exp(x[4]);
betarh_e =tth1_e/c_e;
STEFOCh=cbind(1/c_e,-tth1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*2*J;
ParamCovarh =diag(2)*c(vcm[p-3,p-3],ste[4]^2)*(2*J);
betarSTEh=sqrt(STEFOCh%*%ParamCovarh%*%t(STEFOCh)/(2*J));
cat('parm estimates for heterogeneity (pi,bp,alphap,betar) are:\n');
cat(cbind(exp(x[1])/(1+exp(x[1])),t(-exp(x[2:3])), betarh_e),'\n');
cat(cbind(t(ste[1:3]),betarSTEh));
cat(cbind(t(trat[1:3]),betarh_e/betarSTEh));
cat('log likelihood value is:\n');
cat(-fval);
LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n'); 
�
�
# regret coefficient
#[betar; betas(1,5)/(alpha+c+gamma*c); betas(1,6)/betas(1,3);betarmean]
�
�
#se_est';
�
GMM code of Regret pricing Project:
�
rm(list = ls());
# GMM Function of full model analysis
MeisamGMMfunc = function(p){
#global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
# parameters: (bp,ah,a, c, tt)
bp = -exp(p[1]);
ah = -exp(p[2]);
a  = exp(p[3]);
c  = exp(p[4]);
tt = p[5];
v  = p[6]^2; # to make sure that variance is positive
rho = exp(p[7])/(1+exp(p[7])); # assuming autocorrelation
#rp = exp(p[7]);
�
# F.O.C is summarized to:
  # F.O.C is summarized to:
  # 1. E(D1*bp+D2*ah+C1)=0
# 2. E(D3*bp+D4*ah+C2)=0
# 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
# 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
# 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
#.*cost
�
y1 = D1*bp+C1+D2*ah; #
y2 = D3*bp+C2+D4*ah; #
y3 = -D5+a+D6*c*cost+bp*P1+D7*ah; #
y4 = -D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost;#
y5 = (-D5+a+D6*c*cost+bp*P1+D7*ah)^2-v; #
y6 = (-D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost)^2-v; #
y7 = (-D5+a+D6*c*cost+bp*P1+D7*ah)*(-D8+D9*a+D11*c*cost+r*bp*P2+D10*tt*cost)-rho*v;#
sig = cbind(y1,y2,y3,y4,y5,y6,y7);
cat(dim(sig),'sigma dim\n');
sig = (t(sig)%*%sig)/J;
sig <<- (t(sig)%*%sig)/J;
cat(dim(sig),'sigma dim\n');
psi = t(cbind(mean(y1),mean(y2),mean(y3),
mean(y4),mean(y5),mean(y6),
mean(y7)));
cat(dim(psi),'dim of psi \n')
cat(dim(ginv(sig)),'dim of siginv \n')
llh = t(psi)%*%ginv(sig)%*%psi*J;
return (llh);
}
�
#global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
A  = Av2;
# normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/A;
MKTSz = MKTSz + (cf*S2); 
r=1./(1+.0025)^Dur1;
shares=cbind(S1/MKTSz,S2/MKTSz);
#normalize Market size
MKTSz=MKTSz/10000;
# put back shares so that it is used in calculation of F.O.C components
S1=shares[,1];
S2=shares[,2];
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
d=rep(1,J)-P2/P1; # (1-d)P1=P2
# F.O.C is summarized to:
# 1. E(D1*bp+D2*ah+C1)=0
# 2. E(D3*bp+D4*ah+C2)=0
# 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
# 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
# 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
# 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
# tt1=br*c
#parameters are: (bp,ah,a, c, tt1,v)
D1=S1*(P1-cost)-S1^2*(P1-cost)-r*A*(1-d)*S1*S2*(P1-cost)+r^2*A*(1-d)^2*S2*(P1-cost)-S1*S2*(1-d)*(P1-cost)*r-r^2.*A*(1-d)^2.*S2^2*(P1-cost);
D2=P1*d*S1-A*d*S1^2*P1-A*d*S1*S2*(1-d)*P1^r;
C1=S1+r*(1-d)*S2;
D3=r*A*P1*(P1-cost)*S1*S2-r^2*A*P1*(P1-cost)*(1-d)*S2+r^2*A*P1*(P1-cost)*(1-d)*S2^2;
D4=A*P1^2*S1*P1-A*S1^2*P1^2-r*A*S1*S2*(1-d)*P1^2;
C2=-r*S2*P1;
D5=shares[,1]-outside[,1];
D6=(0.5*Dur1+r*Dur2); #consider duration effect on consumption
D7=A*(P1-P2);
D8=shares[,2]-outside[,2];
D9=A*r;
D11 = A*r*Dur2*.5; #include duration of usage into the model
D10=r*(1-A)*(.5*Dur1+r*Dur2); #include duration of usage in the model
D12 =r*A*(P1-P2);#.*cost
# parameters: (bp,ah,a, c, tt, v, kt)
init_p =   c(-0.018,-0.1,0.1,0.6,-0.08,1,.5);
# c(-0.3,-3,.5,1,-0.8,20,.2);
# c(-0.018,-0.04,0.1,0.5,-0.018,10,.01);
# c(-2,-1,1,1,1,-1,1);
# c(-0.2,-0.3,0.3,0.5,0.1,1);
# rep(0,6);
# c(-0.01,-.3,0.1,0.5,0.1,1);
Rprof("GMM.out");
�
# heterogeneity by cost
#first optimization method
library(MASS)
out <- nlm(MeisamGMMfunc, init_p, hessian = TRUE,
     print.level = 2)
print(out);
fval=out$minimum;
param=out$estimate;
exitflag=out$code;
grad1=out$gradient;
hess1=out$hessian;
�
#second optimization method
library(numDeriv)
out <- nlminb(init_p, MeisamGMMfunc)
print(out);
param=out$par;
hess1<- hessian(func=MeisamGMMfunc, x=out$par)
�
#third Optimization Method
# method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"
#method that worked well: L-BFGS-B
#Method "L-BFGS-B" is that of Byrd et. al. (1995) which allows box constraints, that is each variable can be given a lower and/or upper bound. The initial value must satisfy the constraints. This uses a limited-memory modification of the BFGS quasi-Newton method. If non-trivial bounds are supplied, this method will be selected, with a warning.
out <- optim(init_p, MeisamGMMfunc, method="L-BFGS-B",
             control = list(maxit = 30000, temp = 2000, trace = TRUE,
                                          REPORT = 500), hessian=T) #, fnscale=-1
param = out$par;
hess1= out$hessian;
fval = out$value;
�
#Fourth optimization Method: Genetic Algorithm
library(rgenoud)
out <- genoud(MeisamGMMfunc,  nvars=7,max=FALSE) #didn't work
�
library(DEoptim)
lower <- c(-10,-10)
upper <- -lower
�
## run DEoptim and set a seed first for replicability
#set.seed(1234)
DEoptim(MeisamGMMfunc, lower, upper)
�
param = out$par;
hess1= out$hessian;
fval = out$value;
�
�
Rprof(NULL);
std = diag(ginv(hess1));
std = sqrt(std);
trat = cbind(t(-exp(param[1:2])),t(exp(param[3:4])))/t(std[1:4]);
cat('parm estimates and t-stat for (bp,ah,a, c, v) are: \n');
cat(cbind(t(-exp(param[1:2])),t(exp(param[3:4])),param[6]^2),'\n')
cat(cbind(t(trat[1:4]),(param(6)^2)/std[6]));
bp_e = -exp(param[1]);
ah_e = -exp(param[2]);
a_e  = exp(param[3]);
c_e  = exp(param[4]);
tt1_e = param[5];
v_e = param[6]^2;
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
ParamCovar =hess1[c(4,5),c(4,5)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
cat('stock out regret coefficient and tstat is is: \n');
cat(betar_e,'\n');
cat((betar_e/betarSTE),'\n')
cat('Auto correlation coefficient is:\n');
cat(exp(param[7]),'\n')
cat((exp(param[7])/std[7]),'\n')
LL=-fval;
p=7;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n');
�
Without heterogeneity code of Regret pricing Project:
#modified code only high price regret and stock out regret, with modified
# specification of the stock out regret
#clear workspace
rm(list = ls());
Rprof("AggregLogitNoHeterogen.out")
�
J  = 10000;
T  =  3;
P1          =   sample(1:20, J, replace=T);  #generate random integer number
discount    =   runif(J, 0, 1); #generate uniform random number
P2          =   ceiling(P1*discount);
lambda      =   runif(J, 0, 1); #availability
xi          =   matrix(rnorm(20), J,2);
�
# alpha = 2;
# c     = 0.5; 
# bp    = -0.2;
alpha   = 2*runif(1,0,1);
c       = runif(1,0,1);
bp      = runif(1,0,1);
�
gamma =.975; #discount factor
�
P  = cbind(P1, P2);
Pn = matrix(P,nrow=J*2);
# high price regret coefficient
alphap = 3*runif(1,0,1);
# stock out regret coefficient
betar = 5*runif(1,0,1);
# calculate utility
uij1 =      alpha+(c+gamma*c)+bp*P1+ alphap*lambda*(P1-P2)+ xi[,1];
uij2 =      gamma*(lambda*(alpha+c+bp*P2)+ betar*(rep(1,J)-lambda)*(c+gamma*c))+ xi[,2];
e1=exp(uij1); e2=exp(uij2);
shares=cbind(e1/(1+e1+e2),e2/(1+e1+e2));
outside=cbind(1./(1+e1+e2),1./(1+e1+e2));
�
shares_n=matrix(t(shares),nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
#data
rm(list = ls());
#global P1 P2 Dur1 Dur2 lambda gamma shares km cost %outside_n
#global vcm se_est betas variance
library(xlsx);
num<-read.xlsx("C:/Users/MHE/Desktop/ActiveCourses/Projects/BehavioralPricing/Data/cleaned10232013.xlsx",1)
#cbind(summary(num))
names(num)
J =   dim(num)[1];
p =   dim(num)[2];
Dur1=num[,2];
Dur2=num[,3];
P1=num[,4];
P2=num[,5];
Av1=num[,6];
Av2=num[,7];
Av3=num[,12];
S1=num[,8];
S2=num[,9];
MKTSz=num[,10];
cost = num[,11];
T  =  3;
�
# test for cut off of second period
# P3=num[,13];
# P4=num[,16];
# Dur3=num[,14];
# S3=num[,15];
# S2=S3;
# P2=P4;
#Dur2=Dur3;
�
# test for average of second period availability, and normalized S2
lambda  = Av2;
# use normalize availability
#lambda      =   Av2/Av1; #availability
#lambda  = Av3; # availability at the beggining of second period
�
# test for normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/lambda;
MKTSz = MKTSz + (cf*S2); 
�
# tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711
�
#gamma =.975; #discount factor
gamma=1/(1+.0025)^Dur1;
# create shares
shares=cbind(S1/MKTSz,S2/MKTSz);
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
shares_n=matrix(shares,nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share
�
�
#beta=cbind(alpha,c,bp);
# X1= cbind(rep(1,J),(1+gamma)*rep(1,J),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(1+gamma));
# no fixed effect and heterogeneity
# p=5;
# X1= cbind(rep(1,J),(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
#no fixed effect, but heterogeneity with market size and cost
# p=5;
# X1= cbind(rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
#no fixed effect, but heterogeneity with market size and cost (include
#cherry picking and fixed it to negative of regret coefficient)
# p=5;
# X1= cbind(rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,-gamma*lambda*(P1-P2),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
#no fixed effect, but heterogeneity only in ownership through MKTSz (include %cherry picking as separate coefficient)
#p  = 6;
#X1 = cbind(rep(0,J),rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
#X2 = cbind(gamma*lambda*(P1-P2),gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
#no fixed effect, but heterogeneity with market size and cost (include
#cherry picking as separate coefficient)
# p=6;
# X1= cbind(rep(0,J),rep(1,J)/MKTSz,(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*(P1-P2),gamma*lambda/MKTSz,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# no fixed effect but capture effect of consumption heterogeneity value with cost
# capture hterogeneity in consumption utility using cost data
# p = 5;
# X1 = cbind(rep(1,J),(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# include heterogeneity using cost both in consumption utility and
# ownership utility
# p=5;
# X1= cbind(rep(1,J)*cost,(Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*cost,gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# inclusion of heterogeneity using cost only in stock out regret and
# ownership utility
# p=5;
# X1= cbind(rep(1,J)*cost,(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda*cost,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2)*cost);
# fixed effect (duration 0.5 because it is average duration of usage)
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2));
# fixed effect with consumption utility heterogeneity inclusion
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2)*cost,P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,0.5*gamma*lambda*Dur2*cost,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# fixed effect with heterogeneity of consumption in regret, but not in
# consumption utility directly 
# p=J+4;
# X1= cbind(diag(J),(0.5*Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda, 0.5*gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(0.5*Dur1+gamma*Dur2)*cost);
# fixed effect with markdown dummy
# p=J+5;
# X1= cbind(diag(J),rep(1,J),(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda,gamma*lambda,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
# including cost rather than fixed effect
#  p=6;
#  X1= cbind(rep(1,J),cost,(Dur1+gamma*Dur2),P1,lambda*(P1-P2),rep(0,J));
#  X2= cbind(gamma*lambda,gamma*lambda*cost,gamma*lambda*Dur2,gamma*lambda*P2,rep(0,J),gamma*(rep(1,J)-lambda)*(Dur1+gamma*Dur2));
# fixed effect, introducing availability in the first period
# p=J+4;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(diag(J)*lambda1,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(diag(J)*gamma*lambda2,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma.*Dur2));
# heterogeneity with cost, introducing availability in the first period
# p=6;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(lambda1,lambda*cost,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda2,gamma*lambda2*cost,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma*Dur2));
# no fixed effect, introducing availability in the first period
# p=5;
# lambda1=Av1;
# lambda2=Av2;
# X1= cbind(lambda1,lambda1*(Dur1+gamma*Dur2),lambda1*P1,lambda2*(P1-P2),rep(0,J));
# X2= cbind(gamma*lambda2,gamma*lambda2*Dur2,gamma*lambda2*P2,rep(0,J),gamma*lambda1*(Dur1+gamma*Dur2));
�
X = t(cbind(X1,X2));
#Xn=matrix(X,ncol=J*2,nrow=5);
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn=log(shares_n/outside_n);
�
#OLS
betas=solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors=Yn-Xn%*%betas;
vcm=as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est=sqrt(diag(vcm));
�
#params=[alpha c bp alphap betar];
�
betas   =  t(betas);
se_est  =  t(se_est);
a_e     =  t(betas[1,1:(p-4)]);
c_e     =  betas[1,(p-3)];
bp_e    =  betas[1,(p-2)];
alphap_e=  betas[1,(p-1)];
tt1_e   =  betas[1,p];
betar_e =tt1_e/c_e;
STEFOC=cbind(1/c_e,-tt1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*J;
ParamCovar =vcm[c(p-3,p),c(p-3,p)]*(2*J);
betarSTE=sqrt(STEFOC%*%ParamCovar%*%t(STEFOC)/(2*J));
#rbind(cbind(params,betas[1,1:4],betar_e),cbind(betas[1,1:4]/se_est[1,1:4],betar_e/betarSTE));
#rbind(cbind(betas[1,1:4],betar_e),cbind(betas[1,1:4]/se_est[1,1:4],betar_e/betarSTE));
# c bp alphap betar 
variance                 =    colMeans(errors^2)*2*J/(2*J-1); 
LL =    - 2*J*log(sqrt(2*pi*variance)) -   .5*sum(errors^2/variance);
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n'); 
cat('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:\n');
cat(cbind(t(betas[1,(p-3):(p-1)]),betar_e), '\n');
cat(cbind(t(se_est[1,(p-3):(p-1)]),betarSTE),'\n');
cat(cbind(t(betas[1,(p-3):(p-1)]/se_est[1,(p-3):(p-1)]),betar_e/betarSTE),'\n');
# intercept, single intercept
cat('Intercept is: \n');
cat(betas[1,(p-4)],'\n');
cat(se_est[1,(p-4)],'\n');
cat(betas[1,(p-4)]/se_est[1,(p-4)],'\n');
Rprof(NULL);
�
# for fixed effects
cat('Fixed Effects are: \n');
cat(betas[1,1:(p-4)], '\n');
cat(se_est[1,1:(p-4)],'\n');
cat(betas[1,1:(p-4)]/se_est[1,1:(p-4)],'\n');


nls {stats}
R Documentation
Nonlinear Least Squares
Description
Determine the nonlinear (weighted) least-squares estimates of the parameters of a nonlinear model.
Usage
nls(formula, data, start, control, algorithm,
    trace, subset, weights, na.action, model,
    lower, upper, ...)
Arguments
formula
a nonlinear model�formula�including variables and parameters. Will be coerced to a formula if necessary.
data
an optional data frame in which to evaluate the variables in�formula�and�weights. Can also be a list or an environment, but not a matrix.
start
a named list or named numeric vector of starting estimates. When�start�is missing, a very cheap guess for�start�is tried (if�algorithm != "plinear").
control
an optional list of control settings. See�nls.control�for the names of the settable control values and their effect.
algorithm
character string specifying the algorithm to use. The default algorithm is a Gauss-Newton algorithm. Other possible values are�"plinear"�for the Golub-Pereyra algorithm for partially linear least-squares models and�"port"�for the �nl2sol� algorithm from the Port library � see the references.
trace
logical value indicating if a trace of the iteration progress should be printed. Default is�FALSE. If�TRUE�the residual (weighted) sum-of-squares and the parameter values are printed at the conclusion of each iteration. When the�"plinear"�algorithm is used, the conditional estimates of the linear parameters are printed after the nonlinear parameters. When the�"port"�algorithm is used the objective function value printed is half the residual (weighted) sum-of-squares.
subset
an optional vector specifying a subset of observations to be used in the fitting process.
weights
an optional numeric vector of (fixed) weights. When present, the objective function is weighted least squares.
na.action
a function which indicates what should happen when the data contain�NAs. The default is set by the�na.action�setting of�options, and is�na.fail�if that is unset. The �factory-fresh� default is�na.omit. Value�na.exclude�can be useful.
model
logical. If true, the model frame is returned as part of the object. Default is�FALSE.
lower, upper
vectors of lower and upper bounds, replicated to be as long as�start. If unspecified, all parameters are assumed to be unconstrained. Bounds can only be used with the�"port"�algorithm. They are ignored, with a warning, if given for other algorithms.
...
Additional optional arguments. None are used at present.
Details
An�nls�object is a type of fitted model object. It has methods for the generic functions�anova,�coef,�confint,�deviance,�df.residual,�fitted,�formula,�logLik,�predict,�print,�profile,�residuals,summary,�vcov�and�weights.
Variables in�formula�(and�weights�if not missing) are looked for first in�data, then the environment of�formula�and finally along the search path. Functions in�formula�are searched for first in the environment offormula�and then along the search path.
Arguments�subset�and�na.action�are supported only when all the variables in the formula taken from�data�are of the same length: other cases give a warning.
Note that the�anova�method does not check that the models are nested: this cannot easily be done automatically, so use with care.
Value
A list of
m
an�nlsModel�object incorporating the model.
data
the expression that was passed to�nls�as the data argument. The actual data values are present in the environment of the�m�component.
call
the matched call with several components, notably�algorithm.
na.action
the�"na.action"�attribute (if any) of the model frame.
dataClasses
the�"dataClasses"�attribute (if any) of the�"terms"�attribute of the model frame.
model
if�model = TRUE, the model frame.
weights
if�weights�is supplied, the weights.
convInfo
a list with convergence information.
control
the control�list�used, see the�control�argument.
convergence, message
for an�algorithm = "port"�fit only, a convergence code (0�for convergence) and message.
To use these is�deprecated, as they are available from�convInfo�now.
Warning
Do not use�nls�on artificial "zero-residual" data.
The�nls�function uses a relative-offset convergence criterion that compares the numerical imprecision at the current parameter estimates to the residual sum-of-squares. This performs well on data of the form
y = f(x, ?) + eps
(with�var(eps) > 0). It fails to indicate convergence on data of the form
y = f(x, ?)
because the criterion amounts to comparing two components of the round-off error. If you wish to test�nls�on artificial data please add a noise component, as shown in the example below.
The�algorithm = "port"�code appears unfinished, and does not even check that the starting value is within the bounds. Use with caution, especially where bounds are supplied.
Note
Setting�warnOnly = TRUE�in the�control�argument (see�nls.control) returns a non-converged object (since�R�version 2.5.0) which might be useful for further convergence analysis,�but�not�for inference.
Author(s)
Douglas M. Bates and Saikat DebRoy: David M. Gay for the Fortran code used by�algorithm = "port".
References
Bates, D. M. and Watts, D. G. (1988)�Nonlinear Regression Analysis and Its Applications, Wiley
Bates, D. M. and Chambers, J. M. (1992)�Nonlinear models.�Chapter 10 of�Statistical Models in S�eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.
http://www.netlib.org/port/�for the Port library documentation.
See Also
summary.nls,�predict.nls,�profile.nls.
Self starting models (with �automatic initial values�):�selfStart.
Examples

require(graphics)

DNase1 <- subset(DNase, Run == 1)

## using a selfStart model
fm1DNase1 <- nls(density ~ SSlogis(log(conc), Asym, xmid, scal), DNase1)
summary(fm1DNase1)
## the coefficients only:
coef(fm1DNase1)
## including their SE, etc:
coef(summary(fm1DNase1))

## using conditional linearity
fm2DNase1 <- nls(density ~ 1/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(xmid = 0, scal = 1),
                 algorithm = "plinear")
summary(fm2DNase1)

## without conditional linearity
fm3DNase1 <- nls(density ~ Asym/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(Asym = 3, xmid = 0, scal = 1))
summary(fm3DNase1)

## using Port's nl2sol algorithm
fm4DNase1 <- nls(density ~ Asym/(1 + exp((xmid - log(conc))/scal)),
                 data = DNase1,
                 start = list(Asym = 3, xmid = 0, scal = 1),
                 algorithm = "port")
summary(fm4DNase1)

## weighted nonlinear regression
Treated <- Puromycin[Puromycin$state == "treated", ]
weighted.MM <- function(resp, conc, Vm, K)
{
    ## Purpose: exactly as white book p. 451 -- RHS for nls()
    ##  Weighted version of Michaelis-Menten model
    ## ----------------------------------------------------------
    ## Arguments: 'y', 'x' and the two parameters (see book)
    ## ----------------------------------------------------------
    ## Author: Martin Maechler, Date: 23 Mar 2001

    pred <- (Vm * conc)/(K + conc)
    (resp - pred) / sqrt(pred)
}

Pur.wt <- nls( ~ weighted.MM(rate, conc, Vm, K), data = Treated,
              start = list(Vm = 200, K = 0.1))
summary(Pur.wt)

## Passing arguments using a list that can not be coerced to a data.frame
lisTreat <- with(Treated,
                 list(conc1 = conc[1], conc.1 = conc[-1], rate = rate))

weighted.MM1 <- function(resp, conc1, conc.1, Vm, K)
{
     conc <- c(conc1, conc.1)
     pred <- (Vm * conc)/(K + conc)
    (resp - pred) / sqrt(pred)
}
Pur.wt1 <- nls( ~ weighted.MM1(rate, conc1, conc.1, Vm, K),
               data = lisTreat, start = list(Vm = 200, K = 0.1))
stopifnot(all.equal(coef(Pur.wt), coef(Pur.wt1)))

## Chambers and Hastie (1992) Statistical Models in S  (p. 537):
## If the value of the right side [of formula] has an attribute called
## 'gradient' this should be a matrix with the number of rows equal
## to the length of the response and one column for each parameter.

weighted.MM.grad <- function(resp, conc1, conc.1, Vm, K)
{
  conc <- c(conc1, conc.1)

  K.conc <- K+conc
  dy.dV <- conc/K.conc
  dy.dK <- -Vm*dy.dV/K.conc
  pred <- Vm*dy.dV
  pred.5 <- sqrt(pred)
  dev <- (resp - pred) / pred.5
  Ddev <- -0.5*(resp+pred)/(pred.5*pred)
  attr(dev, "gradient") <- Ddev * cbind(Vm = dy.dV, K = dy.dK)
  dev
}

Pur.wt.grad <- nls( ~ weighted.MM.grad(rate, conc1, conc.1, Vm, K),
                   data = lisTreat, start = list(Vm = 200, K = 0.1))

rbind(coef(Pur.wt), coef(Pur.wt1), coef(Pur.wt.grad))

## In this example, there seems no advantage to providing the gradient.
## In other cases, there might be.


## The two examples below show that you can fit a model to
## artificial data with noise but not to artificial data
## without noise.
x <- 1:10
y <- 2*x + 3                            # perfect fit
yeps <- y + rnorm(length(y), sd = 0.01) # added noise
nls(yeps ~ a + b*x, start = list(a = 0.12345, b = 0.54321))
## terminates in an error, because convergence cannot be confirmed:
try(nls(y ~ a + b*x, start = list(a = 0.12345, b = 0.54321)))

## the nls() internal cheap guess for starting values can be sufficient:

x <- -(1:100)/10
y <- 100 + 10 * exp(x / 2) + rnorm(x)/10
nlmod <- nls(y ~  Const + A * exp(B * x))

plot(x,y, main = "nls(*), data, true function and fit, n=100")
curve(100 + 10 * exp(x / 2), col = 4, add = TRUE)
lines(x, predict(nlmod), col = 2)



## The muscle dataset in MASS is from an experiment on muscle
## contraction on 21 animals.  The observed variables are Strip
## (identifier of muscle), Conc (Cacl concentration) and Length
## (resulting length of muscle section).
utils::data(muscle, package = "MASS")

## The non linear model considered is
##       Length = alpha + beta*exp(-Conc/theta) + error
## where theta is constant but alpha and beta may vary with Strip.

with(muscle, table(Strip)) # 2, 3 or 4 obs per strip

## We first use the plinear algorithm to fit an overall model,
## ignoring that alpha and beta might vary with Strip.

musc.1 <- nls(Length ~ cbind(1, exp(-Conc/th)), muscle,
              start = list(th = 1), algorithm = "plinear")
summary(musc.1)

## Then we use nls' indexing feature for parameters in non-linear
## models to use the conventional algorithm to fit a model in which
## alpha and beta vary with Strip.  The starting values are provided
## by the previously fitted model.
## Note that with indexed parameters, the starting values must be
## given in a list (with names):
b <- coef(musc.1)
musc.2 <- nls(Length ~ a[Strip] + b[Strip]*exp(-Conc/th), muscle,
              start = list(a = rep(b[2], 21), b = rep(b[3], 21), th = b[1]))
summary(musc.2)


outDEoptim <- DEoptim(Rosenbrock, lower, upper, DEoptim.control(NP = 80,
                        itermax = 400, F = 1.2, CR = 0.7))
outDEoptim <- DEoptim(Wild, lower = -50, upper = 50,
                        control = DEoptim.control(trace = FALSE))
oneCore <- system.time( DEoptim(fn=Genrose, lower=rep(-25, n), upper=rep(25, n),
                   control=list(NP=10*n, itermax=maxIt)))
�
  withParallel <-  system.time( DEoptim(fn=Genrose, lower=rep(-25, n), upper=rep(25, n),
                   control=list(NP=10*n, itermax=maxIt, parallelType=1)))
DEoptim(Wild, lower = -50, upper = 50,
          control = DEoptim.control(NP = 50))

Usage
DEoptim.control(VTR = -Inf, strategy = 2, bs = FALSE, NP = NA,
  itermax = 200, CR = 0.5, F = 0.8, trace = TRUE, initialpop = NULL,
  storepopfrom = itermax + 1, storepopfreq = 1, p = 0.2, c = 0, reltol,
  steptol, parallelType = 0, packages = c(), parVar = c(),
  foreachArgs = list())
Arguments
VTR
the value to be reached. The optimization process will stop if either the maximum number of iterationsitermax�is reached or the best parameter vector�bestmem�has found a value�fn(bestmem)�<=�VTR. Default to�-Inf.
strategy
defines the Differential Evolution strategy used in the optimization procedure:
1: DE / rand / 1 / bin (classical strategy)
2: DE / local-to-best / 1 / bin (default)
3: DE / best / 1 / bin with jitter
4: DE / rand / 1 / bin with per-vector-dither
5: DE / rand / 1 / bin with per-generation-dither
6: DE / current-to-p-best / 1
any value not above: variation to DE / rand / 1 / bin: either-or-algorithm. Default strategy is currently�2. See *Details*.
bs
if�FALSE�then every mutant will be tested against a member in the previous generation, and the best value will proceed into the next generation (this is standard trial vs. target selection). If�TRUE�then the old generation and�NP�mutants will be sorted by their associated objective function values, and the best�NPvectors will proceed into the next generation (best of parent and child selection). Default is�FALSE.
NP
number of population members. Defaults to�NA; if the user does not change the value of�NP�from�NA�or specifies a value less than 4 it is reset when�DEoptim�is called as�10*length(lower). For many problems it is best to set�NP�to be at least 10 times the length of the parameter vector.
itermax
the maximum iteration (population generation) allowed. Default is�200.
CR
crossover probability from interval [0,1]. Default to�0.5.
F
differential weighting factor from interval [0,2]. Default to�0.8.
trace
Positive integer or logical value indicating whether printing of progress occurs at each iteration. The default value is�TRUE. If a positive integer is specified, printing occurs every�trace�iterations.
initialpop
an initial population used as a starting population in the optimization procedure. May be useful to speed up the convergence. Default to�NULL. If given, each member of the initial population should be given as a row of a numeric matrix, so that�initialpop�is a matrix with�NP�rows and a number of columns equal to the length of the parameter vector to be optimized.
storepopfrom
from which generation should the following intermediate populations be stored in memory. Default toitermax�+�1, i.e., no intermediate population is stored.
storepopfreq
the frequency with which populations are stored. Default to�1, i.e., every intermediate population is stored.
p
when�strategy =�6, the top (100 * p)% best solutions are used in the mutation.�p�must be defined in (0,1].
c
c�controls the speed of the crossover adaptation. Higher values of�c�give more weight to the current successful mutations.�c�must be defined in (0,1].
reltol
relative convergence tolerance. The algorithm stops if it is unable to reduce the value by a factor ofreltol�*�(abs(val)�+�� �reltol)�after�steptol�steps. Defaults tosqrt(.Machine$double.eps), typically about�1e-8.
steptol
see�reltol. Defaults to�itermax.
parallelType
Defines the type of parallelization to employ, if any.��: The default, this uses�DEoptim�one only one core.1: This uses all available cores, via the�parallel�package, to run�DEoptim. If�parallelType=1, then thepackages�argument and the�parVar�argument need to specify the packages required by the objective function and the variables required in the environment, respectively.�2: This uses the�foreach�package for parallelism; see the�sandbox�directory in the source code for examples. If�parallelType=1, then theforeachArgs�argument can pass the options to be called with�foreach.
packages
Used if�parallelType=1; a list of package names (as strings) that need to be loaded for use by the objective function.
parVar
Used if�parallelType=1; a list of variable names (as strings) that need to exist in the environment for use by the objective function or are used as arguments by the objective function.
foreachArgs
A list of named arguments for the�foreach�function from the package�foreach. The arguments�i,.combine�and�.export�are not possible to set here; they are set internally.
Details
This defines the Differential Evolution strategy used in the optimization procedure, described below in the terms used by Price et al. (2006); see also Mullen et al. (2009) for details.
* strategy =�1: DE / rand / 1 / bin.�
This strategy is the classical approach for DE, and is described in�DEoptim.
* strategy =�2: DE / local-to-best / 1 / bin.�
In place of the classical DE mutation the expression is used, where old_i,g and best_g are the i-th member and best member, respectively, of the previous population. This strategy is currently used by default.
* strategy =�3: DE / best / 1 / bin with jitter.
In place of the classical DE mutation the expression is used, where jitter is defined as 0.0001 *�rand�+ F.
* strategy =�4: DE / rand / 1 / bin with per vector dither.
In place of the classical DE mutation the expression is used, where dither is calculated as F + \code{rand} * (1 - F).
* strategy =�5: DE / rand / 1 / bin with per generation dither.
The strategy described for�4�is used, but dither is only determined once per-generation.
* strategy =�6: DE / current-to-p-best / 1.
The top (100*p) percent best solutions are used in the mutation, where p is defined in (0,1].
* any value not above: variation to DE / rand / 1 / bin: either-or algorithm.
In the case that�rand�< 0.5, the classical strategy�strategy =�1�is used. Otherwise, the expression is used.
Several conditions can cause the optimization process to stop:
* if the best parameter vector (bestmem) produces a value less than or equal to�VTR�(i.e.�fn(bestmem)<=�VTR), or
* if the maximum number of iterations is reached (itermax), or
* if a number (steptol) of consecutive iterations are unable to reduce the best function value by a certain amount (reltol�*�� � ��(abs(val)�+�reltol)).�100*reltol�is approximately the percent change of the objective value required to consider the parameter set an improvement over the current best member.
Zhang and Sanderson (2009) define several extensions to the DE algorithm, including strategy 6, DE/current-to-p-best/1. They also define a self-adaptive mechanism for the other control parameters. This self-adaptation will speed convergence on many problems, and is defined by the control parameter�c. If�c�is non-zero, crossover and mutation will be adapted by the algorithm. Values in the range of�c=.05�to�c=.5appear to work best for most problems, though the adaptive algorithm is robust to a wide range of�c.


%==============================================================================================
%				Check VIF
%=============================================================================================
cntrVIF = 0;
 for i=1:n;
     if (size(phetrgn{i},2)>2)
         temp = regstats(phetrgn{i}(:,2),phetrgn{i}(:,3:size(phetrgn{i},2)),'linear');
         VIF =1/(1-temp.rsquare);
     end;
     if (VIF >10)
         cntrVIF = cntrVIF + 1;
     end;
 end;
  fprintf('number of multicollinearity p element 1 of vector is: %f\n',cntrVIF);
  
%===============================================================================================
%				Simulating Data
%===============================================================================================
pp =1;
p      =  1;     T = 100;               % p dimension of state vector; T length of series
m0     =  randn(p,1); C0 = eye(p);      % intial state distribution at t=0

%Bass Model parameter simulation
qi1=0.38*rand(1,1);
pi1=0.003*rand(1,1);
mi1=1000*rand(1,1);

F      =  ones(p,1);  GT = diag([-qi1./mi1 (1-pi1+qi1)]); d = diag(GT);     % Observation and systems matrix  
v      =  eye(p)*0.2;       w = 0.5*eye(p);              % known observation and sytem variance


% Simulate Observations  y(t) and states 
tt1    =  5*rand(p,T+1); y = zeros(p,T); xp = rand(T,1); F =  eye(p); y=[]; beta=pi1*mi1 ;
ew     =  chol(w)'*randn(p,T);  ev = chol(v)'*randn(p,T); xp= ones(p,T); uT=diag(beta)*xp;
%a      =  rand(1,5); b = rand(1,5); alpha = [1.2; 1.05];

% LINEAR Goodwill
%for  t =  2:T+1 tt1(1,t) =  d(1)*tt1(1,t-1) + uT(1,t-1) + ew(1,t-1); end;
%for  t =  2:T+1 tt1(2,t) =  d(2)*tt1(2,t-1) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);

% NONLINEAR Goodwill
for  t =  2:T+1 tt1(1,t) =  d(1)*tt1(1,t-1).^2 + d(2)*tt1(1,t-1)+ uT(1,t-1) + ew(1,t-1); end;                
%for  t =  2:T+1 tt1(2,t) =  tt1(2,t-1)- d(2)*tt1(2,t-1)^alpha(2) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);


for  t =  1:T 

 y(:,t)  = tt1(1,t)  +  ev(:,t);
 %[a(1)*tt1(1,t) - a(2)*tt1(2,t) - a(3)*tt1(1,t)^2 +  a(4)*tt1(2,t)^2 + a(5)*tt1(1,t)*tt1(2,t); ...
  %           b(1)*tt1(2,t) - b(2)*tt1(1,t) - b(3)*tt1(2,t)^2 +  b(4)*tt1(1,t)^2 + b(5)*tt1(1,t)*tt1(2,t)] + ev(:,t);

end;
plot(y(1,:)); pause; % plot(y(2,:)); 

%===========================================================================================
%							Metrapolis Hasting
%==========================================================================================
% first simulate M0|p,q,beta erround the mode obtained using fminunc
X0= pqM0beta;
alpha     = 0.5;
accptnrnd = 0.8;
[modepltfrm,fval,exitflag,output,grad,hessian]=fminunc('PlatformFullLikelihood',X0,options,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon);
var        = diag(inv(hessian));
var = max(var,1e-6);
j=1;
while ((alpha < accptnrnd)) %&& (swfac == 1) )
   j=j+1
   wpm =pc*var;
   wpm = max(wpm, 1e-6);
   pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
   while (pqM0betaNew(3)<0) 
       j=j+1
      pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
   end;
   postPNew  = -PlatformFullLikelihood(pqM0betaNew,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon); % log of new posterior
   postPOld  = -PlatformFullLikelihood(pqM0beta,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon); % log of old posterior
   alpha     = postPNew - postPOld;
   accptnrnd = log(rand(1,1));
   % M0paramNew = M0param + pc*randn(length(M0Param),1);
end;
cumj= cumj+j;
% check acceptance rate and modify it
accepRate=1/cumj % because i out of all cumj iterations is accepted until now
GTp(:,:)  =   diag([M0param ppparam qpparam eta npparam]);
uTp(1:pT) =   ppparam.*(eta*caddon(1:(size(yc,1)-1),:)+M0param) + repmat((eta*caddon(1:(size(yc,1)-1),:)+M0param), [1 size(caddon(1:(size(yc,1)-1),:),2)]).*(yc(1:(size(yc,1)-1),:)*npparam');

%======================================================================
%				Adaptive Metrapolis Hasting
%===========================================================================
 % platform EKF calculation
    [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatformCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),yc,caddon);   %,a,b,alpha

   
    ttr1=tt1p(1:pT)';
    ttind1p= [tt0p;tt1p(1:pT-1)'];
    
   %simulate GT = d, beta (System Equation)
   % first simulate M0|p,q,beta erround the mode obtained using fminunc
   X0= pqM0beta;
   alpha     = 0.5;
   accptnrnd = 0.8;
   [modepltfrm,fval,exitflag,output,grad,hessian]=fminunc('PlatformFullLikelihood',X0,options,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon);
   var        = diag(inv(hessian));
   var = max(var,1e-6);
   j=1;
   while ((alpha < accptnrnd)) %&& (swfac == 1) )
       j=j+1
       wpm =pc*var;
       wpm = max(wpm, 1e-6);
       pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
       while (pqM0betaNew(3)<0) 
           j=j+1
              pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
          if (j>1e4)           
            break;
          end;
       end;
       postPNew  = -PlatformFullLikelihood(pqM0betaNew,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon); % log of new posterior
       postPOld  = -PlatformFullLikelihood(pqM0beta,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p,caddon); % log of old posterior
       alpha     = postPNew - postPOld;
       accptnrnd = log(rand(1,1));
       if (j>1e4)
           postPNew = postPOld;
           pqM0betaNew =pqM0beta;
           break;
       end;
       % M0paramNew = M0param + pc*randn(length(M0Param),1);
   end;
   cumj= cumj+j;
   % check acceptance rate and modify it
   accepRate=i/cumj % because i out of all cumj iterations is accepted until now
   if (floor(i./5)==i/5)
     if (accepRate>0.15)  
          pc =  pc*3;
          cumj = i./0.15;% to maintain past dependancy 
     elseif (accepRate<0.01) 
           pc =  pc/3;
          cumj = i./0.01;
     end;
   end;
   
   
   %===========================================
   %		Likelihood
   %=============================================
   LLtemp (j)      =  -0.5*(y{j}' - ttr1addon')*(y{j}' - ttr1addon')'/v(j).^2 - ... %LLtemp (j)
            0.5*T(j)*p*log(2*pi*v(j).^2)- 0.5*(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon)'*(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon)/w (j) - ...
            0.5*T(j)*p*log(2*pi*w(j)); % LLtemp (j)
			
	%=======================================
	%		Burn in and Thinning
	%==========================================
	tic;
    i
    sw=0;
    if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 

   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
        sw=1;
        savinground = savinground + 1;
        LLtempcs =zeros(1,n); % reset to make sure I do not add extra elements
   end;
   if (sw==1) 
          Y1a{jp}         =     Y1; 
          MADa{jp}         =    MAD; 
          MSEa{jp}         =    MSE; 
         
          LL (jp)      = LL(jp) + sum(LLtemp);
          bi_{jp}          =     b_; 
          b0i_{jp}         =     b0_; 
          ci_{jp}          =     c_;
     end;   
	 toc;
R Reference Card
by Tom Short, EPRI PEAC, tshort@epri-peac.com 2004-11-07
Granted to the public domain. See www.Rpad.org for the source and latest
version. Includes material from R for Beginners by Emmanuel Paradis (with
permission).
Getting help
Most R functions have online documentation.
help(topic) documentation on topic
?topic id.
help.search("topic") search the help system
apropos("topic") the names of all objects in the search list matching
the regular expression ”topic”
help.start() start the HTML version of help
str(a) display the internal *str*ucture of an R object
summary(a) gives a “summary” of a, usually a statistical summary but it is
generic meaning it has different operations for different classes of a
ls() show objects in the search path; specify pat="pat" to search on a
pattern
ls.str() str() for each variable in the search path
dir() show files in the current directory
methods(a) shows S3 methods of a
methods(class=class(a)) lists all the methods to handle objects of
class a
Input and output
load() load the datasets written with save
data(x) loads specified data sets
library(x) load add-on packages
read.table(file) reads a file in table format and creates a data
frame from it; the default separator sep="" is any whitespace; use
header=TRUE to read the first line as a header of column names; use
as.is=TRUE to prevent character vectors from being converted to factors;
use comment.char="" to prevent "#" from being interpreted as
a comment; use skip=n to skip n lines before reading data; see the
help for options on row naming, NA treatment, and others
read.csv("filename",header=TRUE) id. but with defaults set for
reading comma-delimited files
read.delim("filename",header=TRUE) id. but with defaults set
for reading tab-delimited files
read.fwf(file,widths,header=FALSE,sep=" ",as.is=FALSE)
read a table of f ixed width f ormatted data into a ’data.frame’; widths
is an integer vector, giving the widths of the fixed-width fields
save(file,...) saves the specified objects (...) in the XDR platformindependent
binary format
save.image(file) saves all objects
cat(..., file="", sep=" ") prints the arguments after coercing to
character; sep is the character separator between arguments
print(a, ...) prints its arguments; generic, meaning it can have different
methods for different objects
format(x,...) format an R object for pretty printing
write.table(x,file="",row.names=TRUE,col.names=TRUE,
sep=" ") prints x after converting to a data frame; if quote is TRUE,
character or factor columns are surrounded by quotes ("); sep is the
field separator; eol is the end-of-line separator; na is the string for
missing values; use col.names=NA to add a blank column header to
get the column headers aligned correctly for spreadsheet input
sink(file) output to file, until sink()
Most of the I/O functions have a file argument. This can often be a character
string naming a file or a connection. file="" means the standard input or
output. Connections can include files, pipes, zipped files, and R variables.
On windows, the file connection can also be used with description =
"clipboard". To read a table copied from Excel, use
x <- read.delim("clipboard")
To write a table to the clipboard for Excel, use
write.table(x,"clipboard",sep="\t",col.names=NA)
For database interaction, see packages RODBC, DBI, RMySQL, RPgSQL, and
ROracle. See packages XML, hdf5, netCDF for reading other file formats.
Data creation
c(...) generic function to combine arguments with the default forming a
vector; with recursive=TRUE descends through lists combining all
elements into one vector
from:to generates a sequence; “:” has operator priority; 1:4 + 1 is “2,3,4,5”
seq(from,to) generates a sequence by= specifies increment; length=
specifies desired length
seq(along=x) generates 1, 2, ..., length(along); useful for for
loops
rep(x,times) replicate x times; use each= to repeat “each” element
of x each times; rep(c(1,2,3),2) is 1 2 3 1 2 3;
rep(c(1,2,3),each=2) is 1 1 2 2 3 3
data.frame(...) create a data frame of the named or unnamed
arguments; data.frame(v=1:4,ch=c("a","B","c","d"),n=10);
shorter vectors are recycled to the length of the longest
list(...) create a list of the named or unnamed arguments;
list(a=c(1,2),b="hi",c=3i);
array(x,dim=) array with data x; specify dimensions like
dim=c(3,4,2); elements of x recycle if x is not long enough
matrix(x,nrow=,ncol=) matrix; elements of x recycle
factor(x,levels=) encodes a vector x as a factor
gl(n,k,length=n*k,labels=1:n) generate levels (factors) by specifying
the pattern of their levels; k is the number of levels, and n is
the number of replications
expand.grid() a data frame from all combinations of the supplied vectors
or factors
rbind(...) combine arguments by rows for matrices, data frames, and
others
cbind(...) id. by columns
Slicing and extracting data
Indexing vectors
x[n] nth element
x[-n] all but the nth element
x[1:n] first n elements
x[-(1:n)] elements from n+1 to the end
x[c(1,4,2)] specific elements
x["name"] element named "name"
x[x > 3] all elements greater than 3
x[x > 3 & x < 5] all elements between 3 and 5
x[x %in% c("a","and","the")] elements in the given set
Indexing lists
x[n] list with elements n
x[[n]] nth element of the list
x[["name"]] element of the list named "name"
x$name id.
Indexing matrices
x[i,j] element at row i, column j
x[i,] row i
x[,j] column j
x[,c(1,3)] columns 1 and 3
x["name",] row named "name"
Indexing data frames (matrix indexing plus the following)
x[["name"]] column named "name"
x$name id.
Variable conversion
as.array(x), as.data.frame(x), as.numeric(x),
as.logical(x), as.complex(x), as.character(x),
... convert type; for a complete list, use methods(as)
Variable information
is.na(x), is.null(x), is.array(x), is.data.frame(x),
is.numeric(x), is.complex(x), is.character(x),
... test for type; for a complete list, use methods(is)
length(x) number of elements in x
dim(x) Retrieve or set the dimension of an object; dim(x) <- c(3,2)
dimnames(x) Retrieve or set the dimension names of an object
nrow(x) number of rows; NROW(x) is the same but treats a vector as a onerow
matrix
ncol(x) and NCOL(x) id. for columns
class(x) get or set the class of x; class(x) <- "myclass"
unclass(x) remove the class attribute of x
attr(x,which) get or set the attribute which of x
attributes(obj) get or set the list of attributes of obj
Data selection and manipulation
which.max(x) returns the index of the greatest element of x
which.min(x) returns the index of the smallest element of x
rev(x) reverses the elements of x
sort(x) sorts the elements of x in increasing order; to sort in decreasing
order: rev(sort(x))
cut(x,breaks) divides x into intervals (factors); breaks is the number
of cut intervals or a vector of cut points
match(x, y) returns a vector of the same length than x with the elements
of x which are in y (NA otherwise)
which(x == a) returns a vector of the indices of x if the comparison operation
is true (TRUE), in this example the values of i for which x[i]
== a (the argument of this function must be a variable of mode logical)
choose(n, k) computes the combinations of k events among n repetitions
= n!/[(n-k)!k!]
na.omit(x) suppresses the observations with missing data (NA) (suppresses
the corresponding line if x is a matrix or a data frame)
na.fail(x) returns an error message if x contains at least one NAR Reference Card
by Tom Short, EPRI PEAC, tshort@epri-peac.com 2004-11-07
Granted to the public domain. See www.Rpad.org for the source and latest
version. Includes material from R for Beginners by Emmanuel Paradis (with
permission).
Getting help
Most R functions have online documentation.
help(topic) documentation on topic
?topic id.
help.search("topic") search the help system
apropos("topic") the names of all objects in the search list matching
the regular expression ”topic”
help.start() start the HTML version of help
str(a) display the internal *str*ucture of an R object
summary(a) gives a “summary” of a, usually a statistical summary but it is
generic meaning it has different operations for different classes of a
ls() show objects in the search path; specify pat="pat" to search on a
pattern
ls.str() str() for each variable in the search path
dir() show files in the current directory
methods(a) shows S3 methods of a
methods(class=class(a)) lists all the methods to handle objects of
class a
Input and output
load() load the datasets written with save
data(x) loads specified data sets
library(x) load add-on packages
read.table(file) reads a file in table format and creates a data
frame from it; the default separator sep="" is any whitespace; use
header=TRUE to read the first line as a header of column names; use
as.is=TRUE to prevent character vectors from being converted to factors;
use comment.char="" to prevent "#" from being interpreted as
a comment; use skip=n to skip n lines before reading data; see the
help for options on row naming, NA treatment, and others
read.csv("filename",header=TRUE) id. but with defaults set for
reading comma-delimited files
read.delim("filename",header=TRUE) id. but with defaults set
for reading tab-delimited files
read.fwf(file,widths,header=FALSE,sep=" ",as.is=FALSE)
read a table of f ixed width f ormatted data into a ’data.frame’; widths
is an integer vector, giving the widths of the fixed-width fields
save(file,...) saves the specified objects (...) in the XDR platformindependent
binary format
save.image(file) saves all objects
cat(..., file="", sep=" ") prints the arguments after coercing to
character; sep is the character separator between arguments
print(a, ...) prints its arguments; generic, meaning it can have different
methods for different objects
format(x,...) format an R object for pretty printing
write.table(x,file="",row.names=TRUE,col.names=TRUE,
sep=" ") prints x after converting to a data frame; if quote is TRUE,
character or factor columns are surrounded by quotes ("); sep is the
field separator; eol is the end-of-line separator; na is the string for
missing values; use col.names=NA to add a blank column header to
get the column headers aligned correctly for spreadsheet input
sink(file) output to file, until sink()
Most of the I/O functions have a file argument. This can often be a character
string naming a file or a connection. file="" means the standard input or
output. Connections can include files, pipes, zipped files, and R variables.
On windows, the file connection can also be used with description =
"clipboard". To read a table copied from Excel, use
x <- read.delim("clipboard")
To write a table to the clipboard for Excel, use
write.table(x,"clipboard",sep="\t",col.names=NA)
For database interaction, see packages RODBC, DBI, RMySQL, RPgSQL, and
ROracle. See packages XML, hdf5, netCDF for reading other file formats.
Data creation
c(...) generic function to combine arguments with the default forming a
vector; with recursive=TRUE descends through lists combining all
elements into one vector
from:to generates a sequence; “:” has operator priority; 1:4 + 1 is “2,3,4,5”
seq(from,to) generates a sequence by= specifies increment; length=
specifies desired length
seq(along=x) generates 1, 2, ..., length(along); useful for for
loops
rep(x,times) replicate x times; use each= to repeat “each” element
of x each times; rep(c(1,2,3),2) is 1 2 3 1 2 3;
rep(c(1,2,3),each=2) is 1 1 2 2 3 3
data.frame(...) create a data frame of the named or unnamed
arguments; data.frame(v=1:4,ch=c("a","B","c","d"),n=10);
shorter vectors are recycled to the length of the longest
list(...) create a list of the named or unnamed arguments;
list(a=c(1,2),b="hi",c=3i);
array(x,dim=) array with data x; specify dimensions like
dim=c(3,4,2); elements of x recycle if x is not long enough
matrix(x,nrow=,ncol=) matrix; elements of x recycle
factor(x,levels=) encodes a vector x as a factor
gl(n,k,length=n*k,labels=1:n) generate levels (factors) by specifying
the pattern of their levels; k is the number of levels, and n is
the number of replications
expand.grid() a data frame from all combinations of the supplied vectors
or factors
rbind(...) combine arguments by rows for matrices, data frames, and
others
cbind(...) id. by columns
Slicing and extracting data
Indexing vectors
x[n] nth element
x[-n] all but the nth element
x[1:n] first n elements
x[-(1:n)] elements from n+1 to the end
x[c(1,4,2)] specific elements
x["name"] element named "name"
x[x > 3] all elements greater than 3
x[x > 3 & x < 5] all elements between 3 and 5
x[x %in% c("a","and","the")] elements in the given set
Indexing lists
x[n] list with elements n
x[[n]] nth element of the list
x[["name"]] element of the list named "name"
x$name id.
Indexing matrices
x[i,j] element at row i, column j
x[i,] row i
x[,j] column j
x[,c(1,3)] columns 1 and 3
x["name",] row named "name"
Indexing data frames (matrix indexing plus the following)
x[["name"]] column named "name"
x$name id.
Variable conversion
as.array(x), as.data.frame(x), as.numeric(x),
as.logical(x), as.complex(x), as.character(x),
... convert type; for a complete list, use methods(as)
Variable information
is.na(x), is.null(x), is.array(x), is.data.frame(x),
is.numeric(x), is.complex(x), is.character(x),
... test for type; for a complete list, use methods(is)
length(x) number of elements in x
dim(x) Retrieve or set the dimension of an object; dim(x) <- c(3,2)
dimnames(x) Retrieve or set the dimension names of an object
nrow(x) number of rows; NROW(x) is the same but treats a vector as a onerow
matrix
ncol(x) and NCOL(x) id. for columns
class(x) get or set the class of x; class(x) <- "myclass"
unclass(x) remove the class attribute of x
attr(x,which) get or set the attribute which of x
attributes(obj) get or set the list of attributes of obj
Data selection and manipulation
which.max(x) returns the index of the greatest element of x
which.min(x) returns the index of the smallest element of x
rev(x) reverses the elements of x
sort(x) sorts the elements of x in increasing order; to sort in decreasing
order: rev(sort(x))
cut(x,breaks) divides x into intervals (factors); breaks is the number
of cut intervals or a vector of cut points
match(x, y) returns a vector of the same length than x with the elements
of x which are in y (NA otherwise)
which(x == a) returns a vector of the indices of x if the comparison operation
is true (TRUE), in this example the values of i for which x[i]
== a (the argument of this function must be a variable of mode logical)
choose(n, k) computes the combinations of k events among n repetitions
= n!/[(n-k)!k!]
na.omit(x) suppresses the observations with missing data (NA) (suppresses
the corresponding line if x is a matrix or a data frame)
na.fail(x) returns an error message if x contains at least one NA
unique(x) if x is a vector or a data frame, returns a similar object but with
the duplicate elements suppressed
table(x) returns a table with the numbers of the differents values of x
(typically for integers or factors)
subset(x, ...) returns a selection of x with respect to criteria (...,
typically comparisons: x$V1 < 10); if x is a data frame, the option
select gives the variables to be kept or dropped using a minus sign
sample(x, size) resample randomly and without replacement size elements
in the vector x, the option replace = TRUE allows to resample
with replacement
prop.table(x,margin=) table entries as fraction of marginal table
Math
sin,cos,tan,asin,acos,atan,atan2,log,log10,exp
max(x) maximum of the elements of x
min(x) minimum of the elements of x
range(x) id. then c(min(x), max(x))
sum(x) sum of the elements of x
diff(x) lagged and iterated differences of vector x
prod(x) product of the elements of x
mean(x) mean of the elements of x
median(x) median of the elements of x
quantile(x,probs=) sample quantiles corresponding to the given probabilities
(defaults to 0,.25,.5,.75,1)
weighted.mean(x, w) mean of x with weights w
rank(x) ranks of the elements of x
var(x) or cov(x) variance of the elements of x (calculated on n-1); if x is
a matrix or a data frame, the variance-covariance matrix is calculated
sd(x) standard deviation of x
cor(x) correlation matrix of x if it is a matrix or a data frame (1 if x is a
vector)
var(x, y) or cov(x, y) covariance between x and y, or between the
columns of x and those of y if they are matrices or data frames
cor(x, y) linear correlation between x and y, or correlation matrix if they
are matrices or data frames
round(x, n) rounds the elements of x to n decimals
log(x, base) computes the logarithm of x with base base
scale(x) if x is a matrix, centers and reduces the data; to center only use
the option center=FALSE, to reduce only scale=FALSE (by default
center=TRUE, scale=TRUE)
pmin(x,y,...) a vector which ith element is the minimum of x[i],
y[i], . . .
pmax(x,y,...) id. for the maximum
cumsum(x) a vector which ith element is the sum from x[1] to x[i]
cumprod(x) id. for the product
cummin(x) id. for the minimum
cummax(x) id. for the maximum
union(x,y), intersect(x,y), setdiff(x,y), setequal(x,y),
is.element(el,set) “set” functions
Re(x) real part of a complex number
Im(x) imaginary part
Mod(x) modulus; abs(x) is the same
Arg(x) angle in radians of the complex number
Conj(x) complex conjugate
convolve(x,y) compute the several kinds of convolutions of two sequences
fft(x) Fast Fourier Transform of an array
mvfft(x) FFT of each column of a matrix
filter(x,filter) applies linear filtering to a univariate time series or
to each series separately of a multivariate time series
Many math functions have a logical parameter na.rm=FALSE to specify missing
data (NA) removal.
Matrices
t(x) transpose
diag(x) diagonal
%*% matrix multiplication
solve(a,b) solves a %*% x = b for x
solve(a) matrix inverse of a
rowsum(x) sum of rows for a matrix-like object; rowSums(x) is a faster
version
colsum(x), colSums(x) id. for columns
rowMeans(x) fast version of row means
colMeans(x) id. for columns
Advanced data processing
apply(X,INDEX,FUN=) a vector or array or list of values obtained by
applying a function FUN to margins (INDEX) of X
lapply(X,FUN) apply FUN to each element of the list X
tapply(X,INDEX,FUN=) apply FUN to each cell of a ragged array given
by X with indexes INDEX
by(data,INDEX,FUN) apply FUN to data frame data subsetted by INDEX
merge(a,b) merge two data frames by common columns or row names
xtabs(a b,data=x) a contingency table from cross-classifying factors
aggregate(x,by,FUN) splits the data frame x into subsets, computes
summary statistics for each, and returns the result in a convenient
form; by is a list of grouping elements, each as long as the variables
in x
stack(x, ...) transform data available as separate columns in a data
frame or list into a single column
unstack(x, ...) inverse of stack()
reshape(x, ...) reshapes a data frame between ’wide’ format with
repeated measurements in separate columns of the same record and
’long’ format with the repeated measurements in separate records;
use (direction=”wide”) or (direction=”long”)
Strings
paste(...) concatenate vectors after converting to character; sep= is the
string to separate terms (a single space is the default); collapse= is
an optional string to separate “collapsed” results
substr(x,start,stop) substrings in a character vector; can also assign,
as substr(x, start, stop) <- value
strsplit(x,split) split x according to the substring split
grep(pattern,x) searches for matches to pattern within x; see ?regex
gsub(pattern,replacement,x) replacement of matches determined
by regular expression matching sub() is the same but only replaces
the first occurrence.
tolower(x) convert to lowercase
toupper(x) convert to uppercase
match(x,table) a vector of the positions of first matches for the elements
of x among table
x %in% table id. but returns a logical vector
pmatch(x,table) partial matches for the elements of x among table
nchar(x) number of characters
Dates and Times
The class Date has dates without times. POSIXct has dates and times, including
time zones. Comparisons (e.g. >), seq(), and difftime() are useful.
Date also allows + and -. ?DateTimeClasses gives more information. See
also package chron.
as.Date(s) and as.POSIXct(s) convert to the respective class;
format(dt) converts to a string representation. The default string
format is “2001-02-21”. These accept a second argument to specify a
format for conversion. Some common formats are:
%a, %A Abbreviated and full weekday name.
%b, %B Abbreviated and full month name.
%d Day of the month (01–31).
%H Hours (00–23).
%I Hours (01–12).
%j Day of year (001–366).
%m Month (01–12).
%M Minute (00–59).
%p AM/PM indicator.
%S Second as decimal number (00–61).
%U Week (00–53); the first Sunday as day 1 of week 1.
%w Weekday (0–6, Sunday is 0).
%W Week (00–53); the first Monday as day 1 of week 1.
%y Year without century (00–99). Don’t use.
%Y Year with century.
%z (output only.) Offset from Greenwich; -0800 is 8 hours west of.
%Z (output only.) Time zone as a character string (empty if not available).
Where leading zeros are shown they will be used on output but are optional
on input. See ?strftime.
Plotting
plot(x) plot of the values of x (on the y-axis) ordered on the x-axis
plot(x, y) bivariate plot of x (on the x-axis) and y (on the y-axis)
hist(x) histogram of the frequencies of x
barplot(x) histogram of the values of x; use horiz=FALSE for horizontal
bars
dotchart(x) if x is a data frame, plots a Cleveland dot plot (stacked plots
line-by-line and column-by-column)
pie(x) circular pie-chart
boxplot(x) “box-and-whiskers” plot
sunflowerplot(x, y) id. than plot() but the points with similar coordinates
are drawn as flowers which petal number represents the number
of points
stripplot(x) plot of the values of x on a line (an alternative to
boxplot() for small sample sizes)
coplot(x˜y | z) bivariate plot of x and y for each value or interval of
values of z
interaction.plot (f1, f2, y) if f1 and f2 are factors, plots the
means of y (on the y-axis) with respect to the values of f1 (on the
x-axis) and of f2 (different curves); the option fun allows to choose
the summary statistic of y (by default fun=mean)
matplot(x,y) bivariate plot of the first column of x vs. the first one of y,
the second one of x vs. the second one of y, etc.
fourfoldplot(x) visualizes, with quarters of circles, the association between
two dichotomous variables for different populations (x must
be an array with dim=c(2, 2, k), or a matrix with dim=c(2, 2) if
k = 1)
assocplot(x) Cohen–Friendly graph showing the deviations from independence
of rows and columns in a two dimensional contingency table
mosaicplot(x) ‘mosaic’ graph of the residuals from a log-linear regression
of a contingency table
pairs(x) if x is a matrix or a data frame, draws all possible bivariate plots
between the columns of x
plot.ts(x) if x is an object of class "ts", plot of x with respect to time, x
may be multivariate but the series must have the same frequency and
dates
ts.plot(x) id. but if x is multivariate the series may have different dates
and must have the same frequency
qqnorm(x) quantiles of x with respect to the values expected under a normal
law
qqplot(x, y) quantiles of y with respect to the quantiles of x
contour(x, y, z) contour plot (data are interpolated to draw the
curves), x and y must be vectors and z must be a matrix so that
dim(z)=c(length(x), length(y)) (x and y may be omitted)
filled.contour(x, y, z) id. but the areas between the contours are
coloured, and a legend of the colours is drawn as well
image(x, y, z) id. but with colours (actual data are plotted)
persp(x, y, z) id. but in perspective (actual data are plotted)
stars(x) if x is a matrix or a data frame, draws a graph with segments or a
star where each row of x is represented by a star and the columns are
the lengths of the segments
symbols(x, y, ...) draws, at the coordinates given by x and y, symbols
(circles, squares, rectangles, stars, thermometres or “boxplots”)
which sizes, colours . . . are specified by supplementary arguments
termplot(mod.obj) plot of the (partial) effects of a regression model
(mod.obj)
The following parameters are common to many plotting functions:
add=FALSE if TRUE superposes the plot on the previous one (if it exists)
axes=TRUE if FALSE does not draw the axes and the box
type="p" specifies the type of plot, "p": points, "l": lines, "b": points
connected by lines, "o": id. but the lines are over the points, "h":
vertical lines, "s": steps, the data are represented by the top of the
vertical lines, "S": id. but the data are represented by the bottom of
the vertical lines
xlim=, ylim= specifies the lower and upper limits of the axes, for example
with xlim=c(1, 10) or xlim=range(x)
xlab=, ylab= annotates the axes, must be variables of mode character
main= main title, must be a variable of mode character
sub= sub-title (written in a smaller font)
Low-level plotting commands
points(x, y) adds points (the option type= can be used)
lines(x, y) id. but with lines
text(x, y, labels, ...) adds text given by labels at coordinates
(x,y); a typical use is: plot(x, y, type="n"); text(x, y,
names)
mtext(text, side=3, line=0, ...) adds text given by text in
the margin specified by side (see axis() below); line specifies the
line from the plotting area
segments(x0, y0, x1, y1) draws lines from points (x0,y0) to points
(x1,y1)
arrows(x0, y0, x1, y1, angle= 30, code=2) id. with arrows
at points (x0,y0) if code=2, at points (x1,y1) if code=1, or both if
code=3; angle controls the angle from the shaft of the arrow to the
edge of the arrow head
abline(a,b) draws a line of slope b and intercept a
abline(h=y) draws a horizontal line at ordinate y
abline(v=x) draws a vertical line at abcissa x
abline(lm.obj) draws the regression line given by lm.obj
rect(x1, y1, x2, y2) draws a rectangle which left, right, bottom, and
top limits are x1, x2, y1, and y2, respectively
polygon(x, y) draws a polygon linking the points with coordinates given
by x and y
legend(x, y, legend) adds the legend at the point (x,y) with the symbols
given by legend
title() adds a title and optionally a sub-title
axis(side, vect) adds an axis at the bottom (side=1), on the left (2),
at the top (3), or on the right (4); vect (optional) gives the abcissa (or
ordinates) where tick-marks are drawn
rug(x) draws the data x on the x-axis as small vertical lines
locator(n, type="n", ...) returns the coordinates (x,y) after the
user has clicked n times on the plot with the mouse; also draws symbols
(type="p") or lines (type="l") with respect to optional graphic
parameters (...); by default nothing is drawn (type="n")
Graphical parameters
These can be set globally with par(...); many can be passed as parameters
to plotting commands.
adj controls text justification (0 left-justified, 0.5 centred, 1 right-justified)
bg specifies the colour of the background (ex. : bg="red", bg="blue", . . .
the list of the 657 available colours is displayed with colors())
bty controls the type of box drawn around the plot, allowed values are: "o",
"l", "7", "c", "u" ou "]" (the box looks like the corresponding character);
if bty="n" the box is not drawn
cex a value controlling the size of texts and symbols with respect to the default;
the following parameters have the same control for numbers on
the axes, cex.axis, the axis labels, cex.lab, the title, cex.main,
and the sub-title, cex.sub
col controls the color of symbols and lines; use color names: "red", "blue"
see colors() or as "#RRGGBB"; see rgb(), hsv(), gray(), and
rainbow(); as for cex there are: col.axis, col.lab, col.main,
col.sub
font an integer which controls the style of text (1: normal, 2: italics, 3:
bold, 4: bold italics); as for cex there are: font.axis, font.lab,
font.main, font.sub
las an integer which controls the orientation of the axis labels (0: parallel to
the axes, 1: horizontal, 2: perpendicular to the axes, 3: vertical)
lty controls the type of lines, can be an integer or string (1: "solid",
2: "dashed", 3: "dotted", 4: "dotdash", 5: "longdash", 6:
"twodash", or a string of up to eight characters (between "0" and
"9") which specifies alternatively the length, in points or pixels, of
the drawn elements and the blanks, for example lty="44" will have
the same effect than lty=2
lwd a numeric which controls the width of lines, default 1
mar a vector of 4 numeric values which control the space between the axes
and the border of the graph of the form c(bottom, left, top,
right), the default values are c(5.1, 4.1, 4.1, 2.1)
mfcol a vector of the form c(nr,nc) which partitions the graphic window
as a matrix of nr lines and nc columns, the plots are then drawn in
columns
mfrow id. but the plots are drawn by row
pch controls the type of symbol, either an integer between 1 and 25, or any
single character within ""
1 l 2 3 4 5 6 7 8 9 10l 11 12 13l 14 15
16l 17 18 19l 20 l 21l 22 23 24 25 * * . X X a a ? ?
ps an integer which controls the size in points of texts and symbols
pty a character which specifies the type of the plotting region, "s": square,
"m": maximal
tck a value which specifies the length of tick-marks on the axes as a fraction
of the smallest of the width or height of the plot; if tck=1 a grid is
drawn
tcl a value which specifies the length of tick-marks on the axes as a fraction
of the height of a line of text (by default tcl=-0.5)
xaxt if xaxt="n" the x-axis is set but not drawn (useful in conjonction with
axis(side=1, ...))
yaxt if yaxt="n" the y-axis is set but not drawn (useful in conjonction with
axis(side=2, ...))
Lattice (Trellis) graphics
xyplot(y˜x) bivariate plots (with many functionalities)
barchart(y˜x) histogram of the values of y with respect to those of x
dotplot(y˜x) Cleveland dot plot (stacked plots line-by-line and columnby-
column)
densityplot(˜x) density functions plot
histogram(˜x) histogram of the frequencies of x
bwplot(y˜x) “box-and-whiskers” plot
qqmath(˜x) quantiles of x with respect to the values expected under a theoretical
distribution
stripplot(y˜x) single dimension plot, x must be numeric, y may be a
factor
qq(y˜x) quantiles to compare two distributions, x must be numeric, y may
be numeric, character, or factor but must have two ‘levels’
splom(˜x) matrix of bivariate plots
parallel(˜x) parallel coordinates plot
levelplot(z˜x*y|g1*g2) coloured plot of the values of z at the coordinates
given by x and y (x, y and z are all of the same length)
wireframe(z˜x*y|g1*g2) 3d surface plot
cloud(z˜x*y|g1*g2) 3d scatter plot
In the normal Lattice formula, y x|g1*g2 has combinations of optional conditioning
variables g1 and g2 plotted on separate panels. Lattice functions
take many of the same arguments as base graphics plus also data= the data
frame for the formula variables and subset= for subsetting. Use panel=
to define a custom panel function (see apropos("panel") and ?llines).
Lattice functions return an object of class trellis and have to be print-ed to
produce the graph. Use print(xyplot(...)) inside functions where automatic
printing doesn’t work. Use lattice.theme and lset to change Lattice
defaults.
Optimization and model fitting
optim(par, fn, method = c("Nelder-Mead", "BFGS",
"CG", "L-BFGS-B", "SANN") general-purpose optimization;
par is initial values, fn is function to optimize (normally minimize)
nlm(f,p) minimize function f using a Newton-type algorithm with starting
values p
lm(formula) fit linear models; formula is typically of the form response
termA + termB + ...; use I(x*y) + I(xˆ2) for terms made of
nonlinear components
glm(formula,family=) fit generalized linear models, specified by giving
a symbolic description of the linear predictor and a description of
the error distribution; family is a description of the error distribution
and link function to be used in the model; see ?family
nls(formula) nonlinear least-squares estimates of the nonlinear model
parameters
approx(x,y=) linearly interpolate given data points; x can be an xy plotting
structure
spline(x,y=) cubic spline interpolation
loess(formula) fit a polynomial surface using local fitting
Many of the formula-based modeling functions have several common arguments:
data= the data frame for the formula variables, subset= a subset of
variables used in the fit, na.action= action for missing values: "na.fail",
"na.omit", or a function. The following generics often apply to model fitting
functions:
predict(fit,...) predictions from fit based on input data
df.residual(fit) returns the number of residual degrees of freedom
coef(fit) returns the estimated coefficients (sometimes with their
standard-errors)
residuals(fit) returns the residuals
deviance(fit) returns the deviance
fitted(fit) returns the fitted values
logLik(fit) computes the logarithm of the likelihood and the number of
parameters
AIC(fit) computes the Akaike information criterion or AIC
Statistics
aov(formula) analysis of variance model
anova(fit,...) analysis of variance (or deviance) tables for one or more
fitted model objects
density(x) kernel density estimates of x
binom.test(), pairwise.t.test(), power.t.test(),
prop.test(), t.test(), ... use help.search("test")
Distributions
rnorm(n, mean=0, sd=1) Gaussian (normal)
rexp(n, rate=1) exponential
rgamma(n, shape, scale=1) gamma
rpois(n, lambda) Poisson
rweibull(n, shape, scale=1) Weibull
rcauchy(n, location=0, scale=1) Cauchy
rbeta(n, shape1, shape2) beta
rt(n, df) ‘Student’ (t)
rf(n, df1, df2) Fisher–Snedecor (F) (c2)
rchisq(n, df) Pearson
rbinom(n, size, prob) binomial
rgeom(n, prob) geometric
rhyper(nn, m, n, k) hypergeometric
rlogis(n, location=0, scale=1) logistic
rlnorm(n, meanlog=0, sdlog=1) lognormal
rnbinom(n, size, prob) negative binomial
runif(n, min=0, max=1) uniform
rwilcox(nn, m, n), rsignrank(nn, n) Wilcoxon’s statistics
All these functions can be used by replacing the letter r with d, p or q to
get, respectively, the probability density (dfunc(x, ...)), the cumulative
probability density (pfunc(x, ...)), and the value of quantile (qfunc(p,
...), with 0 < p < 1).
Programming
function( arglist ) expr function definition
return(value)
if(cond) expr
if(cond) cons.expr else alt.expr
for(var in seq) expr
while(cond) expr
repeat expr
break
next
Use braces {} around statements
ifelse(test, yes, no) a value with the same shape as test filled
with elements from either yes or no
do.call(funname, args) executes a function call from the name of
the function and a list of arguments to be passed to it

# Basic confirmatory trial.
an R program to compute the simulated Type I error and other operating characteristics of the basic Phase III confirmatory trial.
adapt1 <- function(simulateP,nsims,postcut,hypothesisP,nCuts){.
   win <- logical(nsims).
   ss <- numeric(nsims).
.
   nInts <- nCuts.
   for (i in 2:length(nCuts)){.
      nInts[i] <- nCuts[i] - nCuts[i-1].
   }.
.
   for (i in 1:nsims){.
      x <- rbinom(length(nCuts),nInts,simulateP).
      x <- c(x[1],x[1]+x[2],x[1]+x[2]+x[3]).
      ProbSup <- 1 - pbeta(hypothesisP,1+x,1+nCuts-x).
.
# Probability of Success.
## Meisam: here we check if in any of those locations we are passing the threshold.
      win[i] <- any(ProbSup > postcut ).
# Sample size.
      ss[i] <- min(nCuts[ProbSup > postcut],max(nCuts)).
   }.
   out <- c(length(win[win])/nsims,mean(ss),.
                       sqrt(var(ss)),table(ss)/nsims).
   names(out) <- c('Pr(win)','MeanSS','SD SS',as.character(nCuts)).
   out.
}.
.
## Input these values for the Type I error of Example 5.2.1:.
> nsims <- 1000000.
> postcut <- 0.95.
> hypothesisP <- 0.5.
> simulateP <- 0.5.
> nCuts <- c(50,75,100).
> out <- adapt1(simulateP,nsims,postcut,hypothesisP,nCuts).
.
> out.
  Pr(win)    MeanSS     SD SS        50        75       100.
 0.095770 96.455625 12.247579  0.059165  0.023445  0.917390.

 
allH = data.table(allH)
# str(allH)
# dim(allH)
# unqiue(allH$Property_Location)

#number of unique locations
t(t(table(allH$Property_Location)))

#only for cleaning purpose
allH[is.na(Count...),Count...:=0]

#aggregate number of observations within each location
aggregate(allH$Count..., by=list(Category=allH$Property_Location), FUN=sum)

#check
#allH[as.character(Property_Location)=="Telangana",Count...]


#ROC diagram
library(pROC)
interMediateData= cbind(designMatrixSample,predictedValue)
g <- roc(c_indicator ~ predictedValue, data = interMediateData)
plot(g) 

loginCount = designMatrixSample[,list(login_count,
                         login_count_last_0,
                         login_count_last_7,
                         login_count_last_7.14,
                         login_count_last_14,
                         login_count_last_14.21,
                         login_count_last_21,
                         login_count_last_21.30,
                         login_count_last_30)]

cedIndex = designMatrix[c_indicator==1,]
noNcedIndex = designMatrix[c_indicator==0,]
sampleSize =floor(min(nrow(cedIndex),nrow(noNcedIndex))*0.40)
sample = c(sample(cedIndex[,..I],sampleSize), sample(noNcedIndex[,..I],sampleSize))
designMatrixSample = designMatrix[..I%in%sample,]
designMatrixTest =  designMatrix[!(..I%in%sample),]						 

quantile(inputData$l,c(0,0.25,0.50,0.75,.80,.90, .95, 1.000))
inputData[l>100000 ,l_bucket:='l.100KAbove']
hist(inputData$l_count_last_30)

library(MASS)
fit <- stepAIC(fitOriginal, trace = TRUE)

predictedValue<-predict(fit, designMatrixSample, type="response")
confusion_matrix <- function(dataframe, cutoff = 0.2, plot.it = TRUE,
                             xlab = c("dep_var = 0", "dep_var = 1"),
                             ylab = c("score = 0", "score = 1"), title = NULL) {
  stopifnot(is.data.frame(dataframe) &&
              all(c('score', 'dep_var') %in% colnames(dataframe)))
  stopifnot(is.numeric(dataframe$score) && is.numeric(dataframe$dep_var))
  
  
  dataframe$score <- ifelse(dataframe$score <= cutoff, 0, 1)
  categories <- dataframe$score * 2 + dataframe$dep_var
  confusion <- matrix(tabulate(1 + categories, 4), nrow = 2)
  colnames(confusion) <- ylab
  rownames(confusion) <- xlab
  if (plot.it) fourfoldplot(confusion, color = c("#CC6666", "#99CC99"),
                            conf.level = 0, margin = 1, main = title)
  confusion
  
}
pred_df <- data.frame(dep_var = designMatrixSample$c, score = predictedValue)
#threshold = quantile(predictedValue,  probs = c(50)/100)
threshold = 0.5
confusion_matrix(pred_df, cutoff = threshold)
confusion_matrix(pred_df, cutoff = threshold)/length(predictedValue)

library(pROC)
interMediateData= cbind(designMatrixSample,predictedValue)
g <- roc(c ~ predictedValue, data = interMediateData)
plot(g) 
	 
#------------------------------
# check the tree method for defining the bins
#-----------------------------
# decision tree did not work
#install.packages("rpart")
# library(rpart)
# 
# # grow tree 
# fit <- rpart(factor(churn_indicator) ~current_platform+login_count,
#           #   method="class", 
#              data=inputData)
# fit <- rpart(Kyphosis ~ Age, data = kyphosis)
# 
# printcp(fit) # display the results 
# plotcp(fit) # visualize cross-validation results 
# summary(fit) # detailed summary of splits
# 
# # plot tree 
# plot(fit, uniform=TRUE, 
#      main="Classification Tree for Kyphosis")
# text(fit, use.n=TRUE, all=TRUE, cex=.8)

setwd(codeFolder)
#getwd()


cRoot = getwd()
# Sourcing the code that picks the latest version of any source file we wish to use
# unless of course, the version number is actually specified
source(paste0(cRoot, '/sourceLatestVersion.R'))

# sourcing some common functions
cCommonFuncFileName = sourceLatestVersion(
  path = paste0(cRoot, '/'),
  pattern = 'CommonFunction'
)

source(cCommonFuncFileName)


# Determine number of clusters
wss <- (nrow(clusteringData)-1)*sum(apply(clusteringData,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(clusteringData, 
                                     centers=i)$withinss)
modelSel=as.data.frame(cbind(1:15,wss))
names(modelSel)=c('NumClust','WithinGroupSumSq')
library(ggplot2) 
# Separate regressions of mpg on weight for each number of cylinders
qplot(NumClust, WithinGroupSumSq, data=modelSel, geom=c("point", "smooth"), 
      main="Number of Cluster Selection based on Within Group Sum of Square", 
      xlab="Number of Clusters", ylab="Within Groups Sum of Squares")+theme_set(theme_grey(base_size = 24)) 

# plot(1:15, wss, type="b", xlab="Number of Clusters",
#      ylab="Within groups sum of squares")

fit <- glm(c ~ p + DoW , data=designMatrix, family=binomial())

summary(fit) 
sink("Results/logitRegressionGainLoss.txt")
summary(fit) 
sink()	

#function to seprate day and month
parseDayMonth = function(DateList){
  parsedDate=data.table(sapply(lapply(DateList,function(x) return(strsplit(x,"/")[[1]])), "[[", 1),
                        sapply(lapply(DateList,function(x) return(strsplit(x,"/")[[1]])), "[[", 2))
  parsedDate[,V1:=as.numeric(V1)]
  parsedDate[,V2:=as.numeric(V2)]
  setnames(parsedDate,"V1","month")
  setnames(parsedDate,"V2","day")
  return(parsedDate)
}

HData[,Checkout.Day:=as.numeric(getDay(Checkout_Dt))] 

HDtCheckinNonWorking = merge(
  HData[,list(Confirm_Nbr,Checkin.Day,Checkin.Month)],
  nonWorkingHollidaysDt[, 
                        list(
                          Checkin.Month = month, 
                          Checkin.Day = day)
                        ],
  by = c('Checkin.Month','Checkin.Day')
)

starRating[,StarRating:=ceiling(mean(StarRating)),by=SynXis_Property_ID]

starRating[is.na(StarRating),StarRating:=3]

starRating <-subset(starRating,select=c("SynXis_Property_ID","StarRating"))

#======================================================
#function to generate bar chart by normalizing the frequencies (percentages)
#======================================================
GenerateOVerallSummaryPlotsPercentage<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1")]
  dtDataSubset[,PCT:=N*100/sum(N)]
  
  if (!is.null(FileName)){
    plot<-
      ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
      theme(text = element_text(size=20),
            axis.text.x = element_text(angle=90, vjust=1)) 
    ggsave(plot,filename=paste0(FileName, '.png'))  
  }else{
    ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
      theme(text = element_text(size=20),
            axis.text.x = element_text(angle=90, vjust=1)) 
  }
}
#======================================================
# function to generate bar chart based on the frequencies
#======================================================
GenerateOVerallSummaryPlotsFreq<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1")]
  dtDataSubset[,PCT:=N]
  
  if (!is.null(FileName)){
    plot<-
      ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10),0),limits=c(0,max(dtDataSubset$PCT)))+
      theme(text = element_text(size=20),
            axis.text.x = element_text(angle=90, vjust=1)) +
      ggsave(filename=paste0(FileName, '.png'))  
  }else{
    ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
      ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
      scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10,0)),limits=c(0,max(dtDataSubset$PCT)))+
      theme(text = element_text(size=20),
            axis.text.x = element_text(angle=90, vjust=1)) 
  }
}

#======================================================
# stacked bar chart
#======================================================
GenerateStackkedBarChart<-function(dtData,feature1,segment,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,segment,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segment)]
  
  
  if (!is.null(FileName)){
    ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
      ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
    ggsave(filename=paste0(FileName, '.png'))  
  }else{
    ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
      ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
  }
}

#create the Histogram for the numerical features
#========================================================================

#function to draw a histogram of feature1 distribution, it recieves the min and max and step to visualize
histogramDraw<-function(dtData,feature1,ID, MinValueDraw, MaxValueDraw, stepSizeDraw, FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  
  if (!is.null(FileName)){
    ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
  }else{
    ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
  }
}

#===============================================================================
#function to draw a histogram of feature1 distribution only for segment SegInstance, it recieves the min and max and step to visualize

histogramSegmentDraw<-function(dtData,feature1,segmentVarName, SegInstance, MinValueDraw, MaxValueDraw, stepSizeDraw, ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,segmentVarName,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segmentVarName)]
  dtDataSubset = dtDataSubset[Segments==SegInstance,]
  
  if (!is.null(FileName)){
    ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
  }else{
    ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
  }
}

toPlotData = copy(HData)
toPlotData[,dayTypeObservence:=ifelse(observence.days,"Observence Days", "Other days")]
setnames(toPlotData,"Profile_Type_Nm","Profile.Class")

GenerateStackkedBarChart(dtData=toPlotData,feature1="dayTypeObservence",segment="Profile.Class",ID="Confirm_Nbr",
                         paste0(getwd(),"/imagesForPresentation/ObservenceDaysVs.Others"))
						 
gc()

library(data.table)
library(stringr)
library(ggplot2)
library(gdata)

unique(HData[,Room_Cnt])

cat(as.character(unique(HData[,PMS_Room_Type_Cd])),sep=", ")

sort(unique(HData[,Checkin_Dt]))
length(unique(HData[,Checkin_Dt]))

# LDA method

#=======================================================
# Run Latent Dirichlet Allocation (LDA) to benchmark
#=======================================================
#install the package first
#install.packages("topicmodels")
library(topicmodels)


print ('Starting LDA...............................................\n')

#the number of clusters is set to 7 for tractability, but it can be benchmarked based on log likelihood
k = 7

print ('the number of clusters is:')
print(k)

control_LDA_VEM <- list(estimate.alpha = TRUE, alpha = 50/k, estimate.beta = TRUE,
                        verbose = 1, prefix = tempfile(), save = 0, keep = 0,
                        seed = as.integer(Sys.time()), nstart = 1, best = TRUE,
                        var = list(iter.max = 500, tol = 10^-6),
                        em = list(iter.max = 1000, tol = 10^-4),
                        initialize = "random")

#Note 1: The variational Bayesian approach is selected here for estimation, but Gibbs sampling is another option
#Note 2: for now I have run it once, but the correct approach is to run it multiple times and select the one with
#        the highest log likelihood, as it is using Expectation Maximization, so it might fall into local maxima
lda = LDA(x = inputMatrix, k, method = "VEM", control = control_LDA_VEM , model = NULL)

#sum(lda@loglikelihood)   # because it gives likelihood for each individual
#posterior prediction for the data (it can be used for out of sample prediction as well)
lda_inf <- posterior(lda, inputMatrix)


#lda_inf$terms identifies weight of each of the ancilliaries for each cluster [nclusters x nfeatures]
#lda_inf$topics identifies the membership weight for each of the clusters [nObs x nclusters] 

#identify each of the clusters (hard here means which one has the maximum weight and assign accordingly)
hardCluster = max.col (lda_inf$topics)  #[nObs]

#maximum loading of each of the features in each cluster
featuresMaxCluster = max.col(t(lda_inf$terms)) #[nfeatures]
ClustersMaxFeature = max.col(lda_inf$terms) #[ncluster]

#==================================================
#save the result into a csv file
#===================================================
# the weight of membership of each observation (PNR) in each of the clusters (and the maximum cluster)
outputLDAObsClustPath = "C://LDA.ClusterWeightEachObs.csv"
write.csv(cbind(lda_inf$topics,hardCluster),file=outputLDAObsClustPath)

# the weight of each ancillary (feature) in each of the clusters (and the maximum ancillary per cluster, and maximum cluster per ancillary)
outputAncillaryCluster = cbind(t(lda_inf$terms),featuresMaxCluster)
# add cluster max at the end
outputAncillaryCluster = rbind (outputAncillaryCluster,c(ClustersMaxFeature,0))
#set the last row name to clusters Max feature
row.names(outputAncillaryCluster)=c(row.names(outputAncillaryCluster)[1:(nrow(outputAncillaryCluster)-1)],"Cluster's max feature")
outputLDAFeatureClustPath = "C://LDA.ClusterFeatureWeight.csv"
write.csv(outputAncillaryCluster,file=outputLDAFeatureClustPath)


#=========================================================================
# run Non-negative matrix factorization
#=========================================================================
# install pcakge 
#install.packages("NMF")

library(NMF)

kNMF = 7 #use the same number of clusters to allow comparison with other methods


# perform a 3-rank NMF using the default algorithm (run in verbose form)

#in my run there has been an error of final objective value is NA in couple of runs when default algorithm is used

#for now I will only run with 'lee' algorithm, but later on we can test all the following list of algorithm
#available algorithms are:
#'.M#brunet', '.R#brunet', '.R#lee', '.R#nsNMF', '.R#offset', '.siNMF', 'brunet','Frobenius', 'KL', 'lee', 'ls-nmf', 'nsNMF', 'offset', 'pe-nmf', 'siNMF', 'snmf/l', 'snmf/r'

methodNMF = "lee"
#using lee algorithm 
res <- nmf(inputMatrix, kNMF, methodNMF , .options = 'v3')  


#res@fit@H identifies weight of each of the ancilliaries for each cluster [nclusters x nfeatures]
#res@fit@W identifies the membership weight for each of the clusters [nObs x nclusters] 

#identify each of the clusters (hard here means which one has the maximum weight and assign accordingly)
hardClusterNMF = max.col (res@fit@W)  #[nObs]

#maximum loading of each of the features in each cluster
featuresMaxClusterNMF = max.col(t(res@fit@H)) #[nfeatures]
ClustersMaxFeatureNMF = max.col(res@fit@H) #[ncluster]


#==================================================
#save the result into a csv file
#===================================================
# the weight of membership of each observation (PNR) in each of the clusters (and the maximum cluster)
outputLDAObsClustPathNMF = "C://NMF.ClusterWeightEachObs.csv"
outputW = res@fit@W
colnames(outputW) <- c(1:kNMF)
write.csv(cbind(outputW,hardClusterNMF),file=outputLDAObsClustPathNMF)

# the weight of each ancillary (feature) in each of the clusters (and the maximum ancillary per cluster, and maximum cluster per ancillary)
outputH = t(res@fit@H)
colnames(outputH)<-c(1:kNMF)
outputAncillaryClusterNMF = cbind(outputH,featuresMaxClusterNMF)
# add cluster max at the end
outputAncillaryClusterNMF = rbind (outputAncillaryClusterNMF,c(ClustersMaxFeatureNMF,0))
#set the last row name to clusters Max feature
row.names(outputAncillaryClusterNMF)=c(row.names(outputAncillaryClusterNMF)[1:(nrow(outputAncillaryClusterNMF)-1)],"Cluster's max feature")
outputLDAFeatureClustPathNMF = "C://NMF.ClusterFeatureWeight.csv"
write.csv(outputAncillaryClusterNMF,file=outputLDAFeatureClustPathNMF)



#=========================================================================================================
# Restricted Boltzman Machine
#there is another code in 
#            http://www.r-bloggers.com/restricted-boltzmann-machines-in-r/
#=========================================================================================================
#install the package
#install.packages("deepnet")
library(deepnet)

# the number of clusters is set like above for better comparison, but it should be experimented to 
# wee which number generates more reasonable results
nClustRBM = 7


# I used the learning rate that the mentioned source used, but actually it has to be experimented 
# (the same applies to  momentum, batchsize and number of iterations)
# As I had to have number of test cases divisable by batch size I discarded couple of observations
inputMatrixRBM = inputMatrix[1:(nrow(inputMatrix)-(nrow(inputMatrix)%%100)),]

#number of gibbs iteration is set to 10, but again it can be changed to see how does the performance change
rbmOutput <- rbm.train(inputMatrixRBM, nClustRBM, numepochs = 20, 
                       batchsize = 100, learningrate = 0.8, 
                       learningrate_scale = 1, momentum = 0.5, visible_type = "bin", hidden_type = "bin",cd = 10)

# the output is not explained in the document, so I guessed the weights are in variable w of the output, but it could be vw

weights=rbmOutput$W

#Note: I also don't know which one is the bias term B or VB
# the weight of each ancillary (feature) in each of the clusters (and the maximum ancillary per cluster, and maximum cluster per ancillary)
outputRBM = t(weights)
colnames(outputRBM)<-c(1:nClustRBM)

# add cluster max at the end
outputAncillaryClusterRBM = outputRBM
#set the last row name to clusters Max feature
row.names(outputAncillaryClusterRBM)=colnames(inputMatrixRBM)
outputLDAFeatureClustPathRBM = "C://RBM.ClusterFeatureWeight.csv"
write.csv(outputAncillaryClusterRBM,file=outputLDAFeatureClustPathRBM) 


# Determine Number of Factors to Extract
dim(mydata) # 996  61
mydata = inputDTForFactAnalysis
library(nFactors)
ev <- eigen(cor(mydata)) # get eigenvalues
ap <- parallel(subject=nrow(mydata),var=ncol(mydata),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)

# Principal Axis Factor Analysis
library(psych)
fit <- principal(mydata, nfactors=10, rotate="varimax")
fit # print results
str(fit)
write.csv(fit$loadings,file='/principleCompAnalysisWeights.csv')

library(data.table)

inputDTForFactAnalysis= subset(clustOutput[clustSize>30,],,featuresOfInterest)

library("RPostgreSQL")
con <- dbConnect(drv, host="<<REDSHIFT ENDPOINT>>", port="<<PORT NUMBER>>", dbname="<<DBNAME>>", user="<<USERNAME>>", password="<<PASSWORD>>")

t <- dbGetQuery(con, "
SELECT
\"ti_orderid\" AS \"transaction_id\",
\"ti_name\" AS \"sku\"
FROM
\"events\"
WHERE
\"event\" = 'transaction_item'
")

basket_rules <- apriori(txn, parameter = list(sup = 0.005, conf = 0.01, target="rules"))

RChart
====================================
rChart: create interactive javascript visualization using R

so learning complex tool such as D3 is not required

Source: http://ramnathv.github.io/rCharts/


#installation method that works:
#====================================
#install.packages("devtools", dependencies=TRUE)
#install.packages('Rcpp', dependencies = TRUE)
#install.packages("ggplot2", dependencies=TRUE) 
library(devtools)
library(Rcpp)

library(downloader)
download("https://github.com/ramnathv/rCharts/archive/master.tar.gz", "rCharts.tar.gz")
install.packages("rCharts.tar.gz", repos = NULL, type = "source")




# Example codes for R-chart
#========================================================
setwd("C:\\Users\\sg0224373\\Desktop\\STasks\\HProject\\RCode\\rChartSample")
require(rCharts)
haireye=as.data.frame(HairEyeColor)
n1 <- nPlot(Freq ~ Hair, group= 'Eye', type= 'multiBarChart', data=subset(haireye, 
                                                                          Sex=='Male')
)
#miesam: to see the chart
show(n1)
#meisam: create directory of fig that does not exist
dir.create("fig", showWarnings = FLASE, recursive = FALSE, mode = "0777")
n1$save('fig/n1.html',cdn=TRUE)
cat('<iframe src="fig/n1.html" width=100%, height=600></iframe>')

#object n1 contains the plot

calling plot or not assignment creates the plot (or show function)

#print out the html for the plot
n1$html()

#can save and use the code in slidify
n1$save(filename)

#Deconstructing another example
#====================
##Exampe 1 Facetted Scatterplot
names(iris)=gsub("\\.","",names(iris))
r1=rPlot(SepalLength~SepalWidth | Species, data = iris, color = 'Species', type= 'point')
r1$save('fig/r1.html',cdn=TRUE)
cat('<iframe src="fig/r1.html" width=100%, height=600></iframe>')


#Example 2 Facetted Barplot
#========================
hair_eye = as.data.frame(HairEyeColor)
r2 <- rPlot(Freq ~ Hair | Eye, color = 'Eye', data= hair_eye, type = 'bar')
r2$save ('fig/r2.html', cdn = TRUE)
cat('<iframe src="fig/r2.html" width=100%, height = 600></iframe>')

#How to get the js/html or publish an rChart
#======================================
r1<- rPlot(mpg ~wt | am + vs, data = mtcars, type = "point", color="gear")
r1$print("chart1") # print out the js
r1$save('myplot.html') #save as html file


r1$publish('myPlot', host='gist') #save to gist, rjson required
r$publish('myPlot', host=rpubs') #save to rpubs

#===================================================================

rChart has links to several libraries
#===================================================================

#morris
data(economics, package="ggplot2")
econ<-transform(economics, data=as.character(date))
m1 <- mPlot(x="date", y=c("psavert", "uempmed"), type="Line", data=econ)
m1$set(pointSize=0, lineWidth=1)
m1$save('fig/m1.html', cdn=TRUE)
cat('<iframe src="fig/m1.html" width=100%, height=600></iframe>')

XCharts
#============================================================
require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2]=c("category", "year")
x1<- xPlot(value ~ year, group = "category", data= uspexp, type="line-dotted")
x1$save('fig/x1.html', cdn=TRUE)
cat('<iframe src="fig/x1.html" width=100%, height=600></iframe>')

#Leaflet
#============================
mp3 <- Leaflet$new()
mp3$setView(c(51,505,-0.09), zoom=13)
mp3$marker(c(51.5, -0.09), bindPopup= "<p> Hi. I am popup </p>")
mp3$marker(c(51.495, -0.083), bindPopup= "<p> Hi. I am another popup </p>")
show(mp3)
mp3$save('fig/mp3.html')

mp3$save('fig/mp3.html', cdn=TRUE)
cat('<iframe src="fig/mp3.html", width=100%, height=600></iframe>')

#Rickshaw
#============================
usp = reshape2::melt(USPersonalExpenditure)
#get the decades into a date Rickshaw links
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group = "Var1", data = usp, type = "area", width=560)
#add a helpful slider this easily; other features TRUE as a default
p4$set(slider = TRUE)
p4$save('fig/p4.html')

p4$save('fig/p4.html', cdn=TRUE)
cat('<iframe src="fig/p4.html" width=100%, height=600></iframe>')

#highchart
#===============================
h1<- hPlot(x="Wr.Hnd", y="NW.Hnd", data=MASS::survey, type=c("line", "bubble", "scatter"), 
           group="Clap", size="Age")

h1$save('fig/h1.html')
show(h1)

h1$save('fig/h1.html', cdn=TRUE)
cat('<iframe src="fig/h1.html" width=100%, height=600></iframe>')


rChart summary
#=================================
(1) makes creating interactive javascript visualization in R easy
(2) non-trivial customization require knowledgte of javascript
(3) It is under development

#Rchart cheat sheet
#=============================
# continuous time plot: mPlot
# frequency plot by: rPlot, type='bar'
# scatter plot: type="point"
# line curve: xPlot, type='line-dotted'
# for map and landmark: Leaflet
#stack diagram by: Rickshaw
#for maps GoogleVis library is good

#clean the work sapce first
#-------------------------
rm(list = ls())

#==================================
#load the required libraries
library(shiny)
library(data.table)
library(stringr)
library(ggplot2)
library(gdata)
library(MASS)
#========================================

#set the path to the path that includes the server.R and ui.R and the data file
#run shiny app
#shiny
load("dtHDataDerived.Rdata")
HData = HDatatmp
runApp(getwd())


SimulateBinomialPosterior <- function(y, n, ndraws){
	#Args:
	#	y: Vector of success counts, per arm.
	#	n: Vector of trial counts, per arm.
	#ndraws: The desired number of posterior draws.
	number.of.arms <- length(y)
	ans <- matrix (nrow = ndraws,
			ncol = number.of.arms)
	for (arm in 1:number.of.arms) {
		ans[,arm] <- rbeta(ndraws,
				y[arm] + 1, n[arm] - y[arm] +1)
	}
	return (ans)
}
ComputeWinProbability <- function (value.posterior){
	# Args:
	#	value.posterior: A matrix representing the value
	# 	of each arm. Rows are Monte Carlo draws from the
	#	posterior distribution of values. Columns
	#	represent different arms.
	# Returns:
	#	The vector of optimal arm probabilities.
	
	number.of.arms <- ncol(value.posterior)
	optimal.arm.probabilities <- table (
		factor(max.col(value.posterior),
		levels = 1:number.of.arms))
	return(optimal.arm.probabilities / nrow(value.posterior))
}
#the output is a vector of probability for each arm
# the factor function puts zero for those arms that have not won anywhere (no count for the success)
BinomialBandit <- function(y, n, ndraws){
	# Args:
	#	y: Vector of success counts, per arm.
	#	n: Vector of traial counts, per arm.
	# ndraws: The desired number of posterior draws
	success.probabilities <- SimulateBinomialPosterior (y, n, ndraws)
	winprob <- ComputeWinProbability(success.probabilities)
	ans <- list (success.probabilities = success.probabilities,
		optimal.arm.probabilities = winprob)
	class(ans) <- "BinomialBandit"
	return(ans)
}


 gsub(x = as.character(A), pattern = '  ', replacement = '') 
 
 POSIXct
 
 POSIXlt
 
 dtResSubset[, .N, by = list(A, FN)]
 
 merge(
    dtODSubset,
    dtAD[, list(TOT = A, C, C1)],
    by = 'TOT'
  )
 
 
 rm(dtOMC)
 
 setDT(data.frame(lapply(DT,as.character),stringsAsFactors = F))
 
 library(shiny)
library(ggplot2)
library(data.table)
require(rCharts)

#================================================
#visualization
#==========================================
#important note [Meisam]: This is the function that helps to apply the result of D3 on Shiny app
#link: https://github.com/ramnathv/rCharts/issues/522
renderChart3 <- function( expr, env = parent.frame(), quoted = FALSE ){
  func <- shiny::exprToFunction(expr, env, quoted)
  function() {
    rChart_ <- func()
    cht_style <- sprintf("<style>.rChart {width: %spx; height: %spx} </style>", 
                         rChart_$params$width, rChart_$params$height)
    cht <- paste(
      capture.output(cat(
        rChart_$print()
        ,render_template(
          rChart_$templates$afterScript %||% 
            "<script></script>"
          , list(chartId = rChart_$params$dom, container = rChart_$container)
        )
        ,sep = ""
      ))
      , collapse = "\n")
    HTML(paste(c(cht_style, cht), collapse = "\n"))
  }
}

#Visualization functions
#============================================

#======================================================
#function to generate bar chart by normalizing the frequencies (percentages)
#======================================================
GenerateOVerallSummaryPlotsPercentage<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1",feature1)]
  dtDataSubset[,PCT:=N*100/sum(N)]
  
  
  if (!is.null(FileName)){
    plot<-
#       ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
#       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
#       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
#       theme(text = element_text(size=20),
#             axis.text.x = element_text(angle=90, vjust=1)) 
#     ggsave(plot,filename=paste0(FileName, '.png'))  
      #dataSubset=subset(dtDataSubset,select=c(feature1,'freq'))
      #dataSubset$color=c('lightblue', 'lightgreen','lightpink')                 
      plot <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                                           type = "discreteBarChart")
      plot$xAxis(
        tickFormat =   "#!
        function(d) {return d;}
        !#",
        rotateLabels = -30
      ) 
       # hPlot(x = feature1, y = "freq", data =dataSubset, type = "bar")
      #plot$plotOptions(column = list(cursor = 'pointer', point = list(events = list(click = "#! function() { location.href = this.options.url; } !#"))))
      #plot$plotOptions(series = list(color = 'lightgreen'))
      #show(plot)
#       nPlot(x = feature1, y = "freq", data = subset(dtDataSubset,select=c(feature1,'freq'))[order(-freq)],
#                      type = "discreteBarChart")
#       plot$chart(margin = list(bottom = 100))
#       plot$yAxis( axisLabel = "Randomness", width = 40 )
#       plot$xAxis(staggerLabels = TRUE)
      # 
      # rPlot(x = list(var = feature1, sort = "freq"), y = "freq",     data = dtDataSubset, type = 'bar')
      
      
#       rPlot(x = list(var = feature1, sort = "freq"), y = "freq", 
#                     data = subset(dtDataSubset,select=c(feature1,'freq')), type = 'bar',color='black')
   
    return (plot)
  }else{
#     plot=ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
#       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
#       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),10),limits=c(0,max(dtDataSubset$PCT)))+
#       theme(text = element_text(size=20),
#             axis.text.x = element_text(angle=90, vjust=1)) 
    plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                          type = "discreteBarChart")
    plot$chart(margin = list(bottom = 200))
    #http://stackoverflow.com/questions/24344794/rcharts-nplot-formating-x-axis-with-dates
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return d;}
      !#",
      rotateLabels = -30
    )
    plot$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
    #http://stackoverflow.com/questions/13136964/how-can-i-position-rotated-x-axis-labels-on-column-chart-using-nvd3
#     plot$templates$script  = 
#                      "<script type='text/javascript'>
#                   chart.margin({bottom: 60});
#     d3.select('.nv-x.nv-axis > g').selectAll('g').selectAll('text').attr('transform', function(d,i,j) { return 'translate (-10, 25) rotate(-90 0,0)' }) ;
#                    </script>"
    #http://zevross.com/blog/2014/04/03/interactive-visualization-from-r-to-d3-using-rcharts/
#     plot$templates$script = system.file("C:\\\temp\\script_multiselect.html",
#                                         package = "rCharts")
    return (plot)
  }
}
#======================================================
# function to generate bar chart based on the frequencies
#======================================================
GenerateOVerallSummaryPlotsFreq<-function(dtData,feature1,ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset<-dtDataSubset[,.N,by=c("dummy1")]
  #dtDataSubset[,PCT:=N]
  dtDataSubset[,PCT:=N*100/sum(N)]
  
  if (!is.null(FileName)){
    plot<-
#       ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
#       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
#       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10),0),limits=c(0,max(dtDataSubset$PCT)))+
#       theme(text = element_text(size=20),
#             axis.text.x = element_text(angle=90, vjust=1)) +
#       ggsave(filename=paste0(FileName, '.png'))
      plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(PCT)],
                      type = "discreteBarChart")
      plot$xAxis(
        tickFormat =   "#!
        function(d) {return d;}
        !#",
        rotateLabels = -30
      )
    return (plot)
  }else{
#     plot = ggplot(data=dtDataSubset,aes(x=dummy1,y=PCT,fill=dummy1))+ geom_bar(stat="identity")+
#       ggtitle(feature1) +xlab("") + ylab("PCT")+ theme_bw()+guides(fill=FALSE)+
#       scale_y_continuous(breaks=seq(0,max(dtDataSubset$PCT),round(max(dtDataSubset$PCT)/10,0)),limits=c(0,max(dtDataSubset$PCT)))+
#       theme(text = element_text(size=20),
#             axis.text.x = element_text(angle=90, vjust=1)) 
    plot  <-  nPlot(x = feature1, y = "PCT", data = subset(dtDataSubset,select=c(feature1,'PCT'))[order(-PCT)],
                    type = "discreteBarChart")
    plot$xAxis(
      tickFormat =   "#!
      function(d) {return '%' + d;}
      !#",
      rotateLabels = -30
    )
    plot$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
    return (plot)
  }
}

#======================================================
# stacked bar chart
#======================================================
GenerateStackkedBarChart<-function(dtData,feature1,segment,ID,FileName=NULL){
  require(gridExtra)
  require(rjson)
  require(stringr)
  require(plyr)
  require(rCharts)
  require(reshape2)
  #toPlotData = copy(HData);  setnames(toPlotData,"Property_Nm","Property.Name");  setnames(toPlotData,"Profile_Type_Nm","Profile.Class")
  #dtData=toPlotData;feature1="Property.Name";segment="Profile.Class";ID="Confirm_Nbr"
  #rm(toPlotData);   gc()
  
  dtDataSubset<-subset(dtData,select=c(feature1,segment,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segment)]
  
  #if it is 0 and 1 levels then replace them with feature name and not feature name
  if (length(unique(dtDataSubset$dummy1))==2){
    checkBinary= all(unique(dtDataSubset$dummy1)%in% c(0,1)) | all(unique(dtDataSubset$dummy1)%in% c(T,F))
    if (checkBinary){
      dtDataSubset[get(feature1)==0,dummy2:=paste0("Not ",feature1)]
      dtDataSubset[get(feature1)==1,dummy2:=feature1]
      dtDataSubset[,dummy1:=NULL]
      setnames(dtDataSubset,"dummy2","dummy1")
    }
  }
  
  
  if (!is.null(FileName)){
    plot = ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
      ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    #option 1: old ggplot 
#     plot = ggplot(dtDataSubset, aes(dummy1, fill=Segments)) + geom_bar()+ ylab("Freq.")+xlab("")+
#       ggtitle(feature1) +theme(text = element_text(size=20),axis.text.x = element_text(angle=90, vjust=1)) 
#     
    #rchart
    
    dtRChartSubset = subset(dtDataSubset,select=c(ID,"dummy1","Segments"))
    df.melt <-melt(table(dtRChartSubset$dummy1,dtRChartSubset$Segments))
    names(df.melt)=c(feature1,segment,"PCT")
    setDT(df.melt)
    df.melt[,PCT:=PCT*100/sum(PCT)]
    
    #option 2: using dplot in rchart
#     d1 <- dPlot(
#       x = "Freq", 
#       y = feature1, 
#       groups = segment, 
#       data = df.melt, 
#       type = 'bar')
#     
#     #Here, set the chart options to tell rCharts how to format the visualization  
#     d1$xAxis(type = "addPctAxis")
#     d1$yAxis(type = "addCategoryAxis", orderRule = segment)
#     
#     d1$legend( x = 80, y = 10, width = 1000, height = 30, horizontalAlign = "left", orderRule = segment)
    
    
    
    #d1$set(width = 1200)
    # set the size
    #d1$params$width <- 1000
    #d1$params$height <- 700
    
#     d1$setTemplate(
#       afterScript = "
#         <script>
#         d3.selectAll('#{{ chartId }} svg text')
#           .style('font-size', '18')
#         d3.selectAll(' svg text').style('font-size', '15')
#         </script>
#       ")
    #grid.arrange(plot, d1, ncol=2)
    df.meltTemp <-df.melt
    names(df.meltTemp)=c(make.names(feature1),segment,"PCT")
    
    
    # option 3: dPlot in rChart
    #check horizontal one:
#     p2 <- dPlot(as.formula(paste("Freq ~ ",make.names(feature1))), groups = segment,
#                 data = df.meltTemp,
#                 type = 'bar'
#     )
#     p2$chart(margin = list(left = 500,right=500,bottom=500,top=500)) # margin makes room for label
#     p2$yAxis( axisLabel = "Randomness" )
#     p2$legend( x = 600, y = 30, width = 100, height = 30, horizontalAlign = "right", orderRule = segment)
    
    #p2$xAxis(axisLabel = 'Year')
    #p2$yAxis(categories = c(unique(as.character(dtDataSubset[,dummy1]))),
    #        title=list(text = ""))
    
    #p2$defaultColors(c('brown', 'blue', '#594c26', 'green'))
    # solution from dimple original java script library:
    #https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.chart
    #https://github.com/ramnathv/rCharts/issues/77
    # by taking the str of the object it is possible to find out what is the chart in d3
#     p2$setTemplate(
#       afterScript = "
#       <script>
#         //d3.selectAll('#{{ chartId }} svg text')
#         //myChart.style('font-size', '14')
#         myChart.setMargins(50, 50, 50, 200);  //dimple code to set margin by meisam
#         //myChart.setBounds(20, 20, 1000, 1000); // dimple code to set chart size by meisam
#       </script>
#       ")
    
    #======================================================
    # rotation is required only if the length is too much
    #======================================================
#     
#     if (feature1=='Rate Category'){
#       p2$setTemplate(afterScript = 
#                        "<script>
#         myChart.setMargins(50, 100, 50, 200)  //dimple code to set margin by meisam
#         d3.selectAll('#{{ chartId }} svg text').style('font-size', '14')
#         myChart.axes[0].shapes.selectAll('text').attr('transform', 'rotate(10)').style('text-anchor','middle').style('font-size','150%')
#         myChart.svg.append('text').attr('x', 40).attr('y', 20).style('text-anchor','beginning').style('font-size', '100%')
#         myChart.addMeasureAxis('y', 'attendance');// axes[0] if for x asix and axes[1] is for y axis     
#       </script>"
#       )
#     }else{
#       p2$setTemplate(afterScript = 
#                        "<script>
#         myChart.setMargins(50, 100, 50, 200)  //dimple code to set margin by meisam
#         d3.selectAll('#{{ chartId }} svg text').style('font-size', '14');
#          </script>"
#       )
#     }
    
    #
    p3 =nPlot(as.formula(paste("PCT ~ ",make.names(feature1))), group = segment, data =  df.meltTemp, type = 'multiBarChart')
    p3$chart(margin = list(left = 80))
    p3$yAxis(axisLabel = "PCT", width = 70)
    p3$chart(margin = list(right = 80))
    p3$chart(margin = list(bottom = 150))
    p3$chart(margin = list(top = 80))
    p3$xAxis(
#       tickFormat =   "#!
#       function(d) {return d;}
#       !#",
      rotateLabels = -30
    )
    p3$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")   
    p3$chart(reduceXTicks = FALSE)
    return (p3)
  }
}

#======================================================
# stacked bar chart for Date, although the name of the fun is Line Chart
#======================================================
GenerateDateLineChart<-function(dtData,feature1,segment,ID,dateType="Week"){
  #Type could be either "Week" or "Month" 
  
  #dtData = copy(HDatatmp);feature1="Checkin_DOW";segment="SegmentName";ID="Confirm_Nbr";dateType="Week"
  #dtData = copy(HDatatmp);feature1="checkin_Month";segment="SegmentName";ID="Confirm_Nbr";dateType="Month"
  #rm(dtData); gc()
  
  require(gridExtra)
  require(rjson)
  require(stringr)
  require(plyr)
  require(rCharts)
  require(reshape2)
 
  dtDataSubset<-subset(dtData,select=c(feature1,segment,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segment)]
  
  # plotting by rChart
  #------------------------
  dtRChartSubset = subset(dtDataSubset,select=c(ID,"dummy1","Segments"))
  df.melt <-melt(table(dtRChartSubset$dummy1,dtRChartSubset$Segments))
  names(df.melt)=c(feature1,segment,"PCT")
  setDT(df.melt)
  df.melt[,PCT:=PCT*100/sum(PCT)]
  

  df.meltTemp <-df.melt
  names(df.meltTemp)=c(make.names(feature1),segment,"PCT")
  
  if (dateType=="Week"){
    df.meltTemp = rbind(df.meltTemp[get(make.names(feature1))=="Mon",],
                        df.meltTemp[get(make.names(feature1))=="Tue",],
                        df.meltTemp[get(make.names(feature1))=="Wed",],
                        df.meltTemp[get(make.names(feature1))=="Thu",],
                        df.meltTemp[get(make.names(feature1))=="Fri",],
                        df.meltTemp[get(make.names(feature1))=="Sat",],
                        df.meltTemp[get(make.names(feature1))=="Sun",])
  }else if (dateType =="Month"){
    df.meltTemp = rbind(df.meltTemp[get(make.names(feature1))=="January",],
                        df.meltTemp[get(make.names(feature1))=="February",],
                        df.meltTemp[get(make.names(feature1))=="March",],
                        df.meltTemp[get(make.names(feature1))=="April",],
                        df.meltTemp[get(make.names(feature1))=="May",],
                        df.meltTemp[get(make.names(feature1))=="June",],
                        df.meltTemp[get(make.names(feature1))=="July",],
                        df.meltTemp[get(make.names(feature1))=="August",],
                        df.meltTemp[get(make.names(feature1))=="September",],
                        df.meltTemp[get(make.names(feature1))=="October",],
                        df.meltTemp[get(make.names(feature1))=="November",],
                        df.meltTemp[get(make.names(feature1))=="December",])
  }
  
  
  
  p3 <- nPlot(as.formula(paste("PCT ~ ",make.names(feature1))), group = segment, data =  df.meltTemp, type = 'multiBarChart')
  
  #print(p3)

  p3$chart(margin = list(left = 80))
  p3$yAxis(axisLabel = "PCT", width = 70)
  p3$chart(margin = list(right = 80))
  p3$chart(margin = list(bottom = 150))
  p3$chart(margin = list(top = 80))
  p3$xAxis(
    #       tickFormat =   "#!
    #       function(d) {return d;}
    #       !#",
    rotateLabels = -30
  )
  p3$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")   
  p3$chart(reduceXTicks = FALSE)
  return (p3)
}


#=======================================================
# Bar chart of revenue: feature 1: revenue
#=======================================================
GeneratBarPlot<-function(dtData,feature1,segment){
  dtDataSubset<-subset(dtData,select=c(feature1,segment))
  names(dtDataSubset)=c("value","ID")
  dtDataSubset=dtDataSubset[, lapply(.SD, sum), by = ID]
  totalValue = sum(dtDataSubset$value)
  dtDataSubset[,value:=value/totalValue]
  setnames(dtDataSubset,"value","PCT")
  setnames(dtDataSubset,"ID",segment)

  plot  <-  nPlot(x = segment, y = "PCT", data = subset(dtDataSubset,select=c(segment,'PCT'))[order(-PCT)],
                    type = "discreteBarChart")
  plot$chart(margin = list(bottom = 200))
  plot$chart(margin = list(left = 200))
  #http://stackoverflow.com/questions/24344794/rcharts-nplot-formating-x-axis-with-dates
  plot$xAxis(
    tickFormat =   "#!
    function(d) {return d;}
    !#",
    rotateLabels = -30
  )
  plot$yAxis(tickFormat = "#! function(d) {return '%' + d.toFixed(2)} !#")
  return (plot)
  
}

#=================================================================================
#create the Histogram for the numerical features
#========================================================================

#function to draw a histogram of feature1 distribution, it recieves the min and max and step to visualize
histogramDraw<-function(dtData,feature1,ID, MinValueDraw, MaxValueDraw, stepSizeDraw, FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  
  if (!is.null(FileName)){
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram for ",feature1)) +
      labs(x=paste0(feature1), y="Freq.")
    return (plot)
  }
}

#===============================================================================
#function to draw a histogram of feature1 distribution only for segment SegInstance, it recieves the min and max and step to visualize

histogramSegmentDraw<-function(dtData,feature1,segmentVarName, SegInstance, MinValueDraw, MaxValueDraw, stepSizeDraw, ID,FileName=NULL){
  dtDataSubset<-subset(dtData,select=c(feature1,segmentVarName,ID))
  dtDataSubset[,dummy1:=get(feature1)]
  dtDataSubset[,Segments:=get(segmentVarName)]
  dtDataSubset = dtDataSubset[Segments==SegInstance,]
  
  if (!is.null(FileName)){
    plot=ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
    
    ggsave(filename=paste0(FileName, '.png'))  
    return (plot)
  }else{
    plot = ggplot(data=dtDataSubset, aes(as.numeric(dtDataSubset$dummy1))) + 
      geom_histogram( 
        breaks=seq(MinValueDraw, MaxValueDraw, by = stepSizeDraw), 
        col="blue", 
        aes(fill=..count..), 
        alpha = .2) + 
      labs(title=paste0("Histogram of ",feature1, "for ", SegInstance, "Segment")) +
      labs(x=paste0(feature1), y="Freq.")
    return (plot)
  }
}

#=============================================================================
# Shiny portion of the application
#=============================================================================

shinyServer(function(input, output) {
  #============================================
  #selecting an appropriate chart
  #============================================
  
  
  
    #renderPlot
    #renderChart3
    output$plot <-renderChart2({if((input$x =="A Segment") &   (input$y =="Checkout Day of Week")){
	}
	})
	
R shiney app tutorial
==========================

Open source web application framework for R, developed by Rstudio

Easy to turn analytical analysis into stylish, interactive web apps, presentable to a winder audiance


Link to few examples of interactive web apps made using Shiny:

http://shiny.rstuido.com/gallery/
http://www.showmeshiny.com



#============================
.Rmd: R mark down

Shiney: platform for creating interactive R programs embeded into a web page

Web input from calls R and predict algorithm and display results

Using shiny, the time to create simple, yet powerful, web-based interactive data product in R is minimized

- However, it lacks the flexibility of full featured (and more complex) solutions.

required knowledge: html (page structure, sectioning), css (style), js (interactivity)

Shiney: uses bootstrap style (render well on mobile platforms)


Solution possible using client/server programming

OpenCPU: provides an API for calling R from web documents

Context
===================
Novel prediction algorithm to predict risk for developing diabetes.

Patients and caregivers will be able to enter their data and, if needed take preventive measures


Create a website so that users can input the relevant predictors and obtain their prediction


(1) Download and install Rtools

(2) follow:

install.packages("shiny")

library(shiny)

diabetesRisk <- function(glucose) glucose/200

(3) interactive plotting can be conducted by manipulate function in rstudio

(4) rChart is also relevant

Good source: http://rstudio.github.io/shiny/tutorial/

#==========================================================================


Shiny Project
==================
Directory containing two parts:
(1) one named ui.R (user interface) controls how it looks
(2) server.R controls what it does.

ui.R
#============
library(shiny)
shinyUI(pageWithSidebar(
headerPanel("Data science FTW!"),
sidebarPanel(
h3('Sidebar text')
),
mainPanel(
h3('Main Panel text')
)
))

server.r
================
library(shiny)
shinyServer(
function(input, output) {
}
)

To run
=================

In R, change to the directories with these files and type runApp()

The app directory can be sent as an argument

R functions for HTML markup
===========================
ui.R

shinyUI(pageWithSidebar(
headerPanel("Illustrating markup"),
sidebarPanel(
h1('Sidebar panel'),
h1('H1 text'),
h2('H2 Text'),
h3('H3 Text'),
h4('H4 Text')
),
mainPanel(
h3('Main Panel text'),
code('some code'),
p('some ordinary text')
)
))

illustrating inputs ui.R
===========================
shinyUI(pageWithSidebar(
headerPanel("Illustrating inputs"),
sidebarPanel(
numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
checkboxGroupInput("id2", "Checkbox",
c("Value 1" = "1",
"Value 2" = "2",
"Value 3" = "3")),
dateInput("date", "Date:")
),
mainPanel(
)
))

Part of ui.R
==================================
mainPanel(
h3('Illustrating outputs'),
h4('You entered'),
verbatimTextOutput("oid1"),
h4('You entered'),
verbatimTextOutput("oid2"),
h4('You entered'),
verbatimTextOutput("odate")
)

#====================================================
# simple input and output pass example
#====================================================
ui.R
-------
#illustrating inputs ui.R (input)
shinyUI(pageWithSidebar(
  headerPanel("Illustrating inputs"),
  sidebarPanel(
    numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
    checkboxGroupInput("id2", "Checkbox",
                       c("Value 1" = "1",
                         "Value 2" = "2",
                         "Value 3" = "3")),
    dateInput("date", "Date:")
  ),
  #part of ui.R (output)
  mainPanel(
    h3('Illustrating outputs'),
    h4('You entered'),
    verbatimTextOutput("oid1"),
    h4('You entered'),
    verbatimTextOutput("oid2"),
    h4('You entered'),
    verbatimTextOutput("odate")
  )
))


server.R
---------
library(shiny)


#recieving the input
shinyServer(
  function(input, output) {
    output$oid1 <- renderPrint({input$id1})
    output$oid2 <- renderPrint({input$id2})
    output$odate <- renderPrint({input$date})
  }
)

#================================================================
# Define a client and server app that predicts the probability of diabetes given glocose
#=================================================================
server.R
--------------
diabetesRisk <- function(glucose) glucose / 200
shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$glucose})
    output$prediction <- renderPrint({diabetesRisk(input$glucose)})
  }
)

ui.R
---------------
#Building a prediction function

shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Diabetes prediction"),
    sidebarPanel(
      numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction")
    )
  )
)

#===============================================
#Image example
#===============================================
# built an example with an image
# histogram of data
# put slider on so that the user has to guess the mean


server.R
------------
# visualization and guessing mean
library(UsingR)
data(galton)
shinyServer(
  function(input, output) {
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
      mu <- input$mu
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste("mu = ", mu))
      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
  }

ui.R
------------
#image visualization so that user has to guess the mean
shinyUI(pageWithSidebar(
  headerPanel("Example plot"),
  sidebarPanel(
    sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05,)
  ),
  mainPanel(
    plotOutput('newHist')
  )
))

#======================
# Experiment with the shiny ui and server for reactive and non reactive
#============================

server.R
#-----------------
# Experiment code of running
library(shiny)
x <<- x + 1
y <<- 0
shinyServer(
  function(input, output) {
    y <<- y + 1
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({as.numeric(input$text1)+1})
    #reactive
    output$text4 <- renderText(y)
    #not reactive
    output$text5 <- renderText(x)
  }
)


ui.R
---------------
#code of testing refershing run
shinyUI(pageWithSidebar(
  headerPanel("Hello Shiny!"),
  sidebarPanel(
    textInput(inputId="text1", label = "Input Text1"),
    textInput(inputId="text2", label = "Input Text2")
  ),
  mainPanel(
    p('Output text1'),
    textOutput('text1'),
    p('Output text2'),
    textOutput('text2'),
    p('Output text3'),
    textOutput('text3'),
    p('Outside text'),
    textOutput('text4'),
    p('Inside text, but non-reactive'),
    textOutput('text5')
  )
))


# Non-reactive reactivity
#--------------------
(1) Sometimes you don't want shiny to immediately perform reactive calculations from widget inputs
(2) In other words, you want something like a submit button


#only when a button is pushed:
#==============================
Notice it doesn't display output text3 until the go button is pressed
input$goButton (or whatever you named it) gets increased by one for every time pushed
So, when in reactive code (such as render or reactive) you can use conditional statements
like below to only execute code on the first button press or to not execute code until the first or
subsequent button press
if (input$goButton == 1){ Conditional statements }


#not display third text until the go button is pushed
# shinyServer(
#   function(input, output) {
#     output$text1 <- renderText({input$text1})
#     output$text2 <- renderText({input$text2})
#     output$text3 <- renderText({
#       input$goButton
#       isolate(paste(input$text1, input$text2))
#     })
#   }
# )

#not display until the button is pushed (any time a button is pressed the counter increases)
shinyServer(
  function(input, output) {
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({
      if (input$goButton == 0) "You have not pressed the button"
      else if (input$goButton == 1) "you pressed it once"
      else "OK quit pressing it"
    })
  }
)

#=====================
# More style
#======================
The sidebar layout with a main panel is the easiest.
Using shinyUI(fluidpage( is much more flexible and allows tighter access to the bootstrap
styles
Examples here (http://shiny.rstudio.com/articles/layout-guide.html)
fluidRow statements create rows and then the column function from within it can create
columns
Tabsets, navlists and navbars can be created for more complex apps

More complex layout, direct use of html:
http://shiny.rstudio.com/articles/htmlui.html
Have an index.html page in that directory
Your named input variables will be passed to server.R <input type="number" name="n"
value="500" min="1" max="1000" />
Your server.R output will have class definitions of the form shiny- <pre id="summary"
class="shiny-text-output"></pre>


#==========================
# Debugging techniques for Shiny
#==========================

We saw that runApp(displayMode = 'showcase') highlights execution while a shiny app
runs
Using cat in your code displays output to stdout (so R console)
The browser() function can interupt execution and can be called conditionally
(http://shiny.rstudio.com/articles/debugging.html)


#==========================
# Tighter control over style
#==========================
(1) all the style elements are handled through ui.R

Instead, it is possible to create www directory and then an index.html file in that directory

have specific js libraries and appropriately name ids and classes

Other things Shiny can do
---------------------------
(1) Allow users to upload or download files
(2) Have tabbed main panels
(3) Have editable data tables
(4) Have a dynamic UI
(5) User defined inputs and outputs
(6) Put a submit button so that Shiny only executes complex code after user hits it


#================================
# Distributing a Shiny app
#================================

Option 1:
--------------
put on github or gist or dropbox 

send the app directory to the person and they can run runApp("path")

Can create Rpackage and a wrapper that calls runApp (only if user knows R)

Option 2:
---------------
run a shiny server

sett up a shiny server (www.rstudio.com/shiny/server/)

Use one of the virtual machines where they already have Shiny server running well (e.g. AWS)

Set up Shiny server (linux server administration)

Shiny hostings

Don't put system calls in the code (introduces security concerns)


#Best way to use Shiny: reuse the following codes
#=========================
http://shiny.rstuido.com/gallery/
http://www.showmeshiny.com


#==========================
# input types
#===========================
# slide bar
# check box
# text box (textInput)
# submit button
# Numeric input (up and down arrow)

#separation by: comma
------------
main structure of ui by shinyUI(...)

#Also in presentation 
# markup for code: code('something...')
# h1...h4()
# p('something to write ..')
headerPanel("something here")

#panels
--------
#sidebarPanel
#mainPanel

#output
------
# text(...)
#verbatimTextOutput("nameofVar")

#plot related
-------------
#renderPlot ({...})

Refreshable code
#-----------------------
shinyServer(function(input, output){..})
run repeatedly as needed, when new values entered "rendered"

Recieving reactive error
#========================
include the item that is recieved from input into reactive(.) function

names(tmp) = c('Date','Revenue','Country')
tmp$Date = as.numeric(tmp$Date)
tmp$Revenue = as.numeric(tmp$Revenue)

ggplot(tmp, aes(Date,Revenue,group=Country,col=Country)) + 
  geom_rect(data=tmp, aes(xmin=183, xmax=203, ymin=min(tmp$Revenue), ymax=max(tmp$Revenue)), 
            fill='gray80', alpha=0.1) +
  geom_rect(data=tmp, aes(xmin=213, xmax=224, ymin=min(tmp$Revenue), ymax=max(tmp$Revenue)), 
            fill='gray80', alpha=0.1) +
  geom_rect(data=tmp, aes(xmin=251, xmax=273, ymin=min(tmp$Revenue), ymax=max(tmp$Revenue)), 
            fill='gray80', alpha=0.1) +
  geom_rect(data=tmp, aes(xmin=293, xmax=307, ymin=min(tmp$Revenue), ymax=max(tmp$Revenue)), 
            fill='gray80', alpha=0.1) +
  geom_point() + geom_smooth(span = 0.6)+
  theme_set(theme_gray(base_size = 18))+
  labs(title = paste0(plotName))+ ylab(plotName)+xlab("days from 2015/11/30") 

rm(list = ls())

fitPPl = lm(usNPl~caNPl, data =uscaAdDT[50:183,])
summary(fitPPl)




 