function [c,ceq,gradc,gradceq]=shareconstraint(x) %
global P1 P2 Dur1 Dur2 availlambda gamma shares cost;
%global  uij1s1 uij2s1

[J,T]=size(shares);


%X0=[pi1 bpd alphapd betard*c delta]
E= exp(1);

% parameters function [pi1 bp alphap betar*c delta]
pi1      =  x(1); %share of first segment 
bpd       =  x(2); %price coefficient difference heterogeneity coeff
alphapd   =  x(3); %high price regret difference heterogeneity coeff
tth1d    =   x(4); %stock out regret difference heterogeneity coeff multiplied to consumption utility
delta   = reshape(x(5:2*J+4)',[J 2]);
%delta = [ uij1s1 uij2s1];

X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  availlambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*availlambda.*cost gamma.*availlambda.*Dur2.*0.5 gamma.*availlambda.*P2 zeros(J,1) gamma.*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)];
betaparam2 = [0; 0; bpd;alphapd;tth1d];

delta1 =      delta(:,1);
delta2 =      delta(:,2);

expdelta1 = exp(delta1);
expdelta2 =  exp(delta2);

uij1s1 = delta1;
uij2s1 = delta2;
uij1s2 = delta1 + X1*betaparam2; 
uij2s2 = delta2 + X2*betaparam2; 

% e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
% % condition to make sure I am not departing from feasible region
% if (sum(sum(isinf(log(1+e1+e2))))>0)
%    
%     e1
%     x
%     [uij1s1 uij1s2]
%     error('share e1 is infinity');
% end;

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
shares_e=[exp(-log(1+e1+e2))*[pi1;1-pi1] exp(log(e2)-log(1+e1+e2))*[pi1;1-pi1]];
 %period 1, segment 1, segment 2
s11 = exp(-log(1+e1+e2))*[1;0];
s12 = exp(-log(1+e1+e2))*[0;1];
 % period 2, segment 1 , segment 2
s21 =exp(log(e2)-log(1+e1+e2))*[1;0];
s22 =exp(log(e2)-log(1+e1+e2))*[0;1];
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    shares_e=[exp(log(e1)-log(1+e1+e2))*[pi1;1-pi1] exp(-log(1+e1+e2))*[pi1;1-pi1]];
    %period 1, segment 1, segment 2
    s11 = exp(log(e1)-log(1+e1+e2))*[1;0];
    s12 =  exp(log(e1)-log(1+e1+e2))*[0;1];
    % period 2, segment 1 , segment 2
    s21 = exp(-log(1+e1+e2))*[1;0]; 
    s22 =exp(-log(1+e1+e2))*[0;1];
end;

%loge1=[uij1s1 uij1s2]; loge2=[uij2s1 uij2s2]-[uij1s1 uij1s2];
%shares_e=[exp(-log(1+e1+e2))*[pi1;1-pi1] exp(loge2-log(1+e1+e2))*[pi1;1-pi1]];



% if (sum(sum(isnan(-log(1+e1+e2))))>0)
%     error('the share is (i.e. e1/(1+e1+e2) NaN');
% end;
% if (sum(sum(isnan(exp(-log(1+e1+e2))*[pi1;1-pi1])))>0)
%    % pi1
%    % isnan(e1./(1+e1+e2)*[pi1;1-pi1])
%     error('first portion of shares_e is NaN');
% end;
% if (sum(sum(isnan(exp(loge2-log(1+e1+e2))*[pi1;1-pi1])))>0)
%     error('second portion of shares_e is NaN');
% end;
% 

ceq = shares - shares_e;
% if (sum(sum(isnan(x)))>0)
%     error('x is NaN');
% end;
% %shares_e
% if (sum(sum(isnan(shares_e)))>0)
%     error('shares_e is NaN');
% end;
% size(ceq)
ceq = ceq(:);
%ceq
c=[];
gradc = [];
% for the first share
element11 = s11 - s12;
element12 = (1 - pi1).*(P1.*s12.*(1 - s12 - s22) + (P1 - P2.*gamma.*availlambda).*s12.*s22);
element13 = (P1 - P2).*(1 - pi1).*availlambda.*(1 - s12).*s12;
element14 = -(gamma.*(Dur1./2 + Dur2.*gamma).*(1 - pi1).*(1 - availlambda).*s12.*s22);
element15=diag(pi1.*(1 - s11).*s11 + (1 - pi1).*(1 - s12).*s12);
element16=diag(-(pi1.*s11.*s21) - (1 - pi1).*s12.*s22);
% for the second share
element21=s21 - s22;
element22=(1 - pi1).*((-P1 + P2.*gamma.*availlambda).*s12.*s22 + P2.*gamma.*availlambda.*(1 - s12 - s22).*s22);
element23=-((P1 - P2).*(1 - pi1).*availlambda.*s12.*s22);
element24=gamma.*(Dur1./2 + Dur2.*gamma).*(1 - pi1).*(1 - availlambda).*(1 - s22).*s22;
element25=diag(-(pi1.*s11.*s21) - (1 - pi1).*s12.*s22);
element26=diag(pi1.*(1 - s21).*s21 + (1 - pi1).*(1 - s22).*s22);

gradceq1 = [element11, element12, element13, element14, element15, element16];
gradceq2 =  [element21, element22, element23, element24, element25, element26];
gradceq = [gradceq1;gradceq2]';
      
      
      
%       disp('size of constraint is:')
%       size(ceq)
%       disp('size of gradceq and gradceq2 is:')
%       size(gradceq)