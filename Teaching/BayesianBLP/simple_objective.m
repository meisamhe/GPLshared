ObjectiveFunction = @simple_objectivef;
X0 = [0.5 0.5];   % Starting point
[x,fval] = patternsearch(ObjectiveFunction,X0)
% test minimization function
%another way:
x = fminsearch(ObjectiveFunction,X0)