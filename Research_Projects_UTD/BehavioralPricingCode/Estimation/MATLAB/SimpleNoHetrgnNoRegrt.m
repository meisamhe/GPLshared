%simulate data
clear all; 
global likelihood LogJacobian LogDemandShockLikelihood SE esh;
J  =  150;
T  =  3;
P1          =   randi(20,J,1);
discount    =   randi(2,J,1);
P2          =   P1.*discount;
lambda      =   rand(J,1); %availability
gamma       =   .975; %discount factor
c           =   rand(1,1); %utility of usage
alpha       =   2*rand(1,1); %brand intercept for all J brands [crrently only consider one alpha]
betap       =   rand(1,1);
xi          =   randn(J,2);

% calculate utility
uij1(:,1) =      alpha+c+gamma*c+betap(1,1)*P1 + xi(:,1);
uij2(:,1) =      gamma*(lambda.*((alpha+c)*ones(J,1)+betap(1,1)*P2))+ xi(:,2);
denom1    =      sum([exp(uij1(:,1)) exp(uij2(:,1)) ones(J,1)],2); %xi(:,3)
Sh       =      [exp(uij1(:,1)) exp(uij2(:,1)) ones(J,1)]./repmat(denom1,[1 3]);%xi(:,3)
%simple OLS
y1     =    log(Sh(:,1)./Sh(:,3));
y2     =    log(Sh(:,2)./Sh(:,3));
regresult1   =     regstats(y1, P1,'linear');
regresult1.beta
regresult2   =     regstats(y2/gamma./lambda,P2,'linear');
regresult2.beta
% simple OLS with likelihood
X0        =       [2 1 1]; %for c, betap, alpha
X0        =       zeros(1,3);
%X0        =      [0.9380 0.4532  4.5032];
options=optimset('Display','iter','TolX',10^-30,'TolFun',10^-30);
[x,fval,exitflag,output,grad,hessian]=fminunc('OLSFuncSimpleNoRegNoHetr',X0,options,gamma,J,T,P1,P2,Sh,lambda);
[c betap(1,1) alpha(1,1);x]


%estimate
X0        =       -5*ones(1,3); %for c, betap, alpha
%anonymous function method
km   =    0.001;
ObjectiveFunction        =    @(x)FuncSimpleNoRegNoHetr(x,gamma,J,T,P1,P2,Sh,lambda);
[x,fval,exitflag,output] =     fminsearch(ObjectiveFunction,X0);
%testing fmincon
ub = Inf(size(X0)); 
lb = -ub; 
[x,fval,exitflag,output,lambda1,grad,hessian] =  fmincon('FuncSimpleNoRegNoHetr',X0,[],[],[],[],lb,ub,[],[],gamma,J,T,P1,P2,Sh,lambda);
%use fminunc
X0        =      0*ones(1,3); %for c, betap, alpha
X0        =      [0.26 0.77 3.5];
options=optimset('Display','iter','TolX',10^-30,'TolFun',10^-30);
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncSimpleNoRegNoHetr',X0,options,gamma,J,T,P1,P2,Sh,lambda);
%compare simulate and estimate
[likelihood LogJacobian LogDemandShockLikelihood]
[c betap(1,1);x(1,1:2)]
[alpha(1,1); x(1,3)]
%calculate t-stat
STE    = sqrt(diag(inv(hessian)));
tratio = x'./STE
