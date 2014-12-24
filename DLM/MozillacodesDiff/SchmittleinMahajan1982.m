% To check the identification for model with regret
function [LL] = SchmittleinMahajan1982(x,tt0,tt1,Tj,pT,tt1p) %,gradf

p = exp(x(1));
q = exp(x(2));
alpha = exp(x(3))/(1+exp(x(3))); % because it cannot be more than estimated market size

% claculate parameter of likelihood
a  = q/p;
b = (a+1)*p;
c= alpha;

% create data of likelihood
ttr1   = tt1';
ttind1 = [tt0;tt1(1:Tj-1)'];
xi     = ttr1 -ttind1; % for those who adopt at moment t
T = 1:1:Tj;
LT =0:1:(Tj-1);

xT    = tt1p(pT) - tt1(Tj);


LL = -(sum(xi'.*(log(max(c,1e-50))+log(max(((1-exp(-b*T))./(1+a*exp(-b*T))-(1-exp(-b*LT))./(1+a*exp(-b*LT))),1e-50))))+xT*log(max(1-c*(1-exp(-b*Tj))./(1+a*exp(-b*Tj)),1e-50)));

