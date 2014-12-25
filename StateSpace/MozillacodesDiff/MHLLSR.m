% this function will calculate likelihood for metropolis hasting on: II) n(t) = f(E(n(t-1)),E(m(t-1))) + J*(n(t-1) - E(n(t-1)))  + w;  w~N(0,W), J: Jacobian
function  LL = MHLLSR(pqalpha,ttind1,ttr1,Tj,w) %,b1,b2,alpha
  p     = pqalpha(1);
  q     = pqalpha(2);
  alpha = exp(pqalpha(3))/(1+exp(pqalpha(3))); % since alpha is between zero and 1
  abg = [-q/alpha;(1-p+q);p*alpha]; % alpha beta gamma
  errors2=(ttr1-ttind1(1:Tj,1:3)*abg(1:3,1))'*(ttr1-ttind1(1:Tj,1:3)*abg(1:3,1));
  
  LL =-(- 0.5*Tj*log(2*pi*w) -   0.5*sum(errors2/w));
return;