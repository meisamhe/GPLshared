% identification for with regret and heterogeneous case
clear all; 
global P1 P2 Dur1 Dur2 lambda gamma shares km cost  %outside_n
global vcm se_est betas 
global YnNLSQ
global pi1r bpdr alphapdr betardr cr
global deltatemp
global variance


J  = 1000000;
T  =  3;

% contraction mapping facilitator
deltatemp = zeros(J,T-1);

%variables
P1          =   ceil(30*rand(J,1));
discount    =   0.5.*rand(J,1);
P2          =   ceil(P1.*discount);
lambda      =   rand(J,1); %availability
Dur1        =   4+ceil(3*rand(J,1));
Dur2        =   10+abs(ceil(20*rand(J,1)) - Dur1);
%simulating cost
cost = ceil(5*rand(J,1));

xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 3*rand(1,1);
c     = 2*rand(1,1);


%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% heterogeneity
km   =    1e-10;

pi1    = 0.001;%0.999;%0.8; %0.001;%0.0000000001;%;%0.99999;%rand(1,1); %size of first segment
bp(1,1)    = -3*rand(1,1);
bpd   = -2*rand(1,1);
bp(1,2)    = bp(1,1)+ bpd;
% high price regret coefficient
alphap(1,1) = -6.2*rand(1,1);
alphapd = -3.2*rand(1,1);
alphap(1,2) = alphap(1,1)+ alphapd;
% stock out regret coefficient
betar(1,1) = -1.5*rand(1,1);
betard = -1.5*rand(1,1);
betar(1,2) = betar(1,1)+ betard;

% keep real parameters
pi1r =pi1;
bpdr = bpd;
alphapdr = alphapd;
betardr = betard; 
cr =c;


% calculate utility
uij1s1 =      alpha.*cost+(0.5*Dur1+gamma.*Dur2).*c+bp(1,1)*P1+ alphap(1,1).*lambda.*(P1-P2)+ xi(:,1);
uij2s1 =      gamma.*(lambda.*(alpha.*cost+0.5*c.*Dur2+bp(1,1)*P2)+ betar(1,1)*(ones(J,1)-lambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
uij1s2 =      alpha.*cost+(0.5*Dur1+gamma.*Dur2).*c+bp(1,2)*P1+ alphap(1,2).*lambda.*(P1-P2)+ xi(:,1);
uij2s2 =      gamma.*(lambda.*(alpha.*cost+0.5*c.*Dur2+bp(1,2)*P2)+ betar(1,2)*(ones(J,1)-lambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
shares=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
outside=[1./(1+e1+e2)*[pi1;1-pi1] 1./(1+e1+e2)*[pi1;1-pi1]];

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

%genetic algorithm to show identification
FitnessFunction = @FuncIdentificationBLPWithRegEffcnt;
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables);
[exp(x(1))/(1+exp(x(1))) x(2) x(3) x(4)]

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