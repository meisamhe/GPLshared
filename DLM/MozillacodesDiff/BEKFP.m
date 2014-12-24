
% For platform FFBS of BASS model
% v should be full covariance matrix, but w should be conditional

function [m,C,m0,C0,tt1,tt0] = BEKFP(y,F,p,m0,C0,v,w,GT,uT,GTtemp,piaitemp,n,tt2,unblncPnl) %,b1,b2,alpha
% Author:  Norris Bruce... June 2013
% Modified: Meisma Hejazinia ... Dec 2013
global Y1p MADp MSEp ;

 T   =  size(y,1);
 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; 
 d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;

 tilold=-1;
 % kalman Filtering
 for t      =   1:T

%      if (floor(t/100) == t/100)
%         t
%      end;
     g      =   Jm(d,mt); %alpha,
     r      =   g*Ct*g' + w;                        % variance of prior at t-1

     a      =   fm(d,mt) + uT(t,:); %alpha,

     
     if size(find(unblncPnl>t+1,1),1)>0
            til = find(unblncPnl>t+1,1)-1;
     else
            til = n;
     end
     

    if (t == T)
       Ja = 1; % for this case there is no state equation for add-ons to use
       h = a; % for this case there is no state equation for add-ons to use 
    else
        if (til == tilold)% to speedup process
            rlvntt=tt2(unblncPnl(1:til,2),t);
            Ja(1) = 1; 
            Ja(2:til+1) = -c1.*rlvntt.^2./(a.^2) + c3;
            h(1) = a;
            h(2:til+1) = c1.*rlvntt.^2./a+  c2.*rlvntt+c3.*a;
         else 
           % we needed t in order to corporate relevant add-ons only
            % make sure the first one is the platform
            Ja  = zeros(til+1,1); %first one for platform and the rest are add-ons
            Ja(1) = 1; % for the real data of ffx add-on observation equation 
            % we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons)      
            % since I am conditioning for n_it-1 then I should use the real data
            c1 = reshape(GTtemp(1,1,unblncPnl(1:til,2)),[til 1]);
            c2 = reshape(GTtemp(2,2,unblncPnl(1:til,2)), [til 1]);
            c3 = piaitemp(unblncPnl(1:til,2))';
            rlvntt=tt2(unblncPnl(1:til,2),t);
            Ja(2:til+1) = -c1.*rlvntt.^2./(a.^2) + c3;
            h  = zeros(til+1,1); %first one for platform and the rest are add-ons
            % make sure the first one is the platform
            h(1) = a; % for the real data of ffx add-on observation equation 
            % we need for moment zero because our data is from moment 1 (which is from state eq. of add-ons) 
            h(2:til+1) = c1.*rlvntt.^2./a+  c2.*rlvntt + c3.*a;
        end;
    end;
     F = Ja;   
     forecast = h;
     tilold =til;

     Y1p(1:til+1,t)  = forecast;    % n for all addons and 1 for platform

     % we use relvar here in order to only select relevant elements of full
     % covar matrix

     q      =   F*r*F' + relvar(v,t, unblncPnl, n, T);                         % variance of 1-step ahead prediction

    if (t == T)
       e = y(t,:) - forecast(1); % for this case there is no state equation for add-ons to use 
    else
        
        e  = zeros(til+1,1); %first one for platform and the rest are add-ons

        e(1) = y(t,:) - forecast(1);
        % first element is tt_0
        e(2:til+1) = tt2(unblncPnl(1:til,2),t+1) - forecast(2:til+1); %because it is about state equation (+1 is because independant state is one more thatn market share of observation equation)
    end;

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
  tt1(:,T)  = m(:,T) + chol(C(:,:,T))'*randn(p,1);  % Sample last posterior
 
 for t    =   (T-1):-1:(1)
%      if (floor(t/100) == t/100)
%         t
%      end;
     
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