%simulate data
clear all; 
global likelihood likelihoodM;
global nonlinearp betarp linearp;

J  = 1000;
T  =  3;
P1          =   randi(20,J,1);
discount    =   rand(J,1);
P2          =   ceil(P1.*(1-discount));
lambda      =   rand(J,1); %availability

alpha  = 2*rand(1,1);
c     = rand(1,1);

gamma =.975; %discount factor

%segment size
pi1         =   rand(1,1); %for first segment
%For both segments
%price coefficient
bp    = rand(1,2);
bp   =[min(bp) max(bp)];
% high price regret coefficient
alphap = 3*rand(1,2);
alphap   =[min(alphap) max(alphap)];
% stock out regret coefficient
betar = 5*rand(1,2);
betar   =[min(betar) max(betar)];

% Unobserved demand shock
xi          =   randn(J,2);
% calculate utility
% for the first segment
uij1(:,1) =      alpha+(c+gamma*c)+bp(1,1)*P1+ alphap(1,1)*lambda.*(P1-P2)+ xi(:,1);
uij2(:,1) =      gamma*(lambda.*(alpha+c+bp(1,1)*P2)+ betar(1,1)*(ones(J,1)-lambda).*(c+gamma*c))+ xi(:,2);
% second segment
uij1(:,2) =      uij1(:,1) + bp(1,2)*P1+ alphap(1,2)*lambda.*(P1-P2);
uij2(:,2) =      uij2(:,1) +  gamma*(lambda.*(bp(1,2)*P2)+ betar(1,2)*(ones(J,1)-lambda).*(c+gamma*c));
e1=exp(uij1); e2=exp(uij2);
shares_1=[e1(:,1)./(1+e1(:,1)+e2(:,1)) e2(:,1)./(1+e1(:,1)+e2(:,1))];
shares_2=[e1(:,2)./(1+e1(:,2)+e2(:,2)) e2(:,2)./(1+e1(:,2)+e2(:,2))];
shares  = pi1*shares_1 + (1-pi1)*shares_2;
outside_1=[1./(1+e1(:,1)+e2(:,1)) 1./(1+e1(:,1)+e2(:,1))];
outside_2=[1./(1+e1(:,2)+e2(:,2)) 1./(1+e1(:,2)+e2(:,2))];
outside  = pi1*outside_1 + (1-pi1)*outside_2;

P  = [P1 P2];
Pn = reshape(P',J*2,1);

% denom1    =      sum([exp(uij1(:,1)) exp(uij2(:,1)) ones(J,1)],2);
% Sh1       =      [exp(uij1(:,1))./denom1 exp(uij2(:,1))./denom1 ones(J,1)./denom1];
%  % for second segment
% uij1(:,2) =      alpha + (c + gamma*c)*ones(J,1) + betap(1,2)*P1 + alphap(1,2)*lambda.*(P1-P2);
% uij2(:,2) =      gamma*(lambda.*(alpha+c*ones(J,1)+betap(1,2)*P2) + betar(1,2)*(1-lambda).*log(ones(J,1) + exp(alpha+(c+gamma*c)*ones(J,1)+betap(1,2)*P1)));
% denom2    =      sum([exp(uij1(:,2)) exp(uij2(:,2)) ones(J,1)],2);
% Sh2       =      [exp(uij1(:,2))./denom2 exp(uij2(:,2))./denom2 ones(J,1)./denom2];
% % calculate total share
% Sh        =      pi1*Sh1   +    (1-pi1)*Sh2;
% estimate
X0  =  0*ones(1,4);
global MX;
MX  =  zeros(1,4+J);
global MX0;
MX0 =  zeros(1,4+J);
%anonymous function method
km   =    0.001;
ObjectiveFunction        =    @(x)FuncSimpleWRegWHetr(x,gamma,J,T,P1,P2,Sh,lambda,km);
%conditional
% ub = Inf(size(X0)); 
% lb = -ub; 
% lb(4) = 0; 
% ub(4) = 1; 
% x = fmincon(ObjectiveFunction,X0,[],[],[],[],lb,ub);
%unconditional
x =     fminsearch(ObjectiveFunction,X0);
%compare simulate and estimate
[likelihood likelihoodM]
[betap(1,1) alphap(1,1) betar(1,1) pi1;x]
[c betap(1,2) alphap(1,2) betar(1,2);MX(1, 1:4)]
[alpha'; x(1,5:4+J)]
%calculate t-stat
