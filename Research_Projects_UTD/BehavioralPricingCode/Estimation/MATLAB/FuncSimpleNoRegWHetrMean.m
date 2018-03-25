function y = FuncSimpleNoRegWHetrMean (x,delta,P1,P2,lambda,gamma,J)%(x,w1,w2,w3,w4,wp,p,o,s,nudta,oins,mmm,n,km,nd);
    global likelihoodM variance;
    % x=[c betap alphap betar alpha']
    % Estimate following parameters
    % alpha: brand intercept
    % c: usage utility
    % betap: coefficient of price
    % alphap: high price regret
    % betar: unavailability regret
    % delta is the mean that is estimated previously (response)
    uij1  =  delta(:,1);
    uij2  =  delta(:,2);
    dd    =  delta(:,3);
    c     =  x(1,1);
    betap =  x(1,2);
    alpha =  x(1,3);
    %calculate error for the first period
    e1    =    uij1-((alpha +c + gamma*c)*ones(J,1) + betap*P1);   
    e2    =    uij2-(gamma*lambda.*((alpha+c)*ones(J,1) + betap*P2));
    % unobserved demand shock matrix
    dmsh  =  [e1 e2  dd(:,1)];
    dmsh2 =  dmsh.^2;
    % Likelihood function
    variance                 =    mean(dmsh2(:));
    likelihoodM =    - 3*J*log(sqrt(2*pi*variance)) -   .5*sum(dmsh2(:)./variance);
    y           =    - likelihoodM ;