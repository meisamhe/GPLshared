function y = FuncSimpleNoRegNoHetr(x,gamma,J,T,P1,P2,Sh,lambda,sigma)%(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
global likelihood LogJacobian LogDemandShockLikelihood SE esh;
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
alpha  =    x(1,3); % brand fixed effect
y1     =    log(Sh(:,1)./Sh(:,3));
y2     =    log(Sh(:,2)./Sh(:,3));

%objective function should be square of errors for both
SE                       =    [(y1 - (alpha+c+gamma*c+betap*P1));(y2-gamma*(lambda.*(alpha+c+betap*P2)))].^2;
variance                 =    mean(SE(:))
LogDemandShockLikelihood =    - J*2*log(sqrt(2*pi*variance)) -   0.5*sum(SE(:)./variance);
likelihood               =    LogDemandShockLikelihood;
y                        =    - likelihood;