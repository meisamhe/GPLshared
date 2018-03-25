function [c,ceq]=shareconstraint(x) %,gradc,gradceq
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
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    shares_e=[exp(log(e1)-log(1+e1+e2))*[pi1;1-pi1] exp(-log(1+e1+e2))*[pi1;1-pi1]];
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
%gradc = [];
% for the first share

% gradceq1 = exp([delta1 + log((1 + E.^delta1 + E.^delta2).^(-1) - (E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + ...
%       E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)).^(-1)), ...
%  delta1 - P1.*(bpd + alphapd.*availlambda) - 2.*log(E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + ...
%      E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(-1 + pi1) + ...
%   log(-(E.^(P2.*alphapd.*availlambda).*P1) + E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2).*(-P1 + P2.*gamma.*availlambda)), ...
%  P1.*bpd + delta1 + P1.*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2 + ...
%   log(E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda) + E.^(P2.*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) - ...
%   2.*log(E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda) + E.^(P2.*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%      E.^(delta1 + P1.*(bpd + alphapd.*availlambda) + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(-P1 + P2) + log(-1 + pi1) + log(availlambda), ...
%  1i.*pi + delta1 + delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2 - ...
%   2.*log(E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - ...
%        (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(gamma./2) + log(Dur1 + 2.*Dur2.*gamma) + log(-1 + pi1) + log(-1 + availlambda), ...
%  diag(delta1 + log((E.^delta1.*(-1 + pi1))./(E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - ...
%          (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)).^2 - (-1 + pi1)./(E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + ...
%       E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) - (E.^delta1.*pi1)./(1 + E.^delta1 + E.^delta2).^2 + ...
%     pi1./(1 + E.^delta1 + E.^delta2))), diag(delta1 + log((E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2).*(-1 + pi1))./...
%      (E.^delta1 + E.^(P2.*alphapd.*availlambda - P1.*(bpd + alphapd.*availlambda)) + E.^(delta2 + P2.*(alphapd + bpd.*gamma).*availlambda - P1.*(bpd + alphapd.*availlambda) - (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)).^...
%       2 - (E.^delta2.*pi1)./(1 + E.^delta1 + E.^delta2).^2))]);
% 
% 
% % for the second share
% element1 =delta2 + log((1 + E.^delta1 + E.^delta2).^(-1) - E.^(P2.*bpd.*gamma.*availlambda)./(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%       E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)));
% element2 =1i.*pi + delta2 + P2.*bpd.*gamma.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2 - ...
%   2.*log(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%      E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(-1 + pi1) + ...
%   log(P2.*gamma.*availlambda + E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda).*(-P1 + P2.*gamma.*availlambda));
% element3= P1.*bpd + delta1 + delta2 + (P1 - P2).*alphapd.*availlambda + P2.*bpd.*gamma.*availlambda + ...
%   (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2 - 2.*log(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%      E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(P1 - P2) + log(-1 + pi1) + log(availlambda);
% element4=delta2 + P2.*bpd.*gamma.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2 + log(1 + E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda)) - ...
%   2.*log(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%      E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + log(gamma./2) + log(Dur1 + 2.*Dur2.*gamma) + log(-1 + pi1) + log(-1 + availlambda);
%  element5= diag(delta2 + log((E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + P2.*bpd.*gamma.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2).*(-1 + pi1))./...
%      (E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + ...
%         (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)).^2 - (E.^delta1.*pi1)./(1 + E.^delta1 + E.^delta2).^2));
%  element6 =diag(delta2 + log((E.^(delta2 + 2.*P2.*bpd.*gamma.*availlambda).*(-1 + pi1))./(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%        E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)).^2 - ...
%     (E.^(P2.*bpd.*gamma.*availlambda).*(-1 + pi1))./(E.^(delta2 + P2.*bpd.*gamma.*availlambda) + E.^((gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2) + ...
%       E.^(P1.*bpd + delta1 + (P1 - P2).*alphapd.*availlambda + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + availlambda).*tth1d)./2)) + ((1 + E.^delta1).*pi1)./(1 + E.^delta1 + E.^delta2).^2));
%      gradceq2 = exp([element1, element2, element3, ...
%  element4, element5, element6]);
% 
%      
%       gradceq = [gradceq1;gradceq2]';
      
      
      
%       disp('size of constraint is:')
%       size(ceq)
%       disp('size of gradceq and gradceq2 is:')
%       size(gradceq)