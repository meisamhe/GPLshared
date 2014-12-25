function [f] = fm(d,tt1) %alpha,
 %tt1;
 %f =  [tt1(1)- d(1)*tt1(1)^alpha(1); ...
  %     tt1(2)- d(2)*tt1(2)^alpha(2)];
 f = d(1)*tt1.^2 + d(2)*tt1;
         