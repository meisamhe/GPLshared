% Test simple Bass model including platform over real data together with MCMC and parameters
% this is the corrected version that uses metrapolist hasting to
% avoid imaginary number, and does not use approximation of EKF
% (Over full Data)
% estimate
matlabpool close force local
matlabpool close;
matlabpool open;
clear all;                              % clear workspace
clc
global  Y1p MADp MSEp;
parallelsize   = 6;
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
tt1    =  5*rand(p,T+1); y = zeros(p,T); xp = rand(T,1); F =  eye(p); y=[]; beta=pi1*mi1 ;
ew     =  chol(w)'*randn(p,T);  ev = chol(v)'*randn(p,T); xp= ones(p,T); uT=diag(beta)*xp;
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
r     = 4; % since here it is OL, Rating, version, weekend
k     =  3+r; %estimating three parameters for Bass, OL, ST, interaction
jumps      =    1; idx = 0; jp = 0; ndraw=4000;  ndraw0 = 2000; 
 n = 3;  %number of add-ons
 
% Read platform data inclusion
format long
scale = 10^7;
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\platformdata.xlsx',1);
yp = num(:,20)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
yc = num(:,21)/scale; %10 million competitors firefox platform downloads
ych = num(:,22)/scale; %10 million chrome firefox platform downloads
yie = num(:,23)/scale; %10 million chrome firefox platform downloads
ysaf = num(:,24)/scale; %10 million chrome firefox platform downloads
yop = num(:,25)/scale; %10 million chrome firefox platform downloads
pT   = size(yp,1); %cut the data of add-ons based on platform data
yusd =num(:,36)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
yrt = num(:,31)/scale; %10 million competitors firefox platform downloads
yrt = cumsum(yrt); % since cumulative reviews are important
dwnldaddon =num(:,34)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
crtdAddons =num(:,33)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
crtdAddons = cumsum(crtdAddons); % since cumulative reviews are important
updtdAddons =num(:,31)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
updtdAddons = cumsum(updtdAddons); % since cumulative reviews are important
%dwnldaddon =cumsum(dwnldaddon);

yc =[ych  yie];  % yie yie ysaf yop %yusd.*yrt yrt %dwnldaddon
yc = [zeros(1,size(yc,2)); yc(1:(size(yc,1)),:)]; % for the moment m0 it is zero
kp     = 3+size(yc,2); %estimating three parameters (3 bass parameters and 2 competition parameter; we have rating and OL (2) and interaction (1))
%yp  = Mt(2:pT); %simulated data [end of the same file]
ppparam = 0.0003;
npparam =repmat(-0.0002,[size(yc,2) 1]);
qpparam = 0.0131;
pqM0beta = [max(yp) ppparam qpparam npparam']; 
GTp  = diag(pqM0beta);
uTp= ppparam*pqM0beta(1) + pqM0beta(1)*yc*npparam;
options = optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always'); %,'GradObj','on'
% tunning parameters
pc        = 0.7; % for the draws of M0
accepRate =0;
pqM0betaNewtemp  = zeros(parallelsize,kp);

  %platform variables
 bp_ =  zeros(pT*p,(ndraw-ndraw0)/jumps);
 b0p_ = zeros(p,(ndraw-ndraw0)/jumps);
 cp_ = zeros(kp+1+1,(ndraw-ndraw0)/jumps); %because v has the size of (n+1)*(n+1): 2 variance, 3 Bass parameters and 1 competition param
 %df_ = zeros((2*n+2)*(2*n+2),(ndraw-ndraw0)/jumps);   % to save full var-covar matrix
 mp=zeros(1,pT);
 Cp = repmat(eye(pp),[1 1 pT]);
 m0p = ones(pp,1);
 C0p = repmat(eye(pp),[1 1]);
 
  %platform
  T = pT;
  tt1p    =  15*ones(p,pT); 
  vp     =  0.2; % it includes all observation equations of platform state equation
  wp = 0.5;              % known observation and sytem variance
  LL       =    zeros(1,(ndraw-ndraw0)/jumps);   % log likelihood
  cumj=0; 
 
 %for platform
 errwp_ =0;
 errvp_ = 0;
 MADp=zeros(1,pT); MSEp = zeros(1,pT);
 Y1p = zeros(1,pT); % n for add-ons and 1 for platform
 b0p    =  0.1*ones(1,kp); 
 S0p =  1.5e7;
 btempp=zeros(kp,1);
 
 
 
  % prior 
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
 v      =  ones(1,n)*0.2;       w = 0.5*ones(1,n);              % known observation and sytem variance
 b0    =  zeros(k,n); 
 S0Inv =  1.5e-7*eye(k);
 
%prepare latent measure to initiate data of add-ons
[mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatformCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),yc);   %,a,b,alpha
ttr1=tt1p(1:pT)';
ttind1p= [tt0p;tt1p(1:pT-1)'];

%simulate GT = d, beta (System Equation)
% first simulate M0|p,q,beta erround the mode obtained using fminunc
X0= pqM0beta;
alpha     = 0.5;
accptnrnd = 0.8;
[modepltfrm,fval,exitflag,output,grad,hessian]=fminunc('PlatformFullLikelihood',X0,options,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p);
var        = diag(inv(hessian));
var = max(var,1e-6);
j=1;
while ((alpha < accptnrnd)) %&& (swfac == 1) )
   j=j+1
   wpm =pc*var;
   wpm = max(wpm, 1e-6);
   pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
   postPNew  = -PlatformFullLikelihood(pqM0betaNew,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p); % log of new posterior
   postPOld  = -PlatformFullLikelihood(pqM0beta,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p); % log of old posterior
   alpha     = postPNew - postPOld;
   accptnrnd = log(rand(1,1));
   % M0paramNew = M0param + pc*randn(length(M0Param),1);
