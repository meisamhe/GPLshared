%test likelihood
function LL = LLTest(theta,data)
mu = theta(1);
sig = theta(2);
l=-0.5*log(2*pi)-log(sig)-0.5*( (data-mu)/sig ).^2;
LL = -sum(l);