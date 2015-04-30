% Global solver MrEleven
function [x,k] = MrEleven(p, x, a, i)

% function [x,k] =  MrEleven(p,x,a,i)
%
% Author                :  Xi He
% Description           :  Solve problem 'p' by algorithm 'a' with initial point 'x' and parameter set 'i'
% Input                 :  p ~ Problem handle
%                          x ~ Initial point
%                          a ~  Algorithm name
%                          i ~ parameter set(fixed)
% Output                :  x ~ output when algorithm terminated
%                          k ~ Total number of iteration

%% Add problem_set, algorithm_set and searching_set to the search path
addpath('./problem_set','./Algorithm_set','./searching_set');

% Set default parameters
default;

% Check if all the input variables are valid and analyze those variables
[p,alg,sea] = Checkvars(p,x,a,i);

% Create file for writing data
resdis = fopen('MrEleven.txt','a');
assert(resdis~=-1,'MrEleven: Failed to open MrEleven.txt.');

fprintf(resdis,'\n=====================================\n');
fprintf(resdis,'Problem:%s,  Algorithm:%s%s,  Initation:(',p,alg,sea);
fprintf(resdis,'%6.3f ',x);
fprintf(resdis,')''\n=====================================\n');
if ~strcmp(alg,'trustregion')
    fprintf(resdis,'%-6s\t%-10s\t%-12s%-6s\n', 'Iter','gnorm','alpha','x');
else
    fprintf(resdis,'%-6s\t%-10s\t%-12s%-6s\n','Iter','gnorm','radius','x');
end

%% Initialize iteration counter
k = 0;

% Update global count number
global COUNTF;
global COUNTG;
COUNTF = COUNTF + 1;
COUNTG = COUNTG + 1;

% Evaluate objective function
f = feval(p,x,0);

% Evaluate objective gradient
g = feval(p,x,1);

% Evaluate inital gradient norm
normg0 = norm(g);

% Initialize approxmiate Hessian matrix to identity matrix for BFGS and SR1 method
H = eye(length(x));

% Initialize trust region radius to be i.initialradius
D = i.initialradius;

%% Termination condition
while ~Termination(p,k,x,normg0,g,i)
    
    % For non-trustregion method
    if ~strcmp(alg,'trustregion')
        
        % Calculate descent direction with respect to alg = {steepest, newton, BFGS}
        d = feval(alg,p,x,f,g,H,i);
        
        % Calculate acceptable step-size with respect to sea = {wolfe, backtrack}
        [alpha,g1] = feval(sea,p,x,d,f,g,H,i);
        
        % Update $s = x_{k+1} - x_k$
        s = alpha*d;
        
        % For BFGS, update Hessian matrix by
        if strcmp(alg,'bfgs')
            % Use BFGS method to update the Hessian matrix based on prior information of update $s$.
            H = feval('Hessianupdate',p,s,x,d,f,g,g1,H,i);
        end
        
        g = g1;
        
        % Write data to MrEleven.txt
        fprintf(resdis,'%-6d\t%-10.3e\t%-10.3e\t(',k,norm(g),alpha);
        fprintf(resdis,' %6.3e ',x);
        fprintf(resdis,')\n');
        
        % Update variable value
        x = x + s;
        
        % Update function value and gradient value and their counter
        
        COUNTF = COUNTF + 1;
        f = feval(p,x,0);
    else
        
        % For trustregion method, update descent direction and step-size together
        [x,f,g,D,H] = feval(alg,sea,p,x,g,f,H,D,i);
        
        % Write data to MrEleven.txt
        %COUNTG = COUNTG + 1;
        %g = feval(p,x,1);
        fprintf(resdis,'%-6d\t%-10.3e\t%-10.3e\t(',k,norm(g),D);
        fprintf(resdis,' %6.3e ',x);
        fprintf(resdis,')''\n');
    end
    
    % Increment iteration counter
    k = k + 1;
end
end

%% Global termination rules for all the algorithm
function flag = Termination(p,k,x,normg0,g,i)

% It iteration over the maximal available iteration k.maxiter or the current gradient norm is less than the optimal tolerance, set this function value to be 1.
if k > i.maxiter || norm(g) <= i.opttol*max(normg0,1)
    flag = 1;
else
    flag = 0;
end
end

