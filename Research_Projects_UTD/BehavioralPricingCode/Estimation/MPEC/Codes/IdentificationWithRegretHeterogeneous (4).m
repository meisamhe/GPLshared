% identification for with regret and heterogeneous case
clear all; 


%==================================Define Variables, and  simulate========================
global P1 P2 Dur1 Dur2 availlambda gamma shares km cost   %outside_n
global vcm se_est betas 
global YnNLSQ
global pi1r bpdr alphapdr betardr cr
global deltatemp

J  = 10000;
T  =  3;

% contraction mapping facilitator
deltatemp = zeros(J,T-1);

%variables
P1          =   ceil(30*rand(J,1));
discount    =   0.5.*rand(J,1);
P2          =   ceil(P1.*discount);
availlambda      =   rand(J,1); %availability
Dur1        =   4+ceil(3*rand(J,1));
Dur2        =   10+abs(ceil(20*rand(J,1)) - Dur1);
%simulating cost
cost = ceil(5*rand(J,1));

xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 3*rand(1,1);
c     = 3*rand(1,1);


%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% heterogeneity
km   =    1e-10;

pi1    = 0.01;%0.999;%0.8; %0.001;%0.0000000001;%;%0.99999;%rand(1,1); %size of first segment
bp(1,1)    = -3*rand(1,1);
bpd   = -4*rand(1,1);
bp(1,2)    = bp(1,1)+ bpd;
% high price regret coefficient
alphap(1,1) = -2*rand(1,1);
alphapd = -6.2*rand(1,1);
alphap(1,2) = alphap(1,1)+ alphapd;
% stock out regret coefficient
betar(1,1) = -1.5*rand(1,1);
betard = -3*rand(1,1);
betar(1,2) = betar(1,1)+ betard;

% keep real parameters
pi1r =pi1;
bpdr = bpd;
alphapdr = alphapd;
betardr = betard; 
cr =c;

tth1d = c*betard;

%parameters to summarize and be efficient
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  availlambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*availlambda.*cost gamma.*availlambda.*Dur2.*0.5 gamma.*availlambda.*P2 zeros(J,1) gamma.*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)];

% define parameters to simplify calculation of likelihood
betaparam1 = [alpha; c; bp(1,1);alphap(1,1);betar(1,1)*c];
betaparam2 = [0; 0; bpd;alphapd;tth1d];

% ====================================================Create Data According to DGP=================================================
% calculate utility
% first segment
delta1 = X1*betaparam1 + xi(:,1);
delta2 = X2*betaparam1 + xi(:,2);
uij1s1 = delta1;
uij2s1 = delta2;
uij1s2 = delta1 + X1*betaparam2; 
uij2s2 = delta2 + X2*betaparam2; 

