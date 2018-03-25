
% For platform FFBS of BASS model (Modified to only include only platform
% data and not add-on's state equation anymore)


function [m,C,m0,C0,tt1,tt0] = BEKFPMOnlyPlatformCompetitor(y,F,p,m0,C0,v,w,GT,uT,yc,caddon) %,b1,b2,alpha
% Author:  Norris Bruce... June 2013
% Modified: Meisma Hejazinia ... Dec 2013
global Y1p MADp MSEp ;

 T   =  size(y,1);
 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; 
 d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;

 % kalman Filtering
 for t      =   1:T

%      if (floor(t/100) == t/100)
%         t
%      end;
     g      =   Jmcm(d,mt,yc,caddon,t); %alpha,
     r      =   g*Ct*g' + w;                        % variance of prior at t-1

     a      =   fmcm(d,mt,yc,caddon,t) + uT(t,:); %alpha,

     Ja = 1; % for this case there is no state equation for add-ons to use
     h = a; % for this case there is no state equation for add-ons to use 
     F = Ja;   
     forecast = h;
     Y1p(1,t)  = forecast;    % n for all addons and 1 for platform

     % we use relvar here in order to only select relevant elements of full
     % covar matrix

     q      =   F*r*F' + v(1,1);                         % variance of 1-step ahead prediction
     e = y(t,:) - forecast(1); % for this case there is no state equation for add-ons to use 

     A      =   r*F'*(q\speye(size(q)));

     MSEp =    sum(e.^2); MADp = sum(abs(e));
     mt     =    a + A * e; Ct = r - A*q*A';
     Ct     =    (Ct+Ct')/2;
     C(:,:,t)=Ct;
     m(:,t)= mt; % mean variance of posterior at t

     
     %===================== iterated EKF, use mt========================
     %[mt,Ct] = iter_EKF(A,y,t,v,r,a,b1,b2,MSE,MAD,Y1); %=================
     %===================== iterated EKF, use mt========================
 end;
 %Backward smoothing 
  if (C(:,:,T)<0)
         C(:,:,T)=1e-15;
  end;
  tt1(:,T)  = m(:,T) + chol(C(:,:,T)+1e-15)'*randn(p,1);  % Sample last posterior
 
 for t    =   (T-1):-1:(1)
%      if (floor(t/100) == t/100)
%         t
%      end;
     
     g    =   Jmcm(d,m(:,t),yc,caddon,t); %alpha,
     
     a    =   fmcm(d,m(:,t),yc,caddon,t)+ uT(t+1,:); %alpha,
     
     
    %g    =   GT(:,:,1);
    %a    =   g*m(:,t) + uT(:,t);    
     
     r    =   g*C(:,:,t)*g' + w;
     b    =   C(:,:,t)*g'/r;
     u    =   C(:,:,t)*g';
    
     Cm   =   C(:,:,t) - u/r*u';  
     tm   =   m(:,t) + b*(tt1(:,t+1)-a); 
     if (Cm<0)
         Cm=1e-15;
     end;
%     
%      if min(diag(Cm)) < 0 
%         error('Negative variance found in C matrix');  end;
%       
     C(:,:,t)  =  C(:,:,t) - b*(r-C(:,:,t+1))*b';
     m(:,t)    =  m(:,t) + b*(m(:,t+1)-a);    
     tt1(:,t)  =  tm + chol(Cm+1e-15)'*randn(p,1);
 end;
  
 % Now ad-hoc treatment of start value 
 if (C(:,:,1)<0)
         C(:,:,1)=1e-15;
end;
 m0    =  m(:,1);  C0 = C(:,:,1);  
 tt0   =  m0 + chol(C0+1e-15)'*randn(p,1); 
 
  clear a A e b r Cm tm mt Ct