
function [m,C,m0,C0,tt1] = kalffbsMeasurement(y,F,p,m0,C0,v,w,GT,uT)
% Author:  Meisam Hejazi Nia... July 2014
global Y1 MAD MSE

 T   =  length(y); m = repmat(m0,[1 T+1]); C = double(repmat(C0,[1 1 T+1]));   C(:,:,1)=C0;  m(:,1)= m0;
 mt  =  m0; Ct = C0;    Y1 = [];   g  = GT(2);  MAD=[]; MSE=[];   % mt, Ct mean and variance of prior at t-1

 
 % here we have time varying F
 
 % kalman Filtering
 for t      =   1:T
     r      =   g*Ct*g' + w;                          % variance of prior at t-1
     a      =   g*mt + uT(t);                                 % mean of prior at t-1
     
     %pool forecasts
     
     forecast = F(t,:)*a;  Y1(t,:)  = forecast;       % mean of 1-step ahead prediction
     q      =   F(t,:)'*r*F(t,:) + v;                           % variance of 1-step ahead prediction
     
     A      =    r*F(t,:)*(q\speye(size(q)));                     % fraction of variance of state to variance of data
     e      =   (y(t,:) - forecast)'; 
     MSE(t,:) =    e.^2; MAD(t,:) = abs(e);
     mt     =    a + A * e; Ct = r - A*q*A'; 
     if (Ct <0)
         Ct=0.0001;
     end;
          
     Ct     =    (Ct+Ct')/2; C(:,:,t+1)=Ct;  m(:,t+1)= mt; % mean variance of posterior at t

 end;
 
 
 
 %Backward smoothing 
  tt1(:,T+1)  = m(:,T+1) + chol(C(:,:,T+1))'*randn(p,1);  % Sample last posterior
 
 for t    =   (T):-1:(1)
    % g    =   GT(:,:,1);
     a    =   g*m(:,t) + uT(t); 
     
     r    =   g*C(:,:,t)*g' + w;
     b    =   C(:,:,t)*g'*inv(r);
     u    =   C(:,:,t)*g';
    
     Cm   =   C(:,:,t) - u*inv(r)*u';  
     tm   =   m(:,t) + b*(tt1(:,t+1)-a); 
    
     if min(diag(Cm)) < 0 
        error('Negative variance found in C matrix');  end;
      
     C(:,:,t)  =  C(:,:,t) - b*(r-C(:,:,t+1))*b';
     m(:,t)    =  m(:,t) + b*(m(:,t+1)-a);    
     tt1(:,t)  =  tm + chol(Cm)'*randn(p,1);
 end;
 
  C0   =  C(:,:,1) ;  m0 =  m(:,1);
 
  clear a A e b r Cm tm mt Ct