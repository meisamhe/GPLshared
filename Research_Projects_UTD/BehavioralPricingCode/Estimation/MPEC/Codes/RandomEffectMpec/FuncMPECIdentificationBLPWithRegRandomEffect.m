% To check the identification for model with regret
function [y] = FuncMPECIdentificationBLPWithReg(x)%,G
global P1 P2 Dur1 Dur2 availlambda gamma shares  km cost resultedShare; %outside_n
global vcm se_est betas variance
global pi1r bpdr alphapdr betardr cr

[J,T]=size(shares);
E= exp(1);


% parameters function [pi1 bp alphap betar*c delta]
pi1      =  x(1);  %share of first segment 
bp1       =  x(2); %price coefficient of the the first segment
bp2       =  x(3); %price coefficient of the second segment
alphap1   =  x(4);  %high price regret of the first segment
alphap2   =  x(5);  %high price regret of the second segment
betar1    =   x(6); %stock out regret of the first segment
betar2    =   x(7); %stock out regret of the second segment
alphai    = x(8:J+7)'; % random effect of ownership utility
tti    = x(J+8: 2*J+7)'; % random effect of consumption utility
xi   = reshape(x(2*J+8:4*J+8)',[J 2]);

%-----------------------------------------Run OLS---------------------------------------------

% calculate variance

variance                 =    mean(xi(:).^2);

variance = max(variance,1e-320); %As a precaution
sigma = sqrt(variance);

% ------------------------------------------write the compelte likelihood-------------------------------
% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
% utility of first segment in the first period
uij1s1 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1) + alphap1*availlambda.*(P1-P2) + xi(:,1);
uij2s1 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp1*P2)+(1-availlambda).*betar1.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1)))+xi(:,2);
% utility of second segment in the first period
uij1s2 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1) + alphap2*availlambda.*(P1-P2) + xi(:,1);
uij2s2 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp2*P2)+(1-availlambda).*betar2.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1)))+xi(:,2);

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
s1    =     1./(1+e1+e2);
s2    =     e2./(1+e1+e2);
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    s1    =     e1./(1+e1+e2);
    s2    =     1./(1+e1+e2);
end;

s11   =     1-s1;
s1=max(s1,1e-160); %As a precaution
s11=max(s11,1e-160); %As a precaution
s21   =     1-s2;
s2=max(s2,1e-160);   %As a precaution
s21=max(s21,1e-160); %As a precaution
% for period 1 and period 2 respectively
Jacobian                 =    (((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;

LogJacobian              =    -sum(log(Jacobian(:)));

LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);

% truncated normal likelihood
alphaimean = mean(alphai);
varalphai  = std(alphai);
ttimean    = mean(tti);
vartti     = std(tti);

LogTNormalphai = sum(log(normpdf((alphai-alphaimean)/varalphai)/varalphai/(1-normcdf(-alphaimean/varalphai))));

LogTNormtti = sum(log(normpdf((tti-ttimean)/vartti)/vartti/(1-normcdf(-ttimean/vartti))));

logLiklihood               =    LogDemandShockLikelihood    +   LogJacobian +  LogTNormalphai + LogTNormtti;

y                        =    - logLiklihood ;
 





