function y = FuncSimpleNoRegWHetr(x,gamma,J,T,P1,P2,Sh,lambda,km)
global likelihood likelihoodM MX MX0 hessian2 variance;
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
pi1      =  x(1,2); %share of first segment
dd       =  zeros(J,T); %since I have three periods and 
k        =  100;
de1      =  dd;
i        =  0; % track contraction mapping
while(k>km);
    i    =   i+1
    de   =   de1; 
    % calculate share of first segment (mean)
    denom1  =   sum(exp(de(1:J,1:3)),2);
    esh1   =  exp(de(1:J,1:3))./repmat(denom1,[1 3]);
    % calculate share of second segment
    uij1 =   betaip*P1   +   de(1:J,1);
    uij2 =   gamma *lambda.*(betaip*P2) +  de(1:J,2);
    denom2  =   sum(exp([uij1 uij2 de(1:J,3)]),2);
    esh2   =   exp([uij1 uij2 de(1:J,3)])./repmat(denom2,[1 3]);
    % calculate total share
    esh    =   esh1*pi1  +  esh2*(1-pi1);
    %contraction mapping
    de1    =  de  +  log(Sh./esh) ;
    k      =  max(abs(de1(:)-de(:)));
end;

dd                       =    de1;
% to avoid Jacobian that is zero, which will create Log(0)= NaN
Jacobian                 =    abs(pi1.*esh1.*(ones(J,3) -   esh1) + (1 - pi1).*esh2.*(ones(J,3) -   esh2)) + ones(size(esh1,1),size(esh1,2));
LogJacobian              =    sum(-log(Jacobian(:)));
%use fmincon
ub    = Inf(size(MX0)); 
lb    = -ub; 
lb(1) = 0;
[MX,fval,exitflag,output,lambda,grad,hessian2] =  fmincon('FuncSimpleNoRegWHetrMean',MX0,[],[],[],[],lb,ub,[],[],dd,P1,P2,lambda,gamma,J);

LogDemandShockLikelihood =    -fval; %which is likelihoodM
likelihood               =    LogDemandShockLikelihood    +   LogJacobian;
y                        =    - likelihood ;

% call likelihood function
%ObjFunc = @(x)FuncSimpleNoRegWHetrMean(x,dd,P1,P2,lambda,gamma,J);
%MX = fminsearch(ObjFunc,MX0);
%use fminunc
% options=optimset('Display','off','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30);
% [MX,fval,exitflag,output,grad,hessian2]=fminunc('FuncSimpleNoRegWHetrMean',MX0,options,dd,P1,P2,lambda,gamma,J);