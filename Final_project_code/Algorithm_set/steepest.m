function x = steepestdescent(p,x,o)

% function x = steepestdescent(p,x,o)
%
% Author      : Frank E. Curtis
% Description : Steepest descent algorithm for unconstrained optimization (min f(x)).
% Input       : p ~ problem function handle
%               x ~ initial iterate
%               o ~ line search option
% Output      : x ~ final iterate
% Revised by  : (your name here)

% Set termination constants
kmax = 1e+03;
etol = 1e-06;

% Store output strings
out_line = '==================================================================';
out_data = '  k        f          ||g||       ||d||       g^T*d        alpha';
out_null =                                '----------  -----------  ----------';

% Print output header
fprintf('%s\n%s\n%s\n',out_line,out_data,out_line);

% Initialize iteration counter
k = 0;

% Evaluate objective function
f = feval(p,x,0);

% Evaluate objective gradient
g = feval(p,x,1);

% Evaluate gradient norm
norms.g = norm(g);

% Store initial gradient norm
norms.g0 = norms.g;

% Iteration loop
while 1
  
  % Print iterate information
  fprintf('%4d  %+.4e  %.4e  ',k,f,norms.g);
  
  % Check termination conditions
  if k > kmax || norms.g <= etol*max(norms.g0,1), break; end;
  
  % Evaluate search direction
  d = -g;
  
  % Evaluate norm of direction
  norms.d = norm(d);
  
  % Print search direction information
  fprintf('%.4e  ',norms.d);
  
  % Evaluate directional derivative
  D = g'*d;
  
  % Run line search
  [a,f] = linesearch(p,x,f,d,D,o);
  
  % Print line search information
  fprintf('%+.4e  %.4e\n',D,a);
  
  % Update iterate
  x = x + a*d;
  
  % Evaluate objective gradient
  g = feval(p,x,1);
  
  % Evaluate gradient norm
  norms.g = norm(g);
  
  % Increment iteration counter
  k = k + 1;
    
end

% Print output footer
fprintf('%s\n%s\n',out_null,out_line);