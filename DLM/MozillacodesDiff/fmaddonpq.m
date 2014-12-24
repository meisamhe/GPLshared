function [f] = fmaddonpq(d,tt1,t,Tj,pT,tt1p,tt0p,phetrgn,qhetrgn,rp,rq) %alpha,


if (pT-Tj+t-1 == 0)

%   f = (d(1)+(d(3+rp:2+rp+rq)'*qhetrgn(t,:)')) *tt1.^2./tt0p + d(2)*tt1 +((d(3:2+rp)'*phetrgn(t,:)')*tt1)...
%       +((d(3+rp+rq:2+rp+2*rq)'*qhetrgn(t,:)')*tt1);
 f = ((d(1+rp:rp+rq)'*qhetrgn(t,:)')) *tt1.^2./tt0p + tt1 +((d(1:rp)'*phetrgn(t,:)')*tt1)... %d(1)+d(2)*
      +((d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')*tt1)+(d(rp+2*rq+1)*tt1);
% f = ((d(1+rp:rp+rq)'*qhetrgn(t,:)')) *tt1.^2./tt0p + tt1 +((d(1:rp)'*phetrgn(t,:)')*tt1)... %d(1)+d(2)*
%       +((d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')*tt1);
else

%   f = (d(1)+(d(3+rp:3+rp+rq-1)'*qhetrgn(t,:)'))*tt1.^2./tt1p(pT-Tj+t-1) + d(2)*tt1 +((d(3:2+rp)'*phetrgn(t,:)')*tt1) ...
%       +((d(3+rp+rq:2+rp+2*rq)'*qhetrgn(t,:)')*tt1);
% rp
% rq
% size(d(1+rp:1+rp+rq-1))
% size(qhetrgn(t,:)')
% size(d(1:rp))
% size(phetrgn(t,:)')
% size(d(1+rp+rq:rp+2*rq)')
% size(qhetrgn(t,:)')
% size(d(rp+2*rq+1))
 f = ((d(1+rp:1+rp+rq-1)'*qhetrgn(t,:)'))*tt1.^2./tt1p(pT-Tj+t-1) + tt1 +((d(1:rp)'*phetrgn(t,:)')*tt1) ... %d(1)+d(2)*
      +((d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')*tt1)+(d(rp+2*rq+1)*tt1);
%    f = ((d(1+rp:1+rp+rq-1)'*qhetrgn(t,:)'))*tt1.^2./tt1p(pT-Tj+t-1) + tt1 +((d(1:rp)'*phetrgn(t,:)')*tt1) ... %d(1)+d(2)*
%       +((d(1+rp+rq:rp+2*rq)'*qhetrgn(t,:)')*tt1);
  
end;


 

         