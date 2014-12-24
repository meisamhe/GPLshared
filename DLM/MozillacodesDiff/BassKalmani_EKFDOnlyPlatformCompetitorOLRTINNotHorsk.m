% Test simple Bass model over real data together with MCMC and parameters
% (only on one add-on)
% estimate
clear all;                              % clear workspace
global  Y1p MADp MSEp;
% MKt6v99 Spec Topics:  Bayesian Dynamic Models, Norris Bruce
% Extended Kalman Filter - Example
pp =1;
p      =  1;     T = 100;               % p dimension of state vector; T length of series
m0     =  randn(p,1); C0 = eye(p);      % intial state distribution at t=0

%Bass Model parameter simulation
qi1=0.38*rand(1,1);
pi1=0.003*rand(1,1);
mi1=1000*rand(1,1);

F      =  ones(p,1);  GT = diag([-qi1./mi1 (1-pi1+qi1)]); d = diag(GT);     % Observation and systems matrix  
v      =  eye(p)*0.2;       w = 0.5*eye(p);              % known observation and sytem variance


% Simulate Observations  y(t) and states 
tt1    =  5*rand(p,T+1); y = zeros(p,T); x = rand(T,1); F =  eye(p); y=[]; beta=pi1*mi1 ;
ew     =  chol(w)'*randn(p,T);  ev = chol(v)'*randn(p,T); x= ones(p,T); uT=diag(beta)*x;
%a      =  rand(1,5); b = rand(1,5); alpha = [1.2; 1.05];

% LINEAR Goodwill
%for  t =  2:T+1 tt1(1,t) =  d(1)*tt1(1,t-1) + uT(1,t-1) + ew(1,t-1); end;
%for  t =  2:T+1 tt1(2,t) =  d(2)*tt1(2,t-1) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);

% NONLINEAR Goodwill
for  t =  2:T+1 tt1(1,t) =  d(1)*tt1(1,t-1).^2 + d(2)*tt1(1,t-1)+ uT(1,t-1) + ew(1,t-1); end;                
%for  t =  2:T+1 tt1(2,t) =  tt1(2,t-1)- d(2)*tt1(2,t-1)^alpha(2) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);


for  t =  1:T 

 y(:,t)  = tt1(1,t)  +  ev(:,t);
 %[a(1)*tt1(1,t) - a(2)*tt1(2,t) - a(3)*tt1(1,t)^2 +  a(4)*tt1(2,t)^2 + a(5)*tt1(1,t)*tt1(2,t); ...
  %           b(1)*tt1(2,t) - b(2)*tt1(1,t) - b(3)*tt1(2,t)^2 +  b(4)*tt1(1,t)^2 + b(5)*tt1(1,t)*tt1(2,t)] + ev(:,t);

end;
plot(y(1,:)); pause; % plot(y(2,:)); 
tt1s = tt1(:,2:T+1);
%==========================================================================
%============================ Data ======================================
%==========================================================================
% global variable used in linearized form
global yp yc betas se_est ;

% Read platform data inclusion
format long
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\platformdata.xlsx',1);
yp = num(:,20)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
yc = num(:,21)/(10^7); %10 million competitors firefox platform downloads
ych = num(:,22)/(10^7); %10 million chrome firefox platform downloads
yie = num(:,23)/(10^7); %10 million chrome firefox platform downloads
ysaf = num(:,24)/(10^7); %10 million chrome firefox platform downloads
yop = num(:,25)/(10^7); %10 million chrome firefox platform downloads
pT   = size(yp,1); %cut the data of add-ons based on platform data
yusd =num(:,36)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
yrt = num(:,31)/(10^7); %10 million competitors firefox platform downloads
yrt = cumsum(yrt); % since cumulative reviews are important
dwnldaddon =num(:,34)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
crtdAddons =num(:,33)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
crtdAddons = cumsum(crtdAddons); % since cumulative reviews are important
updtdAddons =num(:,31)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
updtdAddons = cumsum(updtdAddons); % since cumulative reviews are important
%dwnldaddon =cumsum(dwnldaddon);

