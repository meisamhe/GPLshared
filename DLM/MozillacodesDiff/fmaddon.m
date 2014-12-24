function [f] = fmaddon(d,tt1,t,Tj,pT,tt1p,tt0p,olst) %alpha,


if (pT-Tj+t-1 == 0)

  f = d(1)*tt1.^2./tt0p + d(2)*tt1 +((d(3:size(olst,2)+2)'*olst(t,:)')*tt1);
else

  f = d(1)*tt1.^2./tt1p(pT-Tj+t-1) + d(2)*tt1 +((d(3:size(olst,2)+2)'*olst(t,:)')*tt1);
  
end;


 

         