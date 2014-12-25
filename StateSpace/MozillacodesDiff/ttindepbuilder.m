function  tt = ttindepbuilder(tt0,tt1,Tj,x,m,m0) %,b1,b2,alpha
%    tt=[[tt0;tt1(1:Tj-1)'].^2 [tt0;tt1(1:Tj-1)'] x'];
   % corrected for inflation of EKF
   tt=[2*[tt0;tt1(1:Tj-1)'].*[m0;m(1:Tj-1)']-[m0;m(1:Tj-1)'].^2 [tt0;tt1(1:Tj-1)'] x'];  
return;