yc =[ych  yie];  % yie yie ysaf yop %yusd.*yrt yrt %dwnldaddon
%yc = [0; yc(1:(size(yc,1)-1))]; % for the moment m0 it is zero
yc = [zeros(1,size(yc,2)); yc(1:(size(yc,1)),:)]; % for the moment m0 it is zero
kp     = 3+size(yc,2); %estimating three parameters (3 bass parameters and 2 competition parameter; we have rating and OL (2) and interaction (1))
%yp  = Mt(2:pT); %simulated data [end of the same file]
ppparam = 0.0003;
npparam =repmat(-0.0002,[size(yc,2) 1]);
qpparam = 0.0131;
pqM0beta = [max(yp) ppparam qpparam npparam']; 
GTp  = diag(pqM0beta);
xp = ones(p,pT);
X0= max(yp);
uTp= ppparam*pqM0beta(1) + pqM0beta(1)*yc*npparam;
options = optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always'); %,'GradObj','on'
% prior parameters for M0
varp    =  2.5e2; % consider high variance (broad prior)
meanp   =  max(yc)+5;
px       =  2;
Lpriorp =  - 0.5*log(2*pi*varp) -   0.5*sum((pqM0beta(1)-meanp).^2/varp);
% tunning parameters
pc        = 0.5; % for the draws of M0
pcorigin  = pc;
postPOld  = Lpriorp;
accepRate =0;


 %clear all;
% load data;   % linear state equation equation - nerlove arrow
 
 %load data2;   % nonlinear state equation equation - nerlove arrow

 jumps      =    5; idx = 0; jp = 0; ndraw=8000;  ndraw0 = 2000; 


  %platform variables
 bp_ =  zeros(pT*p,(ndraw-ndraw0)/jumps);
 b0p_ = zeros(p,(ndraw-ndraw0)/jumps);
 cp_ = zeros(kp+1+1,(ndraw-ndraw0)/jumps); %because v has the size of (n+1)*(n+1): 2 variance, 3 Bass parameters and 1 competition param
 %df_ = zeros((2*n+2)*(2*n+2),(ndraw-ndraw0)/jumps);   % to save full var-covar matrix
 mp=zeros(1,pT);
 Cp = repmat(eye(pp),[1 1 pT]);
 m0p = rand(pp,1);
 C0p = repmat(eye(pp),[1 1]);
 
 %for platform
 errwp_ =0;
 errvp_ = 0;
 MADp=zeros(1,pT); MSEp = zeros(1,pT);
 Y1p = zeros(1,pT); % n for add-ons and 1 for platform
 b0p    =  zeros(kp-1,1); 
 S0Invp =  1.5e-7*eye(kp-1);
 btempp=zeros(kp,1);
 
 
 % prior 
 b0    =  zeros(kp-1,1); %[0.5; 0.5; .5; .5]; 
 S0Inv =  1.5e-7*eye(kp-1);
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
 
 %platform
    T = pT;
    tt1p    =  15*ones(p,pT); 
    vp     =  0.2; % it includes all observation equations of platform state equation
    wp = 0.5;              % known observation and sytem variance
    LL       =    zeros(1,(ndraw-ndraw0)/jumps);   % log likelihood
  cumj=0;  
  
  %check multicollinearity
  temp=regstats(yc(:,1),yc(:,2:size(yc,2)),'linear');
  vif = 1/(1-temp.rsquare)
  
   [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatformCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),yc);   %,a,b,alpha


  
  clc
 tic;
