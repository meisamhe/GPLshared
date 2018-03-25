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

dd   =    zeros(J,T); %since I have three periods and 
k    =    100;
de1  =    dd;
km   =    0.001;
i    =    0;
while(k>km);
    de     =  de1 ; 
    %i      =  i   +  1
    uij1   =  (alpha + c + gamma*c)*ones(J,1) + betap(1,1)*P1     + de(1:J,1);
    uij2   =  gamma*(lambda.*((alpha+c)*ones(J,1)+betap(1,1)*P2)) + de(1:J,2);
    denom  =  sum([exp(uij1) exp(uij2) exp(de(1:J,3))],2);
    % estimated share:
    esh    =   [exp(uij1(:,1)) exp(uij2(:,1)) exp(de(1:J,3))]./repmat(denom,[1 3]);
    de1    =  de  +  log(Sh)  -  log(esh);
    k      =  max((abs(de1(:)-de(:))));
end;
%objective function should be square of errors for both
SE                       =    de1.^2;
variance                 =    mean(SE(:));
% to avoid Jacobian that is zero, which will create Log(0)= NaN
Jacobian                 =    esh.*(ones(J,3) -   esh) ;
LogJacobian              =    sum(sum(-log(Jacobian)));
LogDemandShockLikelihood =    - J*3*log(sqrt(2*pi*variance)) -   0.5*sum(SE(:)./variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood;

% sigma  =    abs(x(1,4)); % variance
%simple minimum distance estimator
% eshs   =    zeros(J,3,100);
% for i  =  1:100
%     xi     =    sigma*randn(J,3);
%     uij1   =   (alpha*ones(J,1)+(c+gamma*c)*ones(J,1)+betap*P1)+ xi(:,1);
%     uij2   =   (gamma*(lambda.*(alpha+c*ones(J,1)+betap*P2)))+ xi(:,2);
%     denom1 =    sum([exp(uij1(:,1)) exp(uij2(:,1)) exp(xi(:,3))],2);
%     % estimated share:
%     eshs(:,:,i)    =   [exp(uij1(:,1)) exp(uij2(:,1)) exp(xi(:,3))]./repmat(denom1,[1 3]);
% end;