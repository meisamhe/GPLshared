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
ndraw    = 1000;

penalty  = cell([3 1]);
%Indx = 1:J;
%solution =cell([3 1]);
%contraction mapping

j=1;

penalty{j} =0;
%Indx1 = 1:floor(J/3);
% Indx1 = 1:J;
k        =  100;
de       =  zeros(J,T);%zeros(J,T);%deltatemp/2; %deltatemp*.99
%zeros(J,T); %since I have three periods and we only use two for identification 
%de1      =  de;
% w1       =  zeros(J,ndraw);
% w2       =  zeros(J,ndraw);
% create indexes
IndxS =[1 floor(J/4);floor(J/4)+1 floor(J/2); floor(J/2)+1 floor(3*J/4); floor(3*J/4)+1 J];

% create variables for parfor
s11 = cell([1 4]);
s12 = cell([1 4]);
s21 = cell([1 4]);
s22 = cell([1 4]);
tt12 = cell([1 4]);
tt22 = cell([1 4]);
solutionS=cell([1 4]);
solutionk=cell([1 4]);

% preparing explanatory variables
 p = 5;
X1= [cost (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2) zeros(J,1)];
%     size(gamma.*lambda.*cost)
%     size(gamma.*lambda.*Dur2.*0.5)
%     size(gamma.*lambda.*P2)
%     size(zeros(J,1))
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];

X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's

% variables
Xest1    = cell([1 4]); % keep it for deltaestimate (for first period)
Xest2    = cell([1 4]); % for second period
sharesr  = cell([1 4]);
sizeJ    = cell([1 4]);
randdrew = cell([1 4]);
gamma1    = cell([1 4]);
lambda1   = cell([1 4]);
P21       = cell([1 4]);
P11       = cell([1 4]);
D11       = cell([1 4]);
D21       = cell([1 4]);
i=1;
gamma1{i}  = gamma((IndxS(i,1):IndxS(i,2)));
lambda1{i} = lambda((IndxS(i,1):IndxS(i,2)));
P21{i}     = P2((IndxS(i,1):IndxS(i,2)));
D11{i}     = Dur1((IndxS(i,1):IndxS(i,2)));
D21{i}     = Dur2((IndxS(i,1):IndxS(i,2)));
P11{i}     = P1((IndxS(i,1):IndxS(i,2)));
Xest1{i}    = X1((IndxS(i,1):IndxS(i,2)),:);
Xest2{i}    = X2((IndxS(i,1):IndxS(i,2)),:);
sharesr{i}=shares(IndxS(i,1):IndxS(i,2),:);
sizeJ{i} = IndxS(i,2)-IndxS(i,1)+1;
randdrew{i} =randn(sizeJ{i},ndraw);
solutionS{i} =zeros(sizeJ{i},T);
for i=2:4
    gamma1{i} = gamma((IndxS(i,1):IndxS(i,2)));
    lambda1{i} = lambda((IndxS(i,1):IndxS(i,2)));
    P21{i}     = P2((IndxS(i,1):IndxS(i,2)));
    D11{i}     = Dur1((IndxS(i,1):IndxS(i,2)));
    D21{i}   = Dur2((IndxS(i,1):IndxS(i,2)));
    P11{i}     = P1((IndxS(i,1):IndxS(i,2)));
    Xest1{i}    = X1((IndxS(i,1):IndxS(i,2)),:);
    Xest2{i}    = X2((IndxS(i,1):IndxS(i,2)),:);
    sharesr{i}=shares(IndxS(i,1):IndxS(i,2),:);
    sizeJ{i} = IndxS(i,2)-IndxS(i,1)+1;
    randdrew{i} =randn(sizeJ{i},ndraw);
    solutionS{i} =zeros(sizeJ{i},T);
end;

