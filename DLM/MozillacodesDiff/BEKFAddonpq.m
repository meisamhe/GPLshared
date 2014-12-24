
% for simple test and for only one data point
function [m,C,m0,C0,tt1,tt0,Y1,MAD,MSE] = BEKFAddonpq(y,F,p,m0,C0,v,w,GT,uT,j,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq) %,b1,b2,alpha aipi,,mp,m0p
% Author:  Norris Bruce... June 2013
% Modified: Meisma Hejazinia ... Dec 2013
 T   =  size(y,1);
 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;% Y1 = [];  MAD=[]; MSE=[];   % mt, Ct mean and variance of prior at t-1

 Y1  = zeros(T,1);
 MSE = zeros(T,1);
 MAD = zeros(T,1);
 
 %initial value
 
 % kalman Filtering
 for t      =   1:T
     
         a      =   fmaddonpq(d,mt,t,T,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq) + uT(t,:); %alpha,
         forecast = ha(a); 
         Y1(t,1)  = forecast;     % ha - function b1,b2,
         e      =   (y(t,:) - forecast); 
         MSE(t,1) =    sum(e.^2); MAD(t,1) = sum(abs(e));

       %  size(uT)
        % g      =   Jmaddon(d,mt,t,T,pT,mp,m0p,aipi,tt1p,tt0p,olst); %alpha,  
         g      = Jmaddonpq(d,mt,t,T,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq);
         r      =   g(1,1)*Ct*g(1,1)' + w;
         F      =   Ja();             %b1,b2,a             % Ja Jacobian, EKF
         q      =   F*r*F' + v;                           % variance of 1-step ahead prediction
         A      =    r*F'/q; 

         mt     =    a + A * e; 
         m(:,t)= mt; % mean variance of posterior at t

         Ct = r - A*q*A';                    
         Ct     =    (Ct+Ct')/2;
         C(:,:,t)=Ct; 
     %===================== iterated EKF, use mt========================
     %[mt,Ct] = iter_EKF(A,y,t,v,r,a,b1,b2,MSE,MAD,Y1); %=================
     %===================== iterated EKF, use mt========================
 end;
 %Backward smoothing 
  tt1(:,T)  = m(:,T) + chol(C(:,:,T))'*randn(p,1);  % Sample last posterior
   while (tt1(:,T)<0)
      tt1(:,T)  = m(:,T) + chol(C(:,:,T))'*randn(p,1);  % Sample last posterior
  end;
 for t    =   (T-1):-1:(1)
     
        
  %   g    =   Jmaddon(d,m(:,t),t+1,T,pT,mp,m0p,aipi,tt1p,tt0p,olst); %alpha,
     g      = Jmaddonpq(d,m(:,t),t+1,T,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq);
     r    =   g(1,1)*C(:,:,t)*g(1,1)' + w;
     b    =  C(:,:,t)*g(1,1)'/r;
     u    =  C(:,:,t)*g(1,1)';
    
     Cm   =   C(:,:,t) - u/r*u';
     C(:,:,t)  =  C(:,:,t) - b*(r-C(:,:,t+1))*b';
     
     a    =   fmaddonpq(d,m(:,t),t+1,T,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq)+ uT(t+1,:); %alpha,
     tm   =   m(:,t) + b*(tt1(:,t+1)-a); 
     if min(diag(Cm)) < 0 
        error('Negative variance found in C matrix');  end;

     tt1(:,t)  =  tm + chol(Cm)'*randn(p,1);       

     m(:,t)    =  m(:,t) + b*(m(:,t+1)-a);    
     
 end;
  
 % Now ad-hoc treatment of start value  
 m0    =  m(:,1);  C0 = C(:,:,1);  
 tt0   =  m0 + chol(C0)'*randn(p,1); 
 
  clear a A e b r Cm tm mt Ct