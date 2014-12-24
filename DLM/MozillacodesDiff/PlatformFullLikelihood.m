% To check the identification for model with regret
function [y] = PlatformFullLikelihood(x,yc,ttind1p,ttr1,m,wp,priorvar,priormean,caddon)


ppparam = x(1);
qpparam = x(2);
M0      = x(3);
eta     = x(4);
npparam = x(5:size(x,2));

% size(-qpparam/M0*(2*ttind1p.*m-m.^2))
% size( (1+qpparam-ppparam).*ttind1p)
% size(-(yc(1:(size(yc,1)-1),:)*npparam'))
% size(ttind1p)
% size((ppparam*M0))
% size(((yc(1:(size(yc,1)-1),:)*npparam')*M0))

%f = -qpparam/x*ttind1p.^2 + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam).*ttind1p+ppparam*x + yc(1:(size(yc,1)-1),:)*npparam*x;
f = -qpparam./(M0+eta*caddon(1:(size(yc,1)-1),:)).*(2*ttind1p.*m-m.^2) + (1+qpparam-ppparam).*ttind1p-(yc(1:(size(yc,1)-1),:)*npparam').*ttind1p+(ppparam.*(M0+eta*caddon(1:(size(yc,1)-1),:))) +...
    ((yc(1:(size(yc,1)-1),:)*npparam').*(M0+eta*caddon(1:(size(yc,1)-1),:)));
errors = ttr1-f;
%variance =   mean(errors.^2);

LL =    - 0.5*size(ttind1p,1)*log(2*pi*wp) -   0.5*sum(errors.^2/wp);

Lpriorp =  - 0.5*size(x,2)*log(2*pi*priorvar) -   0.5*sum((x-priormean).^2./priorvar);


y = -LL - Lpriorp;

%gradf=sum(Lpriorp+errors.*(qpparam/x^2*ttind1p.^2 + ppparam +yc(1:(size(yc,1)-1),:)*npparam)/variance);

%,gradf
