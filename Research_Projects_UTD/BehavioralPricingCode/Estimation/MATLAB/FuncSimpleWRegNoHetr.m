function y = FuncSimpleNoRegNoHetr(x,gamma,J,T,P1,P2,Sh,lambda)%(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
global likelihood;
%gamma: the discount factor
%P1: price for first period
%P2: price for 2nd period
%Sh: share for three periods structure[Sh1 Sh2 Sh3]
%lambda: Availability of second period
%arranging matrixes
%J: number of products under study = 106 in hour example
%T: number of periods =2 in hour example
c      =    x(1,1); % utility of usage
betap  =    x(1,2); % price coefficient
alphap =    x(1,3); % high price regret
betar  =    x(1,4); % availability regret
alpha  =    x(1,5); % brand fixed effect

%simple minimum distance estimator
uij1 =      alpha + (c + gamma*c)*ones(J,1) + betap(1,1)*P1 + alphap(1,1)*lambda.*(P1-P2);
uij2 =      gamma*(lambda.*(alpha*ones(J,1)+c*ones(J,1)+betap(1,1)*P2) + betar(1,1)*(1-lambda).*log(ones(J,1) + exp(alpha+(c+gamma*c)*ones(J,1)+betap(1,1)*P1)));
denom  =   sum([exp(uij1) exp(uij2) ones(J,1)],2);
% estimated share:
esh    =   [exp(uij1)./denom exp(uij2)./denom ones(J,1)./denom];
%objective function should be square of errors for both
SE     =   (log(Sh)-log(esh)).^2;
variance                 =    mean(SE(:));
% to avoid Jacobian that is zero, which will create Log(0)= NaN
Jacobian                 =    esh.*(ones(J,3) -   esh) + ones(size(esh,1),size(esh,2));
LogJacobian              =    sum(sum(-log(Jacobian)));
LogDemandShockLikelihood =    - J*3*log(sqrt(2*pi*variance)) -   0.5*sum(sum(SE./variance));
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood;
