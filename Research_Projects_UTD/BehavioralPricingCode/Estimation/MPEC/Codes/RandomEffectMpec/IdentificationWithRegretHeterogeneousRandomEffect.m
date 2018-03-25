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
alphai  = 3*rand(J,1);
tti     = 3*randn(J,1);


%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% heterogeneity
km   =    1e-10;

pi1    = 0.99;%0.999;%0.8; %0.001;%0.0000000001;%;%0.99999;%rand(1,1); %size of first segment
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

% coefficients
bp1 = bp(1,1);
bp2 = bp(1,2);
alphap1 = alphap(1,1);
alphap2 = alphap(1,2);
betar1 = betar(1,1);
betar2 = betar(1,2);

% ====================================================Create Data According to DGP=================================================

% utility of first segment in the first period
uij1s1 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1) + alphap1*availlambda.*(P1-P2) + xi(:,1);
uij2s1 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp1*P2)+(1-availlambda).*betar1.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1)))+xi(:,2);
% utility of second segment in the first period
uij1s2 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1) + alphap2*availlambda.*(P1-P2) + xi(:,1);
uij2s2 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp2*P2)+(1-availlambda).*betar2.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1)))+xi(:,2);

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
Dur1 = Dur1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
Dur2 = Dur2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P1   = P1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P2 = P2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
availlambda = availlambda((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
gamma = gamma((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
% corresponding error term
xi=  xi((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);


shares  = sharestemp;
outside = outsidetemp;


% only keep 105 to make sure to preserve the size
J=150;
shares = shares(1:J,:);
outside = outside(1:J,:);
Dur1 = Dur1(1:J,:);
Dur2 = Dur2(1:J,:);
P1   = P1(1:J,:);
P2 = P2(1:J,:);
availlambda = availlambda(1:J,:);
gamma = gamma(1:J,:);
% corresponding error term
xi=  xi(1:J,:);

X0=[pi1 bpd1 bp2 alphap1 alphap2 betar1 betar2 alphai' tti' xi(:)']; %starting from correct point
shareconstraint(X0)
pause

%==================================MPEC EStimation of the static model on the simulation data===========================================================
%check real likelihood
%start with real parameter
X0=[pi1 bpd1 bp2 alphap1 alphap2 betar1 betar2 alphai' tti' xi(:)']; %starting from correct point
%X0 = xresultGA;
FuncMPECIdentificationBLPWithReg(X0) %  -1.8741e+03
pause

% create starting values for delta and optimization function
clc

%constraint on probability only for now
lb = [0,-Inf(1,6),zeros(1,2*J),-Inf(1,2*J)];
ub = [1,Inf(1,2*J+6),Inf(1,2*J)];

%setting options
options  =  optimset('fmincon');
options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-35,'TolFun',1e-25,'TolX',1e-35);
options = optimset(options,'MaxFunEvals',1e15,'GradObj','off','GradConstr','off');
options = optimset(options,'MaxIter',1e15); %This keeps the previous options

%[xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0*0.1,[],[],[],[],lb,ub,'shareconstraint',options)
%X0 = xnew;
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon('FuncMPECIdentificationBLPWithRegRandomEffect',X0,[],[],[],[],lb,ub,'shareconstraintRandomEffect',options);
disp('estimation time is:');
toc;

ste = diag(inv(hessian));
ste = sqrt(ste);
trat = x(1,1:7)./ste(1:7,1)';
% real parameters:
realparam = [pi1 bp1 bp2 alphap1 alphap2 betar1 betar2];

disp('parm estimates for heterogeneity param of second segment (pi,bp,alphap,betar) are:');
disp([realparam; x(1,1:7); trat])
p = 7;

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);
%check likelihood
disp('the likelihood for the real original point')
-FuncMPECIdentificationBLPWithReg(X0)


%%----------------------------------------------------------
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
