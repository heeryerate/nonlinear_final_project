function d = newton(p,x,f,g,H,i)

% function d= newton(p,x,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate  Newton descent direction
% Input       : p ~ problem handle
%               x ~ current point
%               f, g, H ~ function value, gradient value and Hessian matrix at current point
%               i ~ parameter set
% Output      : d ~ descent direction at point x

% Update global count number
global COUNTH;
COUNTH = COUNTH + 1;

% Compute Hessian matrix at point x
H = feval(p,x,2);

% Keep positive definiteness of Hessian matrix
n = length(x);

a = min(eig(H));
if a <= i.posdeftol
    H = H + (i.mineigtol-a)*eye(n);
end

% Calculate newton descent direction
global COUNTS;
COUNTS = COUNTS + 1;

% Derive the newton descent direction
d = -H\g;
end