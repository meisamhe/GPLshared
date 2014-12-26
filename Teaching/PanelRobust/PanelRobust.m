function [beta,tratio]= PanelRobust(y,x);
t = size(y,1);
n = size(y,2);
y = y - repmat(mean(y),t,1);
x = x - repmat(mean(x),t,1);

beta = sum(sum(y.*x))/sum(sum(x.*x));
u = y - x*beta;
u = reshape(u, [size(u,1)*size(u,2) 1]); 
u2 = u*u'.*kron(eye(n,n),ones(t,t));
x = reshape(x, [size(x,1)*size(x,2) 1]);
vrho = inv(sum(sum(x'*x)))*(sum(sum(x'*u2*x)))*inv(sum(sum(x'*x)));
tratio = (beta)/sqrt(vrho);
end

