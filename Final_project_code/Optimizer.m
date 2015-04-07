% Function to find out the optimal solution with respect to problem "p", algorithm "alg", and search method "sea"
function [x,k] = Optimizer(p,alg,sea,x,i)
    % Initialize iteration counter
    k = 0;

    % Evaluate objective function
    f = feval(p,x,0);

    % Evaluate objective gradient
    g = feval(p,x,1);

    % Evaluate inital gradient norm
    normg0 = norm(g);
    
    % Initialize Hessian matrix to identity matrix for BFGS and SR1 method 
    H = eye(length(x));
    
    % Initialize trust region radius to be i.radius 
    D = i.radius;
    
    % Termination condition
    while ~Termination(p,k,x,normg0,i)
        
        % For non-trustregion method
        if ~strcmp(alg,'trustregion')
            
            % Calculate descent direction with respect to alg = {steepest, newton, BFGS}
            d= feval(alg,p,x,i,H);
            
            % Calculate acceptable step-size with respect to sea = {wolfe, backtrack}
            alpha = feval(sea,p,x,d,i);
            
            % Update $s = x_{k+1} - x_k$
            s = alpha*d;
            
            % For BFGS, update Hessian matrix by
            if strcmp(alg,'bfgs')
                % Use BFGS method to update the Hessian matrix based on prior information of update $s$.
                H = feval('Hessianupdate',p,s,x,i,H);
            end

            % Update variable value
            x = x + s;
        else
            % For trustregion method, update descent direction and step-size together
            [x,D] = feval(alg,sea,p,x,i,H,D);
        end

        % Add 1 to number of iteration
        k = k + 1;
    end 
end

% Global termination rules for all the algorithm
function flag = Termination(p,k,x,normg0,i)

    % Evaluate function gradient
    g = feval(p,x,1);

    % It iteration over the maximal available iteration k.maxiter or the current gradient norm is less than the optimal tolerance, set this function value to be 1.
    if k > i.maxiter || norm(g) <= i.opttol*max(normg0,1)
        flag = 1;
    else
        flag = 0;
    end
end