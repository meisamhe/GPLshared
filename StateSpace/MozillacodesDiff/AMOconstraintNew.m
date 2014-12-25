function [c,ceq]=AMOconstraintNew(x) %,gradc,gradceq

%x = x - mean(x); % demean to make sure that it is zero mean in the data

c=[-x,sum(x)-69009/100]; % just make sure that real x do not become negative (as contribution can not be negative) 
% the mean is free and I will set it to 14.4421 later
% By adding mean and rescaling back I will find the real number of
% contributions
%c = -14.432-x;

ceq = [];




