% To check the identification for model with regret
function [y] = HorskeySimonMethodM0(x,yc,ppparam,npparam,qpparam,ttind1p,ttr1,Lpriorp,m,wp)

%f = -qpparam/x*ttind1p.^2 + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam).*ttind1p+ppparam*x + yc(1:(size(yc,1)-1),:)*npparam*x;
f = -qpparam/x*(2*ttind1p.*m-m.^2) + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam).*ttind1p+ppparam*x + yc(1:(size(yc,1)-1),:)*npparam*x;
errors = ttr1-f;
%variance =   mean(errors.^2);

LL =    - 0.5*size(ttind1p,1)*log(2*pi*wp) -   0.5*sum(errors.^2/wp);


y = -LL - Lpriorp;

%gradf=sum(Lpriorp+errors.*(qpparam/x^2*ttind1p.^2 + ppparam +yc(1:(size(yc,1)-1),:)*npparam)/variance);

%,gradf
