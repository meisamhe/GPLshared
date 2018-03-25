
% For platform FFBS of BASS model (Modified to only include only platform
% data and not add-on's state equation anymore)


function SumMeanStepAheadForecast = FirefoxAMOOptimizationFunction(x,yp,pp,m0p,C0p,caddon,yc) %,b1,b2,alpha

y = yp;
p = pp;
 T   =  size(y,1);
 pT = T;

yctemp = yc;

% as AMO is monthly data
yctemp(1, 3)   = 0;
yctemp(2:19, 3)=x(1);
yctemp(20:50, 3)=x(2);
yctemp(51:80, 3)=x(3);
yctemp(81:111, 3)=x(4);
yctemp(112:141, 3)=x(5);
yctemp(142:172, 3)=x(6);
yctemp(173:203, 3)=x(7);
yctemp(204:231, 3)=x(8);
yctemp(232:262, 3)=x(9);
yctemp(263:292, 3)=x(10);
yctemp(293:323, 3)=x(11);
yctemp(324:353, 3)=x(12);
yctemp(354:384, 3)=x(13);
yctemp(385:415, 3)=x(14);
yctemp(416:445, 3)=x(15);
yctemp(446:476, 3)=x(16);
yctemp(477:506, 3)=x(17);
yctemp(507:537, 3)=x(18);
yctemp(538:568, 3)=x(19);
yctemp(569:596, 3)=x(20);
yctemp(597:627, 3)=x(21);
yctemp(628:657, 3)=x(22);
yctemp(658:688, 3)=x(23);
yctemp(689:718, 3)=x(24);
yctemp(719:749, 3)=x(25);
yctemp(750:780, 3)=x(26);
yctemp(781:810, 3)=x(27);
yctemp(811:841, 3)=x(28);
yctemp(842:871, 3)=x(29);
yctemp(872:902, 3)=x(30);
yctemp(903:933, 3)=x(31);
yctemp(934:962, 3)=x(32);
yctemp(963:994, 3)=x(33);
yctemp(995:1026, 3)=x(34);
yctemp(1027:1058, 3)=x(35);
yctemp(1059:1084, 3)=x(36);
yctemp(1085:1115, 3)=x(37);
yctemp(1116:1146, 3)=x(38);
yctemp(1147:1176, 3)=x(39);
yctemp(1177:1207, 3)=x(40);
yctemp(1208:1237, 3)=x(41);
yctemp(1238:1268, 3)=x(42);
yctemp(1269:1299, 3)=x(43);
yctemp(1300:1327, 3)=x(44);
yctemp(1328:1358, 3)=x(45);
yctemp(1359:1388, 3)=x(46);
yctemp(1389:1419, 3)=x(47);
yctemp(1420:1424, 3)=x(48);

yctemp(:,3) = yctemp(:,3) - mean(yctemp(:,3)); % demean to make sure there is no multicollinearity


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