function y = RegLik(x,gamma,J,T,P1,P2,Sh,lambda,km)%(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
global MX MX0;
%gamma: the discount factor
%P1: price for first period
%P2: price for 2nd period
%Sh: share for three periods structure[Sh1 Sh2 Sh3]
%lambda: Availability of second period
%arranging matrixes
%J: number of products under study = 106 in hour example
%T: number of periods =2 in hour example
%heterogeneous beta includes beta_ip, beta_ir, alpha_ip
betaip=x(1,1); %price coefficient
alphaip=x(1,2); %high price regret coeff
betair=x(1,3); %unavailability regret coeff
pi1=x(1,4); %share of first segment

%use size to create heterogeneities
dd=zeros(J,T); %since I have three periods and 
k=100;
de1=dd;
while(k>km);
    de=de1; 
    %nch=zeros(J,T);
    uij1=betaip*P1+de(1:J,1); 
    %+alphaip*lambda.*(P1-P2)
    uij2=gamma*(betaip*lambda.*P2+de(1:J,2));
    %+betair*(1-lambda).*log(ones(J,1)+exp(betaip*P1))
    denom=sum([exp(uij1) exp(uij2) ones(J,1)],2);
    esh1=[exp(uij1)./denom exp(uij2)./denom ones(J,1)./denom];
    denom=sum([exp(de(1:J,1)) exp(de(1:J,2)) ones(J,1)],2);
    esh2=[exp(de(1:J,1))./denom exp(de(1:J,2))./denom ones(J,1)./denom];
    esh=esh1*pi1+esh2*(1-pi1);
    
    de1=de+log(Sh)-log(esh);
    k=max(max((abs(de1-de))'));
end;
% estimation of mean coefficients
dd=de1;
% call likelihood function
ObjFunc = @(x)RegDeltEst(x,dd,P1,P2,lambda,gamma,J);
[MX,fval1,exitflag1,output1] = fminsearch(ObjFunc,MX0);

%write likelihood for pi (size of main segment), betaip, alphaip, betair
%(use latent model form)
%Wrong!: y=-prod(esh(:)); %multiplication of all elements of all market shares
%recover errors
    uij1   =  dd(:,1);
    uij2   =   dd(:,2);
    c      =   MX(1,1);
    betap  =   MX(1,2);
    alphap =   MX(1,3);
    betar  =   MX(1,4);
    alpha  =   (MX(1,5:4+J))';
    %calculate error for the first period
    e1    =    uij1-(alpha+(c+gamma*c)*ones(J,1)+betap*P1);
    %+alphap*lambda.*(P1-P2)
    e12   =    e1.^2;
    e2    =    uij2-(gamma*(lambda.*(alpha+c*ones(J,1)+betap*P2)));
    %+betar*(1-lambda).*log(ones(J,1)+exp(alpha+(c+gamma*c)*ones(J,1)+betap*P1))
    e22   =     e2.^2;
%objective function should be square of errors for both
y  = sum(e12+e22) + sum(sum((Sh-esh).^2));

%Random component of brand preferences & price: variances
%aw1=x(1,1)*w1;
%aw2=x(1,2)*w2;
%aw3=x(1,3)*w3;
%aw4=x(1,4)*w4;

% for same dimension convention of MATLAB
%for i=1:1000;
%     if i==1;
%         om1=o(:,1);
%         om2=o(:,2);
%         om3=o(:,3);
%         om4=o(:,4);
%         pm=p(:,1);
%     else;
%         om1=[om1 o(:,1)];
%         om2=[om2 o(:,2)];
%         om3=[om3 o(:,3)];
%         om4=[om4 o(:,4)];
%         pm=[pm p];
%     end;
% end;
% aw=aw1.*om1+aw2.*om2+aw3.*om3+aw4.*om4; % create effect of variance on each of the brands
% awp=pm.*wp.*x(1,5); % price coefficient

%Contraction map
%dd=zeros(4*n,1);
%nch=zeros(4*n,1);

%     for i=1:nd;
%         ch=(exp(aw(:,i)+awp(:,i)+de));
%         ch=reshape(ch,n,4);
%         sumcol=1+sum(ch');
%         sumcol=sumcol';
%         sumcol=[sumcol sumcol sumcol sumcol];
%         ch=ch./(sumcol);
%         nch=nch+(reshape(ch,4*n,1)/nd);
%     end;

%zz=inv(nudta'*oins*mmm*oins'*nudta)*(nudta'*oins*mmm*oins'*dd);
%er=dd-nudta*zz;
%y=er'*oins*mmm*oins'*er;
%y=pi1*p1+pi2*p2+pi3*p3;