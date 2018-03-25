%simulate data
clear all; 
global likelihood;
J  =  150;
T  =  3;
P1          =   rand(J,1);
discount    =   rand(J,1);
P2          =   P1.*discount;
lambda      =   rand(J,1); % availability
gamma       =   .975; % discount factor
c           =   rand(1,1); % utility of usage
alpha       =   5*ones(J,1); % brand intercept for all J brands
betap       =   rand(1,1);
alphap      =   rand(1,1); % high price regret
betar       =   rand(1,1); % availability regret
% calculate utility
uij1(:,1) =      alpha + (c + gamma*c)*ones(J,1) + betap(1,1)*P1 + alphap(1,1)*lambda.*(P1-P2);
uij2(:,1) =      gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,1)*P2) + betar(1,1)*(1-lambda).*log(ones(J,1) + exp(alpha+(c+gamma*c)*ones(J,1)+betap(1,1)*P1)));
denom1    =      sum([exp(uij1(:,1)) exp(uij2(:,1)) ones(J,1)],2);
Sh        =      [exp(uij1(:,1))./denom1 exp(uij2(:,1))./denom1 ones(J,1)./denom1];
%estimate
X0        =       0*ones(1,4+1); %for c, betap, alpha
%anonymous function method
km   =    0.001;
ObjectiveFunction        =    @(x)FuncSimpleWRegNoHetr(x,gamma,J,T,P1,P2,Sh,lambda);
ub = Inf(size(X0)); 
lb = -ub; 
%hybridopts = optimset('GradObj','on','Hessian','on');
%[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(ObjectiveFunction,X0,[],[],[],[],lb,ub,[],hybridopts);
%[x,fval,exitflag,output,grad,hessian] =
%[x,FVAL,GRAD,HESSIAN,EXITFLAG,OUTPUT]  =   fmincon(ObjectiveFunction,X0,hybridopts);
[x,fval,exitflag,output] =     fminsearch(ObjectiveFunction,X0);
%use fminunc
options=optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncSimpleWRegNoHetr',X0,options,gamma,J,T,P1,P2,Sh,lambda);
%compare simulate and estimate
likelihood
[c betap(1,1) alphap(1,1) betar(1,1);x(1,1:4)]
[alpha(1,1); x(1,5)]
%calculate t-stat
STE=sqrt(diag(inv(hessian)));
tratio = x'./STE;
tratio(1:4,1)