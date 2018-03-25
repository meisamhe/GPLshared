% this function will include the platform evolution parameter in creating
% independent matrix to run MCMC
function  tt = addonttindepbuilder(tt0,tt1,Tj,x,tt1p,tt0p,pT,m,m0) %,b1,b2,alpha
  % not simple case
 %  tt=[[tt0;tt1(1:Tj-1)'].^2./[tt0p;tt1p(pT-Tj+1:pT-1)'] [tt0;tt1(1:Tj-1)'] x'.*[tt0p;tt1p(pT-Tj+1:pT-1)']];
  % simple case
 % tt=[-[tt0;tt1(1:Tj-1)'].^2./tt1p(pT-Tj+1:pT)'+[tt0;tt1(1:Tj-1)'] tt1p(pT-Tj+1:pT)'-[tt0;tt1(1:Tj-1)'] [tt0;tt1(1:Tj-1)']];
 % corrected for inflation due to EKF
  tt=[2*[tt0;tt1(1:Tj-1)'].*[m0;m(1:Tj-1)']./[tt0p;tt1p(pT-Tj+1:pT-1)']-[m0;m(1:Tj-1)'].^2./[tt0p;tt1p(pT-Tj+1:pT-1)'] [tt0;tt1(1:Tj-1)'] x'.*[tt0p;tt1p(pT-Tj+1:pT-1)']];
 
return;