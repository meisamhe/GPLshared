J  = 1000;
T  =  3;
P1          =   randi(20,J,1);
discount    =   rand(J,1);
P2          =   ceil(P1.*(1-discount));
lambda      =   rand(J,1); %availability

alpha  = 2*rand(1,1);
c     = rand(1,1);

gamma =.975; %discount factor

%segment size
pi1         =   rand(1,1); %for first segment
%For both segments
%price coefficient
bp    = rand(1,2);
bp   =[min(bp) max(bp)];
% high price regret coefficient
alphap = 3*rand(1,2);
alphap   =[min(alphap) max(alphap)];
% stock out regret coefficient
betar = 5*rand(1,2);
betar   =[min(betar) max(betar)];

% Unobserved demand shock
xi          =   randn(J,2);
% calculate utility
% for the first segment
uij1(:,1) =      alpha+(c+gamma*c)+bp(1,1)*P1+ alphap(1,1)*lambda.*(P1-P2)+ xi(:,1);
uij2(:,1) =      gamma*(lambda.*(alpha+c+bp(1,1)*P2)+ betar(1,1)*(ones(J,1)-lambda).*(c+gamma*c))+ xi(:,2);
% second segment
uij1(:,2) =      uij1(:,1) + bp(1,2)*P1+ alphap(1,2)*lambda.*(P1-P2);
uij2(:,2) =      uij2(:,1) +  gamma*(lambda.*(bp(1,2)*P2)+ betar(1,2)*(ones(J,1)-lambda).*(c+gamma*c));
e1=exp(uij1); e2=exp(uij2);
shares_1=[e1(:,1)./(1+e1(:,1)+e2(:,1)) e2(:,1)./(1+e1(:,1)+e2(:,1))];
shares_2=[e1(:,2)./(1+e1(:,2)+e2(:,2)) e2(:,2)./(1+e1(:,2)+e2(:,2))];
shares  = pi1*shares_1 + (1-pi1)*shares_2;
outside_1=[1./(1+e1(:,1)+e2(:,1)) 1./(1+e1(:,1)+e2(:,1))];
outside_2=[1./(1+e1(:,2)+e2(:,2)) 1./(1+e1(:,2)+e2(:,2))];
outside  = pi1*outside_1 + (1-pi1)*outside_2;