% To check the identification for model with regret
function y = FuncIdentificationBLPWithRegEffcnt(x,P1,P2,Dur1,Dur2,lambda,gamma,shares,km,cost)
global vcm se_est betas variance deltatemp
global process % number of processors to prallelize contraction mapping (fixed to 3 right now)


[J,T]=size(shares);

% parameters of heterogeneity [pi1 bp alphap betar*c]
pi1      =  exp(x(1))/(1+exp(x(1))); %share of first segment (use transformation to make sure it is between zero and one)
% use transformation to make sure that it is lower
bpd       =  x(2); %price coefficient difference heterogeneity coeff
alphapd   =  x(3); %high price regret difference heterogeneity coeff
tth1d    =   x(4); %stock out regret difference heterogeneity coeff multiplied to consumption utility

penalty  = cell([3 1]);
%Indx = 1:J;
solution =cell([3 1]);
%contraction mapping
parfor j=1:3;
    if (j==1)
        penalty{j} =0;
        Indx1 = 1:floor(J/3);
        k        =  100;
        kold = 99;
        i        =  0; % track contraction mapping
        dd       =  zeros(J,T);%zeros(J,T);%deltatemp/2; %deltatemp*.99
        %zeros(J,T); %since I have three periods and we only use two for identification 
        de1      =  dd;
        while(k>km)
            i    =   i+1;
            if (ceil(i./1000) == (i./1000))|| (i==1)        
                i
                k
                disp(x)
                if (i./1000 >3000)
                   penalty{j} = -Inf; 
                   break;
                end;

            end;

            de   =   de1;
            % calculate utility
            uij1s1 =      de(Indx1,1);
            uij2s1 =      de(Indx1,2);
            uij1s2 =      de(Indx1,1)+bpd*P1(Indx1) + alphapd.*lambda(Indx1).*(P1(Indx1)-P2(Indx1));    
            uij2s2 =      de(Indx1,2)+gamma(Indx1).*(lambda(Indx1).*(bpd*P2(Indx1))+ tth1d*(ones(size(Indx1,2),1)-lambda(Indx1)).*(0.5*Dur1(Indx1)+gamma(Indx1).*Dur2(Indx1))); 
            e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
            shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
            shares_e=max(shares_e,1e-50);   %As a precaution
            chng =log(shares(Indx1,:))-  log(shares_e);
            de1=setde1(Indx1,chng,de1,de);
            k = max(abs(chng(:)));
