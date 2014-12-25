function LL = BassLogLLAddon(y,F,p,m0,C0,v,w,GT,uT,j)


%  Norris Bruce... Aug. 2008.
%  Meisam Hejazinia .... Modified Dec 2013

global Y1 MAD MSE 
 T   =  size(y,1);
 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;% Y1 = [];  MAD=[]; MSE=[];   % mt, Ct mean and variance of prior at t-1

 
 for t    =   1:T
     
     g      =   Jmaddon(d,mt,t,T); %alpha,
     r      =   g*Ct*g' + w;                          % variance of prior at t-1
     a      =   fmaddon(d,mt,t,T) + uT(t,:); %alpha,
     
     F      =   Ja();             %b1,b2,a             % Ja Jacobian, EKF
     
     forecast =  ha(a); Y1(t,j)  = forecast;     % mean of 1-step ahead prediction
    
     q      =   F*r*F' + v;                           % variance of 1-step ahead prediction
         
     
     A      =    r*F'/q;   
     e      =   (y(t) - forecast);      
     
    MSE(t,j) =    sum(e.^2); MAD(t,j) = sum(abs(e));
     if min(diag(r)) < 0 
       r
     error('Negative variance found in r matrix');  end;
      
     sv   =   sv + 0.5*(e'*e /q+ log(det(q)) ); 
     mt     =    a + A * e; Ct = r - A*q*A';                  
     Ct     =    (Ct+Ct')/2; C(:,:,t+1)=Ct;  m(:,t+1)= mt; % mean variance of posterior at t
     
      %===================== iterated EKF, use mt========================
     %[mt,Ct] = iter_EKF(A,y,t,v,r,a,b1,b2,MSE,MAD,Y1); %=================
     %===================== iterated EKF, use mt========================
     
 end;
 
  LL      =  -(sv + 0.5*T*p*log(2*pi)); 
  clear a A e r forecast mt Ct F q e;   