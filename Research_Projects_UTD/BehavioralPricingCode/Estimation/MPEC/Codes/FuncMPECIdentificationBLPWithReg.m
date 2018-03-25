% To check the identification for model with regret
function [y,G] = FuncMPECIdentificationBLPWithReg(x)%
global P1 P2 Dur1 Dur2 availlambda gamma shares   cost ; %outside_n
global vcm se_est betas variance

[J,T]=size(shares);
E= exp(1);


%X0=[pi1 bpd alphapd betard*c delta]

% parameters function [pi1 bp alphap betar*c delta]
 pi1      =  exp(x(1))/(1+exp(x(1)));;%share of first segment 
bpd       =  x(2); %price coefficient difference heterogeneity coeff
alphapd   =  x(3); %high price regret difference heterogeneity coeff
tth1d    =   x(4); %stock out regret difference heterogeneity coeff multiplied to consumption utility
delta   = reshape(x(5:2*J+4)',[J 2]);
%delta = [ uij1s1 uij2s1];

dd_n=reshape(delta',J*2,1);

%-----------------------------------------Run OLS---------------------------------------------
%beta=[alpha c bp];
p = 5;
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  availlambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*availlambda.*cost gamma.*availlambda.*Dur2.*0.5 gamma.*availlambda.*P2 zeros(J,1) gamma.*(ones(J,1)-availlambda).*(0.5*Dur1+gamma.*Dur2)];

X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn=dd_n;

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));

% calculate variance

variance                 =    mean(errors.^2);

variance = max(variance,1e-320); %As a precaution