%             if (kold ==k && k>km) % randomize in order to avoid blockage
%                 k
%                 kold
%                 abs(chng(:,1))==k
%                 abs(chng(:,2))==k
%                 size(Indx1)
%                 de1(Indx1(abs(chng(:,1))==k),1)
%                 de1(Indx1(abs(chng(:,2))==k),2)
%                 temp = de1(Indx1,:);
%                 temp(abs(temp)==Inf)=1e-1;
%                 de1(Indx1,:) = temp;
%                 de1(Indx1(abs(chng(:,1))==k),1)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx1(abs(chng(:,1))==k),1)*100;
%                 de1(Indx1(abs(chng(:,1))==k),2)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx1(abs(chng(:,1))==k),2)*100 ;
%                 de1(Indx1(abs(chng(:,2))==k),2)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx1(abs(chng(:,2))==k),2)*100;
%                 de1(Indx1(abs(chng(:,2))==k),1)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx1(abs(chng(:,2))==k),1)*100;
%             end;
%             kold =k;
            Indx1 = Indx1(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
            solution{j} = de1(1:floor(J/3),:);
        end;
       
    elseif(j==2)
        penalty{j} =0;
        Indx2 = (floor(J/3)+1):floor(2*J/3);
         k        =  100;
         kold = 99;
        i        =  0; % track contraction mapping
        dd       =  zeros(J,T);%zeros(J,T);%deltatemp/2; %deltatemp*.99
        %zeros(J,T); %since I have three periods and we only use two for identification 
        de1      =  dd;
        while(k>km)
            i    =   i+1;
            if (ceil(i./1000) == (i./1000))|| (i==1)        
                i
                k
                disp(x)
                 if (i./1000 >3000)
                   penalty{j} = -Inf; 
                   break;
                end;

            end;

            de   =   de1;
            % calculate utility
            uij1s1 =      de(Indx2,1);
            uij2s1 =      de(Indx2,2);
            uij1s2 =      de(Indx2,1)+bpd*P1(Indx2) + alphapd.*lambda(Indx2).*(P1(Indx2)-P2(Indx2));    
            uij2s2 =      de(Indx2,2)+gamma(Indx2).*(lambda(Indx2).*(bpd*P2(Indx2))+ tth1d*(ones(size(Indx2,2),1)-lambda(Indx2)).*(0.5*Dur1(Indx2)+gamma(Indx2).*Dur2(Indx2))); 
            e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
            shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
            shares_e=max(shares_e,1e-50);   %As a precaution
            chng =log(shares(Indx2,:))-  log(shares_e);
            de1=setde1(Indx2,chng,de1,de);
            k = max(abs(chng(:)));
%             if (kold ==k && k>km) % randomize in order to avoid blockage
%                 k
%                 kold
%                 abs(chng(:,1))==k
%                 abs(chng(:,2))==k
%                 size(Indx2)
%                 de1(Indx2(abs(chng(:,1))==k),1)
%                 de1(Indx2(abs(chng(:,2))==k),2)
%                 temp = de1(Indx2,:);
%                 temp(abs(temp)==Inf)=1e-1;
%                 de1(Indx2,:) = temp;
%                 de1(Indx2(abs(chng(:,1))==k),1)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx2(abs(chng(:,1))==k),1)*100 ;
%                 de1(Indx2(abs(chng(:,1))==k),2)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx2(abs(chng(:,1))==k),2)*100 ;
%                 de1(Indx2(abs(chng(:,2))==k),2)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx2(abs(chng(:,2))==k),2)*100;
%                 de1(Indx2(abs(chng(:,2))==k),1)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx2(abs(chng(:,2))==k),1)*100;
%             end;
%             kold =k;
            Indx2 = Indx2(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
            solution{j} = de1((floor(J/3)+1):floor(2*J/3),:);
        end;        
    elseif (j==3)
        penalty{j} =0;
        Indx3 = (floor(2*J/3)+1):J;
        k        =  100;
        kold = 99;
        i        =  0; % track contraction mapping
        dd       =  zeros(J,T);%zeros(J,T);%deltatemp/2; %deltatemp*.99
        %zeros(J,T); %since I have three periods and we only use two for identification 
        de1      =  dd;
        while(k>km)
            i    =   i+1;
            if (ceil(i./1000) == (i./1000))|| (i==1)        
                i
                k
                disp(x)
                 if (i./1000 >3000)
                   penalty{j} = -Inf; 
                   break;
                end;
            end;

            de   =   de1;
            % calculate utility
            uij1s1 =      de(Indx3,1);
            uij2s1 =      de(Indx3,2);
            uij1s2 =      de(Indx3,1)+bpd*P1(Indx3) + alphapd.*lambda(Indx3).*(P1(Indx3)-P2(Indx3));    
            uij2s2 =      de(Indx3,2)+gamma(Indx3).*(lambda(Indx3).*(bpd*P2(Indx3))+ tth1d*(ones(size(Indx3,2),1)-lambda(Indx3)).*(0.5*Dur1(Indx3)+gamma(Indx3).*Dur2(Indx3))); 
            e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
            shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
            shares_e=max(shares_e,1e-50);   %As a precaution
            chng =log(shares(Indx3,:))-  log(shares_e);
            de1=setde1(Indx3,chng,de1,de);
            k = max(abs(chng(:)));
%             if (kold ==k && k>km) % randomize in order to avoid blockage
%                 k
%                 kold
%                 abs(chng(:,1))==k
%                 abs(chng(:,2))==k
%                 size(Indx3)
%                 de1(Indx3(abs(chng(:,1))==k),1)
%                 de1(Indx3(abs(chng(:,2))==k),2)
%                 temp = de1(Indx3,:);
%                 temp(abs(temp)==Inf)=1e-1;
%                 de1(Indx3,:) = temp;
%                 de1(Indx3(abs(chng(:,1))==k),1)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx3(abs(chng(:,1))==k),1)*100 ;
%                 de1(Indx3(abs(chng(:,1))==k),2)  = randn(size(find(abs(chng(:,1))==k),1),1).* de1(Indx3(abs(chng(:,1))==k),2)*100 ;
%                 de1(Indx3(abs(chng(:,2))==k),2)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx3(abs(chng(:,2))==k),2)*100;
%                 de1(Indx3(abs(chng(:,2))==k),1)  = randn(size(find(abs(chng(:,2))==k),1),1).*de1(Indx3(abs(chng(:,2))==k),1)*100;
%             end;
%             kold =k;
            Indx3 = Indx3(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
            solution{j} = de1((floor(2*J/3)+1):J,:);
        end;
        
    end;
end;

ttlpenalty = penalty{1} + penalty{2} + penalty{3};
%dd       =    de1; % first segment utility portion
size(solution{1})
size(solution{2})
size(solution{3})
dd        =    [solution{1};solution{2};solution{3}]; % first segment utility portion
de        = dd


% test whetehr share is optimal one:
uij1s1 =      de(:,1);
uij2s1 =      de(:,2);
uij1s2 =      de(:,1)+bpd*P1(:) + alphapd.*lambda(:).*(P1(:)-P2(:));    
uij2s2 =      de(:,2)+gamma(:).*(lambda(:).*(bpd*P2(:))+ tth1d*(ones(size(lambda(:)),1)-lambda(:)).*(0.5*Dur1(:)+gamma(:).*Dur2(:))); 
% e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
% shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
% shares_e=max(shares_e,1e-50);   %As a precaution

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
shares_e=[exp(-log(1+e1+e2))*[pi1;1-pi1] exp(log(e2)-log(1+e1+e2))*[pi1;1-pi1]];
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    shares_e=[exp(log(e1)-log(1+e1+e2))*[pi1;1-pi1] exp(-log(1+e1+e2))*[pi1;1-pi1]];
end;
shares_e = max(shares_e,1e-300);

if (log(shares(:,:))-  log(shares_e))>km
    error('the size of the share and the estimate are not equal!!!');
end;

deltatemp =dd;
size(dd)

dd_n=reshape(dd',J*2,1);

%beta=[alpha c bp];
p = 5;
X1= [cost (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
size(gamma.*lambda.*cost)
size(gamma.*lambda.*Dur2.*0.5)
size(gamma.*lambda.*P2)
size(zeros(J,1))
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

variance                 =    mean(errors.^2);

% to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
uij1s1 =      de(:,1);
uij2s1 =      de(:,2);
uij1s2 =      de(:,1)+bpd*P1(:) + alphapd.*lambda(:).*(P1(:)-P2(:));    
uij2s2 =      de(:,2)+gamma(:).*(lambda(:).*(bpd*P2(:))+ tth1d*(ones(J,1)-lambda(:)).*(0.5*Dur1(:)+gamma(:).*Dur2(:))); 
% e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);

e1=exp(-[uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]-[uij1s1 uij1s2]);
s1    =     1./(1+e1+e2);
s2    =     e2./(1+e1+e2);
% condition to make sure I am not departing from feasible region
if (sum(sum(isinf(log(1+e1+e2))))>0)
    e1=exp([uij1s1 uij1s2]-[uij2s1 uij2s2]); e2=exp(-[uij2s1 uij2s2]);
    s1    =     e1./(1+e1+e2);
    s2    =     1./(1+e1+e2);
end;


%s1    =     e1./(1+e1+e2);
s11   =     1-s1;
s1=max(s1,1e-300); %As a precaution
s11=max(s11,1e-300); %As a precaution
%s2    =     e2./(1+e1+e2);
s21   =     1-s2;
s2=max(s2,1e-300);   %As a precaution
s21=max(s21,1e-300); %As a precaution
% for period 1 and period 2 respectively
Jacobian                 =    (((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;
Jacobian=max(Jacobian,1e-300);   %As a precaution

LogJacobian              =    -sum(log(Jacobian(:)));


LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian + ttlpenalty  ;
y                        =    - likelihood ;
% variance
% LogJacobian
% LogDemandShockLikelihood
% s1
% s2
% disp('likelihood on real param is:  9.4184e+03, but her is:')
% -y
% Jacobian
km