clear all; 
 
J  = 150;
T  =  3;
P1          =   randi(20,J,1);
discount    =   randi(2,J,1);
P2          =   P1.*discount;
lambda      =   rand(J,1); %availability


xi          =   randn(J,2);

% alpha = 2;
% c     = 0.5; 
% bp    = -0.2;
alpha  = 2*rand(1,1);
c     = rand(1,1);
bp    = rand(1,1);

gamma =.975; %discount factor

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% calculate utility
uij1 =      alpha+(c+gamma*c)+bp*P1+ xi(:,1);
uij2 =      gamma*(lambda.*(alpha+c+bp*P2))+ xi(:,2);
e1=exp(uij1); e2=exp(uij2);
shares=[e1./(1+e1+e2) e2./(1+e1+e2)];
outside=[1./(1+e1+e2) 1./(1+e1+e2)];

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

%beta=[alpha c bp];
X1= [ones(J,1) (1+gamma)*ones(J,1) P1 ];
X2= [gamma*lambda gamma*lambda gamma*lambda.*P2];


X=[X1 X2]';
Xn=reshape(X,3,J*2);
Xn=Xn' %stack X's
Yn=log(shares_n./outside_n);


%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/J;
se_est=sqrt(diag(vcm));

params=[alpha c bp];


[params;betas';betas'./se_est']
se_est';