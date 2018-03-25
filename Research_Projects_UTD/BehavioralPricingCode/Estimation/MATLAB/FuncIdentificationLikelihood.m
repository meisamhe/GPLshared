% To check the identification for model with regret
function y = FuncIdentificationBLP(x)
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
pi1      =  exp(x(1))/(1+exp(x(1))); %share of first segment (use transformation to make sure it is between zero and one)
% use transformation to make sure that it is lower
bpd       =  x(2); %price coefficient difference heterogeneity coeff
alphapd   =  x(3); %high price regret difference heterogeneity coeff
tth1d    =   x(4); %stock out regret difference heterogeneity coeff multiplied to consumption utility
alpha    = x(5);
c        = x(6);
bp       = x(7);
alphap   = x(8);
betar    = x(9);

%beta=[alpha c bp];
p = 5;
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1 lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

de= [X1 X2] * [alpha;c;bp;alphap;betar];

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
        if (i>500000) % for genetic algorithm
            penalty = -Inf;
            break;
        end;
    end;
    de   =   de1;
    % calculate utility
    uij1s1 =      de(:,1);
    uij2s1 =      de(:,2);
    uij1s2 =      de(:,1)+bpd*P1+ alphapd.*lambda.*(P1-P2);    
    uij2s2 =      de(:,2)+gamma.*(lambda.*(bpd*P2)+ tth1d*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2));
    
    e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
    shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
    shares_e=max(shares_e,0.00000001);   %As a precaution
    de1    =  de  + log(shares)-  log(shares_e) ;  
    k      =  max(abs(de1(:)-de(:)));
    [min(abs(de1(:)-de(:))) median(abs(de1(:)-de(:))) mean(abs(de1(:)-de(:))) max(abs(de1(:)-de(:)))]
    pause
end;
dd                       =    de1; % first segment utility portion

dd_n=reshape(dd',J*2,1); 

%beta=[alpha c bp];
p = 5;
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1 lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn=dd_n;

%OLS
betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));

% calculate variance
variance                 =    sum(errors(:).^2)/(size(errors(:),1)-1);

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
disp(
disp(likelihood)