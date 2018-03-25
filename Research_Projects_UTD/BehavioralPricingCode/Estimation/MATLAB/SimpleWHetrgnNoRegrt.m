%simulate data
clear all; 
global likelihood likelihoodM hessian2 variance;
J  =  150;
T  =  3;
P1          =   15*rand(J,1);
discount    =   rand(J,1);
P2          =   P1.*discount;
lambda      =   rand(J,1); % availability
gamma       =   .9975; % discount factor
c           =   10*rand(1,1); % utility of usage
alpha       =   3*rand(1,1)*ones(J,1); % brand intercept for all J brands
% segment size
pi1         =   rand(1,1);
% first segment
betap(1,1)       =   -5*rand(1,1);
% second segment
difference       =   -5*rand(1,1);
betap(1,2)       =   betap(1,1)  +  difference;
% unobseved demand shock
xi               =   randn(J,3);
% calculate utility
 % for first segment
uij1(:,1) =      alpha + (c + gamma*c)*ones(J,1) + betap(1,1)*P1 + xi(:,1);
uij2(:,1) =      gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,1)*P2))+ xi(:,2);
denom1    =      sum([exp(uij1(:,1)) exp(uij2(:,1)) exp(xi(:,3))],2);
Sh1       =      [exp(uij1(:,1)) exp(uij2(:,1)) exp(xi(:,3))]./repmat(denom1,[1 3]);
 % for second segment
uij1(:,2) =      alpha + (c + gamma*c)*ones(J,1) + betap(1,2)*P1 + xi(:,1);
uij2(:,2) =      gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,2)*P2))+ xi(:,2);
denom2    =      sum([exp(uij1(:,2)) exp(uij2(:,2)) exp(xi(:,3))],2);
Sh2       =      [exp(uij1(:,2)) exp(uij2(:,2)) exp(xi(:,3))]./repmat(denom2,[1 3]);
% calculate total share
Sh        =      pi1*Sh1   +    (1-pi1)*Sh2;
% estimate
X0  =  rand(1,2);
global MX;
MX  =  zeros(1,3);
global MX0;
MX0 =  rand(1,3);
km   =    0.0001;
% use fmincon
ub = Inf(size(X0)); 
lb = -ub; 
lb(2) = 0; 
ub(2) = 1; 
[x,fval,exitflag,output,lambda,grad,hessian] =  fmincon('FuncSimpleNoRegWHetr',X0,[],[],[],[],lb,ub,[],[],gamma,J,T,P1,P2,Sh,lambda,km);

%compare simulate and estimate
[betap(1,2) pi1;x(1,1)+MX(1,2) x(1,2)]
variance
[c betap(1,1);MX(1, 1:2)]
[alpha(1,1);MX(1,3)]
[likelihood likelihoodM]
%calculate t-stat
STE    = sqrt(diag(inv(hessian)));
tratio = x'./STE;
tratio
STE2=sqrt(diag(inv(hessian2)));
tratio2 = MX'./STE2;
tratio2(1:3,1)
[betap(1,2) pi1 c betap(1,1) alpha(1,1);x(1,1)+MX(1,2) x(1,2) MX(1, 1:2) MX(1,3)]
[tratio' tratio2(1:3,1)']
%----------------------------------------------------------------------
%use fminunc
options=optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncSimpleNoRegWHetr',X0,options,gamma,J,T,P1,P2,Sh,lambda,km);