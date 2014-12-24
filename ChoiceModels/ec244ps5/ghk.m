% GHK simulation of probit probabilities.
% Written by Kenneth Train, Jan 10, 2008.

% Inputs:
%         vtilde: (NALT-1)x1 vector of representative utility differences (nonchosen alternatives minus chosen alternative)
%         choleski: (NALT-1)x(NALT-1) lower triangular Choleski matrix of covariance among errors (ie among utility differences)
%         e: (NALT-1)xNDRAWS matrix of random draws from uniform distribution between 0 and 1 
% Output:
%         p: scalar probability of chosen alternative

function p=ghk(vtilde,choleski,e);

global NALT

cut=-vtilde(1,1)./choleski(1,1);      %Scalar: Cutoff for first error
cumcut=0.5*erfc(-cut./sqrt(2));       %Scalar: Cumulative prob that first error is below cutoff
p=cumcut;
eee=[];
for r=2:(NALT-1);
   ee=e(r-1,:).*cumcut;                     %So now have random draws from uniform between 0 to cumcut
   ee=-sqrt(2)*erfcinv(2*ee);               %To get draws from truncated normal
   eee=[eee ; ee] ;                         %(r-1)xNDRAWS: Append errors for (r-1)th alt to previous draws
   cut=-(vtilde(r,1)+(choleski(r,1:r-1)*eee)); %1xNDRAWS: Add the sum of errors times their choleski element
   cut=cut./choleski(r,r);
   cumcut=0.5*erfc(-cut./sqrt(2));          %1xNDRAWS: Cum prob that r-th error is below cutoff
   p=p.*cumcut;                             %1xNDRAWS
end;
p=mean(p,2);

     