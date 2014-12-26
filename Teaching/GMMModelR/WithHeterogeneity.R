rm(list = ls());

# model with heterogeneity without fixed effect on the data
#use Gradient Methods, Genetic Algorithim, and ...
# parameters to estimate are: [alpha c bp alphap betar] where alpha is
# not fixed effect here, but an intercept
# alpha_e c_e bp_e alphap_e betar_e*c

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

# parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x[1])/(1+exp(x[1])); #share of first segment (use transformation to make sure it is between zero and one)
# use transformation to make sure that it is lower
bp       =  x[2]; #price coefficient difference heterogeneity coeff
alphap   =  x[3]; #high price regret difference heterogeneity coeff
betar    =  x[4]; #stock out regret difference heterogeneity coeff
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
    	if (ceiling(i/1000)>80){
    		stop("too many iterations");
    	}
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

X = t(cbind(X1,X2));
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn= shares_n;
#log(shares_n./outside_n);

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

LogDemandShockLikelihood =    - T*J*log(sqrt(2*pi*variance)) -   .5*colSums(errors^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood ;
#cat ('set of (Jacobian, likelihood, Log demand shock Likelihood) is:\n');
#cat (cbind(LogJacobian,likelihood,LogDemandShockLikelihood),'\n');
#readline()
return(y);
}


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

# test for cut off of second period
# P3=num[,13];
# P4=num[,16];
# Dur3=num[,14];
# S3=num[,15];
# S2=S3;
# P2=P4;
#Dur2=Dur3;

# test for average of second period availability, and normalized S2
lambda  = Av2;
# use normalize availability
#lambda      =   Av2/Av1; #availability
#lambda  = Av3; # availability at the beggining of second period

# test for normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2/lambda;
MKTSz = MKTSz + (cf*S2); 

# tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711

#gamma =.975; #discount factor
gamma=1/(1+.0025)^Dur1;
# create shares
shares=cbind(S1/MKTSz,S2/MKTSz);
outside=matrix(rep(rep(1,J)-rowSums(shares),each=2), ncol=2, byrow=TRUE);
shares_n=matrix(shares,nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share

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

#second optimization method
library(numDeriv)
out <- nlminb(X0, FuncWithHetroWithRegrtRD)
print(out);
x=out$par;
hessian <- hessian(func=FuncWithHetroWithRegrtRD, x=out$par)

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

library(DEoptim)
lower <- c(-10,-10)
upper <- -lower

## run DEoptim and set a seed first for replicability
#set.seed(1234)
#DEoptim(FuncWithHetroWithRegrtRD, lower, upper)

x = out$par;
hessian = out$hessian;
fval = out$value;
#[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDCH',X0,options);
cat('estimation time is:\n');
Rprof(NULL);
#params=cbind(alpha,c,bp(1,1),alpha(1,1),betar(1,1));

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

# parameters of heterogeneity [pi betap alphap betar]
ste = diag(solve(hessian));
ste = sqrt(ste);
trat = cbind(exp(x[1])/(1+exp(x[1])),t(x[2:3])/ste[2:3]);
tth1_e=-x[4];
betarh_e =tth1_e/c_e;
STEFOCh=cbind(1/c_e,-tth1_e/(c_e^2));
#ParamCovar =vcm[c(2,5),c(2,5)]*2*J;
ParamCovarh =diag(2)*c(vcm[p-3,p-3],ste[4]^2)*(2*J);
betarSTEh=sqrt(STEFOCh%*%ParamCovarh%*%t(STEFOCh)/(2*J));
cat('parm estimates for heterogeneity (pi,bp,alphap,betar) are:\n');
cat(cbind(exp(x[1])/(1+exp(x[1])),t(x[2:3]), betarh_e),'\n');
cat(cbind(t(ste[1:3]),betarSTEh));
cat(cbind(t(trat[1:3]),betarh_e/betarSTEh));
cat('log likelihood value is:\n');
cat(-fval);
LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
cat('Log Likelihood, AIC, BIC is:\n');
cat(cbind(LL,AIC,BIC),'\n'); 


# regret coefficient
#[betar; betas(1,5)/(alpha+c+gamma*c); betas(1,6)/betas(1,3);betarmean]


#se_est';