% Test simple Bass model over real data together with MCMC and parameters
% (Over full Data)
% estimate
clear all;                              % clear workspace
matlabpool close;
matlabpool open;
global Y1 MAD MSE
% MKt6v99 Spec Topics:  Bayesian Dynamic Models, Norris Bruce
% Extended Kalman Filter - Example
diary
diary('commandLine.txt')
diary on

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
n = 52;
pluginlists=linspace(1,n,n)+1;
T = zeros(1,n);
%y=zeros(2500,n);
y=cell(zeros(1,n));
x=cell(zeros(1,n));
uT=cell(zeros(1,n));
parfor i=1:n;
    i
    [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\Data\DailyOf100AddOn (Autosaved).xlsx',pluginlists(1,i));
  %  T(1,i)=min(min(checksize(num(:,15)),checksize(num(:,1))),checksize(num(:,8)));
    T(i)       = checksize(num(:,1));
    [x{i},y{i},uT{i}] = read(num,T(i),beta,p);
    %y(i, 1:T(i)) = fliplr(num(1:T(i),1)')'./1e3; %K download
    %x(i,1:T(i)) = ones(p,T(i));
%  usg(1:T(1,i),i)=fliplr(num(1:T(1,i),8)')'; %usage
%   strm(1:T(1,i),i)= fliplr((num(1:T(1,i),15))')';
%     srch(1:T(1,i),i)=fliplr(num(1:T(1,i),20)')'; %search data
%     version(1:T(1,i),i)= fliplr((num(1:T(1,i),19))')'; %versioning
%     Z(1:T(1,i),i)=fliplr((num(1:T(1,i),26))')'; %Weekend dummy
%     y(1:T(1,i),i)=y(1:T(1,i),i)./1e3; %y=log(y+1)
    %y(1:T(1,i),i)=y(1:T(1,i),i)-Xi*Z(1:T(1,i),i);
  %  usg(1:T(1,i),i)=usg(1:T(1,i),i)./1e6; %usg=log(usg)
  %  X(1:T(1,i),((k-1)*(i-1)+1):(k-1)*i)=[usg(1:T(1,i),i) strm(1:T(1,i),i)  strm(1:T(1,i),i).^2 version(1:T(1,i),i) srch(1:T(1,i),i)];
  %  uT(1:T(1,i),i)   = X(1:T(1,i),((k-1)*(i-1)+1):(k-1)*i)*beta(:,:,i);
  %uT(1:T(1,i),i)=diag(beta)*x(i,1:T(i));
  disp(i);
  y{i} = cumsum(y{i});
  disp('done...');
end;
%T = T(1,1);
%x=x(1,:);
%y = y(1,:);

GT = repmat(GT,[1 1 n]);

% read cross section data to explain heterogeneity
csk=1; %for cross section (due to multicollinearity the last element is removed)
CSSQ =zeros(n,csk); % for alpha_i
CSL  =zeros(n,csk);   % for beta_i
CSIntr=zeros(n,csk);  % for intercept gamma_i
 parfor i=1:n; %due to multicollinearity the first element is removed
   CSSQ(i,1)=1;
   CSL(i,1)=1;
   CSIntr(i,1)=1;
 end;

 %clear all;
% load data;   % linear state equation equation - nerlove arrow
 
 %load data2;   % nonlinear state equation equation - nerlove arrow

 jumps      =    1; idx = 0; jp = 0; ndraw=8000;  ndraw0 = 2000; 
 %b_         =    zeros(max(T)*p,(ndraw-ndraw0)/jumps,n);
 b_=cell(zeros(1,n));
 bi_= cell(zeros(1, (ndraw-ndraw0)/jumps));

 Y1 =[]; MAD =[]; MSE =[];
 b0_        =   cell(zeros(1,n));
 b0i_        =   cell(zeros(1,(ndraw-ndraw0)/jumps));
 %zeros(p,(ndraw-ndraw0)/jumps,n); 
 m0     =  cell(zeros(1,n));%rand(p,1,n); 
 C0     =  cell(zeros(1,n));
 %repmat(eye(p),[1 1 n]);
 parfor i=1:n;
     m0{i}=rand(p,1);
     C0{i}=eye(p);
 end;
 
 k     =  3; %estimating three parameters
 c_        =    cell(zeros(1,n));
 ci_        =    cell(zeros(1,(ndraw-ndraw0)/jumps));
 %zeros(k+2,(ndraw-ndraw0)/jumps,n);
 
 %defnition of variables we will use
 m = cell(zeros(1,n));%zeros(1,2500,n);
 tt1= cell(zeros(1,n));%zeros(1,2500,n);
 %zeros(n,2500);
 C = cell(zeros(1,n));%zeros(1,2500,n);
 %repmat(eye(p),[1 1 2500 n]);
 Y1 = zeros(max(T(:)),n);
 
 %mean of hyper parameters
 m0_       =   cell(zeros(1,n));
 m0i_       =   cell(zeros(1,(ndraw-ndraw0)/jumps));
 %zeros(1,1,n,((ndraw-ndraw0)/jumps));
 C0_ = cell(zeros(1,n));
 C0i_ = cell(zeros(1,(ndraw-ndraw0)/jumps));
 %repmat(eye(p),[1 1 n ((ndraw-ndraw0)/jumps)]);
 LL       =    zeros(1,(ndraw-ndraw0)/jumps);   % log likelihood
 MAD=zeros(max(T(:)),n); MSE=zeros(max(T(:)),n); 
 
 % prior 
 v      =  ones(1,n)*0.2;       w = 0.5*ones(1,n);              % known observation and sytem variance
 b0    =  zeros(k,n); 
 S0Inv =  1.5e-7*eye(k);
 csb0    =  zeros(csk,1);
 CS0Inv = 1.5e-7*eye(csk);
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
 
 %for cross section coefficients, prior and other variables
 alpha=zeros(csk,k); 
 btemp=zeros(k,n);
 d_=zeros(k*csk+k,((ndraw-ndraw0)/jumps)); 
 eta = ones(1,k); etaw=1;
 LLtemp =zeros(1,n);
 tic;
for i = 1:ndraw
    i
   % Forward Filtering Backward Smoothing Algorithm
   sw=0;
   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 

   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
        sw=1;
        fidb_ = fopen('b_parameterHBKFNoPltfrm.txt', 'a');
        fidb0_ = fopen('b0_parameterHBKFNoPltfrm.txt', 'a');
        fidc_ = fopen('c_parameterHBKFNoPltfrm.txt', 'a');
        fidm0_ = fopen('m0_parameterHBKFNoPltfrm.txt', 'a');
        fidC0_ = fopen('C0_parameterHBKFNoPltfrm.txt', 'a');
        fidLL_ = fopen('LL_parameterHBKFNoPltfrm.txt', 'a');
   end;
  parfor j=1:n;
    [m{j},C{j},m0{j},C0{j},tt1{j},tt0]     =     kalffbsFD(y{j},F,p,m0{j},C0{j},v(j),w(j),GT(:,:,j),uT{j}',j);   %,a,b,alpha
   %[m(:,1:T(j),j),C(:,:,1:T(j),j),m0(:,:,j),C0(:,:,j),tt1(j,1:T(j)),tt0]     =     kalffbsFD(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);   %,a,b,alpha
    %creating the lag of response
   ttr1=tt1{j}';
   %tt1(j,1:T(j))';
   % creating the independant
   %ttind1=[[tt0;tt1(1,1:T(j)-1)'].^2 [tt0;tt1(1,1:T(j)-1)'] x(j,1:T(j))']; % drop last value
    %ttind1=[[tt0;tt1(1,1:T(j)-1)'].^2 [tt0;tt1(1,1:T(j)-1)'] x{j}']; % drop last value
    ttind1= ttindepbuilder(tt0,tt1{j},T(j),x{j}) ; % drop last value
   
   %simulate GT = d, beta (System Equation)
    S1   =  inv(((ttind1'*ttind1)/w(j))+S0Inv);
    b1   =  S1*(((ttind1'*ttr1)/w(j))+S0Inv*b0(:,j));
    bt   =  b1 + chol(S1)'*randn(length(b1),1);
    btemp(:,j)=bt; % to use in cross section
%     bt(1,1)=-1;
%     while ((bt(1,1)<0) || (bt(1,1)>1)); %make sure it complies with theory
%         bt   =  b1 + chol(S1)'*randn(length(b1),1);
%     end;
%    btemp(:,j)=bt; % to use in cross section
    GT   (:,:,j)       =   diag(bt(1:2,1));
    %uT(1:T(j),j)=   bt(3,1)*x(j,1:T(j));
    uT{j}=   bt(3,1)*x{j};
   % uT  = diag(bt(3,1))*x;
        
   %simulate v ~ IG (System Equation)
    wa1  = (wa0+T(j))/2;
    wv12 = (wv02+(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}')'*(ttr1-ttind1(1:T(j),1:2)*bt(1:2,1)-uT{j}'))/2;
    w (j)  =  1/gamrnd(wa1,1/wv12);

    %simulate w ~ IG (Observation Equation)
    va1= (va0+T(j))/2;
    vv12= (vv02+(y{j}' - ttr1')*(y{j}' - ttr1')')/2;
    v (j) =1/gamrnd(va1,1/vv12);

   if (sw==1)     
        %b_(1:T(j),jp,j)          =     reshape(tt1(j,1:T(j))',T(j)*p,1); 
        b_{j}          =     reshape(tt1{j}',T(j)*p,1); 
        %fprintf(fidb_, '%19f\n', reshape(tt1{j}',T(j)*p,1));
        %b0_(:,jp,j)         =     tt0;
        b0_{j}         =     tt0; 
       % fprintf(fidb0_, '%19f\n', tt0);
        %c_(:,jp,j)
        c_{j}          =     [bt;v(j);w(j)];
      %  fprintf(fidc_, '%19f\n',[bt;v(j);w(j)]);
       % m0_(:,:,j,jp)
        m0_{j}   =   m0{j};
     %   fprintf(fidm0_, '%19f\n',m0{j});
        %C0_(:,:,j,jp)
        C0_{j}   =  C0{j};
     %   fprintf(fidC0_, '%19f\n',C0{j});
        LLtemp (j)      =  BassLogLL(y{j},F,p,m0{j},C0{j},v(j),w(j),GT(:,:,j),uT{j}',j);
        %BassLogLL(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
        %fprintf(fidLL_, '%19f\n',LL (1,jp));
   end;    
  end;
  if (sw==1) 
     LL (jp)      = LL(jp) + sum(LLtemp);
       %BassLogLL(y(j, 1:T(j)),F,p,m0(:,:,j),C0(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
      fprintf(fidLL_, '%19f\n',LL (jp));
      bi_{jp}          =     b_; 
      b0i_{jp}         =     b0_; 
      ci_{jp}          =     c_;
      m0i_{jp}   =   m0_;
      C0i_{jp}   =  C0_;
  end;
   % estimation of add-on level effects HB, leave unexplained
   % estimation of plug in level effects
    j=1; %for carryover
    S1   =  inv(((CSSQ'*CSSQ)/eta(j))+CS0Inv);
    b1   =  S1*(((CSSQ'*btemp(j,:)')/eta(j))+CS0Inv*csb0);
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btemp(j,:)'-CSSQ*alpha(:,j))'*(btemp(j,:)'-CSSQ*alpha(:,j)))/2;
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=2; % for usage
    S1   =  inv(((CSL'*CSL)/eta(j))+CS0Inv);
    b1   =  S1*(((CSL'*btemp(j,:)')/eta(j))+CS0Inv*csb0);
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btemp(j,:)'-CSL*alpha(:,j))'*(btemp(j,:)'-CSL*alpha(:,j)))/2;
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    j=3; % for star
    S1   =  inv(((CSIntr'*CSIntr)/eta(j))+CS0Inv);
    b1   =  S1*(((CSIntr'*btemp(j,:)')/eta(j))+CS0Inv*csb0);
    alpha(:,j)   =  b1 + chol(S1)'*randn(length(b1),1);
    wa1  = (wa0+n)/2;
    wv12 = (wv02+(btemp(j,:)'-CSIntr*alpha(:,j))'*(btemp(j,:)'-CSIntr*alpha(:,j)))/2;
    eta(j)   =  1/gamrnd(wa1,1/wv12);
    
    % updating prior for cross sectional effects
    for j=1:n;
        b0(:,j)  =   [CSSQ(j,:)*alpha(:,1); CSL(j,:)*alpha(:,2); CSIntr(j,:)*alpha(:,3)];
    end;
    S0Inv    =   diag(eta);
    
    if (sw==1)
         d_(:,jp)          =     [alpha(:);eta'];
         fidd_ = fopen('d_parameterHBKFNoPltfrm.txt', 'a');
         fprintf(fidd_, '%19f\n', d_(:,jp));
         fclose(fidd_);
         fclose(fidb_);
         fclose(fidb0_); 
         fclose(fidc_); 
         fclose(fidm0_);
         fclose(fidC0_);
         fclose(fidLL_); 
    end;
  
end;
disp('estimation time is:');
disp(num2str(toc./6));

% calculating likelihood and DIC
meanLL = mean(LL);
C0_mean = cell(zeros(1, n));
m0_mean = cell(zeros(1, n));
C0_temp = zeros((ndraw-ndraw0)/jumps, n);
m0_temp = zeros((ndraw-ndraw0)/jumps, n);
parfor i=1:(ndraw-ndraw0)/jumps;
    i
   m0_temp(i,:)   =   cell2mat(m0i_{j});
   C0_temp(i,:)   =  cell2mat(C0i_{j}); 
end;
parfor j=1:n;
    j
     m0_mean{j}   =   mean(m0_temp(:,j));
     C0_mean{j}   =   mean(C0_temp(:,j));
end;
%LLmean =0;
parfor  j=1:n;
    j
    LLtemp (j)      =  BassLogLL(y{j},F,p,m0_mean{j},C0_mean{j},v(j),w(j),GT(:,:,j),uT{j}',j);
end;
%LLmean      = LLmean + BassLogLL(y(1:T(j),j),F,p,m0_mean(:,:,j),C0_mean(:,:,j),v(j),w(j),GT(:,:,j),uT(1:T(j),j)',j);
LLmean      =  sum(LLtemp);
Dthetabar   =   -2*LLmean;
Dbar        =   -2*meanLL;
pD          =    Dbar - Dthetabar;
DIC         =    pD + Dbar;
[DIC pD meanLL]

c_temp=zeros(k+2,(ndraw-ndraw0)/jumps,n);
parfor i=1:(ndraw-ndraw0)/jumps;
    i
   c_temp(:,i,:)  =  cell2mat(ci_{i});
end;

ce_=zeros(k+2,52);
pi_e =zeros(n,(ndraw-ndraw0)/jumps);
qi_e =zeros(n,(ndraw-ndraw0)/jumps);
mi_e =zeros(n,(ndraw-ndraw0)/jumps);
pi_em=zeros(1,n);
qi_em=zeros(1,n);
mi_em=zeros(1,n);
parfor i=1:52;
    i
    for j=1:k+2;
       ce_(j,i)=mean(c_temp(j,:,i));
    end;
    pi_e(i,:) =( -(c_temp(2,:,i)-1)+sqrt(abs((c_temp(2,:,i)-1).^2-4*(c_temp(1,:,i).*c_temp(3,:,i)))))./2;
    qi_e(i,:) = c_temp(2,:,i)-1 + pi_e(i,:);
    mi_e(i,:) = -qi_e(i,:)./c_temp(1,:,i);
    pi_em(i)   =   mean(pi_e(i,:));
    qi_em (i)  =   mean(qi_e(i,:));
    mi_em (i)  =   mean(mi_e(i,:));
end;
disp('parameter estiamte is (mean posterior): alpha, beta, gamma, V, W');
disp(mean(ce_,2)');
%disp([d' beta v w; mean(c_,2)']);

disp('Bass Parameter Estiamte is (meanposterior):');
disp([mean(pi_em(:)) mean(qi_em(:)) mean(mi_em(:))]);
sum(qi_em(:)<0)
sum(pi_em(:)<0)
sum(mi_em(:)<0)

diary off

%test convergence
plot(c_temp(3,:,30));

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