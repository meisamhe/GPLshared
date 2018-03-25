clear all;
t=10000;
xbar = 23;
sigmabar = 10;
x = xbar + sigmabar*randn(t,1); %generate random numbers
theta0 = [3;-1];
lb = [-100;0.001];
ub = [100;200];
%conditional
[thetahat,fval,exitflag,output,lambda,grad,hessian] =  fmincon('LLTest',theta0,[],[],[],[],lb,ub,[],[],x);
STE=sqrt(diag(inv(hessian)));
tratio = thetahat./STE
%unconditional
options=optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
[theta,fval,exitflag,output,grad,hessian]=fminunc('LLTest',theta0,options,x);