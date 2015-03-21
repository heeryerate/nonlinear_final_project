function x = newton(p,x)

% function x = newton(p,x)
%
% Author      : Frank E. Curtis
% Description : Newton's method for nonlinear equations (F(x)=0).
% Input       : p ~ problem function handle
%               x ~ initial iterate
% Output      : x ~ final iterate

% Set termination constants
kmax = 5e+02;
etol = 1e-06;

% Store output strings
out_line = '============================';
out_data = '  k    ||F(x)||      ||d||';
out_null =                   '----------';

% Print output header
fprintf('%s\n%s\n%s\n',out_line,out_data,out_line);

% Initialize iteration counter
k = 0;

% Evaluate F at x
F = feval(p,x,0);

% Evaluate error
norms.F = norm(F);

% Store initial error
norms.F0 = norms.F;

% Iteration loop
while 1
  
  % Print iterate information
  fprintf('%4d  %.4e  ',k,norms.F);
  
  % Check termination conditions
  if k > kmax || norms.F <= etol*max(norms.F0,1), break; end;
  
  % Evaluate Jacobian of F at x
  J = feval(p,x,1);
  
  % Solve Newton system
  d = -J\F;
  
  % Evaluate norm of direction
  norms.d = norm(d);
  
  % Print search direction information
  fprintf('%.4e\n',norms.d); % Update iterate
  x = x + d;
  
  % Evaluate F at x
  F = feval(p,x,0);
  
  % Evaluate error
  norms.F = norm(F);
  
  % Increment counter
  k = k + 1;
  
end

% Print final iterate information
fprintf('%s\n%s\n',out_null,out_line);