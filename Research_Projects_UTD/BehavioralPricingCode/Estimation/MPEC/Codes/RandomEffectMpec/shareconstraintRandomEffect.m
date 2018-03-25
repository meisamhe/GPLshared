function [c,ceq]=shareconstraintRandomEffect(x) %,gradc,gradceq
global P1 P2 Dur1 Dur2 availlambda gamma shares cost;
%global  uij1s1 uij2s1

[J,T]=size(shares);


%X0=[pi1 bpd alphapd betard*c delta]
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

% utility of first segment in the first period
uij1s1 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1) + alphap1*availlambda.*(P1-P2) + xi(:,1);
uij2s1 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp1*P2)+(1-availlambda).*betar1.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp1*P1)))+xi(:,2);
% utility of second segment in the first period
uij1s2 = (alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1) + alphap2*availlambda.*(P1-P2) + xi(:,1);
uij2s2 = gamma.*(availlambda.*(alphai+Dur2/2.*tti-bp2*P2)+(1-availlambda).*betar2.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1)))+xi(:,2);

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
shares_e=[exp(-log(1+e1+e2))*[pi1;1-pi1] exp(log(e2)-log(1+e1+e2))*[pi1;1-pi1]];
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    shares_e=[exp(log(e1)-log(1+e1+e2))*[pi1;1-pi1] exp(-log(1+e1+e2))*[pi1;1-pi1]];
end;


%-------------------------------------------Constraints of estimate share equal to actual share, and endogeneity---------------------
ceqShares = shares - shares_e;
% assumption that error term is mean zero
ceqXiExp  = mean(xi(:));
% exogeneity assumption for the first relation (orthogonality)
ceqXi1Alphai = mean(xi(:,1).*alphai);
ceqXitti = mean(xi(:,1).*tti);
CeqXiDur = mean(xi(:,1).*(Dur1/2+gamma.*Dur2));
ceqXiP1  = mean(P1.*xi(:,1));
ceqXiP1P2 = mean(availlambda.*((P1-P2).*xi(:,1));
% exogeneity assumption for the second relation (orthogonality)
ceqXiAlphai2 = mean(gamma.*(availlambda.*(alphai)).*xi(:,2));
ceqXiDur2 = mean(gamma.*availlambda.*tti.*xi(:,2));
ceqXiP2 = mean(gamma.*(availlambda.*(P2)).*xi(:,2));
ceqXiReg = mean(gamma.*log(1+exp(alphai+ (Dur1/2+gamma.*Dur2).*tti + bp2*P1)).*(1-availlambda).*xi(:,2));

ceq = [ceqShares(:);ceqXiExp; ceqXi1Alphai;ceqXitti;CeqXiDur;ceqXiP1;ceqXiAlphai2;ceqXiDur2;ceqXiP2;ceqXiReg];

c=[];

