function [f] = fmcm(d,tt1,yc,caddon,t) %alpha,
 %tt1;
 %f =  [tt1(1)- d(1)*tt1(1)^alpha(1); ...
  %     tt1(2)- d(2)*tt1(2)^alpha(2)];
 f = -d(3)./(d(1)+caddon(t)*d(4))*tt1.^2 + (1+d(3)-d(2)-(yc(t,:)*d(5:size(d))))*tt1;
 
 

         