i        =  0; % track contraction mapping
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


 %   deltatemp =de1;
   % size(dd)
    dd_n=reshape(de',J*2,1);

    %beta=[alpha c bp];
 
    Yn=dd_n;

    %OLS
    betas= (Xn'*Xn\speye(size(Xn'*Xn)))*Xn'*Yn;
    errors=Yn-Xn*betas;
    vcm=(errors'*errors)*(Xn'*Xn\speye(size(Xn'*Xn)))/(2*J);
    se_est=sqrt(diag(vcm));

    % calculate variance

    variance                 =    mean(errors.^2);
    
    
%    delest=reshape(delest',2,J)';
   
    
    %preparation to calculate shares
 %   de   =   de1;
    % draw for error term
  %  xi   = sqrt(variance)*randdrew; % since not purchase is normalized to zero, and only in first period consumer speculates
    
    
    % calculate utility
    parfor i=1:4;
          % for the second segment in second period to avoid multiple
          % calculations
            ds2 =gamma1{i}.*(lambda1{i}.*(bpd*P21{i})+ tth1d*(ones(sizeJ{i},1)-lambda1{i}).*(0.5*D11{i}+gamma1{i}.*D21{i}));            
            % calculate value of waiting at period t=1, since t=2, it is zero,
            % w(1:J,j), where for J SKU's and j'th draw
            % first segment
            w1 = log (exp(repmat(Xest2{i}*betas,[1 ndraw])+sqrt(variance)*randdrew{i})+ exp(0));
            % second segment
            w2 = log (exp(repmat(Xest2{i}*betas+ds2,[1 ndraw])+sqrt(variance)*randdrew{i})+ exp(0));
            w1mean = mean(w1,2);
            w2mean = mean(w2,2);
            uij1s1 =     solutionS{i}(:,1);% de((IndxS(i,1):IndxS(i,2)),1);
            % calculate share of each segment from each period
            % share of first period for first segment
            s11{i} = exp(uij1s1)./(exp(uij1s1)+ exp(w1mean));
            % calculate size of segment based on shares: Logic sum of those from
            % each segment who has not purchased yet
            % size of first segment in the second period
            N12=pi1*(1-s11{i});
            uij2s1 =      solutionS{i}(:,2);%de((IndxS(i,1):IndxS(i,2)),2);
             % share of second period for first segment
            s21{i} = exp(uij2s1)./(exp(uij2s1)+ 1);
            uij1s2 =      uij1s1 + bpd*P11{i} + alphapd.*lambda1{i}.*(P11{i}-P21{i});    
            % share of first period for second segment
            s12{i} = exp(uij1s2)./(exp( uij1s2)+ exp(w2mean));
             % size of second segment in the second period
            N22=(1-pi1)*(1-s12{i});
            uij2s2 =     uij2s1+ds2;
            % share of first period for second segment
            s22{i} =  exp(uij2s2)./(exp( uij2s2)+1);
            tt12{i} = N12./(N12+N22);
            tt22{i} = 1- tt12{i};
            % Calculate estimated Share
            shares_e =[[s11{i} s12{i}]*[pi1;1-pi1] sum([s21{i} s22{i}].*[tt12{i} tt22{i}],2)];
            shares_e=max(shares_e,1e-50);   %As a precaution
            chng =  log(sharesr{i})-  log(shares_e);%log(shares(IndxS(i,1):IndxS(i,2),:))-  log(shares_e);
            solutionS{i}= solutionS{i}+chng; %de(IndxS(i,1):IndxS(i,2),:)  + chng; 
          %  setde1([IndxS(i,1):IndxS(i,2)],chng,solutionS{i},de(IndxS(i,1):IndxS(i,2),:));
            solutionk{i} = max(abs(chng(:)));
    end;
     % share of segment from period
     % first segment from second period

  %  de1=[solutionS{1};solutionS{2};solutionS{3};solutionS{4}];
    k = max([solutionk{1};solutionk{2};solutionk{3};solutionk{4}]);
    % e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
    % shares_e=[e1./(1+e1+e2)*[pi1;1-pi1] e2./(1+e1+e2)*[pi1;1-pi1]];
%     shares_e =[[s11 s12]*[pi1;1-pi1] sum([s21 s22].*[tt12 tt22],2)];
%     shares_e=max(shares_e,1e-50);   %As a precaution
%     chng =log(shares(Indx1,:))-  log(shares_e);
%     de1=setde1(Indx1,chng,de1,de);
%     k = max(abs(chng(:)));
    
    
   % Indx1 = Indx1(((abs(chng(:,1))>km)|(abs(chng(:,2))>km))); % in other word only pick those indexes that are relevant
    %solution{j} = 
 %   dd        =    de1(1:J,:);%;solution{2};solution{3}]; % first segment utility portion
 %   de        = dd;
 %    de        = de1;
     de =[solutionS{1};solutionS{2};solutionS{3};solutionS{4}];
    
end;

ttlpenalty = penalty{1};% + penalty{2} + penalty{3};
%dd       =    de1; % first segment utility portion
%size(solution{1})
% size(solution{2})
% size(solution{3})

%update Jacobian

% % to avoid Jacobian that is zero, which will create Log(0)= NaN; + ones(size(esh1,1)
% uij1s1 =      de(:,1);
% uij2s1 =      de(:,2);
% uij1s2 =      de(:,1)+bpd*P1(:) + alphapd.*lambda(:).*(P1(:)-P2(:));    
% uij2s2 =      de(:,2)+gamma(:).*(lambda(:).*(bpd*P2(:))+ tth1d*(ones(J,1)-lambda(:)).*(0.5*Dur1(:)+gamma(:).*Dur2(:))); 
% e1=exp([uij1s1 uij1s2]); e2=exp([uij2s1 uij2s2]);
% s1    =     e1./(1+e1+e2);
% s11   =     1-s1;
% s1=max(s1,1e-50); %As a precaution
% s11=max(s11,1e-50); %As a precaution
% s2    =     e2./(1+e1+e2);
% s21   =     1-s2;
% s2=max(s2,1e-50);   %As a precaution
% s21=max(s21,1e-50); %As a precaution
% for period 1 and period 2 respectively

% preparation to calculate Jacobian
s11 = [s11{1};s11{2};s11{3};s11{4}];
s12 = [s12{1};s12{2};s12{3};s12{4}];
s21 = [s21{1};s21{2};s21{3};s21{4}];
s22 = [s22{1};s22{2};s22{3};s22{4}];
tt12 = [tt12{1};tt12{2};tt12{3};tt12{4}];
tt22 = [tt22{1};tt22{2};tt22{3};tt22{4}];

Jacobian                 =    max([[s11.*(1-s11) s12.*(1-s12)]*[pi1;1-pi1] sum([s21.*(1-s21) s22.*(1-s22)].*[tt12 tt22],2)],1e-50);
%(((s1.*s11)*[pi1;1-pi1])).*(((s2.*s21)*[pi1;1-pi1])) -  (((s1.*s2)*[pi1;1-pi1])).^2;

LogJacobian              =    -sum(log(Jacobian(:)));

LogDemandShockLikelihood =    - 0.5*T*J*log(2*pi*variance) -   0.5*sum(errors.^2/variance);
likelihood               =    LogDemandShockLikelihood    +   LogJacobian + ttlpenalty  ;
y                        =    - likelihood ;

disp('likelihood on real param is: ')
-y