end;
cumj= cumj+j;
% check acceptance rate and modify it
accepRate=1/cumj % because i out of all cumj iterations is accepted until now

pqM0beta   = pqM0betaNew;
ppparam   = pqM0beta(1);
qpparam   = pqM0beta(2);
M0param = pqM0beta(3);
npparam = pqM0beta(4:size(pqM0beta,2));
btempp(:,1)=[M0param ppparam qpparam npparam]'; % to use in cross section
% npparam   = btp(3:(2+size(yc,2)));
disp ('platform parameters ar M0p pp qp np are:');
disp(btempp(:,1));
GTp(:,:)  =   diag([M0param ppparam qpparam npparam]);
uTp(1:pT) =   ppparam*M0param + M0param*(yc(1:(size(yc,1)-1),:)*npparam');

%simulate v ~ IG (System Equation)
f = -qpparam/M0param*(2*ttind1p.*[m0p mp(:,1:pT-1)]'-[m0p mp(:,1:pT-1)]'.^2) + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam').*ttind1p+ppparam*M0param + (yc(1:(size(yc,1)-1),:)*npparam')*M0param;
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
disp([vp; wp])


 % addon section:
 % Read only to test
 pluginlists=linspace(1,n,n)+1;
 T = zeros(1,n);
 y=cell([1 n]);
 xaddon=cell([1 n]);
 uT=cell([1 n]);
 piai =cell([1 n]);
 ol =cell([1 n]);
 st =cell([1 n]);
 ver =cell([1 n]);
 wkend =cell([1 n]);
 olst =cell([1 n]);
 % postPOld = cell([1 n]);
 pqalphaaddon =  cell([1 n]);
 for j=1:n
     pqalphaaddon{j}   = [0.0284; 0.2; 0.01;-1e-8.*ones(r,1)];
 end;
 GT  = ones(2+r,2+r,n);
alphabetaapram = cell([1 n]);
parfor j=1:n;
     paparam     = pqalphaaddon{j}(1);
     qaparam     = pqalphaaddon{j}(2);
     alphaaparam = pqalphaaddon{j}(3); % since alpha is between zero and 1
     betaaparam  = pqalphaaddon{j}(4:r+3);
     alphabetaapram{j} =alphaaparam*betaaparam;
     alphap{j} =alphaaparam*paparam;
     bt = [-qaparam/alphaaparam;(1-paparam+qaparam);-betaaparam];
     GT   (:,:,j)       =   diag(bt);
