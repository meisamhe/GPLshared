% Test simple Bass model over simulated data including MCMC and parameters
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
%==========================================================================
%==========================================================================
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

disp('parameter estiamte is (real vs. posterior):');
disp([d' beta v w; mean(c_,2)']);

pi_e =( -(c_(2,:)-1)+sqrt((c_(2,:)-1).^2-4*(c_(1,:).*c_(3,:))))./2;
qi_e = c_(2,:)-1 + pi_e;
mi_e = -qi_e./c_(1,:);

disp('Bass Parameter Estiamte is (real vs. posterior):');
disp([pi1 qi1 mi1; mean(pi_e,2) mean(qi_e,2) mean(mi_e,2)]);

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