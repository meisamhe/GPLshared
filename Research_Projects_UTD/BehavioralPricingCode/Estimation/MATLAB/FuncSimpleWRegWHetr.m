function y = FuncSimpleWRegWHetr(x,gamma,J,T,P1,P2,Sh,lambda,km)
global likelihood likelihoodM MX MX0;
global nonlinearp betarp linearp;
%gamma: the discount factor
%P1: price for first period
%P2: price for 2nd period
%Sh: share for three periods structure[Sh1 Sh2 Sh3]
%lambda: Availability of second period
%arranging matrixes
%J: number of products under study = 106 in hour example
%T: number of periods =2 in hour example
%heterogeneous beta includes beta_ip, beta_ir, alpha_ip
betaip   =  x(1,1); %price coefficient
alphaip  =  x(1,2); %high price regret coeff
betair   =  x(1,3); %unavailability regret coeff
pi1      =  x(1,4); %share of first segment
%penalty  =  500000000;
% if pi1 > 0 && pi1 <1
%    penalty = 0;
% end;
% contraction mapping
%use size to create heterogeneities
dd=zeros(J,T); %since I have three periods and 
k=100;
de1=dd;
linearp = zeros(J,1);
nonlinearp = zeros(J,1);
betarp =0;
while(k>km);
    de   =   de1; 
    % calculate share of first segment (mean)
    denom1  =   sum([exp(de(1:J,1)) exp(de(1:J,2)) ones(J,1)],2);
    esh1   =   [exp(de(1:J,1))./denom1 exp(de(1:J,2))./denom1 ones(J,1)./denom1];
    % calculate share of second segment
    uij1 =    betaip*P1   +   de(1:J,1) +  alphaip*lambda.*(P1-P2);
    uij2 =   gamma *lambda.*(betaip*P2) +  de(1:J,2)+betar(1,1)*(1-lambda).*log(ones(J,1) + exp(alpha+(c+gamma*c)*ones(J,1)+betaip*P1));
    denom2  =   sum([exp(uij1) exp(uij2) ones(J,1)],2);
    esh2   =   [exp(uij1)./denom2 exp(uij2)./denom2 ones(J,1)./denom2];
    
    uij1 =   betaip*P1   +   de(1:J,1) +  alphaip*lambda.*(P1-P2);
    %nonlinear = nonlinearp + betaip*P1;
    %uij2 =   gamma *(betaip*lambda.*P2 +  linearp  +  (betair + betarp)*(1-lambda).*log(ones(J,1)+exp(nonlinear)));
    %+ de(1:J,2)
    denom  =   sum([exp(uij1) exp(uij2) ones(J,1)],2);
    esh1   =   [exp(uij1)./denom exp(uij2)./denom ones(J,1)./denom];

    esh    =   esh1*pi1  +  esh2*(1-pi1);
    
    % call likelihood function
    ObjFunc = @(x)FuncMeanUtilityEst(x,de1,P1,P2,lambda,gamma,J);
    MX = fminsearch(ObjFunc,MX0);
    de1    =  de  +  log(Sh)  -  log(esh);
    k      =  max(max((abs(de1-de))'));
end;

dd=de1;


%objective function should be square of errors for both
SE                       =   (Sh-esh).^2;
variance                 =    mean(SE(:));

LogJacobian              =    - sum(sum(-log(pi1*esh1.*(ones(J,3) -   esh1) + (1 - pi1)*esh2.*(ones(J,3) -   esh2))));
LogDemandShockLikelihood =    - J*3*log(sqrt(2*pi*variance)) -   sum(sum(SE./variance));
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood - likelihoodM ;
