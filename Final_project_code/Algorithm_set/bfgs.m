function [d,H] = bfgs(p,x,f,g,H,i)

% function [d, H] = bfgs(p,x,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate bfgs approximate Hessian matrix and corresponding descent direction
% Input       : p ~ problem handle
%               x ~ current point
%               i ~ parameter set
%               H ~ bfgs approximate Hessian matrix of last iteration
% Output      : d ~ descent direction at point x
% H ~ next bfgs approximate Hessian matrix

% Keep bfgs approximate Hessian matrix positive definite
n = length(x);

a = min(eig(H));
if a <= i.posdeftol
    H = H + (i.mineigtol-a)*eye(n);
end

% Calculate bfgs descent direction of current point x
d = -H\g;

global COUNTS;
COUNTS = COUNTS + 1;
end
