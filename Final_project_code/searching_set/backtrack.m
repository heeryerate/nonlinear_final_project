function [a,g] = backtrack(p,x,d,f,g,H,i)

% function a = backtrack(p,x,d,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate step-size along a descent direction d
% Input       : p ~ problem handle
%               x ~ current point
%               d ~ current descent direction
%               i ~ parameter set
% Output      : a ~ step-size along a descent direction

% Set initial step-size
a0 = 1;

% Initialize step-size to zero
a = 0;

% Scalers to decrease step-size
rho = i.shrinkbacktrack;

% Set count of iteration
count = 0;

gphi0 = g'*d;

while 1
    % Increment iteration counter
    count = count + 1;
    
    % Check the first condition
    if phi(p,x,d,a0) <= f + i.c1ls*a*gphi0;
        
        % If the condition is satisfied, accept step-size
        a = a0;
        break;
    end
    
    % Otherwise, reject and shrink step-size
    a0 = rho*a0;
end
g = feval(p,x+a*d,1);
global COUNTG;
COUNTG = COUNTG + 1;
end

function phivalue = phi(p,x,d,a)

% Increment global counter
global COUNTF;
COUNTF = COUNTF + 1;

% Calculate objective function value
res = x+a*d;
phivalue = feval(p,res,0);
end
