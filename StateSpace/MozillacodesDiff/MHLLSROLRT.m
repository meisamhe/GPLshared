% this function will calculate likelihood for metropolis hasting on: II) n(t) = f(E(n(t-1)),E(m(t-1))) + J*(n(t-1) - E(n(t-1)))  + w;  w~N(0,W), J: Jacobian
function  LL = MHLLSROLRT(pqalpha,ttind1,ttr1,Tj,w,olst,b0,eta) %,b1,b2,alpha
  p     = pqalpha(1);
  q     = pqalpha(2);
  alpha = pqalpha(3);
%   if (pqalpha(3)>1e2)
%      alpha = 1;
%   else
%      alpha = exp(pqalpha(3))/(1+exp(pqalpha(3))); % since alpha is between zero and 1
%   end;
  beta  = pqalpha(4:size(olst,2)+3);
  
  abg = [-q/alpha;(1-p+q);p*alpha;-beta;alpha.*beta]; % alpha beta gamma
  
  errors2=(ttr1-ttind1(1:Tj,:)*abg(:,1))'*(ttr1-ttind1(1:Tj,:)*abg(:,1));
  
  errorsxi2 = diag(([alpha;p;q;beta]-b0)'*([alpha;p;q;beta]-b0));

  prior = - 0.5*(3+size(beta,1))*sum(log(2*pi*eta)) -   0.5*sum(errorsxi2./eta);
  
  LL =(- 0.5*Tj*log(2*pi*w) -   0.5*sum(errors2/w) + prior);
return;