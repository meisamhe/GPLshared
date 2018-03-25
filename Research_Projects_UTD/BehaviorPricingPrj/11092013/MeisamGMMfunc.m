function llh = MeisamGMMfunc(p)
global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J
 % parameters: (bp,ah,a, c, tt)
  bp=p(1);
  ah=p(2);
  a=p(3);
  c=p(4);
  tt=p(5);
  v=p(6).^2;
  % F.O.C is summarized to:
% 1. E(D1*bp+D2*ah+C1)=0
% 2. E(D3*bp+D4*ah+C2)=0
% 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
% 4. E(D8-D9*(a+c)+bp*P2+D10*tt)=0
% 5. E((D5-a*cost-D6*c+bp*P1+D7*ah)^2)-v=0
% 6. E((D8-D9*(a*cost+c)+bp*P2+D10*tt)^2)-v=0
% 7. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*(a+c)+bp*P2+D10*tt))=0
  
  y1 = D1*bp+D2*ah+C1;
  y2 = D3*bp+D4*ah+C2;
  y3 = D5-a-D6*c+bp*P1+D7*ah;
  y4 = D8-D9*(a+c)+bp*P2+D10*tt;
  y5 = (D5-a-D6*c+bp*P1+D7*ah).^2-v;
  y6 = (D8-D9.*(a+c)+bp*P2+D10*tt).^2-v;
  y7 = (D5-a-D6*c+bp*P1+D7*ah).*(D8-D9*(a+c)+bp*P2+D10*tt);
  sig = [y1 y2 y3 y4 y5 y6 y7];
  sig = sig'*sig/J;
  psi = [mean(y1) mean(y2) mean(y3) mean(y4) mean(y5) mean(y6) mean(y7)]';
  llh = psi'*inv(sig)*psi*J;
return;