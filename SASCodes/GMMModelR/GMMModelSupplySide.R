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

#second optimization method
library(numDeriv)
out <- nlminb(init_p, MeisamGMMfunc)
print(out);
param=out$par;
hess1<- hessian(func=MeisamGMMfunc, x=out$par)

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

#Fourth optimization Method: Genetic Algorithm
library(rgenoud)
out <- genoud(MeisamGMMfunc,  nvars=7,max=FALSE) #didn't work

library(DEoptim)
lower <- c(-10,-10)
upper <- -lower

## run DEoptim and set a seed first for replicability
#set.seed(1234)
DEoptim(MeisamGMMfunc, lower, upper)

param = out$par;
hess1= out$hessian;
fval = out$value;


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