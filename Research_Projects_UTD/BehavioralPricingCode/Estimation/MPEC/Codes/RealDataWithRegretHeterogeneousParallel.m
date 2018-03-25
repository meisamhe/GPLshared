% identification for with regret and heterogeneous case

matlabpool close force local
matlabpool close;
matlabpool open;



%===================================================================
%=====================================================================

clear all; 
%global P1 P2 Dur1 Dur2 lambda gamma shares km cost  %outside_n
global vcm se_est betas 
%global YnNLSQ
%global pi1r bpdr alphapdr betardr cr
global deltatemp
global variance
global process % number of processors to prallelize contraction mapping [set to 3 for now]

[num,txt,raw] = xlsread('H:\RegretPrj\cleaned10232013.xlsx',1);
[J,p]   =   size(num);
Dur1=num(:,2); % duration of first period (in weeks)
Dur2=num(:,3); % duration of second period (in weeks)
P1=num(:,4); % average of price of second period
P2=num(:,5); %recover main price ended in 8
Av1=num(:,6); % availability in first period average
Av2=num(:,7); % availability in the second period average 
Av3=num(:,12); % availability right at the beginning of second period
S1=num(:,8); % sales in the first period
S2=num(:,9); % sales of second period
MKTSz=num(:,10); % total market size (inventory * 1.25)
cost = num(:,11); % unit cost of an item
T  =  3;

% First Experiment: test for average of second period availability, and normalized S2
lambda  = Av2;

%inflate MKTSz with the availability as well [No inflation for now]
%MKTSz=MKTSz./lambda;
%S2 = S2./lambda;

% contraction mapping facilitator
deltatemp = zeros(J,T-1);


% heterogeneity
km   =    1e-13;


%discount factor when Dur1=1 then it will show weekly discount factor of gamma =.975;
gamma=1./(1+.0025).^Dur1;
% create shares
shares=[S1./MKTSz S2./MKTSz];
outside=repmat(ones(J,1) - sum(shares,2),[1 2]);


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
lambda = lambda((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
gamma = gamma((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];
% X1 = X1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
% X2 = X2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
shares  = sharestemp;
outside = outsidetemp;

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share
shares_n=max(shares_n,1e-50);   %As a precaution
outside_n=max(outside_n,1e-50);   %As a precaution

%Check Quality of Data simulated: test how share are separated
% sum(uij1s2>uij2s2)
% sum(uij1s1>uij2s1)
% check parameter difference 
%disp([pi bpd alphapd betard])
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

%params1=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
%params2=[alpha c bp(1,2) alphap(1,2) betar(1,2)];

disp('real parameter and estimate is for the first segment:')
disp([betas'])
disp('real parameter and estimate is for the second segment:')
disp([betas'])
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
disp([betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is for the second segment:');
disp([betas(1,1:p-1) betar_e]);
variance1                 =    sum(errors.^2);
LL= - 0.5*2*J*log(2*pi*variance1) -   0.5*sum(errors.^2/variance1);
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);


% estimating BLP
shares=max(shares,1e-150);
tic;
%X0= [0.1 0.1 0.1 0.1];
X0 = [  1.530291034046909 -21.484713882079134  -0.500000000000000   -6.818972394649697]; % GA found point
%X0 = [0.1779/(1-0.1779)     -1.6049   0.1975    -59.1189]
%X0=[log(pi1/(1-pi1))+0.01 bpd+0.01 alphapd+0.01 betard*c+0.01];
%X0=[log(pi1/(1-pi1)) bpd alphapd betard*c]; %starting from correct point
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncDatanBLPWithRegEffcntParallel',X0,options,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost);
toc;
%x = [0.1779/(1-0.1779)     -1.6049   0.1975    -59.1189]; % optimum found
%x=[ 1.530291034046909 -21.484713882079134  -0.500000000000000   -6.818972394649697];
FuncDatanBLPWithRegEffcntParallel(x,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost) % put in order to find real value of betas
%[x,fval,exitflag,output,grad,hessian]=fminunc('FuncIdentificationLikelihood',X0,options);
disp('estimation time is:');
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
disp([betas(1,1:p-1) betar_e]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the second segment):');
disp([betas(1,1:p-1) betar_e]);
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
disp([exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);

%genetic algorithm to show identification
FitnessFunction = {@FuncDatanBLPWithRegEffcntParallel,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost};
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables)
[exp(x(1))/(1+exp(x(1))) x(2) x(3) x(4)]
%x =    -1.5241    1.6049   -0.1975    4.3871
% fval =  -300.1371
% calculating hessian:
f = @(x)FuncDatanBLPWithRegEffcntParallel(x,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost);
[hess,err] = hessian(f,[-1.5241    1.6049   -0.1975    4.3871])

% hess =
% 
%    1.0e+04 *
% 
%     1.1426   -0.0000    0.0000   -0.0000
%    -0.0000    0.0000       NaN    0.0000
%     0.0000       NaN    0.0000    0.0000
%    -0.0000    0.0000    0.0000    0.0000
% 
% 
% err =
% 
%    1.0e-03 *
% 
%     0.3029    0.0003    0.0000    0.0004
%     0.0003    0.0001       NaN    0.0000
%     0.0000       NaN    0.0000    0.0000
%     0.0004    0.0000    0.0000    0.0000

% hess(2,3) = 0;
% hess(3,2) = 0;
hessian =hess;
x =    [-1.5241    1.6049   -0.1975    4.3871];
FuncDatanBLPWithRegEffcntParallel(x,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost)
fval =  -300.1371;
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
disp([betas(1,1:p-1) betar_e]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the second segment):');
disp([betas(1,1:p-1) betar_e]);
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
disp([exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);



%Likelihood at the point
X0=[log(pi1/(1-pi1)) bpd+0.1 alphapd betard*c]; %starting from correct point
FuncIdentificationBLPWithRegEffcnt(X0);

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