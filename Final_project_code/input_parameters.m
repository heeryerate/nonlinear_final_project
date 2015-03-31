% Set (default) problem (function handle)
i.f = 'rosenbrock';

% Set (default) algorithm
i.algorithm  = 'steepestbacktrack';

% Set problem size (Number of variables)
i.numv = 2;

% Set initial iteration
i.x = randn(i.numv,1);

% Set optimality tolerance and iteration limit
i.opttol = 1e-06;
i.maxiter = 1e+03;

% Set Armijo and curvature line search conditions parameters
i.c1ls = 0.1;
i.c2ls = 0.9;

% Set trust region radius update parameters
i.c1tr = 0.25;
i.c2tr = 0.75;

% Set CG optimality tolerance and iteration limit
i.cgopttol = 1e-06;
i.cgmaxiter = i.numv + 1;

% Set tolerance for SR1 Hessian approximation updates
i.sr1updatetol = 1e-04;

% Set tolerance for BFGS Hessian approximation updates
i.bfgsupdatetol = 1e-04;





