% modified code only high price regret and stock out regret, with modified
% specification of the stock out regret
clear all; 
 
J  = 10000;
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
% high price regret coefficient
alphap = 3*rand(1,1);
% stock out regret coefficient
betar = 5*rand(1,1);
% calculate utility
uij1 =      alpha+(c+gamma*c)+bp*P1+ alphap*lambda.*(P1-P2)+ xi(:,1);
uij2 =      gamma*(lambda.*(alpha+c+bp*P2)+ betar*(ones(J,1)-lambda).*(c+gamma*c))+ xi(:,2);
e1=exp(uij1); e2=exp(uij2);
shares=[e1./(1+e1+e2) e2./(1+e1+e2)];
outside=[1./(1+e1+e2) 1./(1+e1+e2)];

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share

%beta=[alpha c bp];
X1= [ones(J,1) (1+gamma)*ones(J,1) P1 lambda.*(P1-P2) zeros(J,1)];
X2= [gamma*lambda gamma*lambda gamma*lambda.*P2 zeros(J,1) gamma*(ones(J,1)-lambda)*(1+gamma)];


X=[X1 X2]';
Xn=reshape(X,5,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);


%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/J;
se_est=sqrt(diag(vcm));

params=[alpha c bp alphap betar];

betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,1);
c_e     =  betas(1,2);
bp_e    =  betas(1,3);
tt1_e   =  betas(1,5);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([1 5],[1 5])*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/J);
[params;betas(1,1:4) betar_e;betas(1,1:4)./se_est(1,1:4) betar_e./betarSTE]


% regret coefficient
[betar; betas(1,5)/(alpha+c+gamma*c); betas(1,6)/betas(1,3);betarmean]


se_est';