% define variables to use in likelihood
delta1 =      delta(:,1);
delta2 =      delta(:,2);
correspErrors = reshape(errors(:)',[J 2]);
xi1    =        correspErrors(:,1);
xi2    =        correspErrors(:,2);
alpha     =  betas(1);
c    =  betas(2);
bp    =  betas(3);
alphap = betas(4);
tth1   =  betas(5);
sigma = sqrt(variance);

% ------------------------------------------write the compelte likelihood-------------------------------
% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
uij1s1 =      delta(:,1);
uij2s1 =      delta(:,2);
uij1s2 =      delta(:,1)+bpd*P1(:) + alphapd.*availlambda(:).*(P1(:)-P2(:));    
uij2s2 =      delta(:,2)+gamma(:).*(availlambda(:).*(bpd*P2(:))+ tth1d*(ones(J,1)-availlambda(:)).*(0.5*Dur1(:)+gamma(:).*Dur2(:))); 

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
s1    =     1./(1+e1+e2);
s2    =     e2./(1+e1+e2);
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    s1    =     e1./(1+e1+e2);
    s2    =     1./(1+e1+e2);
end;


% 
% s11   =     1-s1;
% s1=max(s1,1e-160); %As a precaution
% s11=max(s11,1e-160); %As a precaution
% s21   =     1-s2;
% s2=max(s2,1e-160);   %As a precaution
% s21=max(s21,1e-160); %As a precaution
% % for period 1 and period 2 respectively
% Jacobian                 =    (((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;
% 
% LogJacobian              =    -sum(log(Jacobian(:)));
% 
% LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);
% logLiklihood               =    LogDemandShockLikelihood    +   LogJacobian  ;
% if (variance==0)
%     error('variance is zero!!!');
% end;
% 
% y                        =    - logLiklihood ;
s11   =     1-s1;
s1=max(s1,1e-300); %As a precaution
s11=max(s11,1e-300); %As a precaution
%s2    =     e2./(1+e1+e2);
s21   =     1-s2;
s2=max(s2,1e-300);   %As a precaution
s21=max(s21,1e-300); %As a precaution
% for period 1 and period 2 respectively
Jacobian                 =    (((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;
Jacobian=max(Jacobian,1e-300);   %As a precaution

LogJacobian              =    -sum(log(Jacobian(:)));


LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian   ;
y                        =    - likelihood ;

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
 %period 1, segment 1, segment 2
s11 = exp(-log(1+e1+e2))*[1;0];
s12 = exp(-log(1+e1+e2))*[0;1];
 % period 2, segment 1 , segment 2
s21 =exp(log(e2)-log(1+e1+e2))*[1;0];
s22 =exp(log(e2)-log(1+e1+e2))*[0;1];
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    %period 1, segment 1, segment 2
    s11 = exp(log(e1)-log(1+e1+e2))*[1;0];
    s12 =  exp(log(e1)-log(1+e1+e2))*[0;1];
    % period 2, segment 1 , segment 2
    s21 = exp(-log(1+e1+e2))*[1;0]; 
    s22 =exp(-log(1+e1+e2))*[0;1];
end;

element1 = sum((-(s21.*(-((-1 + s12).*s12) + (-1 + s22).*s22).*(-1 + pi1)) - (-1 + s11).*s11.*(-((-1 + s12).*s12) + (-1 + s22).*s22).*pi1 - ...
  (-1 + s11).*s11.*((-1 + s22).*s22.*(-1 + pi1) - (-1 + s12).*s12.*pi1) - s21.*((-1 + s22).*s22.*(-1 + pi1) - (-1 + s12).*s12.*pi1) + ...
  s21.^2.*(-((-1 + s12).*s12.*(-1 + pi1)) + (-1 + 2.*s11).*s22.*(-1 + pi1) - s11.^2.*pi1 - (s11.^2 + (-1 + s12).*s12).*pi1 + s22.*(1 + (-1 + 2.*s11).*pi1))).*...
 (-(s21.*(-1 + pi1).*((-1 + s22).*s22.*(-1 + pi1) - (-1 + s12).*s12.*pi1)) - (-1 + s11).*s11.*pi1.*((-1 + s22).*s22.*(-1 + pi1) - (-1 + s12).*s12.*pi1) + ...
  s21.^2.*(-(pi1.*((-1 + s12).*s12.*(-1 + pi1) + s11.^2.*pi1)) + s22.*(-1 + pi1).*(1 + (-1 + 2.*s11).*pi1))));

element2= sum((-(pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(-1 + s12).*(P1.*s12.*(1 - s12 - s22) + ...
      (P1 - P2.*gamma.*availlambda).*s12.*s22)) - pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*s12.*...
    (P1.*s12.*(1 - s12 - s22) + (P1 - P2.*gamma.*availlambda).*s12.*s22) + ...
   (-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*((-P1 + P2.*gamma.*availlambda).*s12.*s22 + ...
     P2.*gamma.*availlambda.*(1 - s12 - s22).*s22) - 2.*(-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*s22.*...
    ((-P1 + P2.*gamma.*availlambda).*s12.*s22 + P2.*gamma.*availlambda.*(1 - s12 - s22).*s22)).*...
  (-(s11.^2.*s21.^2.*pi1.^2) - pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(-1 + s12).*s12 + ...
   (-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*s22 - (-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*...
    s22.^2) + ...
 (2.*(-(((-P1 + P2.*gamma.*pi1.*availlambda).*s12 + P2.*gamma.*(-1 + pi1).*availlambda.*(-1 + s22)).*s22.*(-(pi1.*s11.*s21) + ...
       (-1 + pi1).*s12.*s22)) + s12.*(P1.*(-1 + pi1).*(-1 + s12) + (P1.*pi1 - P2.*gamma.*availlambda).*s22).*...
     (-(pi1.*(-1 + s21).*s21) + (-1 + pi1).*(-1 + s22).*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X1*betas) + delta1)) - ...
 (2.*((-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*((-P1 + P2.*gamma.*pi1.*availlambda).*s12 + ...
      P2.*gamma.*(-1 + pi1).*availlambda.*(-1 + s22)).*s22 + (-1 + s12).*s12.^2.*(P1.*(-1 + pi1).*(-1 + s12) + ...
      (P1.*pi1 - P2.*gamma.*availlambda).*s22))).*(((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X2*betas) + delta2)));

element3=sum((-((P1 - P2).*pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*availlambda.*(1 - s12).*(-1 + s12).*s12) - ...
   (P1 - P2).*pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*availlambda.*(1 - s12).*s12.^2 - ...
   (P1 - P2).*(-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*availlambda.*s12.*s22 + ...
   2.*(P1 - P2).*(-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*availlambda.*s12.*s22.^2).*...
  (-(s11.^2.*s21.^2.*pi1.^2) - pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(-1 + s12).*s12 + ...
   (-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*s22 - (-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*...
    s22.^2) + (2.*(P1 - P2).*(-1 + pi1).*availlambda.*s12.*((pi1 - pi1.*s12).*s21.^2 - (-1 + pi1).*s22.*(-1 + s12 + s22) + ...
    pi1.*s21.*(-1 + s12 + s11.*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X1*betas) + delta1)) - ...
 (2.*(P1 - P2).*(-1 + pi1).*availlambda.*s12.*(-(pi1.*(-1 + s11).*s11.*s22) + ...
    (-1 + s12).*s12.*(-1 + s12 + (-1 + pi1).*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X2*betas) + delta2)));

element4=sum((gamma.*(Dur1.*2 + Dur2.*gamma).*pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(1 - availlambda).*(-1 + s12).*s12.*s22 +... 
   gamma.*(Dur1.*2 + Dur2.*gamma).*pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(1 - availlambda).*s12.^2.*s22 + ...
   gamma.*(Dur1.*2 + Dur2.*gamma).*(-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*(1 - availlambda).*(1 - s22).*s22 - ...
   2.*gamma.*(Dur1.*2 + Dur2.*gamma).*(-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*(1 - availlambda).*(1 - s22).*s22.^2).*...
  (-(s11.^2.*s21.^2.*pi1.^2) - pi1.*((-1 + s21).*s21.*(-1 + pi1) - (-1 + s11).*s11.*pi1).*(-1 + s12).*s12 + ...
   (-1 + pi1).*((-1 + s11).*s11.*pi1 + s21.*(-1 + s21 + pi1 + (-1 + 2.*s11).*s21.*pi1)).*s22 - (-1 + pi1).*(s21.*(-1 + pi1) + (-1 + s11).*s11.*pi1).*...
    s22.^2) + (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + pi1).*pi1.*(-1 + availlambda).*s21.*(s12.*(-1 + s21) - s11.*(-1 + s22)).*s22).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X1*betas) + delta1)) + ...
 (gamma.*(Dur1 + 2.*Dur2.*gamma).*(-1 + pi1).*(-1 + availlambda).*s22.*((-1 + s12).*s12.*(s12 + (-1 + pi1).*(-1 + s22)) + ...
    pi1.*s11.*(-1 + s22) + s11.^2.*(pi1 - pi1.*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X2*betas) + delta2)));

element5=(2.*pi1.*(1 - s11).*s11.^2.*(-(pi1.*s12) + pi1.*s12.^2 - pi1.*s21.^2 - (-1 + pi1).*(-1 + s22).*s22) + ...
   pi1.*s11.^2.*(-(pi1.*(1 - s12).*s12) + 2.*pi1.*(1 - s12).*s12.^2 + 2.*pi1.*s11.*s21.^2 + ...
     (-1 + pi1).*s12.*(-1 + s22).*s22 + (-1 + pi1).*s12.*s22.^2) + ...
   (-1 + pi1).*s11.*s21.*(pi1.*s12.^2.*(-1 + s21) + s12.*(pi1 - pi1.*s21) + (-1 + pi1).*s22.*(-1 + s21 + s22)) + ...
   pi1.*(1 - s11).*s11.*(pi1.*s12 - pi1.*s12.^2 + (-1 + pi1).*s22.*(-1 + 2.*s21.^2 + s22)) - ...
   (-1 + pi1).*s21.*(2.*pi1.*(1 - s12).*s12.^2.*(-1 + s21) + pi1.*s11.*s12.*s21 - pi1.*s11.*s12.^2.*s21 + ...
     (1 - s12).*s12.*(pi1 - pi1.*s21) - (-1 + pi1).*s12.*s22.*(-1 + s21 + s22) + ...
     (-1 + pi1).*s22.*(-(s11.*s21) - s12.*s22)) + ...
   pi1.*s11.*(pi1.*(1 - s12).*s12 - 2.*pi1.*(1 - s12).*s12.^2 - (-1 + pi1).*s12.*s22.*(-1 + 2.*s21.^2 + s22) + ...
     (-1 + pi1).*s22.*(-4.*s11.*s21.^2 - s12.*s22))).*...
  (pi1.*s11.^2.*(-(pi1.*s12) + pi1.*s12.^2 - pi1.*s21.^2 - (-1 + pi1).*(-1 + s22).*s22) - ...
   (-1 + pi1).*s21.*(pi1.*s12.^2.*(-1 + s21) + s12.*(pi1 - pi1.*s21) + (-1 + pi1).*s22.*(-1 + s21 + s22)) + ...
   pi1.*s11.*(pi1.*s12 - pi1.*s12.^2 + (-1 + pi1).*s22.*(-1 + 2.*s21.^2 + s22))) + ...
 (2.*(-(pi1.*s11.*s21 - (-1 + pi1).*s12.*s22).^2 + (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*...
     (-(pi1.*(-1 + s21).*s21) + (-1 + pi1).*(-1 + s22).*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X1*betas) + delta1)) - ...
 (2.*(-(pi1.*s11) + pi1.*s11.^2 - (-1 + pi1).*(-1 + s12).*s12).*...
   (pi1.*s11.*s21 + s12.*(1 - s12 + s22 - pi1.*s22))).*...
  (((-1 + s12).*s12.*(-(pi1.*s11.*s21) + (-1 + pi1).*s12.*s22) + ...
    (-(pi1.*(-1 + s11).*s11) + (-1 + pi1).*(-1 + s12).*s12).*(-(pi1.*(-1 + s21).*s21) + ...
      (-1 + pi1).*(-1 + s22).*s22)).*(-(X2*betas) + delta2));

element6=(-2.*pi1.*s11.^2.*s21.*(-(pi1.*s12) + pi1.*s12.^2 - pi1.*s21.^2 - (-1 + pi1).*(-1 + s22).*s22) + ...
   pi1.*s11.^2.*(-2.*pi1.*(1 - s21).*s21.^2 + pi1.*s12.*s22 - 2.*pi1.*s12.^2.*s22 - ...
     (-1 + pi1).*(1 - s22).*(-1 + s22).*s22 - (-1 + pi1).*(1 - s22).*s22.^2) - ...
   (-1 + pi1).*(1 - s21).*s21.*(pi1.*s12.^2.*(-1 + s21) + s12.*(pi1 - pi1.*s21) + ...
     (-1 + pi1).*s22.*(-1 + s21 + s22)) - pi1.*s11.*s21.*(pi1.*s12 - pi1.*s12.^2 + ...
     (-1 + pi1).*s22.*(-1 + 2.*s21.^2 + s22)) - (-1 + pi1).*s21.*(-(pi1.*s12.*(1 - s21).*s21) + ...
     pi1.*s12.^2.*(1 - s21).*s21 - 2.*pi1.*s12.^2.*(-1 + s21).*s22 - s12.*(pi1 - pi1.*s21).*s22 + ...
     (-1 + pi1).*(1 - s22).*s22.*(-1 + s21 + s22) + (-1 + pi1).*s22.*((1 - s21).*s21 + (1 - s22).*s22)) + ...
   pi1.*s11.*(-(pi1.*s12.*s22) + 2.*pi1.*s12.^2.*s22 + (-1 + pi1).*(1 - s22).*s22.*(-1 + 2.*s21.^2 + s22) + ...
     (-1 + pi1).*s22.*(4.*(1 - s21).*s21.^2 + (1 - s22).*s22))).*...
  (pi1.*s11.^2.*(-(pi1.*s12) + pi1.*s12.^2 - pi1.*s21.^2 - (-1 + pi1).*(-1 + s22).*s22) - ...
   (-1 + pi1).*s21.*(pi1.*s12.^2.*(-1 + s21) + s12.*(pi1 - pi1.*s21) + (-1 + pi1).*s22.*(-1 + s21 + s22)) + ...
   pi1.*s11.*(pi1.*s12 - pi1.*s12.^2 + (-1 + pi1).*s22.*(-1 + 2.*s21.^2 + s22))) - 2.*(-(X2*betas) + delta2);
 G = [element1, element2, element3, element4, element5', element6']';
% disp('size of G is:')
% size(G)


 
%disp('Current Likelihood is:')
%-y





