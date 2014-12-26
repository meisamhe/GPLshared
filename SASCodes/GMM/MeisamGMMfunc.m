function llh = MeisamGMMfunc(p)
global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
 % parameters: (bp,ah,a, c, tt)
  bp=-exp(p(1));
  ah=-exp(p(2));
  a=exp(p(3));
  c=exp(p(4));
  tt=p(5);
  v=p(6).^2; % to make sure that variance is positive
  %rho =exp(p(7))/(1+exp(p(7))); % assuming autocorrelation
  rp=exp(p(7));
  
% F.O.C is summarized to:
% F.O.C is summarized to:
% 1. E(D1*bp+D2*ah+C1)=0
% 2. E(D3*bp+D4*ah+C2)=0
% 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
% 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
% 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
% 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
% 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
  %.*cost
  
  y1 = D1*bp+C1; %+D2*ah
  y2 = D3*bp+C2; %+D4*ah
  y3 = -D5+a./MKTSz+D6*c.*cost+bp*P1+D7*ah; %
  y4 = -D8+D9.*a./MKTSz+D11.*c.*cost+r.*bp.*P2+D10*tt.*cost+D12*rp;%
  y5 = (-D5+a./MKTSz+D6*c.*cost+bp*P1+D7*ah).^2-v; %
  y6 = (-D8+D9.*a./MKTSz+D11.*c.*cost+r.*bp.*P2+D10*tt.*cost+D12*rp).^2-v; %
  y7 = (-D5+a./MKTSz+D6*c.*cost+bp*P1+D7*ah).*(-D8+D9.*a./MKTSz+D11.*c.*cost+r.*bp.*P2+D10*tt.*cost+D12*rp);%-rho*v
  sig = [y1 y2 y3 y4 y5 y6 y7];
  sig = sig'*sig/J;
  psi = [mean(y1) mean(y2) mean(y3) mean(y4) mean(y5) mean(y6) mean(y7)]';
  llh = psi'*inv(sig)*psi*J;
return;
