% To check the identification for model without regret
function y = FuncIdentificationBLPNReg(x)
global P1 P2 Dur1 Dur2 lambda gamma shares  km cost deltatemp; %outside_n
global vcm se_est betas variance
global pi1r bpdr alphapdr betardr cr


[J,T]=size(shares);

% parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x(1))/(1+exp(x(1))); %share of first segment (use transformation to make sure it is between zero and one)
% use transformation to make sure that it is lower
bpd       =  x(2); %price coefficient difference heterogeneity coeff

dd       =  deltatemp*.99;%zeros(J,T);%deltatemp/2; 
%zeros(J,T); %since I have three periods and we only use two for identification 
k        =  100;
de1      =  dd;
i        =  0; % track contraction mapping

Indx = 1:J;
%contraction mapping
while(k>km)
    i    =   i+1;
    if (ceil(i./1000) == (i./1000))|| (i==1)
        i
        k
        disp([log(pi1r/(1-pi1r)) bpdr])
        disp(x)

    end;

    de   =   de1;
    % calculate utility
    uij1s1 =      de(Indx,1);
    uij2s1 =      de(Indx,2);
   
    uij1s2 =      de(Indx,1)+bpd*P1(Indx);    
    uij2s2 =      de(Indx,2)+gamma(Indx).*(lambda(Indx).*(bpd*P2(Indx))); 
    e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
    shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
    shares_e=max(shares_e,1e-50);   %As a precaution
    chng =log(shares(Indx,:))-  log(shares_e);
    de1(Indx,:)    =  de(Indx,:)  + chng;
    k = max(abs(chng(:)));
    Indx = Indx(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
    
end;
dd                       =    de1; % first segment utility portion

deltatemp =dd;

dd_n=reshape(dd',J*2,1);

%beta=[alpha c bp];
p = 3;
X1= [cost (0.5*Dur1+gamma.*Dur2) P1];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2];

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

variance                 =    sum(errors.^2);

% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
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

LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian  ;
y                        =    - likelihood ;

disp('likelihood on real param is:  9.4184e+03, but her is:')
-y
