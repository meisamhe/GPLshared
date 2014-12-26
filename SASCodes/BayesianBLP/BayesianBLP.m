%Bayesian BLP
%---------------------simulate data---------------------------------------
% model sizes    
    J=3; % number of brands
    T=5; % attribute of brand or shock
    K=3; %number of random coefficients
    H=1000; % number of people for heterogeneity
%configurable parameters
    tao=10; %variance of aggregate shock
    sigmasqR_DIAG=2; % diagonal variance prior
    sigmasqR_off=10; %  off diagonal variance prior
    Athetabar=inv(eye(K)*10); %Variance of mean sensitivity
%derivatives
    X=randn(T*J,K); %observed product attributes (only on one attribute for simplicity)
  %generate thetabar
    thetabar=mvnrnd(zeros(K,1),Athetabar);  % average sensitivity to each coeff
    thetabar=thetabar'; 
    v=randn(K,H); % vector of heterogeneity
    eta=tao*randn(T*J,1); % unobserved product attribute (aggregate demand shock)
    mu=X*thetabar+eta; % the mean part of utility, heterogeniety excluded
    mu=repmat(mu,1,H); % to be able to add it to variance matrix
  %Sigma (variance of shock) random variable genration
    r(1,1:K)=normrnd(0,sigmasqR_DIAG,[1 K]);
    r(1,(K+1):(K*(K+1)/2))=normrnd(0,sigmasqR_off,[1 K*(K-1)/2]);
    L=diag(exp(r(1,1:K))); % assume r a horizontal vector and creat matrix with diagonals of its exponent
    temp = triu(ones(K),1);
    temp(~~temp)=r(1,(K+1):(K*(K+1)/2));
    temp=temp';
    L=temp'+L;
    Sigma=L*L';   %variance of sensitivity
    % create random coefficients for H person:
    upart=X*L*v; %JT by H
 % generating share   
    num=exp(upart+mu); % JT by H numerator
    for t=1:T;
        den1(t,:)=1+sum(num(((t-1)*J+1):(t*J),:)); %T by H
    end;
    %den=matrix(rep(den1,each=J),ncol=H); %replc each t J times,JT by H
    den=repmat(den1,J,1);
    prob=num./den; % JT by H
    S=reshape(mean(prob'),J,T);% T by J share
    
%------------------preparation--------------------------------------------
%store value/ simulation parameters
    bi=100;
    iter=1000;
    M=bi+iter;
    thetat=zeros(iter,K); %vector of mean sensitivity
    taot=zeros(iter,1); %vector of shock var
    rt=zeros(iter,K*(K+1)/2); %vector of variance
    mut=zeros(iter,J*T); %vector of variance

%priors
  %configurable parameters
    tao=10; %variance of aggregate shock
    sigmasqR_DIAG=2; % diagonal variance prior
    sigmasqR_off=10; %  off diagonal variance prior
    Athetabar=inv(eye(K)*10); %Variance of mean sensitivity
    alpha0=100;
    delta0=1;
    varn_r=10*ones(K*(K+1)/2,K*(K+1)/2); % candidate covariance matrix [K*(K+1)/2] by [K*(K+1)/2] of covariance between sensitivities

    thetabar0=mvnrnd(zeros(K,1),Athetabar);
    thetabar0=thetabar0'; 
    v=randn(K,H); % vector of heterogeneity
    eta=tao*randn(T*J,1); % unobserved product attribute (aggregate demand shock)
    mu=X*thetabar0+eta; % the mean part of utility, heterogeniety excluded
    
    % prior for r, vector of size K*(K+1)/2 of the covariances
    r(1,1:K)=normrnd(0,sigmasqR_DIAG,[1 K]);
    r(1,(K+1):(K*(K+1)/2))=normrnd(0,sigmasqR_off,[1 K*(K-1)/2]);
for i=1:M        
% ------------ (1) Gibbs Sampler for thetabar and taosq --------------------
    sigt1=inv ((X'*X)/tao+inv(Athetabar));
    mut1 = sigt1*((X'*mu)/tao+inv(Athetabar)*thetabar0);
    thetabar1= mut1 + chol(sigt1)'*randn(K,1);
    %this value of thetabar1 will be used in draw of taosq
    
   % sigma update
    et= mu-X*thetabar1;
    ete= et'*et;
    alphat= (alpha0+(T*J))/2;
    deltat= (delta0+ete)/2; %getting updated as a result of betabar update (ete)
    s2t2= gamrnd( alphat,1/deltat);
    tao= 1/s2t2;
    % update taosq so that it be used in the next draw of thetabar
    
    %y1 --> y=mu
    %x --> X
    %s2t1 --> sigmasq=taosq
    % B0-->A=Athetabar
    % beta0-->betabar=thetabar0
    % -->nu=nu0
    % s2t1-->ssq=s0sq
    %output=runiregG(y=mu,X=X,XpX=XpX,Xpy=crossprod(X,mu),sigmasq=taosq,
    %A=Athetabar,betabar=thetabar0,nu=nu0,ssq=s0sq)
    %thetabar=output$betadraw
    %taosq=output$sigmasqdraw
% ------------ (2) Metropolis for r ----------------------------------------
    % Random-Walk Chain
    %rN=r+mvrnorm(1,rep(0,(K*(K+1)/2)),varn_r)  % means create multivar normal with mean zero and variance var_r
    rN=r+mvnrnd(zeros(1,(K*(K+1)/2)),varn_r);    % vector of parameters of var-cov matrix
    crit=0.00001;
    ON=Loglhd(X,S,v,rN,mu,thetabar,tao,H,K,T,J,crit); % use log likelihood for accept rejection
    % use log likelihood rather than likelihood, and calculate for
    % normal distribution likelihood of sensitivity variance
    prior_old=sum(-r(1,1:K).^2/2/sigmasqR_DIAG)+sum(-r(1,(K+1):(K*(K+1)/2)).^2/2/sigmasqR_off);
    prior_new=sum(-rN(1:K).^2/2/sigmasqR_DIAG)+sum(-rN((K+1):(K*(K+1)/2)).^2/2/sigmasqR_off);
    % Evaluate old r (mu) at new (thetabar,taosq)
    %eta=mu-X%*%thetabar
    eta=mu-X*thetabar; % shock as a result of previous mu that is saved
    %llhd_old=sum(log(dnorm(eta,sd=sqrt(taosq))))+OO$sumlogjacob
    % eta is shock, and taosq is its variance, normal distribution part of
    % likelihood
    llhd_old=sum(log(normpdf(eta,tao)))+ON(1,3);
    % four parts (1) likelihood of now (from function) (2)likelihood of old
    % from previous mu, eta (3) new likelihood (4) new prior updated on r
    ratio=exp(ON(1,1)+prior_new-llhd_old-prior_old);
    alphaS=min(1,ratio); % S stands for Sigma
    if (1<=alphaS) 
        r=rN; % update r
        OO=ON; %ns=ns+1; %mu=OO$mu
        mu=OO(:,2);% update mu for next likelihood calculation
    end;
    if (i>bi);
        thetat(i-bi,:)=thetabar1;%vector of mean sensitivity
        taot(i-bi,:)=tao; %vector of shock var
        rt(i-bi,:)=r; %vector of variance
        mut(i-bi,:)=mu;
    end;
    
   if rem(i,10)==0;
       i
   end;

end;

