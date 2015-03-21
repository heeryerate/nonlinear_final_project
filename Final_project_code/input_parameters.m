function i = input_parameters

% function i = input_parameters
%
% Author      : Xi He
% Description : default setting
% Output      : i ~ input

% Set (default) problem (function handle)
i.f = 'rosenbrock';

% Set (default) algorithm
i.algorithm  = 'steepestbacktrack';

% Set problem size (Number of variables)
i.n_v = 2;

% Set initial iteration
i.x = randn(i.n_v,1);

% Set optimality tolerance and iteration limit
i.opttol = 1e-06;
i.maxiter = 1e+3;

% Set Armijo and curvature line search conditions parameters
i.Linesearch_c1 = 0.1;
i.Linesearch_c2 = 0.9;

% Set trust region radius update parameters
i.Trust_c1 = 0.25;
i.Trust_c2 = 0.75;

% Set CG optimality tolerance and iteration limit
i.CG_opttol = 1e-06;
i.CG_maxiter = i.n_v + 1;

% Set tolerance for SR1 Hessian approximation updates
i.SR1_update_tol = 1e-04;

% Set tolerance for BFGS Hessian approximation updates
i.BFGS_update_tol = 1e-04;






