
% For platform FFBS of BASS model (Modified to only include only platform
% data and not add-on's state equation anymore)


function SumMeanStepAheadForecast = FirefoxAMOOptimizationFunctionNew(x,yp,pp,m0p,C0p,caddon,yc) %,b1,b2,alpha

y = yp;
p = pp;
T   =  size(y,1);
pT = T;

yctemp = yc;

yctemp(:,3)=x;

%yctemp(:,3) = yctemp(:,3) - mean(yctemp(:,3)); % demean to make sure there is no multicollinearity


m0 = m0p;
C0 = C0p;
M0param = 1.54e-02;
ppparam = 1.76e-03;
qpparam = 1.27e-08;
eta =3.60e-02;
npparam = [-4.91e-05,-5.66e-04,3.42e-05,3.52e-05];
v = 1.44e-02;
w = 1.12e-01;
uTp(1:pT) =   ppparam.*(eta*caddon(1:(size(yctemp,1)-1),:)+M0param) + (eta*caddon(1:(size(yctemp,1)-1),:)+M0param).*(yctemp(1:(size(yctemp,1)-1),:)*npparam');
GT(:,:)  =   diag([M0param ppparam qpparam eta npparam]);
uT =uTp(1:pT)';

% Author:  Norris Bruce... June 2013
% Modified: Meisma Hejazinia ... Dec 2013

OptimizedForecast = zeros(1,T);


 m = repmat(m0,[1 T]); C = double(repmat(C0,[1 1 T]));   C(:,:,1)=C0;  m(:,1)= m0; 
 d= diag(GT(:,:,1));
 mt  =  m0; Ct = C0;      g  = GT;

 % kalman Filtering
 for t      =   1:T

%      if (floor(t/100) == t/100)
%         t
%      end;
     g      =   Jmcm(d,mt,yctemp,caddon,t); %alpha,
     r      =   g*Ct*g' + w;                        % variance of prior at t-1

     a      =   fmcm(d,mt,yctemp,caddon,t) + uT(t,:); %alpha,

     Ja = 1; % for this case there is no state equation for add-ons to use
     h = a; % for this case there is no state equation for add-ons to use 
     F = Ja;   
     forecast = h;
     OptimizedForecast(1,t)  = forecast;    % n for all addons and 1 for platform

     % we use relvar here in order to only select relevant elements of full
     % covar matrix

     q      =   F*r*F' + v(1,1);                         % variance of 1-step ahead prediction
     e = y(t,:) - forecast(1); % for this case there is no state equation for add-ons to use 

     A      =   r*F'*(q\speye(size(q)));

     mt     =    a + A * e; Ct = r - A*q*A';
     Ct     =    (Ct+Ct')/2;
     C(:,:,t)=Ct;
     m(:,t)= mt; % mean variance of posterior at t

     
     %===================== iterated EKF, use mt========================
     %[mt,Ct] = iter_EKF(A,y,t,v,r,a,b1,b2,MSE,MAD,Y1); %=================
     %===================== iterated EKF, use mt========================
 end;
 
 SumMeanStepAheadForecast = -sum(OptimizedForecast);
 disp (-SumMeanStepAheadForecast)