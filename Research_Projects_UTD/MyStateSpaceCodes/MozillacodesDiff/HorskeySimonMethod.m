% To check the identification for model with regret
function [y] = HorskeySimonMethod(x,yp,yc) %,gradf
global betas se_est;

pT =size(yp,1);
ypdiff =diff(yp);
%x =exp(x); % to make sure it is positive
% size(yc(1:(size(yc,1)-1),:))
% size((repmat(x,[(pT-1) size(yc,2)])))
% size(yp(1:(pT-1)))
%size((repmat(x,[(pT-1) size(yc,2)])-yp(1:(pT-1))))
ypindep = [(repmat(x,[(pT-1) 1])-yp(1:(pT-1))) yc(1:(size(yc,1)-1),:).*(repmat(x,[(pT-1) size(yc,2)])-repmat(yp(1:(pT-1)),[1 size(yc,2)]))...
    (repmat(x,[(pT-1) 1])-yp(1:(pT-1))).*(yp(1:(pT-1))./repmat(x,[(pT-1) 1]))];
betas=inv(ypindep'*ypindep)*ypindep'*ypdiff;
errors=ypdiff-ypindep*betas;
vcm=(errors'*errors)*inv(ypindep'*ypindep)/(size(yp,1)-1);
se_est=sqrt(diag(vcm));

y = sum(errors.^2);

% size(yc(1:(size(yc,1)-1),:))
% size(betas(2:(1+size(yc,2))))

%gradf=sum(2*errors.*(betas(1)+yc(1:(size(yc,1)-1),:)*betas(2:(1+size(yc,2)))+betas(2+size(yc,2))/(x.^2).*yp(1:(pT-1)).^2));