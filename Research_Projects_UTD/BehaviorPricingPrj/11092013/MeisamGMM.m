clear all
global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J
load Dm.csv; s = Dm;
[J,p]   =   size(s);
Dur1=ones(J,1);
Dur2=ones(J,1);
P1=s(:,2);
P2=s(:,3);
Av2=s(:,4);
S1=s(:,5);
S2=s(:,6);
OU= s(:,7);
T  =  3;
A  = Av2;
% normalized sales of second period
S2temp = S2./A;
S1 = S1./(S1+S2temp);
S2 = S2temp./(S1+S2temp);
r=1./(1+.0025).^Dur1;
shares=[S1 S2];
outside=repmat(OU,[1 2]);
d=P1-P2./P2;

% F.O.C is summarized to:
% 1. E(D1*bp+D2*ah+C1)=0
% 2. E(D3*bp+D4*ah+C2)=0
% 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
% 4. E(D8-D9*(a+c)+bp*P2+D10*tt1)=0
% 5. E((D5-a*cost-D6*c+bp*P1+D7*ah)^2)-v=0
% 6. E((D8-D9*(a*cost+c)+bp*P2+D10*tt1)^2)-v=0
% 7. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*(a+c)+bp*P2+D10*tt1))=0
% tt1=br*c
%parameters are: (bp,ah,a, c, tt1)
D1=S1.*P1-S1.^2.*P1-r.*A.*(1-d).*S1.*S2.*P1+r.*A.*(1-d).^2.*S2.*P1-S1.*S2.*(1-d).*P1-r.*A.*(1-d).^2.*S2.^2.*P1;
D2=-A.*d.*S1.*P1+A.*d.*S1.^2.*P1+A.*d.*S1.*S2.*(1-d).*P1;
C1=S1+S2;
D3=r.*A.*P1.*S1.*S2-r.*A.*P1.^2.*(1-d).*S2+r.*A.*P1.^2.*(1-d).*S2.^2;
D4=A.*P1.*S1.*P1-A.*S1.^2.*P1.^2-A.*S1.*S2.*(1-d).*P1.^2;
C2=-S2.*P2;
D5=shares(:,1)-outside(:,1);
D6=1+r;
D7=A.*(P2-P1);
D8=shares(:,2)-outside(:,2);
D9=A.*r;
D10=(1-A).*(1+r);
% parameters: (bp,ah,a, c, tt, v)
init_p = [-0.022 -.3 .1 .1 .1 1];
[param,fval,exitflag,output,grad1,hess1] = fminunc('MeisamGMMfunc', init_p, optimset('Display','iter','TolX',1e-8,'TolFun',1e-8));
std = diag(inv(hess1));
%std
std = sqrt(std);
std=std';
trat = param(1:4)./std(1:4);
disp('parm estimates and t-stat for (bp,ah,a, c, v) are:');
[param(1:4) param(6).^2;trat param(6).^2./std(6)]
bp=param(1);
ah=param(2);
a=param(3);
c=param(4);
tt=param(5);
v = param(6).^2;
betar_e =tt/c;
STEFOC=[1/c -tt/c^2];
ParamCovar =hess1([4 5],[4 5]);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC');
disp('stock out regret coefficient and tstat is is:');
[betar_e;betar_e./betarSTE]