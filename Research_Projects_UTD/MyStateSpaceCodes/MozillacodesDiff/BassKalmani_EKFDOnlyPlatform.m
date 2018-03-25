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
 k     =  5; %estimating three parameters

% Read platform data inclusion
%[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\NewFFXAddOn\platform.xlsx',1);
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\platformdata.xlsx',1);

yp = num(:,20)/(10^7); %10 million firefox platform download [Scale in order to avoid singularity]
%yp = num(:,2)/5/(10^5)/.85; % divided by 5 since each user has 5 add-ons, divide by .85 because only 85% have add-on
yp = fliplr(yp);
yp=cumsum(yp); % to create cumulate
% yc = num(:,21)/(10^7); %10 million competitors firefox platform downloads
ych = num(:,22)/(10^7); %10 million chrome firefox platform downloads
yie = num(:,23)/(10^7); %10 million chrome firefox platform downloads
% ysaf = num(:,24)/(10^7); %10 million chrome firefox platform downloads
% yop = num(:,25)/(10^7); %10 million chrome firefox platform downloads
 yc =[ych yie];
%yp  = Mt(2:pT); %simulated data [end of the same file]
pT   = size(yp,1); %cut the data of add-ons based on platform data
GTp  = GT;
xp = ones(p,pT);
uTp= diag(beta)*xp(1:pT);


 %clear all;
% load data;   % linear state equation equation - nerlove arrow
 
 %load data2;   % nonlinear state equation equation - nerlove arrow

 jumps      =    1; idx = 0; jp = 0; ndraw=4000;  ndraw0 = 2000; 


  %platform variables
 bp_ =  zeros(pT*p,(ndraw-ndraw0)/jumps);
 b0p_ = zeros(p,(ndraw-ndraw0)/jumps);
 cp_ = zeros(k+1+1,(ndraw-ndraw0)/jumps); %because v has the size of (n+1)*(n+1)
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
 b0p    =  zeros(k,1); 
 S0Invp =  1.5e-7*eye(k);
 btempp=zeros(k,1);
 
 
 % prior 
 b0    =  zeros(k,1); %[0.5; 0.5; .5; .5]; 
 S0Inv =  1.5e-7*eye(k);
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
 
 %platform
    T = pT;
    tt1p    =  15*ones(p,pT); 
    vp     =  0.2; % it includes all observation equations of platform state equation
    wp = 0.5;              % known observation and sytem variance
    LL       =    zeros(1,(ndraw-ndraw0)/jumps);   % log likelihood
 
  
 tic;
for i = 1:ndraw
    i
    
   % platform EKF calculation
    [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatform(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT)');   %,a,b,alpha

   
     ttr1=tt1p(1:pT)';
    ttind1p= ttindepbuilder(tt0p,tt1p(1:pT),pT,xp) ; % drop last value
   
   %simulate GT = d, beta (System Equation)
    S1   =  (((ttind1p'*ttind1p)/wp)+S0Inv)\speye(size((((ttind1p'*ttind1p)/wp)+S0Inv)));%inv(((ttind1'*ttind1)/wp)+S0Inv);
    b1   =  S1*(((ttind1p'*ttr1)/wp)+S0Inv*b0p(:,1));
    btp   =  b1 + chol(S1)'*randn(length(b1),1);
    btempp(:,1)=btp; % to use in cross section
    GTp   (:,:)       =   diag(btp(1:2,1));
    uTp(1:pT) =   btp(3,1)*xp(1:pT);  
    
    %simulate v ~ IG (System Equation)
    wa1  = (wa0+pT)/2;
    wv12 = (wv02+(ttr1-ttind1p(1:pT,1:2)*btp(1:2,1)-uTp')'*(ttr1-ttind1p(1:pT,1:2)*btp(1:2,1)-uTp'))/2;
    wp  =  1/gamrnd(wa1,1/wv12);

    %simulate w ~ IG (Observation Equation)
    va1= (va0+pT)/2;
    vv12= (vv02+((yp - ttr1)'*(yp - ttr1)))/2;
    vp =1/gamrnd(va1,1/vv12);

   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 
    
   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
     
       bp_(1:pT,jp)          =     reshape(tt1p(1:pT)',pT*p,1); 
       b0p_(:,jp)        =     tt0p; 
       cp_(:,jp)         =     [btp;vp;wp]; %vp will be saved as a matrix
       LL (jp)      = LL(jp)- (ttr1-ttind1p(1:pT,1:2)*btp(1:2,1)-uTp')'*(ttr1-ttind1p(1:pT,1:2)*btp(1:2,1)-uTp')/wp.^2 - ...
            0.5*pT*pp*log(2*pi*wp.^2);
       LL (jp)      = LL(jp)- (yp - ttr1)'*(yp - ttr1)/vp.^2 - ...
            0.5*pT*pp*log(2*pi*vp.^2);
       errwp_  =  errwp_ + (ttr1-ttind1p(1:pT,1:2)*btp(1:2,1)-uTp');
       errvp_  =  errvp_ + (yp - ttr1);
    end;
end;
toc;

%platform parameters
cpmean_ = mean(cp_,2);
disp('parameter estiamte is (posterior):');
disp(cpmean_');

pip_e =( -(cp_(2,:)-1)+sqrt((cp_(2,:)-1).^2-4*(cp_(1,:).*cp_(3,:))))./2;
qip_e = cp_(2,:)-1 + pip_e;
mip_e = -qip_e./cp_(1,:);

disp('Bass Parameter Estiamte for the platform is:');
disp([mean(pip_e,2) mean(qip_e,2) mean(mip_e,2)]);


% check Convergence of Platform
plot(cp_(3,:))


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
X0= [max(yp)];
%X0 = [0.3397   -0.1835    3.9435    1.6116]; % GA found point
%X0=[log(pi1/(1-pi1))+0.01 bpd+0.01 alphapd+0.01 betard*c+0.01];
%X0=[log(pi1/(1-pi1)) bpd alphapd betard*c]; %starting from correct point
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always','GradObj','off');
[x,fval,exitflag,output,grad,hessian]=fminunc('HorskeySimonMethod',X0,options,yp,yc);
ste = diag(inv(hessian));
ste = sqrt(ste);
disp('Parameters of simple Bass regression is (p, n, q, M0):')
disp([betas' x]);
disp('t-stat is:');
disp([betas'./se_est' x./ste]);

%genetic algorithm to show identification
FitnessFunction = @HorskeySimonMethod;
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