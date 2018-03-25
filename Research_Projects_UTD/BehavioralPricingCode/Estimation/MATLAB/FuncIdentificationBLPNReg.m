% To check the identification for model with regret
function y = FuncIdentificationBLPNReg(x)
global P1 P2 Dur1 Dur2 lambda gamma shares  km cost deltatemp; %outside_n
global vcm se_est betas variance
global pi1r bpdr alphapdr betardr cr

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

dd       =  deltatemp*.99;%zeros(J,T);%deltatemp/2; 
%zeros(J,T); %since I have three periods and we only use two for identification 
k        =  100;
de1      =  dd;
i        =  0; % track contraction mapping
penalty  =  0;
diffdistrib = dd(:);
conv = diffdistrib;
diffdistold = ones(J*T,1);
%contraction mapping
while(k>km) %|| (all(conv(:))==0);
    i    =   i+1;
    if (ceil(i./1000) == (i./1000))|| (i==1)
        i
        k
        disp([log(pi1r/(1-pi1r)) bpdr])
        disp(x)
       % [diffdistold  diffdistrib ((floor(diffdistrib*1e4) == floor(diffdistold*1e4))) conv(:)]
       % pause
       
       % [min(abs(de1(:)-de(:))) median(abs(de1(:)-de(:))) mean(abs(de1(:)-de(:))) max(abs(de1(:)-de(:)))]
       % [de1-de log(shares)-log(shares_e)]
       % pause;
        %median(de1(:)-de(:))
%         if (i>40000) % for genetic algorithm
%             penalty = -Inf;
%             break;
%         end;
    end;
    diffdistold = diffdistrib;
    de   =   de1;
    % calculate utility
    uij1s1 =      de(:,1);
    uij2s1 =      de(:,2);
    uij1s2 =      de(:,1)+bpd*P1;    
    uij2s2 =      de(:,2)+gamma.*(lambda.*(bpd*P2)); 
    e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
    shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
    shares_e=max(shares_e,1e-50);   %As a precaution
    chng =log(shares)-  log(shares_e);
    de1    =  de  + chng;
    %k      =  max(abs(de1(:)-de(:)));
   % [min(abs(de1(:)-de(:))) median(abs(de1(:)-de(:))) mean(abs(de1(:)-de(:))) max(abs(de1(:)-de(:)))]
   % pause
    %k = sort(abs(de1(:)-de(:)));
    %diffdistrib = k; % distribution of the difference
    k = max(abs(chng(:))); % k = k(ceil(0.9999*size(k,1)));
   % conv = (floor(diffdistrib*1e3) == floor(diffdistold*1e3));
    
end;
dd                       =    de1; % first segment utility portion


% assume independance of error of share
sherror = log(shares)-  log(shares_e);
sherrvar = var(sherror(:));
SherrLKLHD=   - 0.5*T*J*log(2*pi*sherrvar) -   .5*sum(sherror(:).^2/sherrvar);
%sherror =reshape(sherror,J,2);


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
likelihood               =    LogDemandShockLikelihood    +   LogJacobian + penalty ;
y                        =    - likelihood ;

disp('likelihood on real param is:  9.4184e+03, but her is:')
-y
