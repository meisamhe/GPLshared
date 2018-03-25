% modified code only high price regret and stock out regret, with modified
% specification of the stock out regret
clear all; 
 
J  = 10000;
T  =  3;
P1          =   randi(20,J,1);
discount    =   randi(2,J,1);
P2          =   P1.*discount;
lambda      =   rand(J,1); %availability


xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 2*rand(1,1);
c     = rand(1,1);
bp    = rand(1,1);

gamma =.975; %discount factor

P  = [P1 P2];
Pn = reshape(P',J*2,1);
% high price regret coefficient
alphap = 3*rand(1,1);
% stock out regret coefficient
betar = 5*rand(1,1);
% calculate utility
uij1 =      alpha+(c+gamma*c)+bp*P1+ alphap*lambda.*(P1-P2)+ xi(:,1);
uij2 =      gamma*(lambda.*(alpha+c+bp*P2)+ betar*(ones(J,1)-lambda).*(c+gamma*c))+ xi(:,2);
e1=exp(uij1); e2=exp(uij2);
shares=[e1./(1+e1+e2) e2./(1+e1+e2)];
outside=[1./(1+e1+e2) 1./(1+e1+e2)];

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

%data
clear all
global P1 P2 Dur1 Dur2 lambda gamma shares km cost %outside_n
global vcm se_est betas variance
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\BehavioralPricing\Data\cleaned10232013.xlsx',1);
[J,p]   =   size(num);
Dur1=num(:,2);
Dur2=num(:,3);
P1=num(:,4);
P2=num(:,5);
Av1=num(:,6);
Av2=num(:,7);
Av3=num(:,12);
S1=num(:,8);
S2=num(:,9);
MKTSz=num(:,10);
cost = num(:,11);
T  =  3;

% test for cut off of second period
% P3=num(:,13);
% P4=num(:,16);
% Dur3=num(:,14);
% S3=num(:,15);
% S2=S3;
% P2=P4;
%Dur2=Dur3;

% test for average of second period availability, and normalized S2
lambda  = Av2;
% use normalize availability
%lambda      =   Av2./Av1; %availability
%lambda  = Av3; % availability at the beggining of second period

% test for normalized sales of second period
% MKTSz=MKTSz/1.25;
% cf=1.25;
% MKTSz=MKTSz*cf;
% MKTSz = MKTSz - (cf*S2); 
% S2 = S2./lambda;
% MKTSz = MKTSz + (cf*S2); 

%test with other form of likelihood
% MKTSz=MKTSz*78;
% S2 = S2./lambda;

MKTSz = MKTSz*100;


% tstat=regstats(P1,P1-P2,'linear'), tstat.rsquare=.711 => VIF=.711

%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;
% create shares
shares=[S1./MKTSz S2./MKTSz];
outside=repmat(ones(J,1) - sum(shares,2),[1 2]);
shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

%beta=[alpha c bp];
%Model 1: without regret
 p=3;
 X1= [ones(J,1).*cost (0.5*Dur1+gamma.*Dur2) P1];
 X2= [gamma.*lambda.*cost 0.5*gamma.*lambda.*Dur2 gamma.*lambda.*P2];

%Model 2: not account for length of the period
% X1= [ones(J,1) (1+gamma)*ones(J,1) P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma*lambda gamma*lambda gamma*lambda.*P2 zeros(J,1) gamma*(ones(J,1)-lambda)*(1+gamma)];

% Model 3: no fixed effect
% p=5;
% X1= [ones(J,1) (Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(Dur1+gamma.*Dur2)];

%Model 4: no fixed effect, but heterogeneity with market size and cost
% p=5;
% X1= [ones(J,1)./MKTSz (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda./MKTSz 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

%Model 5: no fixed effect, but heterogeneity with market size and cost (include
%cherry picking and fixed it to negative of regret coefficient)
% p=5;
% X1= [ones(J,1)./MKTSz (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda./MKTSz 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 -gamma.*lambda.*(P1-P2) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

%Model 6: no fixed effect, but heterogeneity only in ownership through MKTSz (include %cherry picking as separate coefficient)
%p=6;
%X1= [zeros(J,1) ones(J,1)./MKTSz (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
%X2= [gamma.*lambda.*(P1-P2) gamma.*lambda./MKTSz 0.5*gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

%Model 7: no fixed effect, but heterogeneity with market size and cost (include
%cherry picking as separate coefficient)
% p=6;
% X1= [zeros(J,1) ones(J,1)./MKTSz (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda.*(P1-P2) gamma.*lambda./MKTSz 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

% Model 8: no fixed effect but capture effect of consumption heterogeneity value with cost
% capture hterogeneity in consumption utility using cost data
%  p=5;
%  X1= [ones(J,1) (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
%  X2= [gamma.*lambda 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

% Model 9: include heterogeneity using cost both in consumption utility and
% ownership utility
% p=5;
% X1= [ones(J,1).*cost (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda.*cost 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

% Model 10: inclusion of heterogeneity using cost only in stock out regret and
% ownership utility
%  p=5;
%  X1= [ones(J,1).*cost (05*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
%  X2= [gamma.*lambda.*cost 05*gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(05*Dur1+gamma.*Dur2)];

% Model 11: fixed effect (duration 0.5 because it is average duration of usage)
% p=J+4;
% X1= [eye(J,J) (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [diag(gamma.*lambda) 0.5*gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

% Model 12: fixed effect with consumption utility heterogeneity inclusion
% p=J+4;
% X1= [eye(J,J) (0.5*Dur1+gamma.*Dur2).*cost P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [diag(gamma.*lambda) 0.5*gamma.*lambda.*Dur2.*cost gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

% Model 13: fixed effect with heterogeneity of consumption in regret, but not in
% consumption utility directly 
% p=J+4;
% X1= [eye(J,J) (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [diag(gamma.*lambda) 0.5*gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*cost];

% Model 14: fixed effect with markdown dummy
% p=J+5;
% X1= [eye(J,J) zeros(J,1) (Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
% X2= [diag(gamma.*lambda) gamma.*lambda gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(Dur1+gamma.*Dur2)];

% Model 15: including cost rather than fixed effect
%  p=6;
%  X1= [ones(J,1) cost (Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
%  X2= [gamma.*lambda gamma.*lambda.*cost gamma.*lambda.*Dur2 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(Dur1+gamma.*Dur2)];

% Model 16: fixed effect, introducing availability in the first period
% p=J+4;
% lambda1=Av1;
% lambda2=Av2;
% X1= [diag(lambda1) lambda1.*(Dur1+gamma.*Dur2) lambda1.*P1 lambda2.*(P1-P2) zeros(J,1)];
% X2= [diag(gamma.*lambda2) gamma.*lambda2.*Dur2 gamma.*lambda2.*P2 zeros(J,1) gamma.*lambda1.*(Dur1+gamma.*Dur2)];

% Model 17: heterogeneity with cost, introducing availability in the first period
% p=6;
% lambda1=Av1;
% lambda2=Av2;
% X1= [lambda1 lambda.*cost lambda1.*(Dur1+gamma.*Dur2) lambda1.*P1 lambda2.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda2 gamma.*lambda2.*cost gamma.*lambda2.*Dur2 gamma.*lambda2.*P2 zeros(J,1) gamma.*lambda1.*(Dur1+gamma.*Dur2)];

% Model 18: no fixed effect, introducing availability in the first period
% p=5;
% lambda1=Av1;
% lambda2=Av2;
% X1= [lambda1  lambda1.*(Dur1+gamma.*Dur2) lambda1.*P1 lambda2.*(P1-P2) zeros(J,1)];
% X2= [gamma.*lambda2 gamma.*lambda2.*Dur2 gamma.*lambda2.*P2 zeros(J,1) gamma.*lambda1.*(Dur1+gamma.*Dur2)];

X=[X1 X2]';
%Xn=reshape(X,5,J*2);
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);

%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));

%params=[alpha c bp alphap betar];

betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,1:p-4)';
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
alphap_e=  betas(1,p-1);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
%ParamCovar =vcm([2 5],[2 5])*J;
ParamCovar =vcm([p-3 p],[p-3 p])*(2*J);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
%[params;betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]
%[betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]
% c bp alphap betar 
variance                 =    mean(errors.^2)*2*J/(2*J-1); 
LL =    - 2*J*log(sqrt(2*pi*variance)) -   .5*sum(errors.^2/variance);
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);
disp('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:');
disp([betas(1,p-3:p-1) betar_e;betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE]);
% intercept, single intercept
disp('intercept is:');
disp([beta(1,p-4);beta(1,p-4)./se_est(1,p-4)])
% intercept and cost coefficient
[beta(1,1:2);beta(1,1:2)./se_est(1,1:2)]
% for fixed effects
[beta(1,1:p-4);beta(1,1:p-4)./se_est(1,1:p-4)]

% for the model without regret
disp('coefficient of ownership utility, consumption utility and price are:')
disp([betas betas./se_est])

% bootstrap
 msim = 1000;
 csim = zeros(msim,4);
 estsim = zeros(msim,4);
 for m = 1:msim;
       e = rand(2*J,1)*(2*J-1);
       e = 1 + floor(e);
       errorb=errors(e,:);
       errorb=errorb-mean(errorb);
       errorb=reshape(errorb',J,2); %stack shares on top of eachother
       uij1str =      a_e+(c_e+gamma*c_e)+bp_e*P1+ alphap_e*lambda.*(P1-P2)+ errorb(:,1);
       uij2str =      gamma.*(lambda.*(a_e+c_e+bp_e*P2)+ betar_e*(ones(J,1)-lambda).*(c_e+gamma*c_e))+ errorb(:,2);
       e1str=exp(uij1str); e2str=exp(uij2str);
       sharesstr=[e1str./(1+e1str+e2str) e2str./(1+e1str+e2str)];
       outsidestr=[1./(1+e1str+e2str) 1./(1+e1str+e2str)];
       
       sharesstr_n=reshape(sharesstr',J*2,1); %stack shares on top of eachother
       outsidestr_n=reshape(outsidestr',J*2,1); %stack outside share
       
       Ynstr=log(sharesstr_n./outsidestr_n);
       
       betasstr=inv(Xn'*Xn)*Xn'*Ynstr;
       errorsstr=Yn-Xn*betasstr;
       vcmstr=(errorsstr'*errorsstr)*inv(Xn'*Xn)/(2*J);
       sestr_est=sqrt(diag(vcmstr));
       
       betasstr   =  betasstr';
       sestr_est  =  sestr_est';
       cstr_e     =  betasstr(1,p-3);
       bpstr_e    =  betasstr(1,p-2);
       alphapstr_e=  betasstr(1,p-1);
       tt1str_e   =  betasstr(1,p);
       betarstr_e =tt1str_e/cstr_e;
       STEFOCstr=[1/cstr_e -tt1str_e/cstr_e^2];
       %ParamCovar =vcm([2 5],[2 5])*J;
       ParamCovarstr =vcmstr([p-3 p],[p-3 p])*(2*J);
       betarSTEstr=sqrt(STEFOCstr*ParamCovarstr*STEFOCstr'/(2*J));
       % c bp alphap betar 
       estsim(m,:)=[betasstr(1,p-3:p-1) betarstr_e];
       csim(m,:)= [(betasstr(1,p-3:p-1)-betas(1,p-3:p-1))./sestr_est(1,p-3:p-1) (betarstr_e-betar_e)./betarSTEstr];
 end;
 % bootstrap bias
 B=mean(estsim)-[betas(1,p-3:p-1) betar_e];
 bootstrapest = [betas(1,p-3:p-1) betar_e]-B;
disp('estimation for bootstrap estimation is:');
disp(bootstrapest);
% t-stat of bootstrap
csim = sort(abs(csim));
crtic = csim(0.95*msim,:);
disp('tratio and critical values are given in the following lines:');
disp([betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE;crtic]);

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
%X0 =  [0.5 0.2 0.3 0.4];
%X0 = [0.1 0.1 0.1 01];
%X0= [0.5 0.5 0.5 0.5];
X0= [0.5 0.5 0.5 0.8];
%X0= [0 0 0 0];
%X0= [0.8 0.8 1 0.8];
%[log(pi1/(1-pi1)) log(-bpd) log(-alphapd) log(-betard*c)];
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
% no fixed effect
%[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRD',X0,options);
% fixed effect heterogeneity
%[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDFE',X0,options);
% heterogeneity by cost
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncWithHetroWithRegrtRDCH',X0,options);
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
%disp('Seed for random generation is:');
%disp(SEED1);
% c bp alphap betar 
% display('parameters estimation for: a c bp alphap betar are:');
% disp([betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE])
disp('estimation and t-stat for direct estimation for (c,bp,alphap,betar) is:');
disp([betas(1,p-3:p-1) betar_e;betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE]);
%[betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]
%[betas(1,p-3:p-1) betar_e;betas(1,p-3:p-1)./se_est(1,p-3:p-1) betar_e./betarSTE]
% parameters of heterogeneity [pi betap alphap betar]
ste = diag(inv(hessian));
ste = sqrt(ste);
trat = [exp(x(1,1))/(1+exp(x(1,1))) -exp(x(1,2:3))]./ste(1:3,1)';
tth1_e=-exp(x(1,4));
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
%ParamCovar =vcm([2 5],[2 5])*J;
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity (pi,bp,alphap,betar) are:');
disp([exp(x(1,1))/(1+exp(x(1,1))) -exp(x(1,2:3)) betarh_e;trat(1,1:3) betarh_e./betarSTEh])
disp('log likelihood value is:');
disp(fval);


% regret coefficient
[betar; betas(1,5)/(alpha+c+gamma*c); betas(1,6)/betas(1,3);betarmean]


se_est';