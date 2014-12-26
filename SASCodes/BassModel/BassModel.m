% estimating Bass Model
% Meisam Hejazinia (mxh109420)

A = [0 0;
    1 3000;
    2 4487;
    3 6693;
    4 9947;
    5 14700;
    6 21542;
    7 31181;
    8 44309;
    9 61293;
    10 81550;
    11 102677];
curm=0; % shows current market size
for i=1:12; % calculating total market size given time
    curm=curm+A(i,2);
    A(i,3)=curm;
end;
% calculating covariates/regressors
for i=2:12;
    A(i,4)=A(i-1,3);
    A(i,5)=A(i-1,3)^2;
    A(i,6)=1;
end;
Y=A(2:12,2); % current sales
X=A(2:12,4:5); % 5 should be changed to 5 for manual
%[beta,Sigma,E,CovB,logL] = mvregress(X,Y);
stats=regstats(Y,X,'linear');
%SSresid=sum(E.^2);
%SStotal = (length(Y)-1) * var(Y);
%rsq = 1 - SSresid/SStotal;
a=stats.beta(1);
b=stats.beta(2);
c=stats.beta(3);
m=(-b-sqrt(b^2-4*a*c))/(2*c);
p=a/m;
q=p+b;
t=(log(q)-log(p))/(p+q); % calculating peak
s=m*(p+q)^2/(4*q); % calculating the sales peak
x(1,1)=0; % will keep total market size to date
for i=2:50; % prediction of sales
   ps=(p+(q/m)*x(i-1,1))*(m-x(i-1,1)); % ps will hold todate sales
   ms(i,1)=ps; % ms shows marginal sals of the day
   x(i,1)=x(i-1,1)+ps;
end;
% drawing predicted versus actual
time=1:1:50;
plot(time,ms(:,1),'b');
hold on
timea=2:1:12;
plot(timea,Y,'r');