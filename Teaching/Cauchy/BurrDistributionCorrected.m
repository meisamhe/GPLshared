%Meisam Hejazinia mxh109420 code appendix
% first question Burr distribution vs. beta
for lambda=.1:.1:.5;
    K=1+(((2*pi*(1-lambda)+sin(2*pi*lambda))*sin(2*pi*lambda))/((1-cos(2*pi*lambda))^2));    
    x=rand(1,10000);
    ir=log(abs((1-x)+(sin(2*pi*x)/(2*pi))));
    b=0;
    for i=1:10000;
       % r(i)=1- exp(log(abs(ir(i)))*K);
        r(i)=x(i)*K*exp(log(abs(1-cos(2*pi*x(i))))+ir(i)*(K-1));
        if (r(i)>=0 && r(i)<=1);
            b(length(b)+1)=r(i);
        end;
        sq(i)=r(i)*x(i);
    end;
    indx=int16(lambda*10);
    mub(indx)=mean(r);
    varb(indx)=mean(sq)-mean(r)^2;

    xaxis=0:0.01:1;
    subplot(3,2,lambda*10);
    plot(xaxis,K*(1-cos(2*pi*xaxis)).*((1-xaxis)+(sin(2*pi*xaxis)/(2*pi))).^(K-1),'b');
    
    hold on;
    alpha(indx)=(((1-mub(indx))/varb(indx))-(1/mub(indx)))*(mub(indx)^2);
    beta(indx)=alpha(indx)*((1/mub(indx))-1);
    plot(xaxis,betapdf(xaxis,alpha(indx),beta(indx)),'r');
end;

for lambda=.1:.1:.5;
indx=int16(lambda*10);
[lambda mub(indx) varb(indx) alpha(indx) beta(indx)]
end;

% Cauchy random variable
for i=1:6;
    x=tan(pi*(rand(1,1000)-0.5));
    subplot(2,3,i);
    probplot('normal',x);
end;
% doing it manually
y=(1:1000)/1000;
plot(y,normpdf(ox,mean(ox),sqrt(var(ox)))); 