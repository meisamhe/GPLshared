% this function will calculate likelihood for metropolis hasting on: II) n(t) = f(E(n(t-1)),E(m(t-1))) + J*(n(t-1) - E(n(t-1)))  + w;  w~N(0,W), J: Jacobian
function  LL = MHLLSROLRTpqFE(pqalpha,ttind1,ttr1,Tj,w,b0,eta,rp,rq,n) %,b1,b2,alpha
%   p     = pqalpha(1);
%   q     = pqalpha(2);
  alpha = pqalpha(1:n);
  %exp(pqalpha(1:n)-log(1+exp(pqalpha(1:n)))); 
 % beta  = pqalpha(1+n:rp+n);
 % gamma  = pqalpha(rp+n+1:rp+rq+n);
  delta = pqalpha(rp+rq+n+1:rp+rq+n+n);
  %exp(pqalpha(rp+rq+n+1:rp+rq+n+n)-log(1+exp(pqalpha(rp+rq+n+1:rp+rq+n+n))));
  
  % rebuild beta and gamma for the related 2 and 3 columns that I have
  % extra
  % first build beta
  beta   = [pqalpha(1+n:2*n);pqalpha(2*n+1)*ones(n,1);pqalpha(2*n+2)*ones(n,1)]; %this will be fixed effects first and then replication of related elements
  gamma  = [pqalpha(rp+n+1:rp+2*n);pqalpha(rp+2*n+1)*ones(n,1);pqalpha(rp+2*n+2)*ones(n,1);pqalpha(rp+2*n+3)*ones(n,1)];
%  disp('start printing sizes')
%   size(gamma)
%   size(-gamma.*repmat((1-delta)./alpha,[4 1]))
%   size(1-delta)
%   size(-beta)
%   size(repmat(alpha,[3 1]).*beta)
%   size(repmat((1-delta),[4 1]).*gamma)
  param = [-gamma.*repmat((1-delta)./alpha,[4 1]);1-delta;-beta;repmat(alpha,[3 1]).*beta;repmat((1-delta),[4 1]).*gamma]; % alpha beta gamma -q/alpha; (1-p+q) p*alpha;
%  param = [-gamma/alpha;1;-beta;alpha.*beta;gamma];
%   
%   size(ttind1(1:Tj,:))
%   size(param(:,1))
%   size(ttind1(1:Tj,:))
%   size (param(:,1))
  errors2=(ttr1-ttind1(1:Tj,:)*param(:,1))'*(ttr1-ttind1(1:Tj,:)*param(:,1));
  
 % errorsxi2 = diag(([alpha;beta;gamma;delta]-b0)'*([alpha;beta;gamma;delta]-b0)); %;p;q p;q;
   errorsxi2 = diag((pqalpha-b0)'*(pqalpha-b0)); %;p;q p;q;
 % errorsxi2 = diag(([alpha;beta;gamma]-b0)'*([alpha;beta;gamma]-b0)); %;p;q p;q;

  prior = - 0.5*(3+size(beta,1))*sum(log(2*pi*eta)) -   0.5*sum(errorsxi2./eta);
  
  LL =(- 0.5*Tj*log(2*pi*w) -   0.5*sum(errors2/w) + prior);
return;