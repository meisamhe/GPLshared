%simulate data
clear all; 
J=150;
T=3;
P1=rand(J,1);
discount=rand(J,1);
P2=P1.*discount;
lambda=rand(J,1); %availability
gamma=.975; %discount factor
c=rand(1,1); %utility of usage
alpha=rand(J,1); %brand intercept for all J brands
betap=rand(1,2);
betap(1,2)=betap(1,1)+rand(1,1);
alphap(1,1)=rand(1,1);
alphap(1,2)=alphap(1,1)+rand(1,1);
betar=rand(1,2);
betar(1,2)=betar(1,1)+rand(1,1);
pi1=rand(1,1); %segment size
uij1(:,1)=alpha+(c+gamma*c)*ones(J,1)+betap(1,1)*P1;
%+alphap(1,1)*lambda.*(P1-P2);
uij1(:,2)=alpha+(c+gamma*c)*ones(J,1)+betap(1,2)*P1;
%+alphap(1,2)*lambda.*(P1-P2);
uij2(:,1)=gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,1)*P2));
%+betar(1,1)*(1-lambda).*log(ones(J,1)+exp(alpha+(c+gamma*c)*ones(J,1)+betap(1,1)*P1)));
uij2(:,2)=gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,2)*P2));
%+betar(1,2)*(1-lambda).*log(ones(J,1)+exp(alpha+(c+gamma*c)*ones(J,1)+betap(1,2)*P1)));
denom1=sum([exp(uij1(:,1)) exp(uij2(:,1)) ones(J,1)],2);
denom2=sum([exp(uij1(:,2)) exp(uij2(:,2)) ones(J,1)],2);
esh1=[exp(uij1(:,1))./denom1 exp(uij2(:,1))./denom1 ones(J,1)./denom1];
esh2=[exp(uij1(:,2))./denom2 exp(uij2(:,2))./denom2 ones(J,1)./denom2];
Sh=esh1*pi1+esh2*(1-pi1);
%estimate
X0=ones(1,4);
global MX;
MX=zeros(1,4+J);
global MX0;
MX0=zeros(1,4+J);
%anonymous function method
km=0.001;
ObjectiveFunction = @(x)RegLik(x,gamma,J,T,P1,P2,Sh,lambda,km);
[x,fval,exitflag,output] = fminsearch(ObjectiveFunction,X0);
%compare simulate and estimate
[betap(1,1) alphap(1,1) betar(1,1) pi1;x]
[c betap(1,2) alphap(1,2) betar(1,2);MX(1, 1:4)]
[alpha'; MX(1,5:4+J)]
%calculate t-stat