for i = 1:ndraw
    i
    
   % platform EKF calculation
    [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatformCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),yc);   %,a,b,alpha

   
    ttr1=tt1p(1:pT)';
    ttind1p= [tt0p;tt1p(1:pT-1)'];
    %ttindepbuilder(tt0p,tt1p(1:pT),pT,xp) ; % drop last value
   
   %simulate GT = d, beta (System Equation)
   % first simulate M0|p,q,beta erround the mode obtained using fminunc
   X0= pqM0beta;
   alpha     = 0.5;
   accptnrnd = 0.8;
   [x,fval,exitflag,output,grad,hessian]=fminunc('PlatformFullLikelihood',X0,options,yc,ttind1p,ttr1,Lpriorp,[m0p mp(:,1:pT-1)]',wp);
   var        = diag(inv(hessian));
   if (hessian <= 0)
       var = max(var,1e-6);
   end;
   j=1;
%   pc = pcorigin;
   swfac =1; % to facilitate the first round when I am using prior
   while ((alpha < accptnrnd)) %&& (swfac == 1) )
       j=j+1
       wpm =pc*var;
       if (wpm==0)
           wpm = 1e-6;
       end;
       pqM0betaNew   =  x + wpm'*randn(length(x),1);
       postPNew  = -PlatformFullLikelihood(pqM0betaNew,yc,ttind1p,ttr1,Lpriorp,[m0p mp(:,1:pT-1)]',wp); % log of new posterior
       postPOld  = -PlatformFullLikelihood(pqM0beta,yc,ttind1p,ttr1,Lpriorp,[m0p mp(:,1:pT-1)]',wp); % log of old posterior
       alpha     = postPNew - postPOld;
       accptnrnd = log(rand(1,1));
       % M0paramNew = M0param + pc*randn(length(M0Param),1);
   end;
   cumj= cumj+j;
   % check acceptance rate and modify it
   accepRate=i/cumj % because i out of all cumj iterations is accepted until now
   
   pqM0beta   = pqM0betaNew;
    ppparam   = pqM0beta(1);
    qpparam   = pqM0beta(2);
    M0param = pqM0beta(3);
    npparam = pqM0beta(4:size(pqM0beta,2));
    btempp(:,1)=[M0param ppparam qpparam npparam]'; % to use in cross section
   % npparam   = btp(3:(2+size(yc,2)));
    disp('I am here 1')
    GTp(:,:)  =   diag([M0param ppparam qpparam npparam]);
    uTp(1:pT) =   ppparam*M0param + M0param*yc(1:(size(yc,1)-1),:)*npparam';
    disp('I am here 2')
    
    %simulate v ~ IG (System Equation)
    f = -qpparam/M0param*(2*ttind1p.*[m0p mp(:,1:pT-1)]'-[m0p mp(:,1:pT-1)]'.^2) + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam').*ttind1p+ppparam*M0param + yc(1:(size(yc,1)-1),:)*npparam'*M0param;
    ewv = ttr1-f;

    wa1  = (wa0+pT)/2;
    wv12 = (wv02+ewv'*ewv)/2;
    wp  =  1/gamrnd(wa1,1/wv12);

    %simulate w ~ IG (Observation Equation)
    va1= (va0+pT)/2;
    vv12= (vv02+((yp - ttr1)'*(yp - ttr1)))/2;
    evv =yp - ttr1;
    vp =1/gamrnd(va1,1/vv12);

    
    disp('vp and wp is:')
    disp(vp)
    disp(wp)
   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 
    
   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
     
       bp_(1:pT,jp)          =     reshape(tt1p(1:pT)',pT*p,1); 
       b0p_(:,jp)        =     tt0p; 
       cp_(:,jp)         =     [btempp;vp;wp]; %vp will be saved as a matrix
       LL (jp)      = LL(jp)- 0.5*(2*wv12-wv02)/wp.^2 -  0.5*pT*pp*log(2*pi*wp.^2);
       LL (jp)      = LL(jp)- 0.5*(2*vv12-va0)/vp.^2 -   0.5*pT*pp*log(2*pi*vp.^2);
       errwp_  =  errwp_ + ewv;
       errvp_  =  errvp_ + evv;
    end;
end;
toc;

%platform parameters
cpmean_ = mean(cp_,2);
disp('parameter estiamte for [M0 q p n] are (posterior):');
disp(cpmean_');


% check Convergence of Platform
for i=1:7; %because 8 variables
    subplot(2,4, i)
    plot(cp_(i,:))
end;

% check multicollinearity
 temp = regstats(mean(bp_,2),yc(1:1423,:),'linear');
 VIF =1/(1-temp.rsquare)
 



% Check significance of platform
%platformparams = [pip_e;qip_e;mip_e];
i =5;
hpdisp = zeros(10,2);
for i =1:7;
    alldraws = [cp_(i,:)' ];

    result = momentg(alldraws);
    means=[result.pmean]';
    stdevs=[result.pstd]';

    % HPDI
    [n1,n2]=size(cp_(i,:));
     hpdis=zeros(n1,2);
      for ii=1:n1
         hpdis(ii,1:2) = hpdi(cp_(i,:)',.95);
      end
      hpdisp(i,:) = hpdis;
end;

% generate data according to Bass Model

ps = 0.0142;
qs  = 0.0306;
ms  = 22.63;
Mt = zeros(pT+1, 1);
mt =zeros(pT,1);
for t=1:pT;
     mt(t) =  -qs/ms *(Mt(t)).^2 + (qs- ps) *Mt(t) + ps*ms;    
     Mt (t+1) = Mt(t) + mt(t);
end;

% data 
yp  = Mt(2:pT);
pT   = size(yp,1); %cut the data of add-ons based on platform data
GTp  = GT;
xp = ones(p,pT);
uTp= diag(beta)*xp(1:pT);

% test simple bass regression for the platform
ypdiff =diff(yp);
ypindep = [yp(1:(size(yp,1)-1)).^2 yp(1:(size(yp,1)-1)) ones((size(yp,1)-1),1)];
betas=inv(ypindep'*ypindep)*ypindep'*ypdiff;
errors=ypdiff-ypindep*betas;
vcm=(errors'*errors)*inv(ypindep'*ypindep)/(size(yp,1)-1);
se_est=sqrt(diag(vcm));
disp('Parameters of simple Bass regression is (alpha, beta, gamma):')
disp([betas']);
disp('t-stat is:');
disp([betas'./se_est']);
pbmparam = (-betas(2)+sqrt(betas(2).^2-4*betas(1)*betas(3)))/2;
qbmparam = -betas(1)*betas(3)/pbmparam;
mbmparam = -qbmparam/betas(1);
disp('Bass parameters are (p, q, m):')
disp([pbmparam qbmparam mbmparam])

% test simple bass regression for the platform with including competitor
% response
ypdiff =diff(yp);
ypindep = [yp(1:(size(yp,1)-1)).^2 yp(1:(size(yp,1)-1)) yp(1:(size(yp,1)-1)).*yc(1:(size(yc,1)-1)) yc(1:(size(yc,1)-1)) ones((size(yp,1)-1),1)];
betas=inv(ypindep'*ypindep)*ypindep'*ypdiff;
errors=ypdiff-ypindep*betas;
vcm=(errors'*errors)*inv(ypindep'*ypindep)/(size(yp,1)-1);
se_est=sqrt(diag(vcm));
disp('Parameters of simple Bass regression is (alpha, beta, gamma):')
disp([betas']);
disp('t-stat is:');
disp([betas'./se_est']);
nparam = - betas(3);
m0param = betas(4)/nparam;
pbmparam = betas(5)/m0param;
qbmparam = - betas(1)/m0param;
disp('Bass parameters are (p, q, m, c):')
disp([pbmparam qbmparam m0param nparam])
disp('q-p = beta check')
disp([qbmparam - pbmparam  betas(2)])

% Use Horskey and Simon Method
scale =10^9;
yp = num(:,20)/(scale); %K firefox platform download [Scale in order to avoid singularity]
yc = num(:,21)/(scale); %K  competitors firefox platform downloads
ych = num(:,22)/(scale); %K  chrome  platform downloads
yie = num(:,23)/(scale); %K  ie platform downloads
ysaf = num(:,24)/(scale); %K  safari firefox platform downloads
yop = num(:,25)/(scale); %K  opera firefox platform downloads
yc =[ych yie]; %[ych yie ysaf yop];
plot([ych yie ysaf yop]) %zeros(1,size(yc,2));
yc = [ yc(1:(size(yc,1)),:)]; % for the moment m0 it is zero
%yp  = Mt(2:pT); %simulated data [end of the same file]
%X0= max(yp);
X0 =2.485903338959157;
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always'); %'GradObj','on'
[x,fval,exitflag,output,grad,hessian]=fminunc('HorskeySimonMethod',X0,options,yp,yc);
ste = diag(inv(hessian));
ste = sqrt(ste);
disp('Parameters of simple Bass regression is (p, n, q, M0):')
disp([betas' x]);
disp('t-stat is:');
disp([betas'./se_est' x./ste]);

%genetic algorithm to show identification
FitnessFunction = {@HorskeySimonMethod,yp,yc};
numberOfVariables = 1;
[x,fval] = ga(FitnessFunction,numberOfVariables);
[exp(x)]



for i = 1:size(b_,1) plot(b_(i,:));  grid; pause; end;
tt1  =   mean(b_,2); tt1 = reshape(tt1,T,p)'; m0 = mean(b0_,2);

 MAD= mean(MAD); MSE = mean(MSE);
% 1-step ahead forecast
for i=1:p
tx = 1:T; plot(tx,Y1(i,:), '--' ,tx,y(i,:),'-.' );
title('Step Ahead Forecast'); xlabel('Time');
ylabel('y(t)'); legend('Predicted','Actual'); pause;
end;

for i=1:p
% Posterior mean vs Simulated tt1
tx = 1:T; plot(tx,tt1(i,:), '--' ,tx,tt1s(i,:),'-.' );
title('Posterior Mean vs Simulation'); xlabel('Time');
ylabel('alpha(t)'); legend('Posterior','Simulation'); pause;
end;


subplot(2,2,1)
plot(y(1,:))
xlabel('Time'); ylabel('y(t)'); 

subplot(2,2,2)
plot(y(2,:))
xlabel('Time'); ylabel('y(t)'); 

subplot(2,2,4)
plot(tt1s(2,:))
xlabel('Time'); ylabel('tt1'); 



subplot(3,2,3)
plot(b_(51,:))
title('alpha(50)');

subplot(3,2,5)
plot(b_(101,:))
title('alpha(100)');



subplot(3,2,2)
plot(b_(103,:))
title('beta(1)');

subplot(3,2,4)
plot(b_(152,:))
title('beta(50)');

subplot(3,2,6)
plot(b_(202,:))
title('beta(100)');