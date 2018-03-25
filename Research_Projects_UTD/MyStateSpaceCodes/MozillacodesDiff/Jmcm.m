function [Jm] = Jmcm(d,tt1,yc,caddon,t) %alpha,

%  Jm =  [1- d(1)*alpha(1)*tt1(1)^(alpha(1)-1); ...
%         1- d(2)*alpha(2)*tt1(2)^(alpha(2)-1)];
%  Jm =  diag(Jm);

%f = d(1)*tt1(1,t-1).^2 + d(2)*tt1(1,t-1);
Jm  =  -2*d(3)./(d(1)+caddon(t)*d(4))*tt1(1) + (1+d(3)-d(2)-(yc(t,:)*d(5:size(d))));
Jm  =  diag(Jm);
