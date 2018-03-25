% Estimat simulated model with regret with heterogeneity
% specification of the stock out regret
clear all; 

global P1 P2 Dur1 Dur2 lambda gamma shares km cost %outside_n
global vcm se_est betas variance
global YnNLSQ

J  = 10000;
T  =  3;
%SEED1       = 13532;
%randn('state',SEED1);
%rand('state',SEED1);
P1          =   ceil(30*rand(J,1));
discount    =   rand(J,1);
P2          =   ceil(P1.*discount);
lambda      =   rand(J,1); %availability
Dur1        =   7+ceil(8*rand(J,1));
Dur2        =   10+abs(ceil(20*rand(J,1)) - Dur1);


xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 12*rand(1,1);
c     = 10*rand(1,1);

% heterogeneity
km   =    0.001;

pi1    = 0;%0.99999;%rand(1,1); %size of first segment
bp(1,1)    = -rand(1,1);
bpd   = -.9*rand(1,1);
bp(1,2)    = bp(1,1)+ bpd;
% high price regret coefficient
alphap(1,1) = -1.2*rand(1,1);
alphapd = -1.2*rand(1,1);
alphap(1,2) = alphap(1,1)+ alphapd;
% stock out regret coefficient
betar(1,1) = -0.15*rand(1,1);
betard = -0.05*rand(1,1);
betar(1,2) = betar(1,1)+ betard;

P  = [P1 P2];
Pn = reshape(P',J*2,1);
%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;

%simulating cost
cost = ceil(5*rand(J,1));


% calculate utility
uij1(:,1) =      alpha.*cost+(0.5*Dur1.*c+gamma.*c.*Dur2)+bp(1,1)*P1+ alphap(1,1).*lambda.*(P1-P2)+ xi(:,1);
uij1(:,2) =      alpha.*cost+(0.5*Dur1.*c+gamma.*c.*Dur2)+bp(1,2)*P1+ alphap(1,2).*lambda.*(P1-P2)+ xi(:,1);
uij2(:,1) =      gamma.*(lambda.*(alpha.*cost+0.5*Dur2.*c+bp(1,1)*P2)+ betar(1,1)*(ones(J,1)-lambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
uij2(:,2) =      gamma.*(lambda.*(alpha.*cost+0.5*Dur2.*c+bp(1,2)*P2)+ betar(1,2)*(ones(J,1)-lambda).*(0.5*Dur1.*c+gamma.*c.*Dur2))+ xi(:,2);
e1=exp(uij1); e2=exp(uij2);
shares=[(e1./(1+e1+e2))*[pi1;1-pi1] (e2./(1+e1+e2))*[pi1;1-pi1]];
shares=max(shares,0.00000001);   %As a precaution
outside=[(1./(1+e1+e2))*[pi1;1-pi1] (1./(1+e1+e2))*[pi1;1-pi1]];

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

% running simple OLS...
%beta=[alpha c bp];
X1= [ones(J,1).*cost (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost (0.5*Dur2).*gamma.*lambda gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];
X=[X1 X2]';
Xn=reshape(X,5,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);
%OLS
betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/J;
se_est=sqrt(diag(vcm));
params=[alpha c bp(1,2) alphap(1,2) betar(1,2)]; % for the second segment
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,1);
c_e     =  betas(1,2);
bp_e    =  betas(1,3);
tt1_e   =  betas(1,5);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([1 5],[1 5])*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/J);
disp('Result of simple regression for alpha, c, bp, alphap, betar is:');
disp([params;betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]);
%max(shares-[exp(uij1(:,2))./(1+exp(uij1(:,2))+exp(uij2(:,2))) exp(uij2(:,2))./(1+exp(uij1(:,2))+exp(uij2(:,2)))])

% test nonlinear least square to find a, c, bp, alpap, betar
tic;
YnNLSQ = log(shares)- log(outside);
X0= params;
[x,resnorm] = lsqnonlin(@NonlinearLeastSquare,X0);
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('NonlinearLeastSquare',X0,options);
disp('estimation time is:');
toc;
params=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
%genetic algorithm to show identification
YnNLSQ = log(shares)- log(outside);
FitnessFunction = @NonlinearLeastSquare;
numberOfVariables = 5;
[x,fval] = ga(FitnessFunction,numberOfVariables);


%use fminunc
% parameters to estimate are: [alpha c bp alphap betar] where alpha is not
% fixed effect here, but an intercept
%alpha_e c_e bp_e alphap_e betar_e*c
% parameters of heterogeneity [pi1 bp alphap betar*c] difference with main
% disp('main parameters for [pi1 bp alphap betar] are:')
% [pi1 bpd alphapd betard*c]
% pause
tic
%X0 =  [0.5 0.2 0.3 0.4];
%X0 = [0.1 0.1 0.1 01];
X0= [0 0 0 0];
%X0= [pi1 bp_e a_e tt1_e];
%[log(pi1/(1-pi1)) log(-bpd) log(-alphapd) log(-betard*c)];
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrt',X0,options);
disp('estimation time is:');
disp(num2str(toc./60));
params=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
% no fixed effect simple intercept
p =5;
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,1);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
%ParamCovar =vcm([2 5],[2 5])*J;
ParamCovar =vcm([p-3 p],[p-3 p])*(2*J);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('threshold parameter for contraction mapping is:');
disp(km);
%disp('Seed for random generation is:');
%disp(SEED1);
display('parameters estimation for: a c bp alphap betar are:');
disp([params;betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE])
%[betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]
%[betas(1,p-3:p-1) betar_e;betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE]
% parameters of heterogeneity [pi betap alphap betar]
ste = diag(inv(hessian));
ste = sqrt(ste);
trat = [exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3)]./ste(1:3,1)';
tth1_e=x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
%ParamCovar =vcm([2 5],[2 5])*J;
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity (pi,bp,alphap,betar) are:');
disp([pi1 bpd alphapd betard;exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e;trat(1,1:3) betarh_e./betarSTEh])
disp('full parameter for second segment for (pi1 a c bp alphap betar) are:');
disp([pi1 alpha c bp(1,2) alphap(1,2) betar(1,2);exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3:4)-x(1,2:3) betar_e+betarh_e])
disp('log likelihood value is:');
disp(fval);
%X1= [eye(J,J) (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
%X2= [diag(gamma.*lambda) 0.5*gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

%test likelihood values
X0=[0.0001   -0.5958   -1.1184   -0.0102];
disp(FuncWithHetroWithRegrt(X0));
X0=[log(pi1/(1-pi1)) bpd+0.01 alphapd betard*c];
disp(FuncWithHetroWithRegrt(X0));

%genetic algorithm to show identification
gaoptions = gaoptimset('Display','iter');
gaoptions = gaoptimset(gaoptions,'UseParallel','always');
FitnessFunction = @FuncWithHetroWithRegrt;
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables,gaoptions);
[x,fval] = ga(FitnessFunction,numberOfVariables);