end;
parfor i=1:n;
    i
    [numaddon,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\Data\DailyOf100AddOn (Autosaved).xlsx',pluginlists(1,i));
  %  T(1,i)=min(min(checksize(num(:,15)),checksize(num(:,1))),checksize(num(:,8)));
    T(i)       = min([checksize(numaddon(:,17)) checksize(numaddon(:,1)) checksize(numaddon(:,8)) checksize(numaddon(:,19)) checksize(numaddon(:,26))]);
    if T(i) > pT;
      T(i) = pT;
    end;
   % beta = 0.0001*rand(1,1);
    [xaddon{i},y{i},uT{i},piai{i},ol{i},st{i},ver{i},wkend{i}] = readOLRT(numaddon,T(i),alphabetaapram{i},alphap{i},p,tt1p,tt0p,pT,scale); %int{i}
    olst{i} =[ol{i} st{i} ver{i} wkend{i}]; % int{i}
  disp(i);
  y{i} = cumsum(y{i});
  disp('done...');
end;
% Read add-on cross section data to explain heterogeneity
% +1 to include platform itself
csk=1; %for cross section (due to multicollinearity the last element is removed)
CSSQ =zeros(n,csk); % for alpha_i %+1
CSL  =zeros(n,csk);   % for beta_i %+1
CSIntr=zeros(n,csk);  % for intercept gamma_i %+1
CSOL =zeros(n,csk);
CSST =zeros(n,csk);
CSINT =zeros(n,csk);
 parfor i=1:n; %due to multicollinearity the first element is removed %+1
     i
   CSSQ(i,1)=1;
   CSL(i,1)=1;
   CSIntr(i,1)=1;
   CSOL(i,1) =1;
   CSST(i,1) =1;
   CSINT(i,1) =1;
 end;
 b_=cell([1 n]);
 bi_= cell([1 (ndraw-ndraw0)/jumps]);

 b0_        =   cell([1 n]);
 b0i_        =   cell([1 (ndraw-ndraw0)/jumps]);
 addonaccptcntr = cell([1 n]); % keep track of counter of acceptance for addons
 %zeros(p,(ndraw-ndraw0)/jumps,n); 
 m0     =  cell([1 n]);%rand(p,1,n); 
 C0     =  cell([1 n]);
 %repmat(eye(p),[1 1 n]);
 parfor i=1:n;
     i
     m0{i}=rand(p,1);
     C0{i}=eye(p);
     addonaccptcntr{i} = 0;
 end;
 
 c_        =    cell([1 n]);
 ci_        =    cell([1 (ndraw-ndraw0)/jumps]);
  %defnition of variables we will use
 m = cell([1 pT n]);
 tt1= cell([1 pT n]);
 tt0= cell([1 n]);
 C = cell([1 pT n]);
 errw_ = cell([1 n]);
 errv_ = cell([1 n]);
 Y1    = cell([1 n]);
 MAD      = cell([1 n]);
 MSE      = cell([1 n]);
 Y1a      = cell([1 (ndraw-ndraw0)/jumps]);
 MSEa     = cell([1 (ndraw-ndraw0)/jumps]);
 MADa     = cell([1 (ndraw-ndraw0)/jumps]);
 
 % define error component in order to find conditional distribution for
 % variances
 ee = zeros(pT,2*n+2); % for errors of all observation and system equation of all addons + platform
 eetemp = zeros(pT,n+2);
 eetemp1 = zeros(pT,n);
 
 % for the default value (used random generator to avoid signularity)
  parfor i=1:n;
    errw_{i} =0;
    errv_{i} = 0;
  end;
  
  %for cross section coefficients, prior and other variables
  %prior
 csb0    =  zeros(csk,1);
 CS0Inv = 1.5e-7*eye(csk);
 alphacs=zeros(csk,k); 
 btemp=zeros(k,n);
 dcs_=zeros(k*csk+k,((ndraw-ndraw0)/jumps)); 
 etacs = ones(1,k); etaw=1;
 LLtemp =zeros(1,n);
 tttempcs = zeros(n,pT+1);
 
  % for metrapolist hasting
 pcaddon =38e-4; %tunning parameter
  
  
%check multicolinearity (inside) for addon
 i =3;
 temp = regstats(olst{i}(:,1),olst{i}(:,2:size(olst{i},2)),'linear');
 VIF =1/(1-temp.rsquare)
  temp = regstats(olst{i}(:,3),olst{i}(:,1:2),'linear');
 VIF =1/(1-temp.rsquare)
  
  
  
  %check multicollinearity for platform
  temp=regstats(yc(:,1),yc(:,2:size(yc,2)),'linear');
  vif = 1/(1-temp.rsquare)

  
  clc
 
for i = 1284:ndraw
    tic;
    i
    sw=0;
   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 

   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
        sw=1;
        LLtempcs =zeros(1,n); % reset to make sure I do not add extra elements
   end;

   % platform EKF calculation
    [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMOnlyPlatformCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),yc);   %,a,b,alpha

   
    ttr1=tt1p(1:pT)';
    ttind1p= [tt0p;tt1p(1:pT-1)'];
    
   %simulate GT = d, beta (System Equation)
   % first simulate M0|p,q,beta erround the mode obtained using fminunc
   X0= pqM0beta;
   alpha     = 0.5;
   accptnrnd = 0.8;
   [modepltfrm,fval,exitflag,output,grad,hessian]=fminunc('PlatformFullLikelihood',X0,options,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p);
   var        = diag(inv(hessian));
   var = max(var,1e-6);
   j=1;
   while ((alpha < accptnrnd)) %&& (swfac == 1) )
       j=j+1
       wpm =pc*var;
       wpm = max(wpm, 1e-6);
       pqM0betaNew   =  modepltfrm + wpm'*randn(length(modepltfrm),1);
       postPNew  = -PlatformFullLikelihood(pqM0betaNew,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p); % log of new posterior
       postPOld  = -PlatformFullLikelihood(pqM0beta,yc,ttind1p,ttr1,[m0p mp(:,1:pT-1)]',wp,S0p,b0p); % log of old posterior
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
    disp ('platform parameters ar M0p pp qp np are:');
    disp(btempp(:,1));
    GTp(:,:)  =   diag([M0param ppparam qpparam npparam]);
    uTp(1:pT) =   ppparam*M0param + M0param*(yc(1:(size(yc,1)-1),:)*npparam');
    
    %simulate v ~ IG (System Equation)
    f = -qpparam/M0param*(2*ttind1p.*[m0p mp(:,1:pT-1)]'-[m0p mp(:,1:pT-1)]'.^2) + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam').*ttind1p+ppparam*M0param + (yc(1:(size(yc,1)-1),:)*npparam')*M0param;
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
    disp([vp; wp])
    
    if (sw==1)     
        bp_(1:pT,jp)          =     reshape(tt1p(1:pT)',pT*p,1); 
        b0p_(:,jp)        =     tt0p; 
        cp_(:,jp)         =     [btempp;vp;wp]; %vp will be saved as a matrix
        LL (jp)      = LL(jp)- 0.5*(ewv'*ewv)/wp -  0.5*pT*pp*log(2*pi*wp);
        LL (jp)      = LL(jp)- 0.5*(ewv'*ewv)/vp -   0.5*pT*pp*log(2*pi*vp);
        errwp_  =  errwp_ + ewv;
        errvp_  =  errvp_ + evv;
   end;
    piaitemp = cell2mat(piai);  
   % simulate observation equation parameter (which is state equation for
    % add-ons
    parfor j=1:n;
         disp(j)
        % run ffbs for each addon
        [m{j},C{j},m0{j},C0{j},tt1{j},tt0{j},Y1{j},MAD{j},MSE{j}]     =     BEKFAddon(y{j},F,p,m0{j},C0{j},v(j),w(j),GT(:,:,j),uT{j}',j,pT,mp(:,1:pT),m0p(:,:),piaitemp(j),tt1p,tt0p,olst{j});   %,a,b,alpha
        
        %creating the lag of response
        ttr1addon=tt1{j}';
        
        %simulate v ~ IG (Observation Equation)
        va1= (va0+T(j))/2;
        vv12= (vv02+(y{j}' - ttr1addon')*(y{j}' - ttr1addon')')/2;
        v(j) =1/gamrnd(va1,1/vv12);
        
        % prepare for platform EKF      
        ttind1addon= addonttindepbuilderOLST(tt0{j},tt1{j},T(j),xaddon{j},tt1p,tt0p,pT,m{j},m0{j},olst{j}) ; % drop last value

        % draw full parameters(System Equation)
        alphaaddon     = 0.5;
        accptnrndaddon = 0.8;
        ratekeepraddon =0;
        while (alphaaddon < accptnrndaddon) 
           ratekeepraddon=ratekeepraddon+1
           pqalphaaddonNew = pqalphaaddon{j} + pcaddon*randn(length(pqalphaaddon{j}),1);
           postPNewaddon  = MHLLSROLRT(pqalphaaddonNew,ttind1addon,ttr1addon,T(j),w(j),olst{j},b0(:,j),etacs); % log of new posterior
           postPOldaddon  = MHLLSROLRT(pqalphaaddon{j},ttind1addon,ttr1addon,T(j),w(j),olst{j},b0(:,j),etacs); % log of old posterior
           alphaaddon    = postPNewaddon - postPOldaddon;
           accptnrndaddon = log(rand(1,1));
        end;
        % check acceptance rate and modify it
        addonaccptcntr{j} = addonaccptcntr{j} + ratekeepraddon;
        accepRateaddon=i/addonaccptcntr{j} % because i out of all cumj iterations is accepted until now
        disp(accepRateaddon)

        pqalphaaddon{j}   = pqalphaaddonNew;  
        pparamaddon     = pqalphaaddon{j}(1);
        qparamaddon     = pqalphaaddon{j}(2);
        alphaMaddon = pqalphaaddon{j}(3);
%         if (pqalphaaddon{j}(3)>1e2)
%             alphaMaddon = 1;
%         else
%              alphaMaddon = exp(pqalphaaddon{j}(3))/(1+exp(pqalphaaddon{j}(3))); % since alpha is between zero and 1
%         end;
       betaaddon  = pqalphaaddon{j}(4:size(olst{j},2)+3);
       
       btaddon = [-qparamaddon/alphaMaddon;(1-pparamaddon+qparamaddon);-betaaddon];
        
        
        btempaddon(:,j) = [alphaMaddon;pparamaddon;qparamaddon;betaaddon];
        disp([alphaMaddon pparamaddon qparamaddon betaaddon'])
        %disp([v(j) w(j)])
    
        GT   (:,:,j)       =   diag(btaddon(:,1));


        uT{j} =   pparamaddon*alphaMaddon*xaddon{j}.*[tt0p tt1p(pT-T(j)+1:pT-1)]+alphaMaddon.*(olst{j}*betaaddon)'.*xaddon{j}.*[tt0p tt1p(pT-T(j)+1:pT-1)]; %uT includes relevant market size in it
        piai{j} = pparamaddon*alphaMaddon; % to use in the hap function
        
        
        %simulate w ~ IG (System Equation)
        pqalphatempaddon = [-qparamaddon/alphaMaddon;(1-pparamaddon+qparamaddon);pparamaddon*alphaMaddon;-betaaddon;alphaMaddon.*betaaddon]
        wa1  = (wa0+T(j))/2;
        wv12 = (wv02+(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon)'*(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon))/2;
        w (j)  =  1/gamrnd(wa1,1/wv12);
        
        if (sw==1);
             b_{j}          =     reshape(tt1{j}',T(j)*p,1); 
            b0_{j}         =     tt0{j}; 
            LLtemp (j)      =  LLtemp (j)-0.5*(y{j}' - ttr1addon')*(y{j}' - ttr1addon')'/v(j).^2 - ...
            0.5*T(j)*p*log(2*pi*v(j).^2);
            errv_{j}  =  errv_{j}+(y{j}' - ttr1addon')';
           c_{j}          =     [btempaddon(:,j) ;v(j);w(j)];
           LLtemp (j)      =  LLtemp (j)- 0.5*(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon)'*(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon)/w (j) - ...
            0.5*T(j)*p*log(2*pi*w(j));
           errw_{j}  =  errw_{j}+(ttr1addon-ttind1addon(1:T(j),:)*pqalphatempaddon);
          
        end;
    end;
     if (sw==1) 
          Y1a{jp}         =     Y1; 
          MADa{jp}         =    MAD; 
          MSEa{jp}         =    MSE; 
         
          LL (jp)      = LL(jp) + sum(LLtemp);
          bi_{jp}          =     b_; 
          b0i_{jp}         =     b0_; 
          ci_{jp}          =     c_;
     end;   
     
      % estimation of add-on level effects HB, leave unexplained
   % estimation of plug in level effects
    j=1; %for carryover
    S1   =  (((CSSQ'*CSSQ)/etacs(j))+CS0Inv)\speye(size((((CSSQ'*CSSQ)/etacs(j))+CS0Inv)));% inv(((CSSQ'*CSSQ)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSSQ'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSSQ*alphacs(:,j))'*(btempaddon(j,:)'-CSSQ*alphacs(:,j)))/2; %btempp(j,1)  btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=2; % for usage
    S1   =  (((CSL'*CSL)/etacs(j))+CS0Inv)\speye(size((((CSL'*CSL)/etacs(j))+CS0Inv))); %inv(((CSL'*CSL)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSL'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSL*alphacs(:,j))'*(btempaddon(j,:)'-CSL*alphacs(:,j)))/2; %btempp(j,1) btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=3; % for star
    S1   =  (((CSIntr'*CSIntr)/etacs(j))+CS0Inv)\speye(size((((CSIntr'*CSIntr)/etacs(j))+CS0Inv)));% inv(((CSIntr'*CSIntr)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSIntr'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); % btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSIntr*alphacs(:,j))'*(btempaddon(j,:)'-CSIntr*alphacs(:,j)))/2; %btempp(j,1) btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
      % estimation of plug in level effects
    j=4; %for carryover
    S1   =  (((CSOL'*CSOL)/etacs(j))+CS0Inv)\speye(size((((CSOL'*CSOL)/etacs(j))+CS0Inv)));% inv(((CSSQ'*CSSQ)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSOL'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSOL*alphacs(:,j))'*(btempaddon(j,:)'-CSOL*alphacs(:,j)))/2; %btempp(j,1)  btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=5; % for usage
    S1   =  (((CSST'*CSST)/etacs(j))+CS0Inv)\speye(size((((CSST'*CSST)/etacs(j))+CS0Inv))); %inv(((CSL'*CSL)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSST'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSST*alphacs(:,j))'*(btempaddon(j,:)'-CSST*alphacs(:,j)))/2; %btempp(j,1) btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=6; % for version
    S1   =  (((CSST'*CSST)/etacs(j))+CS0Inv)\speye(size((((CSST'*CSST)/etacs(j))+CS0Inv))); %inv(((CSL'*CSL)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSST'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSST*alphacs(:,j))'*(btempaddon(j,:)'-CSST*alphacs(:,j)))/2; %btempp(j,1) btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
    
     j=7; % for version
    S1   =  (((CSST'*CSST)/etacs(j))+CS0Inv)\speye(size((((CSST'*CSST)/etacs(j))+CS0Inv))); %inv(((CSL'*CSL)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSST'*btempaddon(j,:)')/etacs(j))+CS0Inv*csb0); %btempp(j,1)
    alphacs(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btempaddon(j,:)'-CSST*alphacs(:,j))'*(btempaddon(j,:)'-CSST*alphacs(:,j)))/2; %btempp(j,1) btempp(j,1)
    etacs(j)   =  1/gamrnd(wa1,1/wv12);
   
   
    % updating prior for cross sectional effects
    for j=1:n;
        %b0(:,j)  =   [CSSQ(j,:)*alpha(:,1); CSL(j,:)*alpha(:,2); CSIntr(j,:)*alpha(:,3)];
        alphaparamtemp = CSSQ(j,:)*alphacs(:,1);
        pparamtemp     = CSL(j,:)*alphacs(:,2);
        qparamtemp     = CSIntr(j,:)*alphacs(:,3);
        betaparamtemp  = [CSOL(j,:)*alphacs(4); CSST(j,:)*alphacs(5);CSST(j,:)*alphacs(6);CSST(j,:)*alphacs(7)];%; CSINT(j,:)*alpha(6)];
        b0(:,j)   = [alphaparamtemp;pparamtemp;qparamtemp;betaparamtemp];
    end;
    if (sw==1)
         dcs_(:,jp)          =     [alphacs(:);etacs'];
    end;
    
toc;
end;


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
disp('multicolinearity indicator for platform is:');
temp = regstats(mean(bp_,2),yc(1:1423,:),'linear');
VIF =1/(1-temp.rsquare)


% Check significance of platform
%platformparams = [pip_e;qip_e;mip_e];
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


% add-on parameters
c_temp=zeros(k+2,(ndraw-ndraw0)/jumps,n);
parfor i=1:(ndraw-ndraw0)/jumps;
    i;
    c_temp(:,i,:)  =  cell2mat(ci_{i});
end;
parfor i=1:n;
    i;
    for j=1:k+2;
       ce_(j,i)=mean(c_temp(j,:,i));
    end;
end;
cemeani_ = mean(ce_,2);
disp('parameter estiamte is (mean posterior): alpha, p, q, V, W');
disp(mean(ce_,2)');

disp('number of Parameters lower than 0 for alpha, p, q is as follows respectively:');
disp([sum(ce_(1,:)<0) sum(ce_(2,:)<0) sum(ce_(3,:)<0)]);

% calculating likelihood and DIC
meanLL = mean(LL);

LLmean =0;
parfor  j=1:n;
    j;
    % first calculate mean of errors
    errw_{j} = errw_{j}/((ndraw-ndraw0)/jumps);
    errv_{j} = errv_{j}/((ndraw-ndraw0)/jumps);
    LLtemp (j)      =  - 0.5*errw_{j}'*errw_{j}/ce_(k+2,j) - ...
            0.5*T(j)*p*log(2*pi*ce_(k+2,j).^2) - 0.5* errv_{j}'*errv_{j}/ce_(k+1,j) - ...
        0.5*T(j)*p*log(2*pi*ce_(k+1,j));
end;
% consier platform
LLmean     = LLmean + sum(LLtemp);
LLmean     = LLmean- 0.5*(errwp_'*errwp_)/cpmean_(k+2) - ...
            0.5*pT*pp*log(2*pi*cpmean_(k+2));
LLmean     = LLmean- 0.5*errvp_'*errvp_/cpmean_(k+1) - ...
            0.5*pT*pp*log(2*pi*cpmean_(k+1));

% including the platform into the likelihood function
Dthetabar   =   -2*LLmean;
Dbar        =   -2*meanLL;
pD          =    Dbar - Dthetabar;
DIC         =    pD + Dbar;
disp('DIC pD meanLL is:');
disp([DIC pD meanLL])


%test convergence
plot(c_temp(1,:,3));

% check Convergence of addons and platform
j =3; %addon j
for i=1:9; %because 6 variables
    subplot(3,3, i)
    plot(c_temp(i,:,j))
end;
 

% check Convergence of Platform
plot(cp_(3,:))
% check Convergence of Platform
for i=1:7; %because 8 variables
    subplot(2,4, i)
    plot(cp_(i,:))
end;


% check convergance of HB
% check Convergence of Platform
for i=1:10; %because 8 variables
    subplot(2,5, i)
    plot(dcs_(i,:))
end;


% calculate confidence interval for add-on i
%confidence interval calculation
i =3;
alldraws = [c_temp(:,:,i)' ];

result = momentg(alldraws);
means=[result.pmean]';
stdevs=[result.pstd]';

% HPDI
[n1,n2]=size(c_temp(:,:,i));
 hpdis=zeros(n1,2);
  for ii=1:n1
     hpdis(ii,1:2) = hpdi(c_temp(ii,:,i)',.95);
  end
  hpdis
  
% multicollinearity check for the add-on i: recover latent measure of add-ons to check
i=3;
bitemp_ = zeros(size(y{i},1),(ndraw-ndraw0)/jumps);
bi0temp_= zeros(1,(ndraw-ndraw0)/jumps);
for j=1:(ndraw-ndraw0)/jumps
    bitemp_(:,j)=bi_{j}{i};
    bi0temp_(j)=b0i_{j}{i};
end;
bitempmean_ = mean(bitemp_,2);
b0tempmean_ = mean(bi0temp_,2);


%check multicolinearity (inside)
%olst{i} =[ol{i} st{i}]; % int{i}
 temp = regstats(olst{i}(:,1),olst{i}(:,2),'linear');
 VIF =1/(1-temp.rsquare)

% check multicollinearity (outside)
 temp = regstats(olst{i}(:,2),[olst{i}(:,1) [b0tempmean_;bitempmean_(1:size(bitempmean_,1)-1,:)]./[mean(b0p_);mean(bp_((pT-T(i)+1:pT-1),:),2)]],'linear');
 VIF =1/(1-temp.rsquare)
 temp = regstats(olst{i}(:,1),[olst{i}(:,2) [b0tempmean_;bitempmean_(1:size(bitempmean_,1)-1,:)]./[mean(b0p_);mean(bp_((pT-T(i)+1:pT-1),:),2)]],'linear');
 VIF =1/(1-temp.rsquare)
  temp = regstats( [b0tempmean_;bitempmean_(1:size(bitempmean_,1)-1,:)]./[mean(b0p_);mean(bp_((pT-T(i)+1:pT-1),:),2)],olst{i},'linear');
 VIF =1/(1-temp.rsquare)


% check the fit of add-on
% subplot(2,2, 1);
% plot ([bitempmean_(1:size(bitempmean_,1),:)]);
% subplot(2,2, 2);
% plot (y{i})
% subplot(2,2, 3);
% plot (y{i},[bitempmean_(1:size(bitempmean_,1),:)]);
tx = 1:T(i); plot(tx',[bitempmean_(1:size(bitempmean_,1),:)], '--' ,tx',y{i},'-.' );
title('Real vs Estimated'); xlabel('Time');
ylabel('Aggregate Download'); legend('Real','Estimate');

% check fit of platform
% subplot(2,2, 1);
% plot (mean(bp_,2));
% subplot(2,2, 2);
% plot (yp)
% subplot(2,2, 3);
%plot (yp,mean(bp_,2));
tx = 1:pT; plot(tx',mean(bp_,2), '--' ,tx',yp,'-.' );
title('Real vs Estimated'); xlabel('Time');
ylabel('Aggregate Usage'); legend('Real','Estimate');















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
% yp  = Mt(2:pT);
% pT   = size(yp,1); %cut the data of add-ons based on platform data
% GTp  = GT;
% xp = ones(p,pT);
% uTp= diag(beta)*xp(1:pT);

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
[xp,fval,exitflag,output,grad,hessian]=fminunc('HorskeySimonMethod',X0,options,yp,yc);
ste = diag(inv(hessian));
ste = sqrt(ste);
disp('Parameters of simple Bass regression is (p, n, q, M0):')
disp([betas' xp]);
disp('t-stat is:');
disp([betas'./se_est' xp./ste]);

%genetic algorithm to show identification
FitnessFunction = {@HorskeySimonMethod,yp,yc};
numberOfVariables = 1;
[xp,fval] = ga(FitnessFunction,numberOfVariables);
[exp(xp)]



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