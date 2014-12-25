function  [x,y,uT,piai] = read(num,Ti,beta,p,tt1p,tt0p,pT,scale) %,b1,b2,alpha
   
   y = fliplr(num(1:Ti,1)')'./scale; %M download
   x = ones(p,Ti);
   uT= diag(beta)*x(1:Ti).*[tt0p tt1p(pT-Ti+1:pT-1)];
   piai = diag(beta);
return;