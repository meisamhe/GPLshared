
% log likelihood function code uses invert function
function list=Loglhd(X,S,v,r,mu,thetabar,tao,H,K,T,J,crit)
    % Purpose: Evaluate log likelihood. Sigma is re-parameterized as r.
    % (1). Transform r to L, where Sigma=LL'
        %L=diag(exp(r[1:K]))
        %L[lower.tri(L)]=r[(K+1):(K*(K+1)/2)]
        L=diag(exp(r(1,1:K))); % assume r a horizontal vector and creat matrix with diagonals of its exponent
        temp = triu(ones(K),1);
        temp(~~temp)=r(1,(K+1):(K*(K+1)/2));
        temp=temp'; 
        L=temp'+L; % var-cov of sensitivity decomposed
    % (2). At given L, do inversion to get mu. Then compute eta
        %(L,mu,v,crit,T,H,J,lnactS,indTHJ,indJTH);
        temp = Invert(X,S,L,mu,v,crit,T,J,H);  % contraction mapping
        mu = temp(:,1); prob = temp(:,2:H+1); %niter = temp(1,3);
        eta = mu-X*thetabar; % demand shock
    % (3). Jacobian
        % Form J diagonal elements at each time t
        %diagonal = rowMeans(prob*(1-prob)) 
        temp=prob.*(1-prob);  % TJ by 1 vector
        diagonal=mean(temp,2); % TJ by 1 vector, row mean
        % Form the off diagonal elements
        %dd=-prob%*%t(prob)/H % TJ by TJ
        dd=-prob*prob'/H; % converts integration to form of sum
        % create Jacobian matrix:
        %cc=aaa*dd+diag(diagonal)#TJ by TJ matrix: block diagonal
        cc=(ones(T*J,T*J)-eye(T*J,T*J)).*dd+diag(diagonal);%TJ by TJ matrix: block diagonal
        % calculating jacobian based on each shock in time and sum
        % according to the likelihood function:
        for t = 1:T;
            cct=cc(((t-1)*J+1):(t*J),((t-1)*J+1):(t*J)); %(t)th block of cc
            logjacob(1,t)=-log(abs(det(cct)));
        end;
    % (4). Form Log Likelihood
    sumlogjacob=sum(logjacob);
    %llhd=sum(log(dnorm(eta,sd=sqrt(taosq))))+sumlogjacob
    llhd=sum(log(normpdf(eta,tao)))+sumlogjacob;
list=[llhd*ones(T*J,1) mu sumlogjacob*ones(T*J,1)]; %making the return value same size
