% To check the identification for model with regret
function y = FuncDatanBLPWithRegEffcntFullMDL(x,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost)
global vcm se_est betas variance deltatemp cbp cbphess
global process % number of processors to prallelize contraction mapping (fixed to 3 right now)


[J,T]=size(shares);

% parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x(1))/(1+exp(x(1))); %share of first segment (use transformation to make sure it is between zero and one)
% use transformation to make sure that it is lower
bpd       =  x(2); %price coefficient difference heterogeneity coeff
ard   =  x(3); %high price regret difference heterogeneity coeff
brd    =   x(4); %stock out regret difference heterogeneity coeff multiplied to consumption utility

%penalty  = cell([3 1]);
%Indx = 1:J;
solution =cell([3 1]);
%contraction mapping
penalty =0;
Indx1 = 1:J;%floor(J/3);
k        =  100;
i        =  0; % track contraction mapping
dd       =  zeros(J,T);%zeros(J,T);%deltatemp/2; %deltatemp*.99
%zeros(J,T); %since I have three periods and we only use two for identification 
de1      =  dd;
options=optimset('Display','on','MaxIter',10000,'TolX',10^-15,'TolFun',10^-15,'UseParallel','always','GradObj','on');
X0 =[0.1 0.1];
c=1;
bp =1;
kold =-50;
koldold = -20;
while(k>km)
    i    =   i+1;
    if (kold ==k && koldold==kold)
        penalty = -Inf; 
        break;
    end;
    koldold = kold;
    kold =k;
    if (ceil(i./1000) == (i./1000))|| (i==1)        
        i
        k
        disp(x)
        if (i./1000 >200)
           penalty = -Inf; 
           break;
        end;

    end;

    de   =   de1;
    % calculate utility for the first segment
    uij1s1 =      de(Indx1,1);
    uij2s1 =      de(Indx1,2);
    
    %X0 =[log(c) log(bpd-bp)];
    
    % for the second segment
    [cbp,cbpLL,exitflag,output,grad,cbphess]=fminunc('FuncFullMDL',X0,options,P1,P2,Dur1,Dur2,lambda,gamma,cost,de(Indx1,:));
     c = exp(cbp(1)); % constraint to make sure it is positive
     bp = -exp(cbp(2))+bpd; % sensitivity of the second segment
     a  = betas(1);
     ar = betas(2)+ard;
     br = betas(3)+brd;
     cbpLL
     
    uij1s2 = cost*a+(0.5*Dur1+gamma.*Dur2)*c+bp*P1+lambda.*(P1-P2)*ar;
    uij2s2 = gamma.*lambda.*cost*a + gamma.*lambda.*Dur2.*0.5*c+bp*gamma.*lambda.*P2+br*gamma.*(ones(J,1)-lambda).*max((0.5*Dur1+gamma.*Dur2)*c + bp*P1,1e-50);
   
    e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
    shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
    shares_e=max(shares_e,1e-50);   %As a precaution
    chng =log(shares(Indx1,:))-  log(shares_e);
    de1=setde1(Indx1,chng,de1,de);
    k = max(abs(chng(:)))
  %  Indx1 = Indx1(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
    solution = de1(1:J,:);
end;
 
dd =solution;

ttlpenalty = penalty;
%dd       =    de1; % first segment utility portion
% size(solution{1})
% size(solution{2})
% size(solution{3})
 dd        =    [solution];
 deltatemp =dd;
 de        = dd;
 
% putting back likelihood
LogDemandShockLikelihood = -cbpLL;
 
% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
uij1s1 =      de(Indx1,1);
uij2s1 =      de(Indx1,2);

X0 =[log(c) log(bpd-bp)];

% for the second segment
[cbp,cbpLL,exitflag,output,grad,cbphess]=fminunc('FuncFullMDL',X0,options,P1,P2,Dur1,Dur2,lambda,gamma,cost,de(Indx1,:));
 c = exp(cbp(1)); % constraint to make sure it is positive
 bp = -exp(cbp(2))+bpd; % sensitivity of the second segment
 a  = betas(1);
 ar = betas(2)+ard;
 br = betas(3)+brd;
 cbpLL

uij1s2 = cost*a+(0.5*Dur1+gamma.*Dur2)*c+bp*P1+lambda.*(P1-P2)*ar;
uij2s2 = gamma.*lambda.*cost*a + gamma.*lambda.*Dur2.*0.5*c+bp*gamma.*lambda.*P2+br*gamma.*(ones(J,1)-lambda).*max((0.5*Dur1+gamma.*Dur2)*c + bp*P1,1e-50);
   
e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
s1    =     e1./(1+e1+e2);
s11   =     1-s1;
s1=max(s1,1e-50); %As a precaution
s11=max(s11,1e-50); %As a precaution
s2    =     e2./(1+e1+e2);
s21   =     1-s2;
s2=max(s2,1e-50);   %As a precaution
s21=max(s21,1e-50); %As a precaution
% for period 1 and period 2 respectively


Jacobian                 =    (((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;

LogJacobian              =    -sum(log(Jacobian(:)));


likelihood               =    LogDemandShockLikelihood    +   LogJacobian + ttlpenalty  ;
y                        =    - likelihood ;

disp('likelihood on real param is:  9.4184e+03, but her is:')
-y
