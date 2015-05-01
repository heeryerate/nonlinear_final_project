function [d,H] = bfgs(p,x,f,g,H,i)

% function [d, H] = bfgs(p,x,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate bfgs approximate Hessian matrix and corresponding descent direction
% Input       : p ~ problem handle
%               x ~ current point
%               f, g, H ~ function value, gradient value and bfgs matrix at current point
%               i ~ parameter set
% Output      : d ~ descent direction at point x
%               H ~ bfgs matrix at current point 
% H ~ next bfgs approximate Hessian matrix

% Keep bfgs approximate Hessian matrix positive definite
n = length(x);

a = min(eig(H));
if a <= i.posdeftol
    H = H + (i.mineigtol-a)*eye(n);
end

% Calculate bfgs descent direction of current point x
d = -H\g;

% Update number of linear system solved
global COUNTS;
COUNTS = COUNTS + 1;

end
