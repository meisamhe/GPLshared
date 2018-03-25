function y = RegDeltEst(x,delta,P1,P2,lambda,gamma,J)
    % x=[c betap alphap betar alpha']
    % Estimate following parameters
    % alpha: brand intercept
    % c: usage utility
    % betap: coefficient of price
    % alphap: high price regret
    % betar: unavailability regret
    % delta is the mean that is estimated previously (response)
    uij1=delta(:,1);
    uij2=delta(:,2);
    c=x(1,1);
    betap=x(1,2);
    alphap=x(1,3);
    betar=x(1,4);
    alpha=(x(1,5:4+J))';
    %calculate error for the first period
    e1    =    uij1-(alpha+(c+gamma*c)*ones(J,1)+betap*P1);
    %+alphap*lambda.*(P1-P2)
    e12   =    e1.^2;
    e2    =    uij2-(gamma*(lambda.*(alpha+c*ones(J,1)+betap*P2)));
    %+betar*(1-lambda).*log(ones(J,1)+exp(alpha+(c+gamma*c)*ones(J,1)+betap*P1))
    e22   =     e2.^2;
%objective function should be square of errors for both
y=sum(e12+e22);