% modified code high price regret and stock out regret, with modified
% specification of the stock out regret data
clear all
global P1 P2 Dur1 Dur2 lambda gamma shares km cost %outside_n
global vcm se_est betas variance
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\BehavioralPricing\Data\cleaned10232013.xlsx',1);
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

% For 3rd Experiment: test for cut off of second period
% P3=num(:,13); % price of second period using sum of revenue and sales
% P4=num(:,16); % price average of second period cut off
% Dur3=num(:,14); % duration of second period ended in cut off of second markdown
% S3=num(:,15); % sales of second period of markdown cut off of second markdown
% S2=S3;
% P2=P4;
%Dur2=Dur3;

% First Experiment: test for average of second period availability, and normalized S2
lambda  = Av2;
% For Second Experiment: use normalize availability 
%lambda      =   Av2./Av1; %availability
%lambda  = Av3; % availability at the beggining of second period

% Normalize sales of second period to account for those who could not find
% the product to purchase
% cf=1.25;
% MKTSz = MKTSz - (cf*S2); 
% S2 = S2./lambda;
% MKTSz = MKTSz + (cf*S2);
%MKTSz = MKTSz./1.25*2;

%inflate MKTSz with the availability as well
MKTSz=MKTSz./lambda;
S2 = S2./lambda;

% change market size according to new reasoning
% MKTSz = 9*MKTSz;
%S2 = S2./(Av2./Av1);

%change according to what Dr. Gonca Suggests
% Sh1 = S1./MKTSz;
% Sh2= (1-Sh1).*(1-S2./(MKTSz-S1));
% Sh3 = 1-Sh1 - Sh2;
% shares = [Sh1 Sh2];
% outside = repmat(Sh3,[1 2]);

%discount factor when Dur1=1 then it will show weekly discount factor of gamma =.975;
gamma=1./(1+.0025).^Dur1;
% create shares
shares=[S1./MKTSz S2./MKTSz];
outside=repmat(ones(J,1) - sum(shares,2),[1 2]);

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

% model with heterogeneity without fixed effect on the data
%use fminunc
% parameters to estimate are: [alpha c bp alphap betar] where alpha is not
% fixed effect here, but an intercept
%alpha_e c_e bp_e alphap_e betar_e*c
% parameters of heterogeneity [pi1 bp alphap betar*c] difference with main
% disp('main parameters for [pi1 bp alphap betar] are:')
% [pi1 bpd alphapd betard*c]
% pause
km   =    0.001;
shares=max(shares,0.00000001);   %As a precaution
tic
% test for various starting values
%X0 =  [0.5 0.2 0.3 0.4];
%X0 = [0.1 0.1 0.1 01];
%X0= [0.5 0.5 0.5 0.5];
%X0= [0.5 0.5 0.5 0.8];
%X0= [0 0 0 0];
%X0= [0.8 0.8 1 -0.8];
%[log(pi1/(1-pi1)) log(-bpd) log(-alphapd) log(-betard*c)];
%X0 = [2.3880   -0.1386   -0.5500   -2.4760]; % optimal for the case of ownership utility heterogeneity only (genetic algorithm)
%X0 =  [3.2923   -0.4210    2.4097   -2.3335]; % optimal for the case of both  heterogeneity  (genetic algorithm)
% disp('Still at the right point betas is (a, c, bp, alphap, tt1):');
% RegretBLPLikelihood(X0) % test coeffients at optimum point (betas)
X0 =  [ 1.4435    0.0075    5.2799    0.2429]; % optimal for inflated market share and second period share

options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
% heterogeneity by cost
[x,fval,exitflag,output,grad,hessian]=fminunc('RegretBLPLikelihood',X0,options);

disp('estimation time is:');
disp(num2str(toc./6));
%params=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
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
disp('estimation and t-stat for parameters (c,bp,alphap,betar) is:');
disp([betas(1,p-3:p-1) betar_e;betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE]);
display('estimation and t-state for parameter of ownership utility(a) is:');
disp([beta(1,p-4);beta(1,p-4)./se_est(1,p-4)]);

% calculate nonheterogeneous parameters
ste = diag(inv(hessian));
ste = sqrt(ste);
trat = [exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3)]./ste(1:3,1)';
tth1_e=-x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
%ParamCovar =vcm([2 5],[2 5])*J;
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity (pi,bp,alphap,betar) are:');
disp([exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e;trat(1,1:3) betarh_e./betarSTEh])
%disp('log likelihood value is:');
%disp(fval);

LL=-fval;

AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);


%genetic algorithm optimization
gaoptions = gaoptimset('Display','iter');
gaoptions = gaoptimset(gaoptions,'UseParallel','always');
FitnessFunction = @RegretBLPLikelihood;
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables,gaoptions);
[x,fval] = ga(FitnessFunction,numberOfVariables);

