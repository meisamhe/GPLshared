
% for simple test and for only one data point
function [m,C,m0,C0,tt1,tt0] = kalffbs(y,F,p,m0,C0,v,w,GT,uT,j) %,b1,b2,alpha
% Author:  Norris Bruce... June 2013
% Modified: Meisma Hejazinia ... Dec 2013
global Y1 MAD MSE 
 T   =  size(y,1);
 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;% Y1 = [];  MAD=[]; MSE=[];   % mt, Ct mean and variance of prior at t-1

 
 % kalman Filtering
 for t      =   1:T
    
     g      =   Jm(d,mt); %alpha,
     r      =   g*Ct*g' + w;                          % variance of prior at t-1
     a      =   fm(d,mt) + uT(t,:); %alpha,
     %pause;
    %a      =   g*mt  + uT(:,t);                      % mean of prior at t-1
     F      =   Ja();             %b1,b2,a             % Ja Jacobian, EKF
     
    %forecast = F*a;  Y1(:,t)  = forecast;            % mean of 1-step ahead prediction
     forecast = ha(a); Y1(t,j)  = forecast;     % ha - function b1,b2,
     q      =   F*r*F' + v;                           % variance of 1-step ahead prediction
     
     A      =    r*F'/q;   
     e      =   (y(t,:) - forecast); 
     MSE(t,j) =    sum(e.^2); MAD(t,j) = sum(abs(e));
     mt     =    a + A * e; Ct = r - A*q*A';                    
     Ct     =    (Ct+Ct')/2;
     C(:,:,t)=Ct; 
     m(:,t)= mt; % mean variance of posterior at t
     
     %===================== iterated EKF, use mt========================
     %[mt,Ct] = iter_EKF(A,y,t,v,r,a,b1,b2,MSE,MAD,Y1); %=================
     %===================== iterated EKF, use mt========================
 end;
 %Backward smoothing 
  tt1(:,T)  = m(:,T) + chol(C(:,:,T))'*randn(p,1);  % Sample last posterior
 
 for t    =   (T-1):-1:(1)
     
     g    =   Jm(d,m(:,t)); %alpha,
     a    =   fm(d,m(:,t))+ uT(t,:); %alpha,
     
    %g    =   GT(:,:,1);
    %a    =   g*m(:,t) + uT(:,t);    
     
     r    =   g*C(:,:,t)*g' + w;
     b    =   C(:,:,t)*g'/r;
     u    =   C(:,:,t)*g';
    
     Cm   =   C(:,:,t) - u/r*u';  
     tm   =   m(:,t) + b*(tt1(:,t+1)-a); 
    
     if min(diag(Cm)) < 0 
        error('Negative variance found in C matrix');  end;
      
     C(:,:,t)  =  C(:,:,t) - b*(r-C(:,:,t+1))*b';
     m(:,t)    =  m(:,t) + b*(m(:,t+1)-a);    
     tt1(:,t)  =  tm + chol(Cm)'*randn(p,1);
 end;
  
 % Now ad-hoc treatment of start value  
 m0    =  m(:,1);  C0 = C(:,:,1);  
 tt0   =  m0 + chol(C0)'*randn(p,1); 
 
  clear a A e b r Cm tm mt Ct