% invert function that is used in likelihood (Does contraction mapping like
% the way GMM BLP does
function list=Invert (X,S,L,mu,v,crit,T,J,H) %(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH)
    % Purpose: Invert observed shares S at give L to get mean utility mu's.
    prob=zeros(J*T,H);
    niter=0; % number of iterations taken for the inversion
    munew=mu; % starting value
    muold=munew/2;
    upart=X*L*v; %effect of variance (covar*variance*pop random draw): cholesky=L
    while (max(abs((muold-munew)/munew))>crit);
        muold=munew;
        muold=repmat(muold,1,H); % same size as upart
        size(muold)
        num=exp(upart+ muold); % JT by H numerator
        %den1=matrix(double(T*H),nrow=T)
        for t=1:T;
            den1(t,:)=1+sum(num(((t-1)*J+1):(t*J),:)); %T by H
        end;
        %den=matrix(rep(den1,each=J),ncol=H); %replc each t J times,JT by H
        den=repmat(den1,J,1);
        prob=num./den; % JT by H
        %sh=t(matrix(rowMeans(prob), nrow=J)) 
        sh=reshape(mean(prob'),J,T);% T by J predicted share
        %munew=t(matrix(muold,nrow=J))+log(S)-log(sh) % T by J (t is
        %transpose)
        munew=reshape(mean(muold'),J,T)+log(S)-log(sh); %sh is estimated share (mean over all H people)
        %munew=as.vector(t(munew)) % length JT vector
        munew=reshape(munew,J*T,1); % length JT vertical vector
        muold=muold(:,1); % for the purpose of next iteration comparison [JT*1]
        niter=niter+1;
    end;
list=[munew prob];