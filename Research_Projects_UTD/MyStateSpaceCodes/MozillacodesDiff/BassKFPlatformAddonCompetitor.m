% Test simple Bass model including platform over real data together with MCMC and parameters
% (Over full Data)
% estimate
matlabpool close force local
matlabpool close;
matlabpool open;
clear all;                              % clear workspace
clc
global unblncPnl n  Y1p MADp MSEp tt0temp;
% MKt6v99 Spec Topics:  Bayesian Dynamic Models, Norris Bruce
% Extended Kalman Filter - Example
diary
diary('commandLine.txt')
diary on

%latent masure of platform number of users
pT   = 1790;
tt1p = zeros(1,pT);

p      =  1;     T = 100;               % p dimension of state vector; T length of series
pp     =   1; % for platform size
m0     =  randn(p,1); C0 = eye(p);      % intial state distribution at t=0

%Bass Model parameter simulation
qi1=0.005;
pi1=0.001;
mi1=26;

F      =  ones(p,1);  GT = diag([-qi1./mi1 (1-pi1+qi1)]); d = diag(GT);     % Observation and systems matrix  
v      =  eye(p)*0.005;       w = 0.02*eye(p);              % known observation and sytem variance


% Simulate Observations  y(t) and states 

T = pT;
tt1p    =  15*ones(p,pT);  F =  eye(p);  beta=pi1*mi1 ;
ew      =  chol(w)'*randn(p,T);  ev = chol(v)'*randn(p,T); x= ones(p,T); uT=diag(beta)*x;

% NONLINEAR Goodwill
for  t =  2:T+1 tt1p(1,t) =  d(1)*tt1p(1,t-1).^2 + d(2)*tt1p(1,t-1)+ uT(1,t-1) + ew(1,t-1); end;                
%for  t =  2:T+1 tt1(2,t) =  tt1(2,t-1)- d(2)*tt1(2,t-1)^alpha(2) + uT(2,t-1) + ew(2,t-1); end; plot(tt1);


for  t =  1:T 

 y(:,t)  = tt1p(1,t)  +  ev(:,t);
 %[a(1)*tt1(1,t) - a(2)*tt1(2,t) - a(3)*tt1(1,t)^2 +  a(4)*tt1(2,t)^2 + a(5)*tt1(1,t)*tt1(2,t); ...
  %           b(1)*tt1(2,t) - b(2)*tt1(1,t) - b(3)*tt1(2,t)^2 +  b(4)*tt1(1,t)^2 + b(5)*tt1(1,t)*tt1(2,t)] + ev(:,t);

end;
plot(y(1,:));

pause; % plot(y(2,:)); 
tt0p = tt1p(:,1);
tt1p = tt1p(:,2:T+1);


%==========================================================================
%============================ Data ======================================
%==========================================================================

% global variable used in linearized form
global tt2 GTtemp piaitemp;

