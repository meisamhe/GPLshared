clear all
global D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 C1 C2 P1 P2 J cost D11 r D12 MKTSz
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\BehavioralPricing\Data\cleaned10232013.xlsx',1);
[J,p]   =   size(num);
Dur1=num(:,2);
Dur2=num(:,3);
P1=num(:,4);
P2=num(:,5);
Av1=num(:,6);
Av2=num(:,7);
Av3=num(:,12);
S1=num(:,8);
S2=num(:,9);
MKTSz=num(:,10);
cost = num(:,11);
T  =  3;
A  = Av2;
% normalized sales of second period
MKTSz=MKTSz/1.25;
cf=1.25;
MKTSz=MKTSz*cf;
MKTSz = MKTSz - (cf*S2); 
S2 = S2./A;
MKTSz = MKTSz + (cf*S2); 
r=1./(1+.0025).^Dur1;
shares=[S1./MKTSz S2./MKTSz];
%normalize Market size
MKTSz=MKTSz./10000;
% put back shares so that it is used in calculation of F.O.C components
S1=shares(:,1);
S2=shares(:,2);
outside=repmat(ones(J,1) - sum(shares,2),[1 2]);
d=1-P2./P1; % (1-d)P1=P2
% F.O.C is summarized to:
% 1. E(D1*bp+D2*ah+C1)=0
% 2. E(D3*bp+D4*ah+C2)=0
% 3. E(D5-a-D6*c+bp*P1+D7*ah)=0
% 4. E(D8-D9*a+D11*c+r.*bp*P2+D10*tt1)=0
% 5. E((D5-a-D6*c+bp*P1+D7*ah)^2)-v=0
% 6. E((D8-D9*a+D11*c+r.*bp*P2+D10*tt1)^2)-v=0
% 5. E((D5-a-D6*c+bp*P1+D7*ah)*(D8-D9*a+D11*c+r.*bp*P2+D10*tt1))=0
% tt1=br*c
%parameters are: (bp,ah,a, c, tt1,v)
D1=S1.*(P1-cost)-S1.^2.*(P1-cost)-r.*A.*(1-d).*S1.*S2.*(P1-cost)+r.^2.*A.*(1-d).^2.*S2.*(P1-cost)-S1.*S2.*(1-d).*(P1-cost).*r-r.^2.*A.*(1-d).^2.*S2.^2.*(P1-cost);
D2=P1.*d.*S1-A.*d.*S1.^2.*P1-A.*d.*S1.*S2.*(1-d).*P1.^r;
C1=S1+r.*(1-d).*S2;
D3=r.*A.*P1.*(P1-cost).*S1.*S2-r.^2.*A.*P1.*(P1-cost).*(1-d).*S2+r.^2.*A.*P1.*(P1-cost).*(1-d).*S2.^2;
D4=A.*P1.^2.*S1.*P1-A.*S1.^2.*P1.^2-r.*A.*S1.*S2.*(1-d).*P1.^2;
C2=-r.*S2.*P1;
D5=shares(:,1)-outside(:,1);
D6=(0.5*Dur1+r.*Dur2); %consider duration effect on consumption
D7=A.*(P1-P2);
D8=shares(:,2)-outside(:,2);
D9=A.*r;
D11 = A.*r.*Dur2.*.5; %include duration of usage into the model
D10=r.*(1-A).*(.5*Dur1+r.*Dur2); %include duration of usage in the model
D12 =r.*A.*(P1-P2);%.*cost
% parameters: (bp,ah,a, c, tt, v, kt)
init_p =   [-0.018 -0.1 0.1 0.6 -0.08 1 .5];%
%[ -0.3   -3    .5    1   -0.8   20  .2];
%[-0.018 -0.04 0.1 0.5 -0.018 10 .01];
%;
%[-2 -1 1 1 1 -1 1];
%[-0.2 -.3 .3 .5 .1 1];
%zeros(1,6);
% [-0.01 -.3 .1 .5 .1 1];
[param,fval,exitflag,output,grad1,hess1] = fminunc('MeisamGMMfunc', init_p, optimset('Display','iter','TolX',1e-8,'TolFun',1e-8,'MaxFunEvals',7000));
std = diag(pinv(hess1));
std = sqrt(std);
trat = [-exp(param(1:2)) exp(param(3:4))]./std(1:4,1)';
disp('parm estimates and t-stat for (bp,ah,a, c, v) are:');
disp([-exp(param(1:2)) exp(param(3:4)) param(6).^2;trat(1,1:4) (param(6).^2)./std(6,1)]);
bp=-exp(param(1));
ah=-exp(param(2));
a=exp(param(3));
c=exp(param(4));
tt=param(5);
v = param(6).^2;
betar_e =tt/c;
STEFOC=[1/c -tt/c^2];
ParamCovar =hess1([4 5],[4 5]);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC');
disp('stock out regret coefficient and tstat is is:');
disp([betar_e;betar_e./betarSTE])
disp('cherry picking coefficient is:');
disp(exp(param(7)))
disp(exp(param(7))./std(7,1)')
LL=-fval
p=7;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);