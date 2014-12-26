% Cauchy random variable
for i=1:6;
    x=tan(pi*(rand(1,1000)-0.5));
    subplot(2,3,i);
    probplot('normal',x);
end;
% doing it manually
y=(1:1000)/1000;
plot(y,normpdf(ox,mean(ox),sqrt(var(ox)))); 