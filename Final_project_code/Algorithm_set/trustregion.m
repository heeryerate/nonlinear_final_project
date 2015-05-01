function [x,f,g,D,H] = trustregion(sea,p,x,g,f,H,D,i)

% function  [x,D,H] = trustregion(sea,p,x,g,f,H,D,flag,i)
%
% Author      : Xi He
% Description : Calculate new x, update trust region radius and (approximate Hessian matrix)
% Input       : sea ~ subproblem solve handle (cg or sr1cg)
% p ~ objection function handle
%               x ~ current point
%               i ~ parameter set
%               f, g, H ~ function value, gradient value and Hessian matrix at current point
%               D ~ trust region radius at point x
% Output      : x ~ new x value
%               D ~ new trust region radius
%               H ~ new (approximate) Hessian matrix

% Update global count number
global COUNTF;
global COUNTG;
global COUNTH;

% Calculate Hessian matrix for cg method
if strcmp(sea,'cg')
    H = feval(p,x,2);
end

% Compute descent direction by cg method
d = feval('cg',g,i,D,H);

% Update global count number
COUNTF = COUNTF + 1;
f1 = feval(p,x+d,0);

% Calculate decrease ratio between original function and approximate function
rho = (f-f1)/(-g'*d-d'*H*d);

% If decrease ratio is less than the first trust region parameter
if rho <= i.c1tr
    
    % Shrink trust region ratio to half, flager is a bool variable to decide whether to accept d
    D = D*i.shrinkradius;
    flager = 0;
    
    % If decrease ratio is between the first and the second trust region parameter
elseif rho > i.c1tr && rho <= i.c2tr
    % Accept update but keep trust region radius
    x = x + d;
    flager = 1;
    
    % if decrease ratio is larger than the second trust region parameter
elseif rho > i.c2tr
    % Double trust region radius and accept update
    D = D*i.expandradius;
    x = x + d;
    flager = 1;
end

% If we decide to accept direction d
if flager == 1

    % Update function value
    f = f1;

    % Update global count number
    COUNTG = COUNTG + 1;
    g1 = feval(p,x,1);
    
    % Choose subproblem solver (to use sr1cg) and update SR1 matrix
    if strcmp(sea,'sr1cg')
        H = sr1update(p,d,x,f,g,g1,H,i);
    end
    
    %   Update the gradient value
    g = g1;
end
end