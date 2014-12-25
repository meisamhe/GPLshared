% this function will calculate likelihood for metropolis hasting on: II) n(t) = f(E(n(t-1)),E(m(t-1))) + J*(n(t-1) - E(n(t-1)))  + w;  w~N(0,W), J: Jacobian
function  LL = MHLLSROLRTpq(pqalpha,ttind1,ttr1,Tj,w,b0,eta,rp,rq) %,b1,b2,alpha
%   p     = pqalpha(1);
%   q     = pqalpha(2);
  alpha = pqalpha(1);
  beta  = pqalpha(2:rp+1);
  gamma  = pqalpha(rp+2:rp+rq+1);
 delta = pqalpha(rp+rq+2);
  
  param = [-gamma*(1-delta)/alpha;1-delta;-beta;alpha.*beta;(1-delta)*gamma]; % alpha beta gamma -q/alpha; (1-p+q) p*alpha;
%  param = [-gamma/alpha;1;-beta;alpha.*beta;gamma];
%   
%   size(ttind1(1:Tj,:))
%   size(param(:,1))
  errors2=(ttr1-ttind1(1:Tj,:)*param(:,1))'*(ttr1-ttind1(1:Tj,:)*param(:,1));
  
  errorsxi2 = diag(([alpha;beta;gamma;delta]-b0)'*([alpha;beta;gamma;delta]-b0)); %;p;q p;q;
 % errorsxi2 = diag(([alpha;beta;gamma]-b0)'*([alpha;beta;gamma]-b0)); %;p;q p;q;

  prior = - 0.5*(3+size(beta,1))*sum(log(2*pi*eta)) -   0.5*sum(errorsxi2./eta);
  
  LL =(- 0.5*Tj*log(2*pi*w) -   0.5*sum(errors2/w) + prior);
return;