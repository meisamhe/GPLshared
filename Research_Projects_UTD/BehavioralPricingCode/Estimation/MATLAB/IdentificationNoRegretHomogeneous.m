% identification for no regret and homogeneous case
clear all; 
 
J  = 10000;
T  =  3;
P1          =   ceil(30*rand(J,1));
discount    =   rand(J,1);
P2          =   ceil(P1.*discount);
lambda      =   rand(J,1); %availability
Dur1        =   7+ceil(8*rand(J,1));
Dur2        =   10+abs(ceil(20*rand(J,1)) - Dur1);
cost = ceil(5*rand(J,1));

xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 12*rand(1,1);
c     = 10*rand(1,1);
bp    = -rand(1,1);

%gamma =.975; %discount factor
gamma=1./(1+.0025).^Dur1;

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% calculate utility
uij1 =      alpha.*cost+(0.5*Dur1+gamma.*Dur2).*c+bp*P1+ xi(:,1);
uij2 =      gamma.*(lambda.*(alpha.*cost+0.5*c.*Dur2+bp*P2))+ xi(:,2);
e1=exp(uij1); e2=exp(uij2);
shares=[e1./(1+e1+e2) e2./(1+e1+e2)];
outside=[1./(1+e1+e2) 1./(1+e1+e2)];

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

%beta=[alpha c bp];
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1 ];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2];


X=[X1 X2]';
Xn=reshape(X,3,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);


%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/J;
se_est=sqrt(diag(vcm));

params=[alpha c bp];


[params;betas';betas'./se_est']
se_est';