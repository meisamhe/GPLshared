% this function will include the platform evolution parameter in creating
% independent matrix to run MCMC
function  [tt] = addonttindepbuilderOLSTpqFxdEffect(tttotal,xaddontotal,ttptotal,mtotal,phetrgntotal,qhetrgntotal,tttotaldiag) %,b1,b2,alpha
 % corrected for inflation due to EKF

%  disp('check size:')
%  disp(size(qhetrgntotal.*repmat(2*tttotal.*mtotal./ttptotal-mtotal.^2./ttptotal...
%       ,[1 size(qhetrgntotal,2)])))
%  disp(size( tttotaldiag))
%  disp(size(phetrgntotal.*repmat(tttotal,...
%       [1 size(phetrgntotal,2)])))
%   disp(size(phetrgntotal.*repmat(xaddontotal.*ttptotal,[1 size(phetrgntotal,2)])))
%   disp(size(qhetrgntotal.*repmat(tttotal,...
%       [1 size(qhetrgntotal,2)])))
 
  tt=[qhetrgntotal.*repmat(2*tttotal.*mtotal./ttptotal-mtotal.^2./ttptotal...
      ,[1 size(qhetrgntotal,2)])  tttotaldiag phetrgntotal.*repmat(tttotal,...
      [1 size(phetrgntotal,2)])  phetrgntotal.*repmat(xaddontotal.*ttptotal,[1 size(phetrgntotal,2)]) qhetrgntotal.*repmat(tttotal,...
      [1 size(qhetrgntotal,2)])];    
  %2*[tt0;tt1(1:Tj-1)'].*[m0;m(1:Tj-1)']./[tt0p;tt1p(pT-Tj+1:pT-1)']-[m0;m(1:Tj-1)'].^2./[tt0p;tt1p(pT-Tj+1:pT-1)']
  %x'.*[tt0p;tt1p(pT-Tj+1:pT-1)']
return;