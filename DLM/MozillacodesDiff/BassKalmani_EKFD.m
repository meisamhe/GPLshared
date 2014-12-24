% Test simple Bass model over real data together with MCMC and parameters
% (only on one add-on)
% estimate
clear all;                              % clear workspace
global Y1 MAD MSE
% MKt6v99 Spec Topics:  Bayesian Dynamic Models, Norris Bruce
% Extended Kalman Filter - Example

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
n = 45;
s= 1; %which one to select
s =n;
pluginlists=linspace(1,n-s+1,n-s+1)+s;
T = zeros(1,n-s+1);
for i=1:n-s+1;
    i
    [num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\FirefoxAddon(VeryLowPriority)\Data\DailyOf100AddOn (Autosaved).xlsx',pluginlists(1,i));
  %  T(1,i)=min(min(checksize(num(:,15)),checksize(num(:,1))),checksize(num(:,8)));
    T(1,i)        = checksize(num(:,1));
    y(i, 1:T(1,i)) = fliplr(num(1:T(1,i),1)')'; %download
    x(i,1:T(1,i)) = ones(p,T(1,i));
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
end;
T = T(1,1);
x=x(1,:);
y = y(1,:);
y = cumsum(y);
uT=diag(beta)*x;
 %clear all;
% load data;   % linear state equation equation - nerlove arrow
 
 %load data2;   % nonlinear state equation equation - nerlove arrow

 jumps      =    1; idx = 0; jp = 0; ndraw=2000;  ndraw0 = 1000; 
 b_         =    zeros(T*p,(ndraw-ndraw0)/jumps);Y1 =[]; MAD =[]; MSE =[];
 b0_        =    zeros(p,(ndraw-ndraw0)/jumps); m0     =  rand(p,1); C0 = eye(p);  
 
 k     =  3; %estimating three parameters
 c_        =    zeros(k+2,(ndraw-ndraw0)/jumps);
 
 % prior 
 b0    =  zeros(k,1); %[0.5; 0.5; .5; .5]; 
 S0Inv =  1.5e-7*eye(k);
 wa0=0.1; wv02=.1;va0=0.1;vv02=.1;
  
 tic;
for i = 1:ndraw
    i
   % Forward Filtering Backward Smoothing Algorithm
  
   [m,C,m0,C0,tt1,tt0]    =     kalffbs(y,F,p,m0,C0,v,w,GT,uT);   %,a,b,alpha
   
    %creating the lag of response
   ttr1=tt1';
   % creating the independant
   ttind1=[[tt0;tt1(1,1:T-1)'].^2 [tt0;tt1(1,1:T-1)'] x']; % drop last value

   %simulate GT = d, beta (System Equation)
    S1   =  inv(((ttind1'*ttind1)/w)+S0Inv);
    b1   =  S1*(((ttind1'*ttr1)/w)+S0Inv*b0);
    bt   =  b1 + chol(S1)'*randn(length(b1),1);
%     bt(1,1)=-1;
%     while ((bt(1,1)<0) || (bt(1,1)>1)); %make sure it complies with theory
%         bt   =  b1 + chol(S1)'*randn(length(b1),1);
%     end;
%    btemp(:,j)=bt; % to use in cross section
    GT=diag(bt(1:2,1));
    uT  = diag(bt(3,1))*x;
        
   %simulate v ~ IG (System Equation)
    wa1  = (wa0+T)/2;
    wv12 = (wv02+(ttr1-ttind1(:,1:2)*bt(1:2,1)-uT')'*(ttr1-ttind1(:,1:2)*bt(1:2,1)-uT'))/2;
    w  =  1/gamrnd(wa1,1/wv12);

    %simulate w ~ IG (Observation Equation)
    va1= (va0+T)/2;
    vv12= (vv02+(y - ttr1')*(y - ttr1')')/2;
    v=1/gamrnd(va1,1/vv12);

   if   (i                >     ndraw0)             %  Discarding burnin
        idx               =     idx + 1; end; 
    
   if   idx              ==     jumps
        idx               =     0;
        jp                =     jp + 1;
     
        b_(:,jp)          =     reshape(tt1',T*p,1); 
        b0_(:,jp)         =     tt0; 
        c_(:,jp)          =     [bt;v;w];
    end;
end;


% Check convergance
plot(c_(1,:))
plot(c_(2,:))
plot(c_(3,:))

% mean parameter estimates
disp('parameter estiamte is (real vs. posterior):');
disp([mean(c_,2)']);

pi_e =( -(c_(2,:)-1)+sqrt((c_(2,:)-1).^2-4*(c_(1,:).*c_(3,:))))./2;
qi_e = c_(2,:)-1 + pi_e;
mi_e = -qi_e./c_(1,:);

disp('Bass Parameter Estiamtes is for p q m are:');
disp([ mean(pi_e,2) mean(qi_e,2) mean(mi_e,2)]);

disp('estimation time is:');
disp(num2str(toc./6));

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
yp =y';
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