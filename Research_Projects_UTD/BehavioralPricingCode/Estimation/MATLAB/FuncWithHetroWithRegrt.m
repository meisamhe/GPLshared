% To check the identification for model with regret
function y = FuncWithHetroWithRegrt(x)
global P1 P2 Dur1 Dur2 lambda gamma shares  km cost; %outside_n
global vcm se_est betas variance
%gamma: the discount factor
%P1: price for first period
%P2: price for 2nd period
%lambda: Availability of second period
%arranging matrixes
%J: number of products under study = 106 in hour example
%T: number of periods =2 in hour example
%heterogeneous beta includes beta_ip, beta_ir, alpha_ip
[J,T]=size(shares);

% parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x(1,1))/(1+exp(x(1,1))); %share of first segment (use transformation to make sure it is between zero and one)
% use transformation to make sure that it is lower
bp       =  x(1,2); %price coefficient difference heterogeneity coeff
alphap   =  x(1,3); %high price regret difference heterogeneity coeff
tth1    =   x(1,4); %stock out regret difference heterogeneity coeff multiplied to consumption utility
% disp('input parameters for function are for [pi1 bp alphap betar] are:')
% [pi1 bp alphap betar]
% pause
dd       =  zeros(J,T); %since I have three periods and 
k        =  100;
de1      =  dd;
i        =  0; % track contraction mapping
penalty  =  0;
%contraction mapping
while(k>km);
    i    =   i+1;
    if (ceil(i./1000) == (i./1000))
        i
        %median(de1(:)-de(:))
        if (i>100000) % for genetic algorithm
            penalty = -Inf;
            break;
        end;
    end;
    de   =   de1;
    % calculate utility
    uij1(:,1) =      de(:,1);
    uij2(:,1) =      de(:,2);
    uij1(:,2) =      de(:,1)+bp.*P1+ lambda.*alphap.*(P1-P2);
    uij2(:,2) =      de(:,2)+gamma.*(lambda.*(bp*P2)+ (ones(J,1)-lambda).*tth1.*(0.5*Dur1+gamma.*Dur2));
    e1=exp(uij1); e2=exp(uij2);
    shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
    shares_e=max(shares_e,0.00000001);   %As a precaution
    de1    =  de  + log(shares)-  log(shares_e) ;  
    k      =  max(abs(de1(:)-de(:)));
end;
dd                       =    de1; % first segment utility portion
% run regression to find linear parameters
shares_n = reshape(dd',J*2,1); %stack shares on top of eachother
%disp(shares_n)
%pause
% no fixed effect
p=5;
X1= [ones(J,1).*cost (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost (0.5*Dur2).*gamma.*lambda gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];
X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn= shares_n;
%log(shares_n./outside_n);

%OLS
betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));
% calculate variance
variance                 =    mean(errors.^2)*2*J/(2*J-1); 

% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
s1    =     e1./(1+e1+e2);
s11   =     1-s1;
s1=max(s1,0.00000001); %As a precaution
s11=max(s11,0.00000001); %As a precaution
s2    =     e2./(1+e1+e2);
s21   =     1-s2;
s2=max(s2,0.00000001);   %As a precaution
s21=max(s21,0.00000001); %As a precaution
Jacobian                 =    [(s1.*s11)*[pi1;1-pi1] (s2.*s21)*[pi1;1-pi1]];
LogJacobian              =    -sum(log(Jacobian(:)));

LogDemandShockLikelihood =    - T*J*log(sqrt(2*pi*variance)) -   .5*sum(errors.^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian + penalty;
y                        =    - likelihood ;
%disp ('set of (Jacobian, likelihood, Log demand shock Likelihood) is: ');
%disp ([LogJacobian likelihood LogDemandShockLikelihood]);
%pause