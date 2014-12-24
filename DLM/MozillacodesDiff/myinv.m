function  [A] = myinv(q,y,forecast,t,unblncPnl,tt2,n,r,F,T) %,b1,b2,alpha

   A = r*F'*(q\speye(size(q)));

return;