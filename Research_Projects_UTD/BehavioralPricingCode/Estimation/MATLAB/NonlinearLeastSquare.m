function y = NonlinearLeastSquare(x)
%find a, c, bp, alpap, betar
global P1 P2 Dur1 Dur2 lambda gamma cost YnNLSQ; %outside_n


J =size(P1,1);
alpha =x(1);
c=x(2);
bp=x(3);
alphap=x(4);
betar=x(5);

uij1 =      alpha.*cost+(0.5*Dur1.*c+gamma.*c.*Dur2)+bp*P1+ alphap.*lambda.*(P1-P2);
uij2 =      gamma.*(lambda.*(alpha.*cost+0.5*Dur2.*c+bp*P2)+ betar*(ones(J,1)-lambda).*(0.5*Dur1.*c+gamma.*c.*Dur2));


r(:,1) = YnNLSQ(:,1) - uij1;
r(:,2) = YnNLSQ(:,2) - uij2;

% condition =repmat(r(:,1),[1 4]).*[cost (0.5*Dur1+gamma.*Dur2) P1 lambda.*(P1-P2)]+...
%  repmat(r(:,2),[1 4]).*[gamma.*lambda.*cost (0.5*Dur2).*gamma.*lambda+gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)*betar...
%    gamma.*lambda.*P2 gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2).*c];

% y = sum(condition(:));

y = sum(r(:).^2);