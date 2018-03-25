% this function will include the platform evolution parameter in creating
% independent matrix to run MCMC
function  [tt] = addonttindepbuilderOLSTpq(tt0,tt1,Tj,x,tt1p,tt0p,pT,m,m0,phetrgn,qhetrgn) %,b1,b2,alpha

 % corrected for inflation due to EKF
  tt=[qhetrgn.*repmat(2*[tt0;tt1(1:Tj-1)'].*[m0;m(1:Tj-1)']./[tt0p;tt1p(pT-Tj+1:pT-1)']-[m0;m(1:Tj-1)'].^2./[tt0p;...
      tt1p(pT-Tj+1:pT-1)'],[1 size(qhetrgn,2)])  [tt0;tt1(1:Tj-1)'] phetrgn.*repmat([tt0;tt1(1:Tj-1)'],...
      [1 size(phetrgn,2)])  phetrgn.*repmat(x'.*[tt0p;tt1p(pT-Tj+1:pT-1)'],[1 size(phetrgn,2)]) qhetrgn.*repmat([tt0;tt1(1:Tj-1)'],...
      [1 size(qhetrgn,2)])];    
  %2*[tt0;tt1(1:Tj-1)'].*[m0;m(1:Tj-1)']./[tt0p;tt1p(pT-Tj+1:pT-1)']-[m0;m(1:Tj-1)'].^2./[tt0p;tt1p(pT-Tj+1:pT-1)']
  %x'.*[tt0p;tt1p(pT-Tj+1:pT-1)']
return;