function [beta,tratio]= myols(y,x);
t = size(y,1);
y = y - repmat(mean(y),t,1);
x = x - repmat(mean(x),t,1);

beta = sum(sum(y.*x))/sum(sum(x.*x));
u = y - x*beta;
u2 = u.*u;
u2 = mean(mean(u2));
vrho = u2/sum(sum(x.*x));
tratio = (beta)/sqrt(vrho);
end