% Read platform data inclusion
scale = 10^5;
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\DiffData\platformdata.xlsx',1);
yp = num(:,20)/scale; %10 million firefox platform download [Scale in order to avoid singularity]
yc = num(:,21)/scale; %10 million competitors firefox platform downloads
ych = num(:,22)/scale; %10 million chrome firefox platform downloads
yie = num(:,23)/scale; %10 million chrome firefox platform downloads
ysaf = num(:,24)/scale; %10 million chrome firefox platform downloads
yop = num(:,25)/scale; %10 million chrome firefox platform downloads
yc =[ych yie];  % yie ysaf yop
yc = [zeros(1,size(yc,2)); yc(1:(size(yc,1)),:)]; % for the moment m0 it is zero
kp     =  5; %estimating three parameters (3 bass parameters and 4 competition parameter)
%yp  = Mt(2:pT); %simulated data [end of the same file]
pT   = size(yp,1); %cut the data of add-ons based on platform data
ppparam = 0.0003;
npparam =repmat(-0.0002,[size(yc,2) 1]);
qpparam = 0.0131;
M0param = max(yp); 
GTp  = diag([M0param ppparam qpparam npparam']);
xp = ones(p,pT);
X0= max(yp);
uTp= ppparam*M0param + M0param*yc*npparam;
options = optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always'); %,'GradObj','on'
% prior parameters for M0
varp    =  2.5e2; % consider high variance (broad prior)
meanp   =  max(yc)+5;
px       =  2;
Lpriorp =  - 0.5*log(2*pi*varp) -   0.5*sum((M0param-meanp).^2/varp);
% tunning parameters
pc        = 1e6; % for the draws of M0
pcorigin  = pc;
postPOld  = Lpriorp;
accepRate =0;
cumj    =0;


% % test simple bass regression for the platform
% ypdiff =diff(yp);
% ypindep = [yp(1:(size(yp,1)-1)).^2 yp(1:(size(yp,1)-1)) ones((size(yp,1)-1),1)];
% betas=inv(ypindep'*ypindep)*ypindep'*ypdiff;
% errors=ypdiff-ypindep*betas;
% vcm=(errors'*errors)*inv(ypindep'*ypindep)/(size(yp,1)-1);
% se_est=sqrt(diag(vcm));
% disp('Parameters of simple Bass regression is (alpha, beta, gamma):')
% disp([betas']);
% disp('t-stat is:');
% disp([betas'./se_est']);
% pbmparam = (-betas(2)+sqrt(betas(2).^2-4*betas(1)*betas(3)))/2;
% qbmparam = -betas(1)*betas(3)/pbmparam;
% mbmparam = -qbmparam/betas(1);
% disp('Bass parameters are (p, q, m):')
% disp([pbmparam qbmparam mbmparam])


% Read add-on timely add-on Data
n = 3;
pluginlists=linspace(1,n,n)+1;
T = zeros(1,n);
%y=zeros(2500,n);
y=cell([1 n]);
x=cell([1 n]);
uT=cell([1 n]);
piai =cell([1 n]);
parfor i=1:n;
    i
    [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\Data\DailyOf100AddOn (Autosaved).xlsx',pluginlists(1,i));
  %  T(1,i)=min(min(checksize(num(:,15)),checksize(num(:,1))),checksize(num(:,8)));
    T(i)       = checksize(num(:,1));
    if T(i) > pT;
      T(i) = pT;
    end;
    beta = 0.0001*rand(1,1);
    [x{i},y{i},uT{i},piai{i}] = read(num,T(i),beta,p,tt1p,tt0p,pT,scale);
  disp(i);
  y{i} = cumsum(y{i});
  disp('done...');
end;
GT  = ones(2,2,n);
parfor i=1:n;
    GT(:,:,i) = diag([-10.^(-3)*rand(1,1) rand(1,1)*2]);
end;


 maxy=0;
for i=1:n;
 if(maxy<max(y{i}))
     maxy=max(y{i});
 end;
end;


%include the list of time series to handle unbalanced panel
unblncPnl=sortrows([(pT-T)' linspace(1,n,n)']); % now longest time series comes first
unblncPnl=  [unblncPnl(:,1)+1 unblncPnl(:,2)]; % inorder to start everything from 1 rather than zero


% Read add-on cross section data to explain heterogeneity
% +1 to include platform itself
csk=1; %for cross section (due to multicollinearity the last element is removed)
CSSQ =zeros(n,csk); % for alpha_i
CSL  =zeros(n,csk);   % for beta_i
CSIntr=zeros(n,csk);  % for intercept gamma_i
 parfor i=1:n; %due to multicollinearity the first element is removed
     i
   CSSQ(i,1)=1;
   CSL(i,1)=1;
   CSIntr(i,1)=1;
 end;

 jumps      =    1; idx = 0; jp = 0; ndraw=4000;  ndraw0 = 2000; 
 %b_         =    zeros(max(T)*p,(ndraw-ndraw0)/jumps,n);
 b_=cell([1 n]);
 bi_= cell([1 (ndraw-ndraw0)/jumps]);

 b0_        =   cell([1 n]);
 b0i_        =   cell([1 (ndraw-ndraw0)/jumps]);
 %zeros(p,(ndraw-ndraw0)/jumps,n); 
 m0     =  cell([1 n]);%rand(p,1,n); 
 C0     =  cell([1 n]);
 %repmat(eye(p),[1 1 n]);
 parfor i=1:n;
     i
     m0{i}=rand(p,1);
     C0{i}=eye(p);
 end;
 
 k     =  3; %estimating three parameters
 c_        =    cell([1 n]);
 ci_        =    cell([1 (ndraw-ndraw0)/jumps]);
 %zeros(k+2,(ndraw-ndraw0)/jumps,n);
 
 %platform variables
 bp_ =  zeros(pT*pp,(ndraw-ndraw0)/jumps);
 b0p_ = zeros(pp,(ndraw-ndraw0)/jumps);
 cp_ = zeros(kp+1+1,(ndraw-ndraw0)/jumps); %because v has the size of (n+1)*(n+1)
 %df_ = zeros((2*n+2)*(2*n+2),(ndraw-ndraw0)/jumps);   % to save full var-covar matrix
 mp=zeros(1,pT);
 Cp = repmat(eye(pp),[1 1 pT]);
 m0p = rand(pp,1);
 C0p = repmat(eye(pp),[1 1]);

 %used magic in order to avoid singularity
  vp     =  diag(0.2*rand(1,1)); % it includes all observation equations of platform state equation
  wp = 0.5;              % known observation and sytem variance
 
 %defnition of variables we will use
 m = cell([1 pT n]);%zeros(1,2500,n);
 tt1= cell([1 pT n]);%zeros(1,2500,n);
 tt0= cell([1 n]);%zeros(1,n);
 %zeros(n,2500);
 C = cell([1 pT n]);%zeros(1,2500,n);
 %repmat(eye(p),[1 1 2500 n]);
 errw_ = cell([1 n]);
 errv_ = cell([1 n]);
  
 %repmat(eye(p),[1 1 n ((ndraw-ndraw0)/jumps)]);
 LL       =    zeros(1,(ndraw-ndraw0)/jumps);   % log likelihood
 Y1    = cell([1 n]);
 MAD      = cell([1 n]);
 MSE      = cell([1 n]);
 Y1a      = cell([1 (ndraw-ndraw0)/jumps]);
 MSEa     = cell([1 (ndraw-ndraw0)/jumps]);
 MADa     = cell([1 (ndraw-ndraw0)/jumps]);
 
 %for platform
 errwp_ =0;
 errvp_ = 0;
 MADp=zeros(1,pT); MSEp = zeros(1,pT);
 Y1p = zeros(1,pT); % n for add-ons and 1 for platform
 b0p    =  zeros(kp-1,1); 
 S0Invp =  1.5e-7*eye(kp-1);
 btempp=zeros(kp,1);
 
 %create initial guess for the platform
% [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]    =     kalffbsPInitial(yp(1:pT)',F,pp,m0p(:,:),C0p(:,:),0.2,wp,GTp(:,:),uTp(1:pT)');   %,a,b,alpha
  [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),GTtemp,piaitemp,n,tt2,unblncPnl,yc);   %,a,b,alpha


 % prior 
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
 v      =  ones(1,n)*0.2;       w = 0.5*ones(1,n);              % known observation and sytem variance
 b0    =  zeros(k,n); 
 S0Inv =  1.5e-7*eye(k);
 csb0    =  zeros(csk,1);
 CS0Inv = 1.5e-7*eye(csk);
 
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
 alpha=zeros(csk,k); 
 btemp=zeros(k,n);
 d_=zeros(k*csk+k,((ndraw-ndraw0)/jumps)); 
 eta = ones(1,k); etaw=1;
 LLtemp =zeros(1,n);
 tttemp = zeros(n,pT+1);
  
for i = 1:ndraw 
   tic;
    i
   % Forward Filtering Backward Smoothing Algorithm
   sw=0;
   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 

   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
        sw=1;
        LLtemp =zeros(1,n); % reset to make sure I do not add extra elements
        fidb_ = fopen('b_parameterHBKFNoPltfrm.txt', 'a');
        fidb0_ = fopen('b0_parameterHBKFNoPltfrm.txt', 'a');
        fidc_ = fopen('c_parameterHBKFNoPltfrm.txt', 'a');
        fidLL_ = fopen('LL_parameterHBKFNoPltfrm.txt', 'a');
   end;
   piaitemp = cell2mat(piai);
   
   % add-on ffbs and non state parameter estimation
     parfor j=1:n;
         j
        % run ffbs for each addon
        [m{j},C{j},m0{j},C0{j},tt1{j},tt0{j},Y1{j},MAD{j},MSE{j}]     =     BEKFAddon(y{j},F,p,m0{j},C0{j},v(j),w(j),GT(:,:,j),uT{j}',j,pT,mp(:,1:pT),m0p(:,:),piaitemp(j),tt1p,tt0p);   %,a,b,alpha
        
        %creating the lag of response
        ttr1=tt1{j}';
        
        %simulate v ~ IG (Observation Equation)
        va1= (va0+T(j))/2;
        vv12= (vv02+(y{j}' - ttr1')*(y{j}' - ttr1')')/2;
        v(j) =1/gamrnd(va1,1/vv12);
        
        % prepare for platform EKF 
        tttemp(j,:) = buildmatrix(tt0{j},tt1{j},T(j),pT);

        if (sw==1)  
            b_{j}          =     reshape(tt1{j}',T(j)*p,1); 
            b0_{j}         =     tt0{j}; 
            LLtemp (j)      =  LLtemp (j)-(y{j}' - ttr1')*(y{j}' - ttr1')'/v(j).^2 - ...
            0.5*T(j)*p*log(2*pi*v(j).^2);
            errv_{j}  =  errv_{j}+(y{j}' - ttr1')';
       end;    
     end;
     % save step ahead forecast and MSE and MAD
     if sw ==1 ;
         Y1a{jp}         =     Y1; 
         MADa{jp}         =    MAD; 
         MSEa{jp}         =    MSE; 
     end;
   
   % platform EKF calculation
   tt2 = tttemp;
   GTtemp = GT;   piaitemp = cell2mat(piai);
   tt0temp = tt0;
   %[mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFP(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT)',GTtemp,piaitemp,n,tt2,unblncPnl);   %,a,b,alpha
    [mp(:,1:pT),Cp(:,:,1:pT),m0p(:,:),C0p,tt1p(1:pT),tt0p]     =     BEKFPMCompetitor(yp(1:pT),F,pp,m0p(:,:),C0p(:,:),vp,wp,GTp(:,:),uTp(1:pT),GTtemp,piaitemp,n,tt2,unblncPnl,yc);   %,a,b,alpha

   
    ttr1=tt1p(1:pT)';
   % ttind1p= ttindepbuilder(tt0p,tt1p(1:pT),pT,xp) ; % drop last value
   ttind1p= [tt0p;tt1p(1:pT-1)'];
   
    X0= M0param;
   alphas     = 0.5;
   accptnrnd = 0.8;
   [M0temp,fval,exitflag,output,grad,hessian]=fminunc('HorskeySimonMethodM0',X0,options,yc,ppparam,npparam,qpparam,ttind1p,ttr1,Lpriorp);
   wp        = inv(hessian);
   if (hessian <= 0)
       wp = 1e-6;
   end;
   j=1;
   spmd
      done = false;
      while ~done
        % each lab does some computation in parallel
       j=j+1
       wpm =pc*wp;
       if (wpm==0)
           wpm = 1e-6;
       end;
       M0paramNew   =  M0temp + chol(wpm)'*randn(length(M0temp),1);
       postPNew  = -HorskeySimonMethodM0(M0paramNew,yc,ppparam,npparam,qpparam,ttind1p,ttr1,Lpriorp); % log of new posterior
       postPOld  = -HorskeySimonMethodM0(M0param,yc,ppparam,npparam,qpparam,ttind1p,ttr1,Lpriorp); % log of old posterior
       alphas     = postPNew - postPOld;
       accptnrnd = log(rand(1,1));
       % M0paramNew = M0param + pc*randn(length(M0Param),1); % for random walk
        myDone = ~(alphas < accptnrnd);
        % communicate to see if anyone has found the answer:
        % this ORs together the values of "myDone" from each lab
        done = gop(@or, myDone);
      end
    end
   %while ((alpha < accptnrnd)) %&& (swfac == 1) )    end;
   cumj= cumj+sum(cell2mat(j(1,:)));
   % check acceptance rate and modify it
   accepRate=i/cumj % because i out of all cumj iterations is accepted until now
   
   M0param   = sum((cell2mat(accptnrnd(1,:))< cell2mat(alphas(1,:))).*cell2mat(M0paramNew(1,:)))/sum(cell2mat(accptnrnd(1,:))< cell2mat(alphas(1,:)));
   %M0paramNew;
   % recreating MCMC linear equation to recover (p,q,n)
    ttindtemp = [-ttind1p.^2/M0param+ttind1p M0param-ttind1p yc(1:(size(yc,1)-1),:).*repmat((M0param-ttind1p),[1 size(yc,2)])];
    ttrtemp = ttr1;
    ttr1    = ttr1 - ttind1p;
    ttind1p = ttindtemp;
   
   %simulate GT = d, beta (System Equation)
    S1   =  (((ttind1p'*ttind1p)/wp)+S0Invp)\speye(size((((ttind1p'*ttind1p)/wp)+S0Invp)));%inv(((ttind1'*ttind1)/wp)+S0Inv);
    b1   =  S1*(((ttind1p'*ttr1)/wp)+S0Invp*b0p(:,1));
    btp   =  b1 + chol(S1)'*randn(length(b1),1);
    btempp(:,1)=[M0param btp']'; % to use in cross section
    qpparam   = btp(1);
    ppparam   = btp(2);
    npparam   = btp(3:(2+size(yc,2)));
    GTp(:,:)  =   diag([M0param ppparam qpparam npparam']);
    uTp(1:pT) =   ppparam*M0param + M0param*yc(1:(size(yc,1)-1),:)*npparam;
    
    %simulate v ~ IG (System Equation)
    wa1  = (wa0+pT)/2;
    wv12 = (wv02+(ttr1-ttind1p(1:pT,1:3)*btp(1:3,1))'*(ttr1-ttind1p(1:pT,1:3)*btp(1:3,1)))/2;
    ewv = (ttr1-ttind1p(1:pT,1:3)*btp(1:3,1));
    wp  =  1/gamrnd(wa1,1/wv12);

    %simulate w ~ IG (Observation Equation)
    %simulate w ~ IG (Observation Equation)
    ttr1 = ttrtemp;
    va1= (va0+pT)/2;
    vv12= (vv02+((yp - ttr1)'*(yp - ttr1)))/2;
    evv =yp - ttr1;
    vp =1/gamrnd(va1,1/vv12);
    
    % save platform parameters
    if (sw==1)     
        bp_(1:pT,jp)          =     reshape(tt1p(1:pT)',pT*p,1); 
        b0p_(:,jp)        =     tt0p; 
        cp_(:,jp)         =     [btempp;vp;wp]; %vp will be saved as a matrix
        LL (jp)      = LL(jp)- 0.5*(2*wv12-wv02)/wp -  0.5*pT*pp*log(2*pi*wp);
        LL (jp)      = LL(jp)- 0.5*(2*vv12-va0)/vp -   0.5*pT*pp*log(2*pi*vp);
        errwp_  =  errwp_ + ewv;
        errvp_  =  errvp_ + evv;
   end;
   
    
    % simulate observation equation parameter (which is state equation for
    % add-ons
    parfor j=1:n;
        ttr1=tt1{j}';
        ttind1= addonttindepbuilder(tt0{j},tt1{j},T(j),x{j},tt1p,pT) ; % drop last value
        %ttr1 = ttr1 - ttind1(:,3);
        %ttind1 = ttind1(:,1:2);

       %simulate GT = d, beta (System Equation)
       S1   =  (((ttind1'*ttind1)/w(j))+S0Inv)\speye(size((((ttind1'*ttind1)/w(j))+S0Inv)));%inv(((ttind1'*ttind1)/w(j))+S0Inv);
       b1   =  S1*(((ttind1'*ttr1)/w(j))+S0Inv*b0(:,j));
       m = 2;
       while (m>1) || (m<0) || ~isreal(m)
            bt   =  b1 + chol(S1)'*randn(length(b1),1);
            m = (-(bt(2)-1)-sqrt((bt(2)-1)^2-4*bt(1)*bt(3)))/(2*bt(1));
            if m<0 || m>1 % select the solution that conforms the theory
                m = (-(bt(2)-1)+sqrt((bt(2)-1)^2-4*bt(1)*bt(3)))/(2*bt(1));
            end;
            m
       end;
        pparam = bt(3)/m;
        qparam = -bt(1)*m;
        
        %btemp(:,j)=bt; % to use in cross section
        btemp(:,j) = [m;pparam;qparam];
        disp([m;pparam;qparam])
    
        GT   (:,:,j)       =   diag(bt(1:2,1));
        %GT   (:,:,j)       =   diag([-bt(1) (1+bt(1)-bt(2))]);


        uT{j} =   bt(3,1)*x{j}.*[tt0p tt1p(pT-T(j)+1:pT-1)]; %uT includes relevant market size in it
        %uT{j} =   bt(2)*x{j}.*[tt0p tt1p(pT-T(j)+1:pT-1)];
        piai{j} = bt(3,1); % to use in the hap function
        %piai{j} = bt(2);
        
        %simulate w ~ IG (System Equation)
        wa1  = (wa0+T(j))/2;
        Swv12 = (wv02+(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}')'*(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}'))/2;
        %wv12 = (wv02+(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1))'*(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)))/2;
        w (j)  =  1/gamrnd(wa1,1/wv12);
        
        if (sw==1);
           %c_{j}          =     [bt;v(j);w(j)];
           c_{j}          =     [btemp(:,j) ;v(j);w(j)];
           LLtemp (j)      =  LLtemp (j)- (ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}')'*(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}')/w (j).^2 - ...
            0.5*T(j)*p*log(2*pi*w(j).^2);
           errw_{j}  =  errw_{j}+(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}');
          
        end;
    end;
     if (sw==1) 
          LL (jp)      = LL(jp) + sum(LLtemp);
          fprintf(fidLL_, '%19f\n',LL (jp));
          bi_{jp}          =     b_; 
          b0i_{jp}         =     b0_; 
          ci_{jp}          =     c_;
     end;
     
     %redifinition of v so that it is used in ffbs properly
     %vp = diag([vp v]);    
   
   % estimation of add-on level effects HB, leave unexplained
   % estimation of plug in level effects
    j=1; %for carryover
    S1   =  (((CSSQ'*CSSQ)/eta(j))+CS0Inv)\speye(size((((CSSQ'*CSSQ)/eta(j))+CS0Inv)));% inv(((CSSQ'*CSSQ)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSSQ'*[btemp(j,:)]')/eta(j))+CS0Inv*csb0); %btempp(j,1)
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+([btemp(j,:)]'-CSSQ*alpha(:,j))'*([btemp(j,:)]'-CSSQ*alpha(:,j)))/2; %btempp(j,1)  btempp(j,1)
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=2; % for usage
    S1   =  (((CSL'*CSL)/eta(j))+CS0Inv)\speye(size((((CSL'*CSL)/eta(j))+CS0Inv))); %inv(((CSL'*CSL)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSL'*[btemp(j,:)]')/eta(j))+CS0Inv*csb0); %btempp(j,1)
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+([btemp(j,:)]'-CSL*alpha(:,j))'*([btemp(j,:)]'-CSL*alpha(:,j)))/2; %btempp(j,1) btempp(j,1)
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=3; % for star
    S1   =  (((CSIntr'*CSIntr)/eta(j))+CS0Inv)\speye(size((((CSIntr'*CSIntr)/eta(j))+CS0Inv)));% inv(((CSIntr'*CSIntr)/eta(j))+CS0Inv); 
    b1   =  S1*(((CSIntr'*[btemp(j,:)]')/eta(j))+CS0Inv*csb0); % btempp(j,1)
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+([btemp(j,:)]'-CSIntr*alpha(:,j))'*([btemp(j,:)]'-CSIntr*alpha(:,j)))/2; %btempp(j,1) btempp(j,1)
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    % updating prior for cross sectional effects
    for j=1:n;
        %b0(:,j)  =   [CSSQ(j,:)*alpha(:,1); CSL(j,:)*alpha(:,2); CSIntr(j,:)*alpha(:,3)];
        alphaparam = CSSQ(j,:)*alpha(:,1);
        pparam     = CSL(j,:)*alpha(:,2);
        qparam     = CSIntr(j,:)*alpha(:,3);
        b0(:,j)  =   [-qparam./alphaparam;... 
                      1-pparam+qparam;...
                      pparam.*alphaparam];
    end;
    % for platform
   % b0p(:,1) =  [CSSQ(n+1,:)*alpha(:,1); CSL(n+1,:)*alpha(:,2); CSIntr(n+1,:)*alpha(:,3)];
    
    S0Inv    =   diag(eta);
    
    if (sw==1)
         d_(:,jp)          =     [alpha(:);eta'];
         fidd_ = fopen('d_parameterHBKFNoPltfrm.txt', 'a');
         fprintf(fidd_, '%19f\n', d_(:,jp));
         fclose(fidd_);
         fclose(fidb_);
         fclose(fidb0_); 
         fclose(fidc_); 
         fclose(fidLL_); 
    end;
  toc;
end;
% disp('estimation time is:');
% disp(num2str(toc./60));

%platform parameters
cpmean_ = mean(cp_,2);
disp('parameter estiamte for [M0 q p n] are (posterior):');
disp(cpmean_');


% add-on parameters
c_temp=zeros(k+2,(ndraw-ndraw0)/jumps,n);
parfor i=1:(ndraw-ndraw0)/jumps;
    i
    c_temp(:,i,:)  =  cell2mat(ci_{i});
end;

ce_=zeros(k+2,n);
pi_e =zeros(n,(ndraw-ndraw0)/jumps);
qi_e =zeros(n,(ndraw-ndraw0)/jumps);
mi_e =zeros(n,(ndraw-ndraw0)/jumps);
pi_em=zeros(1,n);
qi_em=zeros(1,n);
mi_em=zeros(1,n);
parfor i=1:n;
    i
    for j=1:k+2;
       ce_(j,i)=mean(c_temp(j,:,i));
    end;
    pi_e(i,:) =( -(c_temp(2,:,i)-1)+sqrt((c_temp(2,:,i)-1).^2-4*(c_temp(1,:,i).*c_temp(3,:,i))))./2;
    qi_e(i,:) = c_temp(2,:,i)-1 + pi_e(i,:);
    mi_e(i,:) = -qi_e(i,:)./c_temp(1,:,i);
    pi_em(i)   =   mean(pi_e(i,:));
    qi_em (i)  =   mean(qi_e(i,:));
    mi_em (i)  =   mean(mi_e(i,:));
end;
disp('parameter estiamte is (mean posterior): alpha, beta, gamma, V, W');
disp(mean(ce_,2)');

disp('Bass Parameter Estiamte is (meanposterior):');
disp([mean(pi_em(:)) mean(qi_em(:)) mean(mi_em(:))]);

disp('number of Parameters lower than 0 for q, p, m is as follows respectively:');
disp([sum(qi_em(:)<0) sum(pi_em(:)<0) sum(mi_em(:)<0)]);

% calculating likelihood and DIC
meanLL = mean(LL);

LLmean =0;
parfor  j=1:n;
    j
    % first calculate mean of errors
    errw_{j} = errw_{j}/jp;
    errv_{j} = errv_{j}/jp;
    LLtemp (j)      =  - errw_{j}'*errw_{j}/ce_(k+2,j).^2 - ...
            0.5*T(j)*p*log(2*pi*ce_(k+2,j).^2) - errv_{j}'*errv_{j}/ce_(k+1,j).^2 - ...
        0.5*T(j)*p*log(2*pi*ce_(k+1,j).^2);
end;

LLmean     = LLmean + sum(LLtemp);
LLmean     = LLmean- errwp_'*errwp_/cpmean_(k+2).^2 - ...
            0.5*pT*pp*log(2*pi*cpmean_(k+2).^2);
LLmean     = LLmean- errvp_'*errvp_/cpmean_(k+1).^2 - ...
            0.5*pT*pp*log(2*pi*cpmean_(k+1).^2);

% including the platform into the likelihood function
Dthetabar   =   -2*LLmean;
Dbar        =   -2*meanLL;
pD          =    Dbar - Dthetabar;
DIC         =    pD + Dbar;
disp('DIC pD meanLL is:');
disp([DIC pD meanLL])

diary off


% test sign of (p+q/m(t-1)) and m(t-1)-n(t-1)

%test convergence
plot(c_temp(3,:,1));

% check Convergence of Platform
plot(cp_(1,:))

pi_e =( -(c_(2,:)-1)+sqrt((c_(2,:)-1).^2-4*(c_(1,:).*c_(3,:))))./2;
qi_e = c_(2,:)-1 + pi_e;
mi_e = -qi_e./c_(1,:);

disp('Bass Parameter Estiamte is (real vs. posterior):');
disp([pi1 qi1 mi1; mean(pi_e,2) mean(qi_e,2) mean(mi_e,2)]);


for i = 1:size(b_,1) plot(b_(i,:));  grid; pause; end;
tt1  =   mean(b_,2); tt1 = reshape(tt1,T,p)'; m0 = mean(m0_,2);

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