%uij1s1 =      alpha.*cost+(0.5*Dur1+gamma.*Dur2).*c+bp(1,1)*P1+ alphap(1,1).*availlambda.*(P1-P2)+ xi(:,1);
% uij2s1 =      gamma.*(availlambda.*(alpha.*cost+0.5*c.*Dur2+bp(1,1)*P2)+ betar(1,1)*(ones(J,1)-availlambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
% uij1s2 =      alpha.*cost+(0.5*Dur1+gamma.*Dur2).*c+bp(1,2)*P1+ alphap(1,2).*availlambda.*(P1-P2)+ xi(:,1);
% uij2s2 =      gamma.*(availlambda.*(alpha.*cost+0.5*c.*Dur2+bp(1,2)*P2)+ betar(1,2)*(ones(J,1)-availlambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
% uij1s2 =     uij1s1+bpd*P1 + alphapd.*availlambda.*(P1-P2);    
% uij2s2 =     uij2s1+gamma.*(availlambda.*(bpd*P2)+ tth1d*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)); 

e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
loge1=[uij1s1 uij1s2]; loge2=[uij2s1 uij2s2];
shares=[exp(loge1-log(1+e1+e2))*[pi1;1-pi1] exp(loge2-log(1+e1+e2))*[pi1;1-pi1]];
outside=[1./(1+e1+e2)*[pi1;1-pi1] 1./(1+e1+e2)*[pi1;1-pi1]];

%===============================================Data preparation limit the size of the data=================================

% test how many shares are lower than 0.0001 remove couple to avoid problem
% size(shares(shares(:,2)>0.0004,2))
% size(shares(shares(:,1)>0.0004,1))
% size(outside(outside(:,2)>0.0004,2))
% size(outside(outside(:,1)>0.0004,1))
% size((shares(:,2)>0.0001))
% size((shares(:,1)>0.0001) )
% size((outside(:,2)>0.0001))
sharestemp =shares((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
J = size(sharestemp,1);
outsidetemp = outside((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
%beta=[alpha c bp];
p = 5;
cost = cost((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
Dur1 = Dur1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
Dur2 = Dur2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P1   = P1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P2 = P2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
availlambda = availlambda((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
gamma = gamma((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  availlambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*availlambda.*cost gamma.*availlambda.*Dur2.*0.5 gamma.*availlambda.*P2 zeros(J,1) gamma.*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)];
% X1 = X1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
% X2 = X2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
% corresponding error term
xi=  xi((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
delta1 = delta1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
delta2 = delta2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);


shares  = sharestemp;
outside = outsidetemp;


% only keep 105 to make sure to preserve the size
J=150;
shares = shares(1:J,:);
outside = outside(1:J,:);
cost = cost(1:J,:);
Dur1 = Dur1(1:J,:);
Dur2 = Dur2(1:J,:);
P1   = P1(1:J,:);
P2 = P2(1:J,:);
availlambda = availlambda(1:J,:);
gamma = gamma(1:J,:);
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  availlambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*availlambda.*cost gamma.*availlambda.*Dur2.*0.5 gamma.*availlambda.*P2 zeros(J,1) gamma.*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)];
delta1 = delta1(1:J,:);
delta2 = delta2(1:J,:);

% corresponding error term
xi=  xi(1:J,:);

% rebuild delta
deltareal= [delta1 delta2];

delta =deltareal(:)';
X0=[pi1 bpd alphapd tth1d delta]; %starting from correct point
shareconstraint(X0)

%=========================================Prepare data and run OLS========================

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share
shares_n=max(shares_n,1e-50);   %As a precaution
outside_n=max(outside_n,1e-50);   %As a precaution

%Check Quality of Data simulated: test how share are separated
% sum(uij1s2>uij2s2)
% sum(uij1s1>uij2s1)
% check parameter difference 
disp([pi bpd alphapd betard])
size(shares)
% size(outside)


% filter X to only those selected


X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);


%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));

params1=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
params2=[alpha c bp(1,2) alphap(1,2) betar(1,2)];

disp('real parameter and estimate is for the first segment:')
disp([params1;betas'])
disp('real parameter and estimate is for the second segment:')
disp([params2;betas'])
disp('t-stat is:')
disp([betas'./se_est'])
se_est';

betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*(2*J);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Result of simple regression for alpha, c, bp, alphap, betar is for the first segment:');
disp([params1;betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is for the second segment:');
disp([params2;betas(1,1:p-1) betar_e]);
J


%==================================MPEC EStimation of the static model on the simulation data===========================================================
%check real likelihood
%delta = zeros(1,2*J);
%start with real parameter
delta =deltareal(:)';
X0=[pi1 bpd alphapd betard*c delta]; %starting from correct point
%X0 = xresultGA;
FuncMPECIdentificationBLPWithReg(X0) %  -1.8741e+03


% create starting values for delta and optimization function
clc

%constraint on probability only for now
lb = [0,-Inf(1,2*J+3)];
ub = [1,Inf(1,2*J+3)];

%setting options
options  =  optimset('fmincon');
options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-35,'TolFun',1e-25,'TolX',1e-35);
options = optimset(options,'MaxFunEvals',1e15,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxIter',1e15); %This keeps the previous options

%[xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0*0.1,[],[],[],[],lb,ub,'shareconstraint',options)
%X0 = xnew;
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon('FuncMPECIdentificationBLPWithReg',X0,[],[],[],[],lb,ub,'shareconstraint',options);
hessian = MPECHessian(x);
disp('estimation time is:');
toc;
p       =  5;
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*2*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Estimation of First Segment alpha, c, bp, alphap, betar is (for the first segment):');
disp([params1;betas(1,1:p-1) betar_e]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the second segment):');
disp([params2;betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
% nonlinear parameters
ste = diag(-inv(hessian));
ste = sqrt(ste);
trat = x(1,1:3)./ste(1:3,1)';
tth1_e=x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity param of second segment (pi,bp,alphap,betar) are:');
disp([pi1 bpd alphapd betard; x(1,1:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])
disp('full parameter for second segment for (pi1 a c bp alphap betar) are:');
disp([pi1 alpha c bp(1,2) alphap(1,2) betar(1,2)])
disp('t-stat for the heterogeneity parameter is:');
disp([x(1,1) betas(1,1:2) betas(1,3:4)-x(1,2:3) betar_e+betarh_e])
%disp('full parameter for second segment for (pi1 a c bp) are:');
%disp([pi1 alpha c bp(1,2);exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3)-x(1,2)])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);
%check likelihood
disp('the likelihood for the real original point')
-FuncMPECIdentificationBLPWithReg(X0)


%%----------------------------------------------------------
%==========================Calculate Numerica Hessian at the point of interest===================================================
km= 1e-15;
FuncIdentificationBLPWithRegEffcnt(X0)
f = @(x0)FuncIdentificationBLPWithRegEffcnt(x0);
point =X0(1:4);
hessian(f,point)


%%--------------------------------------------------------





x=xresultGA
%test constraint
disp('constraint satisfaction for the found point:')
shareconstraint(x)
disp('constraint satisfaction for real original point:')
shareconstraint(X0)


%=========================================GA Algorithm for MPEC========================

% genetic algorithm for constraint optimization
% ConstraintFunction = @shareconstraint;
% ObjectiveFunction = @FuncMPECIdentificationBLPWithReg;
% nvars = size(X0,2);    % Number of variables
% [x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],lb,ub,ConstraintFunction);

% run GA:
%constraint on probability only for now
delta =deltareal(:)';
lb = [0,-Inf(1,2*J+3)];
ub = [1,Inf(1,2*J+3)];
X0=[pi1 bpd alphapd betard*c delta]; %starting from correct point
ObjectiveFunction = @FuncMPECIdentificationBLPWithReg;
nvars = size(X0,2);    % Number of variables
LB = lb';   % Lower bound
UB = ub';  % Upper bound
ConstraintFunction = @shareconstraint;
[x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ...
    ConstraintFunction)

xresultGA = x;
shareconstraint(xresultGA)


%============================================BLP========================================

% estimating BLP
shares=max(shares,1e-50);
tic;
%X0= [0.1 0.1 0.1 0.1];
%X0 = [0.3397   -0.1835    3.9435    1.6116]; % GA found point
%X0=[log(pi1/(1-pi1))+0.01 bpd+0.01 alphapd+0.01 betard*c+0.01];
X0=[log(pi1/(1-pi1)) bpd alphapd betard*c]; %starting from correct point
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncIdentificationBLPWithRegEffcnt',X0,options);
%[x,fval,exitflag,output,grad,hessian]=fminunc('FuncIdentificationLikelihood',X0,options);
disp('estimation time is:');
toc;
p       =  5;
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*2*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the first segment):');
disp([params1;betas(1,1:p-1) betar_e]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the second segment):');
disp([params2;betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
% nonlinear parameters
ste = diag(inv(hessian));
ste = sqrt(ste);
trat = [exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3)]./ste(1:3,1)';
tth1_e=x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity (pi,bp,alphap,betar) are:');
disp([pi1 bpd alphapd betard;exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])
disp('full parameter for second segment for (pi1 a c bp alphap betar) are:');
disp([pi1 alpha c bp(1,2) alphap(1,2) betar(1,2)])
disp('t-stat for the heterogeneity parameter is:');
disp([exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3:4)-x(1,2:3) betar_e+betarh_e])
%disp('full parameter for second segment for (pi1 a c bp) are:');
%disp([pi1 alpha c bp(1,2);exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3)-x(1,2)])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);

%===========================================Genetic Algorithm BLP=================================

%genetic algorithm to show identification
FitnessFunction = @FuncIdentificationBLPWithRegEffcnt;
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables);
[exp(x(1))/(1+exp(x(1))) x(2) x(3) x(4)]

%Likelihood at the point
X0=[log(pi1/(1-pi1)) bpd+0.1 alphapd betard*c]; %starting from correct point
FuncIdentificationBLPWithRegEffcnt(X0);


%===================================Non Linear case just test===========================
% test nonlinear least square to find a, c, bp, alpap, betar
tic;
YnNLSQ = log(shares)- log(outside);
X0= params1;
[x,resnorm] = lsqnonlin(@NonlinearLeastSquare,X0);
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('NonlinearLeastSquare',X0,options);
disp('estimation time is:');
toc;
params1=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
%genetic algorithm to show identification
YnNLSQ = log(shares)- log(outside);
FitnessFunction = @NonlinearLeastSquare;
numberOfVariables = 5;
[x,fval] = ga(FitnessFunction,numberOfVariables);