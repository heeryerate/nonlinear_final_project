function d = cg(g,i,D,H);

% function d = cg(g,i,D,H)
%
% Author      : Xi He
% Description : Calculate descent direction by cg method
% Input       : p ~ problem handle
%               i ~ parameter set
%               D ~ current trust region radius
%               H ~ current (approximate) Hessian matrix
% Output      : a ~ step-size along a descent direction

% Set initial vector to be zero
d = zeros(size(g));

% Evaluation residue
r = H*d+g;

% Set initial conjugate direction p to be -r
p = -r;

% Set initial cg iteration counter to be 0
k = 0;

% While iteration counter less than the maximal iteration
while k<i.cgmaxiter

    % Set pHp to be p'*H*p to save computation
    pHp = p'*H*p;

    % If the Hessian matrix is negative 
    if pHp < 0

        % The optimal attains at trust region boundary
        a = Findroot(d,p,D);

        % Update direction and stop 
        d = d + a*p;
        break;
    else

        % Set rr to be r'*r to save computation
        rr = r'*r;

        % Update step size a
        a = (r'*r)/pHp;
    end
    
    % If the optimal attains at somewhere outside the trust region boundary
    if norm(d+a*p) > D

        % Shrink the step size into trust region boundary
        a = Findroot(d,p,D);

        % Update direction and stop
        d = d + a*p;
        break;
    else

        % Otherwise, update direction and residue
        d = d + a*p;
        r = r + a*H*p;
    end
    
    % If norm of residue is less than 1e-6
    if norm(r) <= i.residuetol
        % Update direction and stop
        d = d + a*p;
        break;
    else

        % Otherwise, update parameter beta and conjugate direction p
        beta = (r'*r)/rr;
        p = -r + beta*p;
    end

    % Update iteration counter
    k = k + 1;
end
end

% A function to find proper step size at boundary
function a = Findroot(d,p,D)
b1 = p'*p;
b2 = p'*d;
a = (sqrt(b2^2-b1*(d'*d-D^2))-b2)/b1;
end