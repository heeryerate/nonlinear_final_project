function d = steepest(p,x,f,g,H,i)

% function d = steepest(p,x,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate steepest descent direction
% Input       : p ~ problem handle
%               x ~  current point
%               f, g, H ~ function value, gradient value and Hessian matrix at current point
%               i ~ parameter set
% Output      : d ~  descent direction at point x

% Compute steepest descent direction
d = -g;

end