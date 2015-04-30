function d = steepest(p,x,f,g,H,i)

% function d = steepest(p,x,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate steepest descent direction
% Input       : p ~ problem handle
%               x ~  current point
%               i ~ parameter set
%               H ~ Hessian matrix of point x (abundant variable for this function)
% Output      : d ~  descent direction at point x

% Compute steepest descent direction
d = -g;
end