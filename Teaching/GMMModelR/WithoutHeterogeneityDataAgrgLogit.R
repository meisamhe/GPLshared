#modified code only high price regret and stock out regret, with modified
# specification of the stock out regret
#clear workspace
rm(list = ls());
Rprof("AggregLogitNoHeterogen.out")

J  = 10000;
T  =  3;
P1          =   sample(1:20, J, replace=T);  #generate random integer number
discount    =   runif(J, 0, 1); #generate uniform random number
P2          =   ceiling(P1*discount);
lambda      =   runif(J, 0, 1); #availability
xi          =   matrix(rnorm(20), J,2);

# alpha = 2;
# c     = 0.5; 
# bp    = -0.2;
alpha   = 2*runif(1,0,1);
c       = runif(1,0,1);
bp      = runif(1,0,1);

gamma =.975; #discount factor

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

shares_n=matrix(t(shares),nrow=J*2); #stack shares on top of eachother
outside_n=matrix(t(outside),nrow=J*2); #stack outside share

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

X = t(cbind(X1,X2));
#Xn=matrix(X,ncol=J*2,nrow=5);
Xn= matrix(X,ncol=J*2, nrow=p);
Xn=t(Xn); #stack X's
Yn=log(shares_n/outside_n);

#OLS
betas=solve(t(Xn)%*%Xn)%*%t(Xn)%*%Yn;
errors=Yn-Xn%*%betas;
vcm=as.vector(t(errors)%*%errors)*solve(t(Xn)%*%Xn)/(2*J);
se_est=sqrt(diag(vcm));

#params=[alpha c bp alphap betar];

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

# for fixed effects
cat('Fixed Effects are: \n');
cat(betas[1,1:(p-4)], '\n');
cat(se_est[1,1:(p-4)],'\n');
cat(betas[1,1:(p-4)]/se_est[1,1:(p-4)],'\n');
